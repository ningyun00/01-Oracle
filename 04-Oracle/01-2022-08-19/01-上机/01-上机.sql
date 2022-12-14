-- 练习二：单行函数练习
-- 1、查询所有学员从入学到今天，一共度过了多少天
select sysdate-studentinfo.stujointime 差天 from studentinfo;

-- 2、查询每月2号入学的学员信息
select * from studentinfo where to_char(studentinfo.stujointime,'DD') = 2;

-- 3、查询所有学员的毕业日期，假定按每个学员入学时间1年半之后将毕业。
select studentinfo.stuname,add_months(studentinfo.stujointime,18) from studentinfo;

-- 4、查询星期四入学的学员姓名，性别，年龄，班级编号
select studentinfo.stuname,to_char(studentinfo.stujointime,'day'),classinfo.classnumber from studentinfo inner join classinfo on studentinfo.sclassid = classinfo.classid where to_char(studentinfo.stujointime,'day') = '星期四'

-- 5、查询‘2007-3-10’之前入学的学员信息
select * from studentinfo where to_char(studentinfo.stujointime,'YYYY-MM-DD') < '2007-03-10';

-- 6、查询所有学员姓名的长度
select studentinfo.stuname,length(studentinfo.stuname) from studentinfo;

-- 7、查询身份证中第9，10位为‘89’的学员信息（要求使用字符串函数）
select studentinfo.* from studentinfo where instr(studentinfo.stucard,'89') = 9;

-- 8、修改班主任信息，将邮箱中的‘yahoo’替换为‘accp’
update teacherinfo set teacherinfo.teacheremail = replace(teacherinfo.teacheremail,'yahoo','accp');

-- 9、查询所有班主任的邮箱的用户名
select substr(teacherinfo.teacheremail,1,instr(teacherinfo.teacheremail,'@')-1) from teacherinfo 

-- 10、查询所有班主任的邮箱的所属网站
select substr(teacherinfo.teacheremail,
instr(teacherinfo.teacheremail,'@')+1,
instr(teacherinfo.teacheremail,'.')-1 - 
instr(teacherinfo.teacheremail,'@')) from teacherinfo 

-- 提示：如果邮箱为qtz@yahoo.com，用户名即qtz，所属网站即yahoo。可先查找出‘@’和‘.’的下标，再截取
-- 11、编写查询语句去掉字符串‘   爱你  要你  我  爱  你   ’中的空格
select replace('   爱你  要你  我  爱  你   ',' ','') from dual;

-- 12、计算每个学员身份证中字符‘1’出现的次数
select studentinfo.stuname,regexp_count(studentinfo.stucard,1) from studentinfo;

-- 13、求小于-58.9的最大整数
select round(-58.9,-0.1) from dual;

-- 14、求大于78.8的最小整数
select round(78.8) from dual;

-- 15、求64除以7的余数
select substr(64/7,instr(64/7,'.')+1) from dual;

-- 16、查询所有学员入学时间，要求显示格式为‘2007年03月02日’
select to_char(studentinfo.stujointime,'YYYY')||'年'||to_char(studentinfo.stujointime,'MM')||'月'||to_char(studentinfo.stujointime,'DD')||'日' from studentinfo;

-- 17、查询当前时间，要求显示格式为‘22时57:37’
select to_char(studentinfo.stujointime,'HH12')||'时'||to_char(studentinfo.stujointime,'MI:SS') from studentinfo;

-- 18、查询2007年入学的学员信息
select * from studentinfo where to_char(studentinfo.stujointime,'YYYY') = 2007;

-- 练习三：分组函数练习
-- 1、查询所有学员的平均年龄（要求保留两位小数）
select round(avg(studentinfo.stuage),2) from studentinfo;

-- 2、查询所有考试的总成绩
select sum(studentexam.examresult) from studentexam;

-- 3、查询SQL考试的最低分数
select min(studentexam.examresult) from studentexam where studentexam.examsubject = 'SQL';

-- 4、查询Java考试成绩最高的学员姓名
select max(studentexam.examresult) from studentexam where studentexam.examsubject = 'Java' order by studentexam.examresult desc;

-- 5、查询学员‘火云邪神’一共参加了几次考试
select count(studentexam.examresult) from studentexam where studentexam.estuid = (select studentinfo.stuid from studentinfo where studentinfo.stuname = '火云邪神');

-- 6、查询各科目的平均成绩
select avg(studentexam.examresult) from studentexam group by studentexam.examsubject;

-- 7、查询每个班级学员的最小年龄
select studentinfo.sclassid,min(studentinfo.stuage) from studentinfo group by studentinfo.sclassid;

-- 8、查询考试不及格的人数
select count(*) from studentexam where studentexam.examresult <60;

-- 9、查询各学员的总成绩，要求筛选出总成绩在140分以上的
select * from (select studentexam.estuid,sum(studentexam.examresult) as s from studentexam   group by studentexam.estuid) where s>140;

-- 10、查询男女学员的平均年龄
select studentinfo.stusex,avg(studentinfo.stuage) from studentinfo group by studentinfo.stusex;

-- 11、查询每门功课的平均分，要求显示平均分在80分以上的(包括80分)
select * from (select studentexam.examsubject,avg(studentexam.examresult) a from studentexam group by studentexam.examsubject) where a>=80;

-- 12、按班主任姓名分组，查所带班级的总成绩分（假定每个班主任只带一个班级）(提示：4表连接)
select TeacherName,sum(ExamResult) from Teacherinfo t,StudentInfo s,StudentExam e,ClassInfo c
where t.teacherid=c.cteacherid
and s.sclassid=c.classid
and s.stuid=e.estuid
group by TeacherName;
