use testdb;

select * from student
as a join student as b on b.出生日期<a.出生日期
where a.姓名='马浅';

select b.学号,b.姓名,b.出生日期 from student  #放在b表中
as a join student as b on b.出生日期<a.出生日期
where a.姓名='马浅';

#子查询：由内向外
select * from student 
where 出生日期<(select 出生日期 from student where 姓名='马浅');