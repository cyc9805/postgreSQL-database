-- 주석
-- 테이블 만들기
create table sample
(
	id int,
	name char(10)
);


-- 데이터 검색하기 
select * from sample;


-- 데이터 입력하기
insert into sample values (1,'전용찬');
insert into sample values (2,'전용환');
insert into sample values (3,'전성익');


-- 데이터 삭제하기-- 주석
-- 테이블 만들기
create table sample
(
	id int,
	name char(10)
);


-- 데이터 검색하기 
select * from sample;


-- 데이터 입력하기
insert into sample values (1,'전용찬');
insert into sample values (2,'전용환');
insert into sample values (3,'전성익');


-- 데이터 삭제하기
delete from sample where id=2;

-- sql은 비절차적 언어
-- 테이블 삭제하기 
drop table sample
delete from sample where id=2;

-- sql은 비절차적 언어
-- 테이블 삭제하기 
drop table sample