select OBJECT_NAME(id) as �洢����,id from syscomments 

where id in

(

    select 

    object_id(name)

    from dbo.sysobjects

    where xtype='v'  --�洢����ΪP

)

and text like '%lock%'  --�ؼ���

group by id 

--VW_InvBackup
--xtype:�������͡����������ж��������е�һ�֣� 

--C = CHECK Լ��

--D = Ĭ��ֵ�� DEFAULT Լ��

--F = FOREIGN KEY Լ��

--L = ��־

--FN = ��������

--IF = ��Ƕ����

--P = �洢����

--PK = PRIMARY KEY Լ���������� K��

--RF = ����ɸѡ�洢����

--S = ϵͳ��

--TF = ����

--TR = ������

--U = �û���

--UQ = UNIQUE Լ���������� K��

--V = ��ͼ

--X = ��չ�洢����

GetCommodityPrice_ByBizID

