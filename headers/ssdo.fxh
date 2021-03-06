texture2D AOWorkMap : RENDERCOLORTARGET <
	float2 ViewPortRatio = {1.0, 1.0};
	#if SSDO_COLOR_BLEEDING > 0
	string Format = YOR16F;
	#else
	string Format = "R16F";
	#endif
>;
sampler AOWorkMapSampler = sampler_state {
    texture = <AOWorkMap>;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
    MipFilter = NONE;
    AddressU  = CLAMP;
    AddressV  = CLAMP;
};

#define DepthLength 10.0	
#define InvDepthLength6 1e-06
static float2 SSAORadius = 0.14 / SSAORayCount * ViewportAspect;

inline float GetOccRate(float2 Tex, float3 VPos, float3 N)
{
	float Depth = tex2D(sumDepthSamp,Tex).x;
	float3 RayPos = coord2WorldViewPos(Tex,Depth);
	const float SSAO_BIAS = 0.01;

	float3 v = RayPos - VPos;
	float distance2 = dot(v, v);
	float dotVN = max(dot(v, N) - SSAO_BIAS, 0.0f);
	float f = max(DepthLength * DepthLength - distance2, 0.0f);
	float f3 = f * f * f;
	float ao = (1.5 + 3 * aoPlus) * f3 * InvDepthLength6 * dotVN / (distance2 + 1e-3);

	return min(ao, 1.0);
}

float4 PS_AO( float2 Tex: TEXCOORD0 ) : COLOR
{
	float Depth = tex2D(sumDepthSamp,Tex).x;
	
	float3 N = tex2D(sumNormalSamp,Tex).xyz;
	float2 cTex = Tex - ViewportOffset;
	float3 VPos = coord2WorldViewPos(cTex,Depth);

	float radMul = 1.0 / SSAORayCount * (3.14 * 2.0 * 7.0);
	float radAdd = hash12(Tex*Depth*ftime) * (PI * 2.0);

	float sum = 0.0;
	float3 col = 0;

	float totalCRad = 0;
	float2 totalCAORad = 0;
	
	float2 qAoRadius = max(SSAORadius * 0.42,SSAORadius - Depth*0.000048.xx);
	// MEMO: unrollするとレジスタを聞い�^ぎてコンパイルが宥らない
	// note: do not use global const variables in (the loop of a) shader.
	[unroll]
	for(int j = 0; j < SSAORayCount; j++)
	{
		float2 sc;
		sincos(totalCRad + radAdd, sc.x, sc.y);
		float2 uv = sc * totalCAORad + cTex;

		float ao = GetOccRate(uv, VPos, N);
		sum += ao;
		#if SSDO_COLOR_BLEEDING > 0
		float3 bouns = easysrgb2linear(tex2D(AlbedoGbufferSamp,uv).xyz);
		bouns*=(1 + tex2D(IBLDiffuseSampler, computeSphereCoord(tex2D(sumNormalSamp,uv).xyz)).xyz);
		col += min(0.28,ao) * bouns;
		#endif
		
		totalCRad += radMul;
		totalCAORad += qAoRadius;
	}
	#if SSDO_COLOR_BLEEDING > 0
	col *= invPi * LightAmbient;
	#endif
	// 圷のSAOのソ�`スでは、ddx/ddyでクアッド�g了の
	// �a屎を佩っていた。

	float s = saturate(1.0 - sum * (1.0 / SSAORayCount));
	return float4(s,col/ SSAORayCount);
}

#undef DepthLength

#define SSDO_COLORBLEEDING \
		"RenderColorTarget0=AOWorkMap;" \
    	"RenderDepthStencilTarget=mrt_Depth;" \
		"ClearSetDepth=ClearDepth;Clear=Depth;" \
		"ClearSetColor=ClearColor;Clear=Color;" \
    	"Pass=AOPass;"