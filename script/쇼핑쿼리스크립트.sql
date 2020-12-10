CREATE TABLE topcategory(
	topcategory_id  int  primary key auto_increment
	, name varchar(25)
) default character set utf8;
CREATE TABLE subcategory(
	subcategory_id int  primary key auto_increment
	, topcategory_id int
	, name varchar(25)
) default character set utf8;

INSERT INTO TOPCATEGORY (NAME) values('상의');
INSERT INTO TOPCATEGORY (NAME) values('하의');
INSERT INTO TOpCATEGORY (NAME) values('액세서리');
INSERT INTO TOPCATEGORY (NAME) values('신발');

INSERT INTO subcategory(topcategory_id,name) values(1,'가디건');
INSERT INTO subcategory(topcategory_id,name) values(1,'셔츠');
INSERT INTO subcategory(topcategory_id,name) values(1,'티셔츠');
INSERT INTO subcategory(topcategory_id,name) values(1,'니트');

INSERT INTO subcategory(topcategory_id,name) values(2,'청바지');
INSERT INTO subcategory(topcategory_id,name) values(2,'치마');
INSERT INTO subcategory(topcategory_id,name) values(2,'슬랙스');
INSERT INTO subcategory(topcategory_id,name) values(2,'면바지');

INSERT INTO subcategory(topcategory_id,name) values(3,'귀걸이');
INSERT INTO subcategory(topcategory_id,name) values(3,'팔찌');
INSERT INTO subcategory(topcategory_id,name) values(3,'목걸이');
INSERT INTO subcategory(topcategory_id,name) values(3,'반지');

INSERT INTO subcategory(topcategory_id,name) values(4,'구두');
INSERT INTO subcategory(topcategory_id,name) values(4,'샌들');
INSERT INTO subcategory(topcategory_id,name) values(4,'슬리퍼');
INSERT INTO subcategory(topcategory_id,name) values(4,'운동화');

select count(s.name) from topcategory t, subcategory s 
where t.topcategory_id = s.topcategory_id;

select t.topcategory_id, t.name,count(s.name) from topcategory t, subcategory s 
where t.topcategory_id = s.topcategory_id
group by t.topcategory_id, t.name;


select n.news_id, n.title, count(c.comments_id) from news n, comments c 
where n.news_id = c.news_id
group by n.news_id, n.title;

select n.news_id as news_id,n.title as title, writer, regdate, hit, count(c.comments_id) as cnt
from news n left join comments c
on n.news_id = c.news_id
group by n.news_id, n.title, writer, regdate, hit
order by n.news_id desc;