create database selectTest;
use selecttest;

#创建学生表
create table student(
	sno varchar(20) primary key,
	sname varchar(20) not null,
	ssex varchar(10) not null,
	sbirthday datetime,
	class varchar(20)
);

#创建教师表
create table teacher(
	tno varchar(20) primary key,
	tname varchar(20) not null,
	tsex varchar(10) not null,
	tbirthday datetime,
	prof varchar(20) not null,
	depart varchar(20) not null
);

#课程表
create table course(
	cno varchar(20) primary key,
	cname varchar(20) not null,
	tno varchar(20) not null,
	foreign key(tno) references teacher(tno)
);

#成绩表
create table score(
	sno varchar(20) not null,
	cno varchar(20) not null,
	degree decimal,
	foreign key(sno) references student(sno),
	foreign key(cno) references course(cno),
	primary key(sno , cno)
);

#添加学生数据
insert into student values('101' , '姚云峰' , '男' , '2020-4-1' , '1006');
insert into student values('102' , '党春茹' , '女' , '1999-5-1' , '1006');
insert into student values('103' , '周宇金' , '女' , '2017-8-3' , '1005');
insert into student values('104' , '党浩' , '男' , '2010-5-21' , '1006');
insert into student values('105' , '左岩西' , '男' , '1997-5-5' , '1006');
insert into student values('106' , '二狗' , '女' , '1920-9-8' , '1003');
insert into student values('107' , '张宇豪' , '男' , '1998-8-24' , '1008');
insert into student values('108' , '吴红石' , '男' , '2008-5-30' , '1006');
insert into student values('109' , '耿乐乐' , '女' , '1999-4-1' , '1009');
insert into student values('110' , '王诗越' , '女' , '2020-12-24' , '1007');
insert into student values('111' , '武悦悦' , '男' , '1900-8-1' , '1002');
select * from student;


#添加教师表
insert into teacher values('001' , '李成' , '男' , '2018-2-2' , '副教授' , '计算机系');
insert into teacher values('002' , '张庆茹' , '女' , '1998-2-2' , '教授' , '信息工程系');
insert into teacher values('003' , '王敏' , '女' , '1963-5-26' , '助教' , '计算机系');
insert into teacher values('004' , '李嘉' , '男' , '1989-2-2' , '教授' , '电子技术系');
select * from teacher;


#添加课程表
insert into course values('3-110' , '计算机导论' , '001');
insert into course values('2-215' , '操作系统原理' , '003');
insert into course values('1-158' , '数据库原理' , '004');
insert into course values('2-113' , '计算机组成原理' , '002');
select * from course;

#添加成绩表
insert into score values('101' , '3-110' , '87');
insert into score values('102' , '2-215' , '75');
insert into score values('103' , '1-158' , '44');
insert into score values('104' , '2-113' , '73');
insert into score values('105' , '3-110' , '86');
insert into score values('106' , '2-113' , '64');
insert into score values('107' , '1-158' , '85');
insert into score values('108' , '3-110' , '78');
insert into score values('109' , '2-215' , '86');
insert into score values('110' , '2-113' , '93');
insert into score values('111' , '1-158' , '74');
insert into score values('111' , '3-110' , '89');
select * from score;

#############################################################
#查询练习

#1.查询student所有信息 
select * from student;

#2.查询student表中的所有记录的sname、ssex和class类
select sname,ssex,class from student;

#3.查询教师所有单位即不重复的depart列（distinct排除重复）
select depart from teacher;
select distinct depart from teacher;

#4.查询score表中成绩在60到80之间的所有记录 
#方法一：between and
select * from score where degree between 60 and 80;

#方法二：运算符比较
select * from score where degree>60 and degree<80;

#5.查询score表中的成绩为85，86，88的记录
use selecttest;
select * from score where degree in ("85","86","88");
#表示或的关系
select * from score where degree = 86 or degree = 85;

#6.查询student表中95031班或性别为男的同学记录
select * from student where class = 95031 or ssex = '男';

#7.以class降序查询student表的所有记录
#升序降序如何表达：
#asc升序
#desc降序
select * from student order by class desc;
#不写asc默认是升序 
select * from student order by class;

#8.以cno升序、degree降序查询score表的所有记录
select * from score order by cno asc,degree desc;

#9.查询1005班级的学生人数
#统计 count
select count(*) from student where class = 1005;
select * from student where class = 1005;

#10.查询score表中的最高分的学生学号和课程号（子查询或者排序）
select sno,cno from score where degree =(select max(degree)from score);
#(1)找到最高分 
select max(degree) from score;
#(2)找到最高分的sno和cno
select sno,cno from score where degree = (select max(degree) from score);
#排序的做法：
select sno,cno,degree from score order by degree;
select sno,cno,degree from score order by degree desc;
select sno,cno,degree from score order by degree desc limit 0,1;

#11.查询每门课的平均成绩
select * from course;
select avg(degree) from score where cno = '1-158'; #数据库原理平均成绩
select avg(degree) from score where cno = '2-113'; #计算机组成原理平均成绩
select avg(degree) from score where cno = '2-215'; #操作系统原理平均成绩
select avg(degree) from score where cno = '3-110'; #计算机导论平均成绩
#写在一个sql语句中
select cno,avg(degree) from score group by cno;
select * from score where cno = '1-158';

#查询score表中的至少有两名学生选修的并以3开头的课程平均分数
select avg(degree) from score group by cno having count(cno)>=2 and cno like '2%';
select cno,avg(degree),count(cno) from score 
group by cno having count(cno)>=2 and cno like '2%';

#13.查询分数大于70，小于90的sno列
select sno,degree from score where degree>70 and degree<90;
select sno,degree from score where degree between 70 and 90;

