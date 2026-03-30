use testdb;
create table department(
学院编号 int auto_increment primary key,
学院名称 char(20) not null unique
)engine=InnoDB;

#查看department表结构
desc department;

#向department表插入数据        
insert into department values(null, '机电工程学院');
insert into department values(null, '土木工程学院');
insert into department values(null, '计算机学院');
insert into department values(null, '管理工程学院');
insert into department values(null, '生物工程学院');

#查看department表数据
select * from department;