-- ��ϰһ��ʹ�������ṹ
-- ������������˾������ְԱ��emp�����Ž���
-- ����ԭ�����ְԱ���ڲ��ű�ţ�deptno�������㡣
-- ������ű��Ϊ��10��������Ϊ2000Ԫ�����ű��Ϊ��20����
-- ����Ϊ1700Ԫ�����ű��Ϊ��30��������Ϊ1500Ԫ��
-- ���������ṹ��������⡣
-- ��ʾ�����ȸ����û������Ա����ţ�empno��
-- ������Ӧ�Ĳ��ű�ţ�deptno����Ȼ����ݲ��ű�ţ�deptno���жϣ�����нˮsal��
declare 
   scott_emp_empno number:='&������Ա�����';
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

-- ��ϰ����ʹ��ѭ���ṹ
-- �������������дһ������ͨ��ѭ����course_details���в���10������¼��Ҫ��ѧ�����ÿ���ۼ�1���γ����û����롣
-- ��ṹ��
create table course_details
(
  sid number,--ѧԱ���
  course varchar2(20)--�γ�
);
-- ������յĿγ�Ϊoralce
-- Ч�����£�
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

-- ��ϰ������дһ��������ʾ1��100֮�����������������
-- ��ʾ��
-- 1����������������ֻ�ܱ�1�ͱ�������������
-- 2��ʹ��forѭ��
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
��ϰ�ġ���userInfo.dmp�ļ��е����ݵ���Scott�û��£����ļ��а���UserInfo�û���Ϣ���ṹ���£�
����  ע��
CUSTOMERID  �ͻ����
CREATETIME  �ͻ�����ʱ��
EMAIL �ͻ�email
LANGUAGE  �ͻ�����
USERNAME  �ͻ��ʻ�
SCREENNAME  �س�
PASSWORD  ����
ISMALE  �Ƿ�ͨ��������֤
BIRTHDAY  ����
POSTALCODE  ��������
FIRSTNAME ��һ����
LASTNAME  �ڶ�����
ADDRESS ��ַ
���дPL/SQL�飬ͳ��70��80��90���û���������ռ���������͵ı�����Ч�����£�
*/
declare
       point70 number :=0;
       point80 number :=0;
       point90 number :=0;
begin
       select count(*) into point70 from scott.userinfo where to_char(scott.userinfo.birthday,'YYYY') like '%__7_%';
       select count(*) into point80 from scott.userinfo where to_char(scott.userinfo.birthday,'YYYY') like '%__8_%';
       select count(*) into point90 from scott.userinfo where to_char(scott.userinfo.birthday,'YYYY') like '%__9_%';
       dbms_output.put_line(70||'��'||point70||'��;'||80||'��'||point80||'��;'||90||'��'||point90||'��;');
       dbms_output.put_line(70||'��ռ��'||round(point70/(point70+point80+point90)*100,2)||'%');
       dbms_output.put_line(80||'��ռ��'||round(point80/(point70+point80+point90)*100,2)||'%');
       dbms_output.put_line(90||'��ռ��'||round(point90/(point70+point80+point90)*100,2)||'%');
end;

drop table course_details
drop table scott.userinfo
