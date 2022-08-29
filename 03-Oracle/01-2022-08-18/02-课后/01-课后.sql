/*
��ϰһ����������
���ϻ���ҵ��school.dmp�ļ��е����ݵ��뵽Scott�û��¡�
���ļ��а���4�����ݱ��ֱ��ǣ�StudentInfo��TeacherInfo��ClassInfo��StudentExam��
��ϰ����������ѯ�Ͳ�����
*/
-- 1����ѯ����ѧԱ��Ϣ
select * from StudentInfo;

-- 2����ѯ����ѧԱ�����������䣨Ҫ��������������ʾ��
select studentinfo.stunname as ����,studentinfo.stuage as ���� from Studentinfo;

-- 3����ѯѧԱ�����乲���ļ���ֵ��Ҫ�󲻼����ظ��
select studentinfo.stuage from studentinfo group by studentinfo.stuage;

-- 4����ѯ����Ů��ѧԱ����Ϣ
select * from studentinfo where studentinfo.stusex = 'Ů';

-- 5����ѯǰ����ѧԱ����Ϣ��Ҫ��ʹ��rownum��
select * from (select * from studentinfo) where rownum <=2;

-- 6����ѯѧԱ��Ϣ��Ҫ����ʾЧ�����£�
select  '����'||studentinfo.stunname||',����'||studentinfo.stuage||',��ס'||studentinfo.stuaddress as ѧԱ��Ϣ from studentinfo;

-- 7����ѯ����С��20�꣬��ס��ɳ������ѧԱ��Ϣ
select * from studentinfo where studentinfo.stuage<20 and studentinfo.stusex = '��' and studentinfo.stuaddress like '%��ɳ%';

-- 8����ѯ������16-18��(����16,18��)��ѧԱ��Ϣ
select * from studentinfo where studentinfo.stuage between 16 and 18;

-- 9����ѯ���֤�а����С�1989���ַ���ѧԱ��Ϣ
select * from studentinfo where studentinfo.stucard like '%1989%';

-- 10����ѯ��2007-3-5������ѧ��ѧԱ��Ϣ
select * from studentinfo where studentinfo.stujointime > to_date('2007-3-5','YYYY-MM-DD')

-- 11����ѯ�����ַΪyahoo�İ�������Ϣ
select * from TeacherInfo where TeacherInfo.teacheremail like '%yahoo%'

-- 12����ѯ�ֻ��ԡ�139����ͷ�İ�������Ϣ
select * from teacherinfo where teacherinfo.teachertel like '139%'

-- 13����ѯ���䲻Ϊ������ѧԱ��ѧ�ţ�������סַ
select * from studentinfo where studentinfo.stuage is not null and studentinfo.stusex ='��';
-- 14����ѯѧ���ڡ�001��,��003��,��004������֮���ѧԱ��������ѧʱ��
select * from studentinfo where studentinfo.stunumber in ('001','003','004');

-- 15����ѯ����ѧԱ��Ϣ���������併������
select * from studentinfo order by studentinfo.stuage desc;

-- 16����ѯ���гɼ��������Է����������򣬷�����ͬ�ģ���ѧԱ�����������
select * from studentexam order by studentexam.examresult desc,studentexam.estuid asc;

/*��ϰ�����߼���ѯ*/
-- 1����ѯ�ɼ�����80�ֵ�ѧԱ�����Ϳ��Կ�Ŀ
select studentinfo.stunname,studentexam.examsubject from studentexam inner join studentinfo on studentexam.estuid = studentinfo.stuid where studentexam.examresult > 80;

-- 2����ѯ����ѧԱ��Ϣ��Ҫ����ʾ������ѧ�ţ����Կ�Ŀ�����Գɼ��������տ��Գɼ������ѧ����������
select studentinfo.stunname,studentinfo.stunumber,studentexam.examsubject,studentexam.examresult from studentinfo inner join studentexam on studentinfo.stuid=studentexam.estuid order by studentexam.examresult desc,studentinfo.stunumber asc;

-- 3����ѯÿ��������Ӧ�İ��������ƣ�Ҫ����ʾ�༶���ƺͰ���������
select classinfo.classnumber,teacherinfo.teachername from Teacherinfo inner join Classinfo on teacherinfo.teacherid = classinfo.classid;

-- 4����ѯÿ������������ѧԱ��Ϣ��Ҫ����ʾ����������������������ϵ�绰���༶���ƣ�ѧԱ������ѧԱѧ�š�(3������)
select * from teacherinfo inner join Classinfo on teacherinfo.teacherid = classinfo.cteacherid inner join studentinfo on studentinfo.sclassid = classinfo.classid;

-- 5����ѯ����ѧԱ��Ϣ�������ڰ༶���飬Ҫ����ʾ�༶��ţ��͸ð༶����ƽ����,����ƽ���ֵĽ������򡣣�3�����ӣ�
select classinfo.classnumber,avg(studentexam.examresult) from studentinfo inner join classinfo on studentinfo.sclassid = classinfo.classid inner join studentexam on studentexam.estuid= studentinfo.stuid group by classinfo.classnumber order by AVG(studentexam.examresult) desc;

-- 6����ѯ��ѧԱ������а������ͬһ���ѧԱ��Ϣ
select * from studentinfo where studentinfo.sclassid = (select studentinfo.sclassid from studentinfo where studentinfo.stunname = '����а��');

-- 7����ѯJava���Լ���>=60�֣���ѧԱ��ϸ��Ϣ
select * from studentinfo where studentinfo.stuid in (select studentexam.estuid from studentexam where studentexam.examsubject = 'Java' and studentexam.examresult>=60);

-- 8����ѯ��ѧԱ������ա�����ͬһ����������ͬ��ѧԱ��Ϣ
select * from studentinfo where studentinfo.sclassid = (select studentinfo.sclassid from studentinfo where studentinfo.stunname = '�����') and studentinfo.stuage = ((select studentinfo.stuage from studentinfo where studentinfo.stunname = '�����'));
-- 9����ѯ������С����λѧԱ�������ͼ�ͥסַ
select * from (select * from studentinfo order by studentinfo.stuage)where rownum <=3
-- 10����ѯ���Գɼ���SQL�γ̵�ǰ�����ĳɼ���Ϣ
select * from (select * from studentexam where studentexam.examsubject = 'SQL' order by studentexam.examresult) where rownum<=3;

-- 11����ѯ���Գɼ���Java�γ̵ĵڶ����ĳɼ���Ϣ
select * from (select rownum as r,studentexam.* from studentexam where studentexam.examsubject = 'Java' order by studentexam.examresult desc) where r = 2;

-- 12����ѯѧԱ��Ϣ��ɸѡ����3-4����¼
select * from (select rownum as r,studentinfo.* from studentinfo) where r>=3 and r<=4;
