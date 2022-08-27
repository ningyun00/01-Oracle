/*
��ϰһ���������ռ�
1.�������ռ���ΪstuSpace���ļ������D�̸�Ŀ¼�£���ʼ��СΪ32M�������Զ�������ÿ������32M�����1G��
*/
drop tablespace stuSpace including contents and datafiles;
create tablespace stuSpace 
datafile 'E:\S3\01-Oracle\02-Oracle\01-2022-08-17\01stuSpace.dbf' 
size 32m 
autoextend on 
next 1m ;

/*
��ϰ��������Oracle�û�
1���û���ΪstuDBA������Ϊstu
2�������ռ�stuSpace����Ϊ�û�stuDBA��Ĭ�ϱ��ռ�
3��Ϊ�û�stuDBA����DBA��ɫ
*/
drop user stuDBA;
grant connect to stuDBA;
grant resource to stuDBA;
grant dba to stuDBA;
create user stuDBA identified by stu default tablespace stuSpace;

/*
��ϰ����������
Ҫ��ʹ��stuDBA�û���¼����������Oracle������������ӦԼ����������SQL�ű�

1��ѧԱ��Ϣ��
������StudentInfo    ������StuID
����                ��������      ����      �Ƿ�Ϊ��    ����
StuID             Number            4       ������     ������¼���
StuNumber         Varchar2          10      ������     ѧԱѧ��
StuName           Varchar2          32      ������     ѧԱ����
StuAge            Number            4       ����       ѧԱ���䣬������16-35��֮��
StuSex            Varchar2          2       ������     ѧԱ�Ա�Ĭ��Ϊ���С���ȡֵ��Χ�ڡ��С���Ů��֮��
StuCard           Varchar2          20      ����       ѧԱ����֤����
StuJoinTime       Date                      ������     ѧԱ��ѧʱ��
StuAddress        Varchar2          50      ����       ѧԱ��ͥסַ
SClassID          number            4       ����       ѧԱ���ڰ༶ID�����������ClassInfo��������ClassID
*/
drop table StudentInfo;
create table StudentInfo(
       StuID Number(4) not null primary key, 
       StuNumber varchar2(10) not null,
       StunName varchar2(32) not null,
       StuAge Number(4) check(StuAge>=16 and StuAge<=35),
       StuSex varchar2(2)default '��' not null check(StuSex in('��','Ů')),
       StuCard varchar2(20),
       StuJoinTime date not null,
       StuAddress varchar2(50),
       SClassID number(4),
       CONSTRAINT fk_SClassID_ClassInfo foreign key (SClassID) references ClassInfo(ClassID)
);
COMMENT ON TABLE StudentInfo IS 'ѧ����Ϣ��';

/*
2���༶��Ϣ��
������ClassInfo    ������ClassID
����              ��������     ����      �Ƿ�Ϊ��   ����
ClassID           Number         4      ������     ������¼���
ClassNumber      Varchar2        20     ������     �༶���(����)
CTeacherID       Number          4      ������     ������ID�����������TeacherInfo��������TeacherID
ClassGrade       Varchar2        2      ������     �༶�����꼶��Ĭ��Ϊ��S1����ȡֵ��Χ�ڡ�S1������S2������Y2��֮��
*/
drop table ClassInfo;
create table ClassInfo(
       ClassID number(4) not null primary key,
       ClassNumber varchar2(20) not null,
       CTeacherID number(4) not null,
       ClassGrade varchar2(2) default'S1' not null check(ClassGrade in('S1','S2','Y2')),
       CONSTRAINT fk_TeacherInfo_ClassInfo foreign key (CTeacherID) references TeacherInfo(TeacherID)
);
comment on table ClassInfo is '�༶��Ϣ��';

/*
3����������Ϣ��
������TeacherInfo    ������TeacherID
����                ��������     ����     �Ƿ�Ϊ��    ����
TeacherID         Number         4        ������      ������¼���
TeacherName       Varchar2       20       ������      ����������
TeacherTel        Varchar2       20       ����        �����ε绰
TeacherEmail      Varchar2       20       ����        �����ε������䣬������뺬�С�@������
*/
drop table TeacherInfo;
create table TeacherInfo(
       TeacherID Number(4) not null primary key,
       TeacherName varchar2(20) not null,
       TeacherTel varchar2(20),
       TeacherEmail varchar2(20) check(TeacherEmail like ('%@%'))
);
comment on table TeacherInfo is '��������Ϣ��';

