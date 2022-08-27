/*
练习一：导入数据
将上机作业中school.dmp文件中的数据导入到Scott用户下。
该文件中包含4个数据表，分别是：StudentInfo表，TeacherInfo表，ClassInfo表，StudentExam表。
练习二：基本查询和操作符
*/
-- 1、查询所有学员信息
select * from StudentInfo;

-- 2、查询所有学员的姓名，年龄（要求列名用中文显示）
select studentinfo.stunname as 姓名,studentinfo.stuage as 姓名 from Studentinfo;

-- 3、查询学员的年龄共有哪几种值（要求不计算重复项）
select studentinfo.stuage from studentinfo group by studentinfo.stuage;

-- 4、查询所有女性学员的信息
select * from studentinfo where studentinfo.stusex = '女';

-- 5、查询前两个学员的信息（要求使用rownum）
select * from (select * from studentinfo) where rownum <=2;

-- 6、查询学员信息，要求显示效果如下：
select  '姓名'||studentinfo.stunname||',年龄'||studentinfo.stuage||',家住'||studentinfo.stuaddress as 学员信息 from studentinfo;

-- 7、查询年龄小于20岁，家住长沙的男性学员信息
select * from studentinfo where studentinfo.stuage<20 and studentinfo.stusex = '男' and studentinfo.stuaddress like '%长沙%';

-- 8、查询年龄在16-18岁(包括16,18岁)的学员信息
select * from studentinfo where studentinfo.stuage between 16 and 18;

-- 9、查询身份证中包含有‘1989’字符的学员信息
select * from studentinfo where studentinfo.stucard like '%1989%';

-- 10、查询‘2007-3-5’后入学的学员信息
select * from studentinfo where studentinfo.stujointime > to_date('2007-3-5','YYYY-MM-DD')

-- 11、查询邮箱地址为yahoo的班主任信息
select * from TeacherInfo where TeacherInfo.teacheremail like '%yahoo%'

-- 12、查询手机以‘139’开头的班主任信息
select * from teacherinfo where teacherinfo.teachertel like '139%'

-- 13、查询年龄不为空男性学员的学号，姓名，住址
select * from studentinfo where studentinfo.stuage is not null and studentinfo.stusex ='男';
-- 14、查询学号在‘001’,‘003’,‘004’三者之间的学员姓名和入学时间
select * from studentinfo where studentinfo.stunumber in ('001','003','004');

-- 15、查询所有学员信息，并按年龄降序排序
select * from studentinfo order by studentinfo.stuage desc;

-- 16、查询所有成绩，按考试分数降序排序，分数相同的，按学员编号升序排序
select * from studentexam order by studentexam.examresult desc,studentexam.estuid asc;

/*练习三：高级查询*/
-- 1、查询成绩大于80分的学员姓名和考试科目
select studentinfo.stunname,studentexam.examsubject from studentexam inner join studentinfo on studentexam.estuid = studentinfo.stuid where studentexam.examresult > 80;

-- 2、查询所有学员信息，要求显示姓名，学号，考试科目，考试成绩，并按照考试成绩降序和学号升序排序
select studentinfo.stunname,studentinfo.stunumber,studentexam.examsubject,studentexam.examresult from studentinfo inner join studentexam on studentinfo.stuid=studentexam.estuid order by studentexam.examresult desc,studentinfo.stunumber asc;

-- 3、查询每个班所对应的班主任名称，要求显示班级名称和班主任名称
select classinfo.classnumber,teacherinfo.teachername from Teacherinfo inner join Classinfo on teacherinfo.teacherid = classinfo.classid;

-- 4、查询每个班主任所带学员信息，要求显示：班主任姓名，班主任联系电话，班级名称，学员姓名，学员学号。(3表连接)
select * from teacherinfo inner join Classinfo on teacherinfo.teacherid = classinfo.cteacherid inner join studentinfo on studentinfo.sclassid = classinfo.classid;

-- 5、查询所有学员信息，按所在班级分组，要求显示班级编号，和该班级考试平均分,并按平均分的降序排序。（3表连接）
select classinfo.classnumber,avg(studentexam.examresult) from studentinfo inner join classinfo on studentinfo.sclassid = classinfo.classid inner join studentexam on studentexam.estuid= studentinfo.stuid group by classinfo.classnumber order by AVG(studentexam.examresult) desc;

-- 6、查询与学员‘火云邪神’属于同一班的学员信息
select * from studentinfo where studentinfo.sclassid = (select studentinfo.sclassid from studentinfo where studentinfo.stunname = '火云邪神');

-- 7、查询Java考试及格（>=60分）的学员详细信息
select * from studentinfo where studentinfo.stuid in (select studentexam.estuid from studentexam where studentexam.examsubject = 'Java' and studentexam.examresult>=60);

-- 8、查询与学员‘孙悟空’属于同一班且年龄相同的学员信息
select * from studentinfo where studentinfo.sclassid = (select studentinfo.sclassid from studentinfo where studentinfo.stunname = '孙悟空') and studentinfo.stuage = ((select studentinfo.stuage from studentinfo where studentinfo.stunname = '孙悟空'));
-- 9、查询年龄最小的三位学员的姓名和家庭住址
select * from (select * from studentinfo order by studentinfo.stuage)where rownum <=3
-- 10、查询考试成绩中SQL课程的前三名的成绩信息
select * from (select * from studentexam where studentexam.examsubject = 'SQL' order by studentexam.examresult) where rownum<=3;

-- 11、查询考试成绩中Java课程的第二名的成绩信息
select * from (select rownum as r,studentexam.* from studentexam where studentexam.examsubject = 'Java' order by studentexam.examresult desc) where r = 2;

-- 12、查询学员信息，筛选出第3-4条记录
select * from (select rownum as r,studentinfo.* from studentinfo) where r>=3 and r<=4;