#14.查询所有学生的sname，cno，degree列
#查询成绩表
select cno,degree from score;
#查询学生表
select sno,sname from student;
select sname,cno,degree from student,score where student.sno=score.sno;

#17.查询1006班学生每门科的平均分
select class from student;   
select * from student where class = '1006';
select sno from student where class = '1006';
select * from score 
where sno in (select sno from student where class = '1006');
select cno,avg(degree) from score
where sno in (select sno from student where class = '1006') group by cno;

#18.查询选修3-110课程的成绩低于111号同学3-110成绩的所有同学
select * from course;
select degree from score where sno = 111 and cno = '3-110';
select * from score where cno = '3-110' 
and degree<(select degree from score where sno = 111 and cno = '3-110');

#19.查询成绩高于学号为111课程号为3-110的成绩所有记录 
select degree from score where cno = '3-110' and sno = '111';
select * from score 
where degree>(select degree from score where cno = '3-110' and sno = '111');

#20.查询和学号108、101的同学同年出生的所有学生的sno，sname，sbirthday列
select year(sbirthday) from student where sno=108 or sno=101;
select sno,sname,sbirthday from student where year(sbirthday) 
in (select year(sbirthday) from student where sno=108 or sno=101);

#21.查询李成教师任课的学生成绩
select tno from teacher where tname = '李成';
select cno from course where tno in(select tno from teacher where tname = '李成');
select degree from score where cno in
(select cno from course where tno in(select tno from teacher where tname = '李成'));

#22.查询选修某课程的同学人数多于三人的教师姓名 
select cno from score group by cno having count(*)>3;
select tno from course where cno in(select cno from score group by cno having count(*)>3);
select tname from teacher where tno in(select tno from course where cno in(select cno from score group by cno having count(*)>3));
#查询1005班和1003班全体学生的记录 
select * from student where class in('1005','1003');

#24.查询存在有85分以上成绩的课程cno
select cno,degree from score where degree>=85;

#25.查询计算机系老师所教课程的成绩表
select tno from teacher where depart='计算机系';
select cno from course where tno in(select tno from teacher where depart='计算机系');
select * from score where cno in(select cno from course where tno in(select tno from teacher where depart='计算机系'));

#26.查询信息工程系与电子技术系不同职称的教师的tname和prof
#  –union联合求并集
select * from teacher where depart='信息工程系' and prof not in(select * from teacher where depart='电子技术系') 
union
select * from teacher where depart='电子技术系' and prof not in(select * from teacher where depart='信息工程系'); 

#27.查询选修编号为2-113且成绩至少低于选修编号为3-110的同学的cno，sno，degree，并按照degree从高到低查询 
select * from score where cno='2-113';
select * from score where cno='3-110';
select * from score 
where degree in(select * from score where cno='2-113')<
degree in(select * from score where cno='3-110')
order by degree desc;
#纠正
select * from score
where cno='2-113' and degree<any(select degree from score
where cno='3-110') order by degree desc;

#28.查询选修编号为2-113且成绩高于选修编号为3-110的同学的cno，sno，degree
select * from score
where cno='2-113' and degree>all(select degree from score
where cno='3-110');

#29.查询所有教师和学生的name，sex，birthday
#用union联合求并集 
select tname as name,tsex as sex,tbirthday as birthday from teacher
union 
select sname,ssex,sbirthday from student;

#30.查询女教师和女同学的name，sex，birthday
select tname as name,tsex as sex,tbirthday as birthday 
from teacher where tsex='女' 
union
select sname,ssex,sbirthday from student where ssex='女';

#31.查询成绩比该课程的平均成绩低的同学的成绩表 
select cno,avg(degree) from score group by cno;
select * from score 
where degree<any(select avg(degree) from score group by cno); 
#纠正： 
select * from score a where degree<(select avg(degree) 
from score b where a.cno=b.cno); 

#32.查询所有任课教师的tname和depart
select tname,depart from teacher;
#纠正： 
select tname,depart from teacher where tno in(select tno from course);

#33.查询至少有两名男生的班级号
select class from student where ssex='男' count(*)>2; 
#订正：
select class from student 
where ssex='男' group by class having count(*)>1; 

#34.查询表中不姓王的同学
select * from student where sname not like('王');
#纠正： 
select * from student where sname not like('王%');

#35.查询student表中每个学生的姓名和年龄 
#年龄=当前日期-出生年份 
#查询当前年份 
select year(now());
select year(sbirthday) from student;
select sname,year(now())-year(sbirthday) as age from student;

#37.以班号和年龄从大到小的顺序查询student表中的全部记录 
select * from student order by class,year(now())-year(sbirthday) desc;
select * from student order by class desc , sbirthday ; 

#38.查询男教师及其所上的课程 
select tname from teacher where tsex='男';
select cname from course 
where tno in(select tno from teacher where tsex='男');

#39.查询最高分的同学的sno，cno，degree
select * from score where max(degree);
#纠正： 
select max(degree) from score;
select * from score where degree in(select max(degree) from score);

#4.查询和姚云峰同性别的所有同学的sname
select sname from student 
where ssex in(select ssex from student where sname='姚云峰');

#41.查询和姚云峰同性别并且同班的同学的sname
select sname from student
where ssex in(select ssex from student where sname='姚云峰')
and class in(select class from student where sname='姚云峰');

#42.查询所有选修计算机导论的男同学的成绩表 
select * from score 
where sno in(select sno from student where ssex='男')
and cno in(select cno from course where cname='计算机导论');

#43.建立grade表 
create table grade(
	low int(3),
	upp int(3),
	grade char(1)
);

insert into grade values(90,100,'A');
insert into grade values(80,89,'B');
insert into grade values(70,79,'C');
insert into grade values(60,69,'D');
insert into grade values(0,59,'E');

select * from grade;