/*
4��ѧԱ�ɼ���
������StudentExam    ����: ExamID
����                ��������       ����             �Ƿ�Ϊ��         ����
ExamID            Number           4                ������          ������¼���
ExamNumber        Varchar2         32               ������          ���ο��Դ���
EStuID            Number           4                ������          ѧԱ��ϢID�����������StudentInfo��������StuID
ExamSubject       Varchar2         20               ������          ���ο��Կγ�����
ExamResult        Number           4                ����            ѧԱ�ɼ���ȡֵ��Χ��0-100��֮��
*/
drop table StudentExam;
create table StudentExam(
       ExamID number(4) not null primary key,
       ExamNumber varchar2(32) not null,
       EStuID number(4) not null,
       ExamSubject varchar2(20) not null,
       ExamResult number(4) check(ExamResult >= 0 and ExamResult <= 100),
       CONSTRAINT fk_StudentInfo_StudentExam FOREIGN KEY (EStuID) REFERENCES StudentInfo(StuID)
);
comment on table StudentExam is 'ѧԱ�ɼ���';

/*
��ϰ�ģ�����ά��
1��ѧУ���������һ����ѧԱ (��Ϊ�յ�ѧУ����û��δ�����༶�����԰༶��ϢΪNullֵ) ����ϸ��Ϣ������ʾ��������Ҫ����Щ��Ϣ¼�������ݿ�֮�У����дSql��佫������Ϣ����ѧԱ��Ϣ�� (StudentInfo) ��
ѧ��  ����  ����  �Ա�  ����֤ ��ѧʱ��  ��ͥסַ  �༶ID
StuNumber StuName StuAge  StuSex  StuCard StuJoinTime StuAddress  SClassID
001 ����а��  18  �� 430105198905022032  2007-3-1  ��ɳ�п�����  Null
002 ��������  20  �� 430104198703012011  2007-3-10 ������̶  Null
003 С��ɳ�  18  �� 420106198912064044  2007-3-2  �㶫��ɽ  Null
004 ӣ�������� 18  Ů 420106198908061085  2007-3-6  ��ɳ����´��  Null
*/
insert into StudentInfo values
(seq_StudentInfo.Nextval,'001','����а��',18,'��','430105198905022032',to_date('2007-3-1','YYYY-MM-DD'),'��ɳ�п�����',null);
insert into StudentInfo values
(seq_StudentInfo.Nextval,'002','��������',20,'��','430104198703012011',to_date('2007-3-10','YYYY-MM-DD'),'������̶',null);
insert into StudentInfo values
(seq_StudentInfo.Nextval,'003','С��ɳ�',18,'��','420106198912064044',to_date('2007-3-2','YYYY-MM-DD'),'�㶫��ɽ',null);
insert into StudentInfo values
(seq_StudentInfo.Nextval,'004','ӣ��������',18,'Ů','420106198908061085',to_date('2007-3-6','YYYY-MM-DD'),'��ɳ����´��',null);

/*
2��ѧУ���а�������Ϣ������ʾ�����дSQL��佫����¼����TeacherInfo����
����           �绰         email
TeacherName    TeacherTel   TeacherEmail
������         13907311119  tsz@yahoo.com
������         13907315200  qtz@yahoo.com
*/
insert into TeacherInfo values(seq_TeacherInfo.Nextval,'������','13907311119','tsz@yahoo.com');
insert into TeacherInfo values(seq_TeacherInfo.Nextval,'������','13907315200','qtz@yahoo.com');

/*
3������ѧУ׼���¿��༶���༶��Ϣ���±���ʾ�����дSQL��䣬������¼�����༶��Ϣ��ClassInfo�С�
�༶��ţ�07034    �����Σ�������   �꼶��S1 
�༶ѧԱ������а��С��ɳ�
��ɲ�����ʾ��
1���Ӱ�������Ϣ���в��Ұ����� ������������ID
2����༶��Ϣ�������Ӱ༶��Ϣ
�༶���        ������ID       �����꼶
ClassNumber     CTeacherID     ClassGrade
07034           ���ҵ���ID     S1
*/
select TeacherID from TeacherInfo where TeacherInfo.Teachername = '������';
insert into ClassInfo values(seq_ClassInfo.Nextval,'07034',(select TeacherID from TeacherInfo where TeacherInfo.Teachername = '������'),'S1');

/*
3����ѧԱ��Ϣ���У���ѧԱ������а�񡯺͡�С��ɳ�������Ϣ�С��༶ID��һ��ֵ�޸�Ϊ07034���Ӧ�İ༶ID
*/
update StudentInfo 
set StudentInfo.Sclassid = (select ClassInfo.Classid from ClassInfo where ClassInfo.Classnumber='07034') 
where StudentInfo.Stunname='����а��' or StudentInfo.Stunname='С��ɳ�';

