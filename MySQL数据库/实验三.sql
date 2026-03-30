use choose;
#1 查询信息表student中的学号、姓名 
select * from student;
select 学号,姓名 from student;

#2 查询学生信息表student中的学号、姓名、年龄 
select 学号,姓名,year(now())-year(出生日期) as 年龄 from student;

#3 查询图书信息表book的折后价（优惠25%），折后价=单价*0.75
select * from book;
select 单价*0.75 as 折后价 from book;

#4 查询课程信息表course中的学分少于4的课程信息 
select * from course;
select * from course where 学分<4;

#6 在学生信息表student中查询“01”班的“女”生有哪些 
select * from student where 班级编号='01' and 性别='女';

#7 在课程信息表course中查询学分在[2,4]范围内的课程信息 
select * from course;
select * from course where 2<=学分<=4;

#8 在学生信息表student中查询“01”班、“03”班的详细信息 
select * from student where 班级编号 in('01','03');

#10 查询课程信息表中课程名称包含“数据库”字符的课程名称和学分
select * from course;
select 课程名称,学分 from course where 课程名称 like '%数据库%';

#11 查询学生信息表中姓名的第二字是“浅”的学生信息
select * from student;
select * from student where 姓名 like '_浅%';

#12 查询学生选课表中成绩为空的信息
select * from choose;
select * from choose where 成绩 is null;

#13 查询学生选课表choose选修"1"号课程的成绩，并按成绩降序排列
select 成绩 from choose where 课程号='1' order by 成绩 desc;

#14 查询学生信息表student的学生的详细信息，按年龄升序排列
select * from student order by year(now())-year(出生日期);

#15查询学生选课表中选修“1”号课程的前三名的成绩
select 成绩 from choose where 课程号='1' order by 成绩 desc limit 3;

#16查询选了课的学生学号
select distinct 学号 from choose;

#17查询学生信息表student中学生人数
select count(*) as 学生人数 from student;

#18查询学生选课表choose中的“1”号课程成绩的最高分和最低分
select max(成绩) as 最高分,min(成绩) as 最低分 from choose where 课程号='1';

#19查询订单表dingdan中总的下单数量和平均下单数量
select * from dingdan;
select sum(下单数量) as 总下单量,avg(下单数量) as 平均下单量 from dingdan;

#20查询订单表dingdan中“2”号买家的总的下单数量和平均下单数量
select sum(下单数量) as 总下单量,avg(下单数量) as 平均下单量 
from dingdan where 买家id='buyer2';

#21将学生信息表student按照“班级编号”分组，统计各班级的学生人数
select * from student;
select 班级编号,count(*) as 班级人数 from student group by 班级编号;

#22查询订单表dingdan中每位买家的总的下单数量和平均下单数量
select 买家id,sum(下单数量),avg(下单数量) from dingdan group by 买家id;

#23统计每个学生选修了多少门课程，以及该学生所获得的总成绩和平均成绩
select * from choose;
select count(学号) as 选修课程门数,sum(成绩) as 总成绩,avg(成绩) as 平均成绩
from choose group by 学号;

#24统计选课门数超过2门的学号和课程门数
select 学号,count(学号) as 课程门数
from choose group by 学号 having count(学号)>2;
