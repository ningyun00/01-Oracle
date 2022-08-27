-- 练习一、使用条件结构
-- 问题描述：公司决定向职员（emp表）发放奖金，
-- 发放原则根据职员所在部门编号（deptno）来计算。
-- 如果部门编号为“10”，奖金为2000元；部门编号为“20”，
-- 奖金为1700元；部门编号为“30”，奖金为1500元，
-- 请用条件结构解决该问题。
-- 提示：首先根据用户输入的员工编号（empno）
-- 获得其对应的部门编号（deptno），然后根据部门编号（deptno）判断，更新薪水sal。
declare 
   scott_emp_empno number:='&请输入员工编号';
   scott_emp_deptno emp.deptno%type;
begin
   select deptno into scott_emp_deptno from (select * from scott.emp where scott.emp.empno = scott_emp_empno);
   if scott_emp_deptno = 10 then
      update scott.emp set scott.emp.comm = scott.emp.comm +2000 where scott.emp.empno = scott_emp_empno;
   elsif scott_emp_deptno = 20 then
      update scott.emp set scott.emp.comm = scott.emp.comm +1700 where scott.emp.empno = scott_emp_empno;
   elsif scott_emp_deptno = 30 then
      update scott.emp set scott.emp.comm = scott.emp.comm +1500 where scott.emp.empno = scott_emp_empno;
   end if;
end;
select * from emp;

-- 练习二、使用循环结构
-- 问题描述：请编写一个程序，通过循环向course_details表中插入10条件记录，要求学生编号每次累加1，课程由用户输入。
-- 表结构：
create table course_details
(
  sid number,--学员编号
  course varchar2(20)--课程
);
-- 例如接收的课程为oralce
-- 效果如下：
  sid       course
1oracle
2oracle
3oracle
4oracle
5oracle
begin 
  for i in 1..10
  loop
    insert into scott.course_details values(i,'oracle');
  end loop;
end;
select * from scott.course_details;

-- 练习三、编写一个程序，显示1至100之间的素数（质数）。
-- 提示：
-- 1、素数（质数）：只能被1和本身整除的数。
-- 2、使用for循环
declare 
   keys boolean :=true;
   counts number :=0;
begin
   for i in 2..100 loop
       for j in 2..i-1 loop
           if mod(i,j) = 0 then 
             keys := false;
           end if;
       end loop;
       if keys = true then
         dbms_output.put_line(i);
         counts := counts+1;
       end if;
       keys := true;
   end loop;
   dbms_output.put_line(counts);
end;

/*
练习四、将userInfo.dmp文件中的数据导入Scott用户下，该文件中包含UserInfo用户信息表，结构如下：
列名  注释
CUSTOMERID  客户编号
CREATETIME  客户创建时间
EMAIL 客户email
LANGUAGE  客户语言
USERNAME  客户帐户
SCREENNAME  呢称
PASSWORD  密码
ISMALE  是否通过邮箱认证
BIRTHDAY  生日
POSTALCODE  邮政编码
FIRSTNAME 第一名称
LASTNAME  第二名称
ADDRESS 地址
请编写PL/SQL块，统计70后，80后，90后用户的人数和占三者人数和的比例。效果如下：
*/
declare
       point70 number :=0;
       point80 number :=0;
       point90 number :=0;
begin
       select count(*) into point70 from scott.userinfo where to_char(scott.userinfo.birthday,'YYYY') like '%__7_%';
       select count(*) into point80 from scott.userinfo where to_char(scott.userinfo.birthday,'YYYY') like '%__8_%';
       select count(*) into point90 from scott.userinfo where to_char(scott.userinfo.birthday,'YYYY') like '%__9_%';
       dbms_output.put_line(70||'后共'||point70||'人;'||80||'后共'||point80||'人;'||90||'后共'||point90||'人;');
       dbms_output.put_line(70||'后占：'||round(point70/(point70+point80+point90)*100,2)||'%');
       dbms_output.put_line(80||'后占：'||round(point80/(point70+point80+point90)*100,2)||'%');
       dbms_output.put_line(90||'后占：'||round(point90/(point70+point80+point90)*100,2)||'%');
end;

drop table course_details
drop table scott.userinfo
