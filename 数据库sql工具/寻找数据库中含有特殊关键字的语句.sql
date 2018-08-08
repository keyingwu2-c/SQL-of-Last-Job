select OBJECT_NAME(id) as 存储过程,id from syscomments 

where id in

(

    select 

    object_id(name)

    from dbo.sysobjects

    where xtype='v'  --存储过程为P

)

and text like '%lock%'  --关键字

group by id 

--VW_InvBackup
--xtype:对象类型。可以是下列对象类型中的一种： 

--C = CHECK 约束

--D = 默认值或 DEFAULT 约束

--F = FOREIGN KEY 约束

--L = 日志

--FN = 标量函数

--IF = 内嵌表函数

--P = 存储过程

--PK = PRIMARY KEY 约束（类型是 K）

--RF = 复制筛选存储过程

--S = 系统表

--TF = 表函数

--TR = 触发器

--U = 用户表

--UQ = UNIQUE 约束（类型是 K）

--V = 视图

--X = 扩展存储过程

GetCommodityPrice_ByBizID

