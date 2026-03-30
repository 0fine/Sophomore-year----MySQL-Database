use choose;

#1、使用SQL语句为表book2（isbn(出版编号),name(书名),brief_introduction(简介),price(单价),publish_time(出版日期)）
#创建一个简单索引。存储引擎为MyISAM、字符集为GBK。
create table book2 
(isbn char(20) primary key,
name char(100) not null,
brief_introduction text not null,
price decimal(6,2),
publish_time date not null,
unique index isbn_unique(isbn),
index name_index(name)
)engine=myisam charset=gbk;
select * from book2;
show index from book2;

#2、将book2表的图书简介brief_introduction字段添加全文索引。
alter table book2 drop index brief_introduction;
drop index brief_introduction_index on book2;

alter table book2 add fulltext 
index brief_introduction_index(brief_introduction);
show index from book2;

#3、删除书籍book2表的复合索引complex_index。
#添加复合索引
create index complex_index on book2(isbn,name);
show index from book2;
#未完成代码alter table book2 add index(col1,col2);

#删除复合索引
drop index complex_index on book2;
show index from book2;