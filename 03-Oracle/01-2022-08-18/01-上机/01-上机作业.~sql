-- 1.找到员工表中工资最高的前3名
select * from (select * from emp order by SAL desc) where rownum <=3;

-- 2.找到员工薪水大于本部门平均薪水的员工



-- 3.统计每个部门的员工个数
select job,count(ename) from emp group by job;

-- 4.列出至少有一个员工的所有部门
select job from emp group by job having count(ename)>=1;

-- 5.列出部门名称和这些部门的员工信息，同时列出那些没有员工的部门
select * from emp where job is not null;

-- 6.列出所有员工的年工资,按年薪从低到高排序
select emp.*,SAL*12 as 年工资 from emp order by SAL*12;

-- 7、列出同部门中工资高于1000 的员工数量超过2 人的部门，显示部门名字、地区名称
select job  from emp where SAL>1000 group by job having count(ename)>2;

-- 8、emp表按照姓名s%模糊查询的分页语句，要求每页显示2条记录
select * from (select * from emp where ename like 'S%') where rownum <3;
