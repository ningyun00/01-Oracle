-- 练习一：理解锁的概念
-- 问题描述：
-- 某公司的员工管理系统需要多个部门的用户经常进行更新，当更新操作比较频繁且多个部门同时更新员工表时，用户会感到系统反应变慢，甚至出现等待很久后才能完成修改的情况。用户向技术人员反应了这一情况，现假设你就是技术人员，请给出合理的解释和解决方案。

-- 分析解释：
-- 上述情况可能是数据库的锁机制引起的。锁机制，用于防止同时访问相同资源的用户之间出现破坏性的交互操作。资源可以是整个表或表中的特定行。当多个用户同时更新相同的数据时，数据库提供锁机制保证同一数据在同一时间只能有一个用户在更新，其他用户必须等待前面的更新完成，从而保证数据的一致性。因此，锁提供了高度的数据并发性。



-- 练习二：在什么情况下出现行级锁？
-- 分析：
-- 在使用insert，delete，update，select…for update语句时，Oracle会自动应用行级锁。Select…for update语句允许用户每次选择多行记录以进行更新。
select * from scott.emp;

-- 请创建示例测试行级锁。
-- 1、打开一个会话，修改Scott用户emp表中员工SMITH的工资为2000；
update scott.emp set scott.emp.SAL = '2000' where scott.emp.ename = 'SMITH'; 

-- 2、打开另一个会话，修改Scott用户emp表中员工SMITH的工资为3000；
update scott.emp set scott.emp.SAL = '3000' where scott.emp.ename = 'SMITH'; 


-- 练习四：序列
-- 1、创建如下表：
drop table Test
Create table Test
(  
       tid number primary key not null,
       tname varchar2(20)
  );
-- 要求：tid的取值为从2开始的偶数，无限增长（如：2，4，6，8，10…）
create sequence seq_Test
start with 0
increment by 2 
minvalue 0

-- 2、请为该表创建序列，并插入5条记录
BEGIN
 FOR i in 1..5
 loop
 INSERT INTO Test VALUES(seq_Test.Nextval,'寜'||i);
 end loop;
 commit;
END;
select * from Test

-- 3、删除刚创建的序列
drop sequence seq_Test

-- 练习五：视图
-- 1、对于用户而言，需要经常使用到Scott用户emp表的ename员工姓名，sal薪水两列，请给出合适的解决方案。（提示：创建视图）
create or replace view view_emp
as 
       select scott.emp.ename,scott.emp.sal from scott.emp;
select * from view_emp

-- 2、在上题基础上，修改视图定义，要求显示emp表的所有列。（提示：替换视图）
create or replace view view_emp
as 
       select scott.emp.* from scott.emp;
select * from view_emp

-- 3、现在需要查看emp表中的员工分别属于哪个部门，即要求显示员工编号，员工姓名和部门名称，请创建相应视图实现。（提示： '连接视图）
create or replace view view_emp
as
       select scott.emp.empno,scott.emp.ename,scott.emp.job from scott.emp;
       
select * from view_emp

-- 4、删除刚创建的视图
drop view view_emp

-- 练习六：索引
-- 编写代码实现如下功能：
drop table Test
Create table Test
(  
       tid number,
       tname varchar2(20)
);

-- 1、为Test表的Tid列创建标准索引
create index index_test_tid on scott.test(tid)

-- 2、为Test表的TName列创建唯一索引
create unique index index_test_tname on scott.test(tname);

-- 3、因用户经常要使用MyTest表的Tid列和TName列作为查询条件，为提高查询速度，请为这两列创建组合索引
create unique index index_test_tid_tname on scott.test(tid,tname);

-- 4、删除刚创建的索引
drop index index_test_tid;
drop index index_test_tname;
drop index index_test_tid_tname;
