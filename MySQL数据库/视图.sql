#5、在choose数据库中，为student表创建视图view1。
use choose;
create view view1 as select* from student;
select * from view1;

#6、教师要查询某个班学生的各门课程成绩，
create view view_成绩 as select classes.班级编号,课程名称,成绩,choose.学号,姓名
from classes,choose,student,course
where classes.班级编号=student.班级编号 and choose.学号=student.学号
and course.课程号=choose.课程号;
select * from view_成绩;
drop view view_成绩;


#7、统计每一门课程的选课人数，以及还能允许多少学生继续选课，
#创建选课视图
create view view_选课 as select 学号,课程名称
from course left join choose on course.课程号=choose.课程号;
select * from view_选课;
drop view view_选课;
#查询选课人数
select 课程名称,count(学号) as 选课人数
from view_选课 group by 课程名称;

#8、将view1视图中学号为“01640405”的学生的姓名改为“李平”。
update view1 set 姓名='李平' where 学号='01640405';
select * from view1;

#9、删除view1视图中学号为“01640407”的记录。
delete from view1 where 学号='01640407';

#10、基于choose数据库先创建一个查看成绩不及格（成绩小于50分）的选课视图choose_view。
create view choose_view
as 
select * from choose where 成绩<50;
select * from choose_view;

#11、创建一个学生成绩不及格（成绩小于60分）的检查视图
create view check_view as select * from choose where 成绩<60;
select * from check_view;

#12、在choose数据库中，为“student”表创建视图，并通过视图
create view student_view as select * from student;
select * from student_view;

#13、在choose数据库中，创建视图，查看计算机学院
create view department_view as select * from department where 学院名称='计算机学院';
drop view if exists department_view;
select * from department_view;

#14、在choose数据库中，创建视图，查看总成绩高于“猴子”同学总成绩的学生学号和姓名。
create view view_总成绩 as select student.学号,student.姓名,
sum(成绩) as 总成绩
from student,choose
where student.学号=choose.学号
group by student.学号;
select * from view_总成绩;

select a.学号,a.姓名 from view_总成绩 a,view_总成绩 b
where a.总成绩>b.总成绩 and b.姓名='猴子';
