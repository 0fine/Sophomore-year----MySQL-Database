use choose;

#1. 基于图书销售管理数据库，查询4号订单买家的详细信息。
select * from dingdan;
select * from buyer where 买家id in
(select 买家id from dingdan where 订单id like '%4%');


#2. 基于学生选课数据库，查询学生的详细信息。
select * from student join classes
on student.班级编号 = classes.班级编号;


#3. 基于学生选课数据库，查询班级人数少于2人的班级信息。
select 班级名称,count(*) as 班级人数
from student join classes on student.班级编号 = classes.班级编号
group by student.班级编号 having count(*)<2;

#4.	基于学生选课数据库，查询每个学生的选课门数。
select * from student left join choose
on student.学号 = choose.学号;

select 姓名,count(成绩) as 选课门数 
from student left join choose
on student.学号 = choose.学号
group by(student.学号);  

#5.基于学生信息表student和班级信息表classes查询每个班级的男生人数，
select 班级名称,count(*) as 男生人数
from student right join classes 
on student.班级编号=classes.班级编号
and 性别='男' group by 班级名称;

#6.查询学生信息表student的出生日期小于“马浅”出生日期的学生学号、姓名、出生日期。
select * from student;
select a.学号,a.姓名,a.出生日期 
from student a join student b
on a.出生日期<b.出生日期 where b.姓名='马浅';

#7.查询图书销售管理数据库中买家“彭万里”购买的图书总数量。
select * from buyer;
select 姓名,下单数量
from buyer join dingdan 
on buyer.买家id=dingdan.买家id
where buyer.姓名='彭万里';

#8.查询没有被任何学生选修的课程信息。
select * from course left join choose 
on course.课程号 = choose.课程号
where choose.学号 is null;

#方法二 
select * from course
where not exists(select 课程号 from choose
where choose.课程号=course.课程号);

#9.使用">=ALL"的子查询查询图书信息表book中单价最贵的图书信息。
select * from book where 单价>=all(select 单价 from book);

#10.复制student表结构为学生表，将student表中“女”生的学生信息添加到学生表中。
create table 学生 like student;
insert into 学生 select * from student where 性别='女';
select * from 学生;

#11.删除学生“英雄”选修"C++"课程的记录。
#删除记录
delete from choose where 学号=(
select 学号 from student where 姓名='英雄')
and 课程号=(
select 课程号 from course where 课程名称='c++');

update choose set 学号=(
select 学号 from student where 姓名='英雄')
where 课程号=(
select 课程号 from course where 课程名称='c++');

#查看删除后记录
select choose.学号,choose.课程号,course.课程名称,student.姓名 from choose 
join student on choose.学号=student.学号
join course on course.课程号=choose.课程号
where student.姓名='英雄';

#12.查询课程信息表course课程号为“1”或“2”的课程信息，UNION连接语句如下。
select * from course where 课程号=1
union select * from course where 课程号=2;