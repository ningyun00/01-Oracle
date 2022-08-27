
/*
练习一、隐式游标（游标属性）
现有如下PL/SQL块，根据用户输入的部门编号，更新员工工资。
declaer
  dno number;
begin 
  dno:='&dno';
  update emp set sal = sal+100 where deptno = dno;
  -- 补全代码;
end;
请在注释处补全代码实现：如果更新成功则显示用户成功更新了多少条记录，否则提示部门不存在。
*/
declare
  dno number;
begin 
  dno:='&dno';
  update emp set sal = sal+100 where deptno = dno;
    select count(*)into dno from emp where deptno = dno;
  if dno>0  then
     dbms_output.put_line('修改了'||dno);
  else
     dbms_output.put_line('部门不存在');
  end if;
end;

/*
练习二、显式游标
使用显式游标编写一个程序，以显示scott用户中emp表和dept表中的empno，ename，sal，deptno，dname五个字段值。
*/
declare
cursor cur_empOrDept is 
select emp.empno,emp.ename,emp.sal,dept.deptno,dept.dname from emp inner join dept on emp.deptno = dept.deptno;
       cur_v_row emp%rowtype;
begin
   for cur_v_row in cur_empOrDept
       loop
                 dbms_output.put_line(cur_v_row.empno||chr(9)||chr(9)||cur_v_row.sal||chr(9)||chr(9)||cur_v_row.deptno||chr(9)||chr(9)||cur_v_row.dname);
       end loop;
end;
 
 
 /*
 练习三、循环游标
编写程序以显示各部门名称和该部门包含的员工姓名。要求使用显式的循环游标实现。
效果如下：
部门编号 ：NO,名称：NAME
员工：1
员工：2
员工：3
 */
declare 
       cursor cur_dept is  select deptno,dname from dept group by dept.deptno,dept.dname order by dept.deptno;
       v_cur_dept_row dept%rowtype;
begin
       for v_cur_dept_row in cur_dept
           loop
                  dbms_output.put_line('部门编号'||v_cur_dept_row.deptno||'，名称：'||v_cur_dept_row.dname);
                  declare 
                         cursor cur_emp is  select emp.ename from emp where emp.deptno in v_cur_dept_row.deptno;
                         v_cur_emp_row emp%rowtype;
                         i number :=0;
                  begin
                         for v_cur_emp_row in cur_emp
                             loop
                                     i := i + 1;
                                     dbms_output.put_line('员工'||i||'：'||v_cur_emp_row.ename);      
                             end loop;
                  end;
           end loop;
end;

/*
练习四、使用游标更新数据
将userInfo.dmp文件中的数据导入到Scott用户下，其中包含UserInfo表，由于UserInfo表中客户密码被加密了，现在请你编写PL/SQL语句，重新生成所有用户的密码，要求密码必须为6位数。
提示：dbms_random程序包提供了生成随机数的方法。
示例：select dbms_random.value(0,100) from dual;产生0-100之间的随机数
*/
declare
       cursor cur_userinfo is select * from scott.userinfo;
       i number :=0;
       v_cur_userinfo_row userinfo%rowtype;
begin
         for v_cur_userinfo_row in cur_userinfo
           loop 
                   i := dbms_random.value(666666,1000000);
                   i := substr(i,instr(i,'.')+6,6);
                   if  length(i)=6 then
                       update userinfo set userinfo.password = i where userinfo.customerid = v_cur_userinfo_row.customerid;
                   end if;
           end loop;
end;

/*
练习五：使用触发器实现员工表的数据备份
*/
create table emp2 as select * from emp;
-- 备份触发器
create or replace trigger trigger_emp
before 
update or insert or delete
on emp for each row
begin
  if inserting then
    insert into emp2 values(:new.empno,:new.ename,:new.job,:new.mgr,:new.hiredate,:new.sal,:new.comm,:new.deptno);
  elsif updateing then
    update emp2 set ename=:new.ename,job=:new.job,mgr=:new.mgr,hiredate=:new.hiredate,sal=:new.sal,comm=:new.comm,deptno=:new.deptno where empno=:new.empno;
  else
    delete from emp2 where empno=:old.empno;
  end if;
end;
select * from emp
select * from emp2
delete from  emp where empno = '7499'
