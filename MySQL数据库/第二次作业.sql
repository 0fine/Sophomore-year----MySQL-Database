#创建gradem数据库
create database gradem;
use gradem;

#创建student表
create table student(
	sno char(10) not null,
    sname varchar(8),
    ssex char(2),
    sbirthday datetime,
    saddress varchar(50),
    sdept char(16),
    speciality varchar(20),
    primary key(sno)
    );

#创建course表
create table course(
	cno char(5) not null,
    cname varchar(20) not null,
    primary key(cno)
);

#创建sc表
create table sc(
	sno char(10) not null,
    cno char(5) not null,
    degree decimal(4,1),
   # constraint sc_sno foreign key(sno) references student(sno),
    constraint sc_cno foreign key(cno) references course(cno)
);

#创建teacher表
create table teacher(
	tno char(3) not null primary key,
    tname varchar(8),
    tsex char(2),
    tbirthday date,
    tdept char(16)
);

#创建teaching表
create table teaching(
	cno char(5) not null,
    tno char(3) not null,
    cterm tinyint(1),
    constraint teaching_cno foreign key(cno) references course(cno),
    constraint teaching_tno foreign key(tno) references teacher(tno)
);

#向student表输入数据
insert into student values
(20050101,'李勇','男','1987-01-12','山东济南','计算机工程系','计算机应用'),
(20050201,'刘晨','女','1988-06-04','山东青岛','信息工程系','电子商务'),
(20050301,'王敏','女','1989-12-23','江苏苏州','数学系','数学'),
(20050202,'张立','男','1988-08-25','河北唐山','信息工程系','电子商务');
select * from student;

#向course表输入数据 
insert into course values
('C01','数据库'),
('C02','数学'),
('C03','信息系统'),
('C04','操作系统');
select * from course;

#向sc表输入数据 
insert into sc values
(20050101,'C01',92),
(20050101,'C02',85),
(20050101,'C03',88),
(20050201,'C02',90),
(20050201,'C03',80);
select * from sc;

#向teacher表输入数据 
insert into teacher values
(101,'李新','男','1977-01-12','计算机工程系'),
(102,'钱军','女','1968-06-04','计算机工程系'),
(201,'王小花','女','1979-12-23','信息工程系'),
(202,'张小青','男','1968-08-25','信息工程系');
select * from teacher;

#向teaching表输入数据 
insert into teaching values
('C01',101,2),
('C02',102,1),
('C03',201,3),
('C04',202,4);
select * from teaching;

#向student表中增加“入学时间”列，其数据类型为日期时间型
alter table student add 入学时间 datetime;
select * from student;

#将student表中的sdept字段长度改为20
alter table student modify sdept char(20);
show columns from student;

#将student表中的speciality字段删除 
alter table student drop speciality;
select * from student;


#删除student表
drop table student;
select * from student;