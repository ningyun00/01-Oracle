
/*
��ϰһ����ʽ�α꣨�α����ԣ�
��������PL/SQL�飬�����û�����Ĳ��ű�ţ�����Ա�����ʡ�
declaer
  dno number;
begin 
  dno:='&dno';
  update emp set sal = sal+100 where deptno = dno;
  -- ��ȫ����;
end;
����ע�ʹ���ȫ����ʵ�֣�������³ɹ�����ʾ�û��ɹ������˶�������¼��������ʾ���Ų����ڡ�
*/
declare
  dno number;
begin 
  dno:='&dno';
  update emp set sal = sal+100 where deptno = dno;
    select count(*)into dno from emp where deptno = dno;
  if dno>0  then
     dbms_output.put_line('�޸���'||dno);
  else
     dbms_output.put_line('���Ų�����');
  end if;
end;

/*
��ϰ������ʽ�α�
ʹ����ʽ�α��дһ����������ʾscott�û���emp���dept���е�empno��ename��sal��deptno��dname����ֶ�ֵ��
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
 ��ϰ����ѭ���α�
��д��������ʾ���������ƺ͸ò��Ű�����Ա��������Ҫ��ʹ����ʽ��ѭ���α�ʵ�֡�
Ч�����£�
���ű�� ��NO,���ƣ�NAME
Ա����1
Ա����2
Ա����3
 */
declare 
       cursor cur_dept is  select deptno,dname from dept group by dept.deptno,dept.dname order by dept.deptno;
       v_cur_dept_row dept%rowtype;
begin
       for v_cur_dept_row in cur_dept
           loop
                  dbms_output.put_line('���ű��'||v_cur_dept_row.deptno||'�����ƣ�'||v_cur_dept_row.dname);
                  declare 
                         cursor cur_emp is  select emp.ename from emp where emp.deptno in v_cur_dept_row.deptno;
                         v_cur_emp_row emp%rowtype;
                         i number :=0;
                  begin
                         for v_cur_emp_row in cur_emp
                             loop
                                     i := i + 1;
                                     dbms_output.put_line('Ա��'||i||'��'||v_cur_emp_row.ename);      
                             end loop;
                  end;
           end loop;
end;

/*
��ϰ�ġ�ʹ���α��������
��userInfo.dmp�ļ��е����ݵ��뵽Scott�û��£����а���UserInfo������UserInfo���пͻ����뱻�����ˣ����������дPL/SQL��䣬�������������û������룬Ҫ���������Ϊ6λ����
��ʾ��dbms_random������ṩ������������ķ�����
ʾ����select dbms_random.value(0,100) from dual;����0-100֮��������
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
��ϰ�壺ʹ�ô�����ʵ��Ա��������ݱ���
*/
create table emp2 as select * from emp;
-- ���ݴ�����
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
