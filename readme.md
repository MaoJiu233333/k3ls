#K3LS#
��һ��mikumikudance�û����������Ⱦ��

    �汾 1.4.0
    
##ʹ�÷���:
###������Ⱦ
* ����Gbuffer_init.pmx,��ȷ������`��һ��`��Ⱦ��pmx�ļ�
* �ر�MMD�Դ������
* ����ambient.x
* ����K3LS.x
* ��MME������壬Ϊģ�ͷ���materials�ļ����µ�fx�ļ�����ͨ����Ӧ��controllers�ļ����µ�pmx�ļ�������ȾЧ��

###ģ�͸���
* ɾ��ģ��������sphere��ͼ����������Ϊ`�oЧ`
* ɾ��ģ��������toon��ͼ
* ��ѡ����ԭ������sphere��ͼ��λ���޸�Ϊ������ͼ

##����
* K3LS - DR �ݲ�֧�ְ�͸��ģ�͵���ȷ��Ⱦ

##�߼�ѡ��
####��`headers\\environment.fxh`�ļ��У�������������Ч��
* SHADOW_QUALITY
        ��Χ1-5
        �Դ湻��������˿�
		
* SSAORayCount
        �Ƽ���Χ24-32
        ����AO��COLOR��BLEEDING������
		
* SSDO_COLOR_BLEEDING
        �Ƽ���Χ15-25��0Ϊ�رմ�Ч��
        COLOR��BLEEDINGЧ����ǿ��
		
* BLUR_COUNT
        �Ƽ���ֵ6
        Ӱ��AO����Ӱ��ģ��ǿ��
        ��������еõ����벻Ҫ�����޸����ѡ��
		
* VOLUMETRIC_FOG_SAMPLE
        �Ƽ���Χ80-140��0Ϊ�رմ�Ч��
        �����ľ�ȷ�ȣ����͵�ֵ�����©�⣬�Լ�����
		
* AA_QUALITY
        �����ǿ�ȣ����Ƽ�5
        ����1ΪSMAA
		
* SMAA_EDGE_DETECT_MODE
        �ڿ���SMAA������´�ѡ����Ч
        0Ϊͨ������ж������Ե
        1Ϊͨ�������ж������Ե
        �Ƽ�0
		
* SMAA_WEIGHT_SUBSAMPLE
        �ڿ���SMAA������´�ѡ����Ч
        SMAA�������������
        ����nX-SMAA
        �Ƽ�1
		
* FILL_2_FLOAT_TO_4
		N������1
		A������0
		
* ENABLE_SSS
		����SSSSSЧ��
		����1


##Reference:
* http://graphicrants.blogspot.jp/2013/08/specular-brdf-reference.html
* http://blog.selfshadow.com/publications/s2012-shading-course/burley/s2012_pbs_disney_brdf_notes_v3.pdf
* http://renderwonk.com/publications/s2010-shading-course/gotanda/course_note_practical_implementation_at_triace.pdf
* http://advances.realtimerendering.com/s2014/wronski/bwronski_volumetric_fog_siggraph2014.pdf
* http://www.iryoku.com/sssss/
* http://iryoku.com/translucency/
* KlayGE(https://github.com/gongminmin/KlayGE)
* Ray(https://github.com/ray-cast/ray-mmd)
* N2+CShader
* ikPolishShader

##Inspired by:
* NCHLShader2
* MikuMikuEffect Reference
* https://zhuanlan.zhihu.com/p/20119162?refer=graphics

##TODO:
* ֧��alpha ��
* �Ľ�Gbuffer ��
* ��Ļ�ռ���Ӱ ��
* �������������� ��
* ����SSSSS ��
* FULL HDR ��
* bokeh
* ���Դ
