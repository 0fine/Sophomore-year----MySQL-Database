use choose;

#1.创建自定义函数，根据学号查找学生所在的班级。
delimiter $$
create function func_classes(a char(20))
returns char(20)
reads sql data
begin
declare s char(20);
select 班级名称 into s from classes where 班级编号 in(select 班级编号 from student where 学号=a);
return s;
end;$$
$$

delimiter $$
drop function cn_fn;
select func_classes('01640402');


#2.创建自定义函数cn_fn，根据班级名称统计该班级的学生总人数。
#调用cn_fn函数，返回“19信息管理1班”的学生人数。
delimiter $$
create function cn_fn(a char(20))
returns int reads sql data
begin 
declare s int;
select count(学号) into s from classes
join student on classes.班级编号 = student.班级编号
where 班级名称=a;
return s;
end;$$

select cn_fn('19信息管理1班');


#3.创建自定义函数，求两个数的最大数。
create function fn1(a int,b int)
returns int
no sql
begin 
if a>b then return a;
else return b;
end if;
end;

select fn1(52,48);


#4.自定义无参数函数，根据系统日期返回礼貌用语，分别用if、case条件语句。

create function fn2()
returns char(10)
no sql
begin
declare m char(10);
if(hour(now())>6 && hour(now())<8)
then set m='早上好';
elseif(hour(now())>=8 && hour(now())<12)
then set m='上午好';
elseif(hour(now())<14 && hour(now())>=12)
then set m='中午好';
elseif(hour(now())<18) 
then set m='下午好';
else set m='晚上好';
end if;
return m;
end;

#select now(),fn2();$$





#5.分别使用while/repeat/循leave环语句创建函数，返回1~n(n>1)的整数和。
delimiter $$
create function fn3(n int)
returns int
no sql
begin
declare sum int default 0;
declare start int default 0;
repeat 
set start=start+1;
set sum=sum+start;
until start=n
end repeat;
return sum;
end;$$

select fn3(100);$$




#6.创建函数，使该函数返回1~n（n>1）能被9整除的数之和。
delimiter $$
create function fn4(n int)
returns int
no sql
begin 
declare sum int default 0;
declare i int default 0;
while i<n do
set i=i+1;
set sum=sum+i;
end while;
return sum;
end;$$

select fn4(10),fn4(50);$$




#1.创建自定义函数，根据学号查找学生所在的班级。



