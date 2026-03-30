use choose;

#1)	创建一个名为s1_proc的存储过程，查看学生选课数据库中学生的总人数。
delimiter $$
create procedure s1_proc()
reads sql data
begin
select count(*) from student;
end;$$

#调用 
call s1_proc();$$


#2)	 创建名为c_proc的存储过程，根据学号查询该学生选修了哪些课程。并调用该存储过程。
delimiter $$
create procedure c_proc(in sno char(20))
reads sql data 
begin
select 课程名称 from course 
where 课程号 in(
select 课程号 from choose where 学号=sno);
end;$$

call c_proc('01640401');$$

drop procedure c_proc;$$

#3)	创建名为c1_proc的存储过程，根据学生的学号查询该学生选修了几门课程，
#s_no是IN输入参数，number是OUT输出参数。并调用该存储过程。
delimiter $$
create procedure c1_proc(in s_no char(20),out number int)
reads sql data
begin 
select count(*) into number
from choose where 学号=s_no;
end;$$

call c1_proc('01640401',@a);$$
select @a;$$

#4)	创建名为s2_proc的存储过程，根据图书编号查询图书名称。
#定义bh为IN输入参数，sm为OUT输出参数。
create procedure s2_proc(in bh char(20),out sm char(20))
reads sql data 
begin
select 图书名称 into sm from book where 图书编号=bh;
end;$$


call s2_proc('a2018002',@s);$$
select @s;$$


#5)	创建名为s3_proc的存储过程，根据图书编号查询图书名称。
#要求使用INOUT参数。调用该存储过程，输入图书编号，返回图书名称。
delimiter $$
create procedure s3_proc(inout bh char(20))
reads sql data
begin
select 图书名称 from book where 图书编号=bh;
end;$$

set @b = 'a2018001';$$
call s3_proc(@b);$$
select @b;$$

#6)	基于图书销售管理数据库创建删除触发器，由于《人性的弱点》这本书滞销导致下架，删除本书的信息，
#同时删除该书在线销售的所有信息。触发器被触发之前先打开onsale表查看数据，执行数据删除后对比数据。
delimiter $$
create trigger trigger_b before delete on book
for each row
begin
delete from onsale where 图书编号=old.图书编号;
end;$$

delete from book where 图书名称='人性的弱点';$$
select * from onsale;
select * from book;

#7)	创建一张只有a,b两个字段的表aa，创建插入触发器检查要添加的a、b的值，
#如果a的值小于10，则允许数据添加。
create table aa(a int,b int);$$
delimiter $$
create trigger a1 before insert on aa for each row
begin 
if new.a<10 then set new.a=new.a;
#else insert mytable values(0);
end if;
end;$$

drop table aa;$$
drop trigger a1;
insert into aa values(8,72);$$
select * from aa;$$
insert into aa values(48,8);$$