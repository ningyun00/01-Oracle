-- 练习一、
-- 用Scott用户的emp表为数据源，编写一个过程根据员工编号输出员工姓名和薪水。（要求将员工姓名和薪水作为输出参数）
create or replace procedure pro_emp_outNameSal
(emp_no in number , emp_name out emp.ename%type , emp_sal out emp.sal%type)
is
begin
       select emp.ename,emp.sal into emp_name,emp_sal from emp where emp.empno  = emp_no;
       exception
              when No_data_found then
              dbms_output.put_line('没找到数据');
              emp_name:='无';
              emp_sal:=0;
end;

declare
       emp_name emp.ename%type;
       emp_sal emp.sal%type;
begin
       pro_emp_outNameSal(10,emp_name,emp_sal);
       dbms_output.put_line('用户名：'||emp_name||'，工资：'||emp_sal);
end;
       
-- 练习二、
-- 用Scott用户的emp表为数据源，编写一个函数根据员工编号返回员工的入职时间。
-- 存储过程
create or replace procedure pro_emp_outHiredate(emp_no in emp.empno%type , emp_hiredate out emp.hiredate%type)
is
begin
       select emp.hiredate into emp_hiredate from emp where emp.empno = emp_no;
       exception
              when NO_data_found then
              dbms_output.put_line('没有该员工');
              emp_hiredate := to_date(sysdate,'YYYY-MM-DD');
end;

declare
          emp_hiredate emp.hiredate%type;
begin
          pro_emp_outHiredate(7499,emp_hiredate);
          dbms_output.put_line(emp_hiredate);
end;

-- 函数
create or replace function fun_emp_outDate(emp_no in number)return date
is
       emp_hiredate date;
begin
       select emp.hiredate into emp_hiredate  from emp where emp.empno = emp_no;
       return emp_hiredate;
end;

declare
          emp_hiredate date;
begin
          emp_hiredate := fun_emp_outDate(7499);
          dbms_output.put_line(to_char(emp_hiredate,'YYYY-MM-DD'));
end;


-- 练习三、
-- 创建程序包，在程序包中定义一个过程用作添加员工，再定义一个函数用作根据员工编号判断员工是否存在。
-- （要求：在用户执行添加操作之前，先调用函数判断该员工是否存在，
-- 如果不存在，则插入并提交数据；否则提示该员工已存在）
create or replace package pack_emp is 
       procedure pro_pack_emp_add
       (
                 emp_no in emp.empno%type,
                 emp_name in emp.ename%type,
                 emp_job in emp.job%type,
                 emp_mgr in emp.mgr%type,
                 emp_hiredate in emp.hiredate%type,
                 emp_sal in emp.sal%type,
                 emp_comm in emp.comm%type,
                 emp_deptno in emp.deptno%type
       );
       function fun_pack_emp_selectNo(emp_no in emp.empno%type)return number;
end;

create or replace package body pack_emp is
       -- 添加用户
      procedure pro_pack_emp_add
             (
                       emp_no in emp.empno%type,
                       emp_name in emp.ename%type,
                       emp_job in emp.job%type,
                       emp_mgr in emp.mgr%type,
                       emp_hiredate in emp.hiredate%type,
                       emp_sal in emp.sal%type,
                       emp_comm in emp.comm%type,
                       emp_deptno in emp.deptno%type
             ) is
       begin
               insert into emp values(emp_no,emp_name,emp_job,emp_mgr,emp_hiredate,emp_sal,emp_comm,emp_deptno);
       end;
       -- 查询是否存在
       function fun_pack_emp_selectNo(emp_no in emp.empno%type)return number is
              emp_noYN number;
       begin
              select count(*) into emp_noYN from emp where emp.empno = emp_no;
              return emp_noYN;        
       end;
end;

declare  
       emp_noYN number := 1;
begin
        emp_noYN := pack_emp.fun_pack_emp_selectNo(emp_noYN);
        if emp_noYN = 0 then
           dbms_output.put_line('添加成功');
           pack_emp.pro_pack_emp_add(emp_noYN,'2','3',4,sysdate,6,7,10);
        else
           dbms_output.put_line('添加失败');
        end if;
end;

/*
练习四、
现有账单表如下：
Create table billInfo
(
  billID varchar2(14),  --账单编号，格式为‘ZD 2010 05 29 0001’
  billDate date      --开单时间
);
要求编写过程实现开单功能，即生成账编号并插入记录。
*/
Create table billInfo
(
  billID varchar2(14),  --账单编号，格式为‘ZD 2010 05 29 0001’
  billDate date         --开单时间
);
drop table billInfo;
create sequence seq_billID start with 1 increment by 1 maxvalue 9999; /*cycle(循环)、cache(缓存)*/
drop sequence seq_billID;
create or replace procedure pro_billInfo is 
       ID number := seq_billID.Nextval;
       VID varchar2(4);
begin
       if length(ID) = 1 then
              VID := '000'||ID;
       elsif length(ID) =2 then
              VID := '00'||ID;
        elsif length(ID) =3 then
              VID := '0'||ID;  
        elsif length(ID) =4 then
              VID := ID;  
       end if;      
       insert into billInfo values('ZD'||to_char(sysdate,'YYYYMMDD')||VID,sysdate);
end;
select * from billInfo
call pro_billInfo();
