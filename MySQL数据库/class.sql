create database theForthPractice;
use theForthPractice;

#Ⅱ
#创建表及插入记录 
create table class(
	cid int(11) not null auto_increment,
	caption varchar(32) not null,
    primary key(cid)
)engine=InnoDB charset=utf8;

insert into class values
(1,'三年二班'),
(2,'三年三班'),
(3,'一年二班'),
(4,'二年九班');
select * from class;
    
#Ⅳ
create table course(
	cid int(11) not null auto_increment,
    cname varchar(32) not null,
    teacher_id int(11) not null,
    primary key(cid),
    key fk_course_teacher (teacher_id),
    constraint fk_course_teacher foreign key(teacher_id) references teacher(tid)
    )engine=InnoDB default charset=utf8;
    
insert into course values
(1,'生物',1),
(2,'物理',2),
(3,'体育',3),
(4,'美术',2);

create table score(
	sid int(11) not null auto_increment,
    student_id int(11) not null,
    course_id int(11) not null,
    num int(11) not null,
    primary key(sid),
    key fk_score_student(student_id),
    key fk_score_course(course_id),
    constraint fk_score_course foreign key(course_id) references course(cid),
    constraint fk_score_student foreign key(student_id) references student(sid)
    )engine=InnoDB default charset=utf8;
    
INSERT INTO score VALUES
(1, 1, 1, 10),
(2, 1, 2, 9),
(5, 1, 4, 66),
(6, 2, 1, 8),
(8, 2, 3, 68),
(9, 2, 4, 99),
(10, 3, 1, 77),
(11, 3, 2, 66),
(12, 3, 3, 87),
(13, 3, 4, 99),
(14, 4, 1, 79),
(15, 4, 2, 11),
(16, 4, 3, 67),
(17, 4, 4, 100),
(18, 5, 1, 79),
(19, 5, 2, 11),
(20, 5, 3, 67),
(21, 5, 4, 100),
(22, 6, 1, 9),
(23, 6, 2, 100),
(24, 6, 3, 67),
(25, 6, 4, 100),
(26, 7, 1, 9),
(27, 7, 2, 100),
(28, 7, 3, 67),
(29, 7, 4, 88),
(30, 8, 1, 9),
(31, 8, 2, 100),
(32, 8, 3, 67),
(33, 8, 4, 88),
(34, 9, 1, 91),
(35, 9, 2, 88),
(36, 9, 3, 67),
(37, 9, 4, 22),
(38, 10, 1, 90),
(39, 10, 2, 77),
(40, 10, 3, 43),
(41, 10, 4, 87),
(42, 11, 1, 90),
(43, 11, 2, 77),
(44, 11, 3, 43),
(45, 11, 4, 87),
(46, 12, 1, 90),
(47, 12, 2, 77),
(48, 12, 3, 43),
(49, 12, 4, 87),
(52, 13, 3, 87);

#Ⅲ
create table student(
	sid int(11) not null auto_increment,
    gender char(1) not null,
    class_id int(11) not null,
    sname varchar(32) not null,
    primary key(sid),
    key fk_class(class_id),
    constraint fk_class foreign key(class_id) references class(cid)
    )engine=InnoDB default charset=utf8;
    
INSERT INTO student VALUES
(1, '男', 1, '理解'), 
(2, '女', 1, '钢蛋'), 
(3, '男', 1, '张三'), 
(4, '男', 1, '张一'), 
(5, '女', 1, '张二'), 
(6, '男', 1, '张四'), 
(7, '女', 2, '铁锤'), 
(8, '男', 2, '李三'), 
(9, '男', 2, '李一'), 
(10, '女', 2, '李二'), 
(11, '男', 2, '李四'), 
(12, '女', 3, '如花'), 
(13, '男', 3, '刘三'), 
(14, '男', 3, '刘一'), 
(15, '女', 3, '刘二'), 
(16, '男', 3, '刘四');

#Ⅰ
create table teacher(
	tid int(11) not null auto_increment,
    tname varchar(32) not null,
    primary key(tid)
    )engine=InnoDB default charset=utf8;
    
INSERT INTO teacher VALUES
(1, '张磊老师'), 
(2, '李平老师'), 
(3, '刘海燕老师'), 
(4, '朱云海老师'), 
(5, '李杰老师');





    