/*
4���¿��༶���༶��Ϣ���±���ʾ�����дSQL��䣬������¼�����༶��Ϣ��ClassInfo�С�
�༶��ţ�07038    ������ ������   �꼶��S1 
�༶ѧԱ���������ܣ�ӣ��������
��ɲ�����ʾ��ͬ��3
*/
insert into ClassInfo values(seq_ClassInfo.Nextval,'07038',(select TeacherInfo.Teacherid from TeacherInfo where TeacherInfo.Teachername='������'),'S1');
update StudentInfo 
set StudentInfo.Sclassid = (select ClassInfo.Classid from ClassInfo where ClassInfo.Classnumber='07038') 
where StudentInfo.Stunname='��������' or StudentInfo.Stunname='ӣ��������';

/*
5�����ѧУ��֯��S1��͵�һ�ο��ԣ����Ա��Ϊ��S1_2007070801��,���Կ�ĿΪSQL��Java���ɼ����±���ʾ���밴���±���ʾ������¼�����ݿ�
ѧԱ  ��Ŀ  �ɼ�
����а��  SQL 80
����а��  Java  56
С��ɳ�  SQL 90
С��ɳ�  Java  80
ӣ�������� SQL 95
ӣ�������� Java  80
��������  SQL 80
��������  Java  90

��ɲ�����ʾ��
1����ѧԱ��Ϣ���в��ҳ���Ӧ��ѧԱID
2���ҵ�ѧԱID��������ݵ�¼�빤����
�Ի���а��Ϊ����
ExamNumber  EStuID  ExamSubject ExamResult
���Դ���  ѧԱID  ���Կ�Ŀ  ���Գɼ�
S1_2007070801 ���ҵ���ID  SQL 80
*/
insert into StudentExam values(seq_StudentExam.Nextval,'S1_2007070801',(select StudentInfo.Stuid from StudentInfo where StudentInfo.Stunname='����а��'),'SQL',80);
insert into StudentExam values(seq_StudentExam.Nextval,'S1_2007070801',(select StudentInfo.Stuid from StudentInfo where StudentInfo.Stunname='����а��'),'Java',56);
insert into StudentExam values(seq_StudentExam.Nextval,'S1_2007070801',(select StudentInfo.Stuid from StudentInfo where StudentInfo.Stunname='С��ɳ�'),'SQL ',90);
insert into StudentExam values(seq_StudentExam.Nextval,'S1_2007070801',(select StudentInfo.Stuid from StudentInfo where StudentInfo.Stunname='С��ɳ�'),'Java',80);
insert into StudentExam values(seq_StudentExam.Nextval,'S1_2007070801',(select StudentInfo.Stuid from StudentInfo where StudentInfo.Stunname='ӣ��������'),'SQL ',95);
insert into StudentExam values(seq_StudentExam.Nextval,'S1_2007070801',(select StudentInfo.Stuid from StudentInfo where StudentInfo.Stunname='ӣ��������'),'Java',80);
insert into StudentExam values(seq_StudentExam.Nextval,'S1_2007070801',(select StudentInfo.Stuid from StudentInfo where StudentInfo.Stunname='��������'),'SQL ',80);
insert into StudentExam values(seq_StudentExam.Nextval,'S1_2007070801',(select StudentInfo.Stuid from StudentInfo where StudentInfo.Stunname='��������'),'Java',90);

/*
6�����ڹ�����Աʧ�󣬾���֤����������û�вμӱ��ο��ԣ��������ݿ��н���ѧԱ�Ŀ�����Ϣɾ����
*/

delete from StudentExam where StudentExam.Estuid = (select StudentInfo.Stuid from StudentInfo where StudentInfo.Stunname = '��������');

/*�鿴��*/
select * from StudentExam;
select * from StudentInfo;
select * from ClassInfo;
select * from TeacherInfo;

/*����*/
create sequence seq_StudentInfo start with 1 increment by 1 maxvalue 100;
create sequence seq_StudentExam start with 1 increment by 1 maxvalue 100;
create sequence seq_ClassInfo   start with 1 increment by 1 maxvalue 100;
create sequence seq_TeacherInfo start with 1 increment by 1 maxvalue 100;

/*ɾ������*/
drop sequence seq_StudentInfo;
drop sequence seq_StudentExam;
drop sequence seq_ClassInfo;
drop sequence seq_TeacherInfo;

/*��ʽ��˳��*/
drop table StudentExam;
drop table StudentInfo;
drop table ClassInfo;
drop table TeacherInfo;