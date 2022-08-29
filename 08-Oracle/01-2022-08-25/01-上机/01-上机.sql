-- ��ϰһ��
-- ��Scott�û���emp��Ϊ����Դ����дһ�����̸���Ա��������Ա��������нˮ����Ҫ��Ա��������нˮ��Ϊ���������
create or replace procedure pro_emp_outNameSal
(emp_no in number , emp_name out emp.ename%type , emp_sal out emp.sal%type)
is
begin
       select emp.ename,emp.sal into emp_name,emp_sal from emp where emp.empno  = emp_no;
       exception
              when No_data_found then
              dbms_output.put_line('û�ҵ�����');
              emp_name:='��';
              emp_sal:=0;
end;

declare
       emp_name emp.ename%type;
       emp_sal emp.sal%type;
begin
       pro_emp_outNameSal(10,emp_name,emp_sal);
       dbms_output.put_line('�û�����'||emp_name||'�����ʣ�'||emp_sal);
end;
       
-- ��ϰ����
-- ��Scott�û���emp��Ϊ����Դ����дһ����������Ա����ŷ���Ա������ְʱ�䡣
-- �洢����
create or replace procedure pro_emp_outHiredate(emp_no in emp.empno%type , emp_hiredate out emp.hiredate%type)
is
begin
       select emp.hiredate into emp_hiredate from emp where emp.empno = emp_no;
       exception
              when NO_data_found then
              dbms_output.put_line('û�и�Ա��');
              emp_hiredate := to_date(sysdate,'YYYY-MM-DD');
end;

declare
          emp_hiredate emp.hiredate%type;
begin
          pro_emp_outHiredate(7499,emp_hiredate);
          dbms_output.put_line(emp_hiredate);
end;

-- ����
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


-- ��ϰ����
-- ������������ڳ�����ж���һ�������������Ա�����ٶ���һ��������������Ա������ж�Ա���Ƿ���ڡ�
-- ��Ҫ�����û�ִ����Ӳ���֮ǰ���ȵ��ú����жϸ�Ա���Ƿ���ڣ�
-- ��������ڣ�����벢�ύ���ݣ�������ʾ��Ա���Ѵ��ڣ�
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
       -- ����û�
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
       -- ��ѯ�Ƿ����
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
           dbms_output.put_line('��ӳɹ�');
           pack_emp.pro_pack_emp_add(emp_noYN,'2','3',4,sysdate,6,7,10);
        else
           dbms_output.put_line('���ʧ��');
        end if;
end;

/*
��ϰ�ġ�
�����˵������£�
Create table billInfo
(
  billID varchar2(14),  --�˵���ţ���ʽΪ��ZD 2010 05 29 0001��
  billDate date      --����ʱ��
);
Ҫ���д����ʵ�ֿ������ܣ��������˱�Ų������¼��
*/
Create table billInfo
(
  billID varchar2(14),  --�˵���ţ���ʽΪ��ZD 2010 05 29 0001��
  billDate date         --����ʱ��
);
drop table billInfo;
create sequence seq_billID start with 1 increment by 1 maxvalue 9999; /*cycle(ѭ��)��cache(����)*/
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
