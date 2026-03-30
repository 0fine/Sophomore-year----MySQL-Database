#1.查询所有的课程的名称以及对应的任课老师姓名 
select * from course;
select * from teacher;
select cname,tname from course,teacher 
where course.teacher_id=teacher.tid; #最终答案

#2.查询学生表中男女生各有多少人 
select * from student;
select gender,count(*) from student where gender='男';
select gender,count(*) from student where gender='女';
select gender,count(gender) from student group by gender; #最终答案
select gender,count(*) from student group by gender; #最终答案

#3.查询物理成绩等于100的学生的姓名 
select * from student;
select * from score;
select student_id from score 
where course_id in(select cid from course where cname='物理') 
and num='100'; 

select * from score 
where course_id in(select cid from course
where cname = '物理'); #筛选物理成绩 

#采用and，条件的交集 
select sname from student 
where sid in(select student_id from score 
where course_id in(select cid from course where cname='物理') 
and num='100');  #最终答案

#用内连接 
select student.sname from score
inner join student on student.sid = score.student_id
inner join course on score.course_id = course.cid
where course.cname = '物理' and score.num=100;  #答案二 



#4.查询平均成绩大于八十分的同学的姓名和平均成绩 
select sname,avg(num) 
from student,score
where student.sid = score.student_id
group by student_id having avg(num);  #最终答案 

#5.查询所有学生的学号，姓名，选课数，总成绩 
select * from student;
select * from course;
select * from class;
select * from score;

select student.sid,sname,count(course_id),sum(num)
from student,score
where student.sid = score.student_id
group by student_id having count(course_id) and sum(num);#最终答案

select student_id,sid,sname 
from score inner join student
on score.student_id = student.sid
where sum(num);

#6.查询姓李老师的个数 
select * from teacher;
select count(tname) from teacher where tname regexp '^李'; #最终答案

#7.查询没有报李平老师课的姓名 
select * from teacher;  #李平的tid=2
select * from course;  #tid=2——cid=2,cid=4
select * from score;

select sname from student
where sid not in 
(select student_id from score where course_id in
(select cid from course where teacher_id in 
(select tid from teacher where tname='李平老师'))); #最终答案

#8.查询物理课程比生物课程高的学生的学号 
select * from score;
select * from course; #物理cid=2 生物cid=1
select * from score 
where course_id in(select cid from course where cname='物理');

select student_id from score 
where 
(num in(select * from score 
where course_id in(select cid from course where cname='物理')) > 
num in(select * from score 
where course_id in(select cid from course where cname='生物')))
group by student_id;

#参考答案 
/*1.查询物理成绩  2.查询生物成绩  3.合表，比较成绩大小 */
select course_phy.student_id,course_phy.num,course_bio.num
from(select student_id,num 
from score inner join course on score.course_id = course.cid
where cname = '物理')
course_phy inner join(select student_id,num from score
inner join course on score.course_id = course.cid 
where cname='生物')
course_bio on course_phy.student_id = course_bio.student_id
where course_phy.num>course.bio.num;

#9.查询没有同时选修物理课程和体育课程的学生姓名 
select * from student;
select * from course;
select * from class;
select * from course where cname in('物理','体育'); #取并集 in()

select sname from student where class_id 
not in(select cid from course where cname in('物理','体育')); 

#参考答案 
SELECT sname FROM student WHERE sid NOT IN 
   (
   SELECT student_id FROM score
	      INNER JOIN course ON score.course_id = course.cid
	      WHERE cname IN ("物理","生物") 
	      GROUP BY student_id
	      HAVING COUNT(1) = 2
   ) ;

#10.查询挂科超过两门（包括两门）的学生姓名和班级
select * from student;
select * from class;

select sname,caption from student 
inner join class on student.class_id = class.cid
where sid in(
select student_id from score 
where num<60
group by student_id
having count(*)>=2);  #最终答案 

select sname,caption
from student,class
where student.class_id = class.cid
and sid in(select * from score 
group by student_id having count(score.num<60)>2);

#11.查询选修了所有课程的学生姓名 
select * from score;
select sname from student 
where sid in 
(select student_id from score 
group by student_id 
having count(course_id)=(select count(*) from course));
#最终答案 

select student_id from score 
group by student_id having count(course_id)=4;

#12.查询李平老师教的课程的所有成绩记录 
select * from teacher;  #李平老师的tid=2
select * from score;
select * from course;
select * from score where course_id
in(select cid from course 
where teacher_id in(select tid from teacher where tname='李平老师') );
#最终答案 

#13.查询全部学生都选修了的课程号和课程名 
select * from score;
select * from course;
select cname,cid from course
where exists
(select * from score where score.course_id = course.cid );
#最终答案 

#14.查询每门课程被选修的次数 
select * from score;
select count(course_id),cname from score,course
where score.course_id = course.cid
group by course_id;  #最终答案 

#15.查询只选修了一门课程的学生姓名和学号 
select * from score;
select sname,sid from student 
where sid in(select * from score
group by student_id having count(student_id)=1);
#最终答案 

#16.查询所有学生考出的成绩并按从高到低排序（成绩去重）
select distinct num from score order by num desc; #最终答案 


/*
内连接：
		等值链接(多表的交集部分；n表连接，至少需要n-1个连接条件；多表顺序没有要求；一般需要为表起别名)、
		非等值链接、
        自连接
外连接：左外连接、右外连接、全外连接 
交叉连接
*/
#17.查询平均成绩大于85的学生姓名和平均成绩 
select avg(num),sname from score,student 
where score.student_id = student.sid
group by student_id
having avg(score.num)>85;  #最终答案 

select avg(num),sname from score,student 
where score.student_id = student.sid
group by student_id
having avg(score.num);

#18.查询生物成绩不及格的学生姓名和对应生物分数 
select * from student;
select * from score;
select * from course;  #生物cid=1
select * from score where num in(select course_id 
in(select cid from course where cname='生物'))<60;  #查询生物的成绩 
select sname,num 
from student,score
#where student.sid=score.student_id
group by course_id in(select cid from course where cname='生物')
having num<60;

select sname,num 
from student,score
where student.sid=score.student_id
and course_id in(select cid from course where cname='生物')
having num<60;

and num in(select * from score where course_id
in(select cid from course where cname='生物'))<60;  #查询生物的成绩 

select num from score where num 
in(select num from score where course_id 
in(select cid from course where cname='生物'))<60;
select sname,num from student,score 
where num 
in(select num from score where course_id 
in(select cid from course where cname='生物'))<60;


#19.查询在所有选修了李平老师课程的学生中，
#这些课程（李平老师的课程，不是所有课程）平均成绩最高的学生姓名 
select * from teacher; #tid=2
select * from course; #cid=2  cid=4
select * from score;
select sname from student 
where sid in(
select student_id where score
group by
);

#20.查询每门课程成绩最好的前两名学生姓名 
select sname from student 
where sid in(
select student_id from score
group by course_id
order by num);











