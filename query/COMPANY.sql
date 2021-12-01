-- DEPARTMENT 테이블 생성
CREATE TABLE DEPARTMENT (
	DEPTNO		INT	NOT NULL,
	DEPTNAME	CHAR(10),
	FLOOR		INT,	--floor 함수
	PRIMARY KEY(DEPTNO) --기본키
);
drop table emp_proj;
drop table employee;
drop table department;
drop table project;
drop table mytable
--테이블 생성하기
--create table 테이블이름 (컬럼이름 컬럼타입 조건,컬럼이름 컬럼타입 조건,컬럼이름 컬럼타입 조건,...);
-- DEPARTMENT 테이블에 투플 추가
INSERT INTO DEPARTMENT VALUES(1, '영업', 8);
INSERT INTO DEPARTMENT VALUES(2, '기획', 10);
INSERT INTO DEPARTMENT VALUES(3, '개발', 9);
INSERT INTO DEPARTMENT VALUES(4, '총무', 7);


--데이터 추가하기
--insert into 테이블이름 values(각각의 값들-);
--insert into 테이블이름(deptno,deptname) values(5,'홍보')

-- EMPLOYEE 테이블 생성
CREATE TABLE EMPLOYEE (
	EMPNO	INT	NOT NULL,
	EMPNAME	CHAR(10)	UNIQUE,
	TITLE	CHAR(10)	DEFAULT '사원',
	MANAGER	INT,
	SALARY	INT	CHECK (SALARY < 6000000),
	DNO		INT,
	PRIMARY KEY(EMPNO)
);

-- MANAGER가 자체 테이블의 EMPNO를 참조하는 외래키 제약조건
-- MANAGER는 자신의 직속 상관이 누구인지를 나타냄
ALTER TABLE EMPLOYEE ADD CONSTRAINT FK_MANAGER
    FOREIGN KEY (MANAGER) REFERENCES EMPLOYEE (EMPNO);

-- DNO가 DEPARTMENT 테이블의 기본키 DEPTNO를 참조하는 외래키 제약조건
-- DEPTNO의 변경시 DNO에도 파급(CASCADE)되어 업데이트한다.
ALTER TABLE EMPLOYEE ADD CONSTRAINT FK_DNO 
    FOREIGN KEY (DNO) REFERENCES DEPARTMENT (DEPTNO)
	ON UPDATE CASCADE;		--cascade는 연쇄 반응을 일으킴->1번이 4번으로 바뀜

-- EMPLOYEE 테이블에 투플 추가
INSERT INTO EMPLOYEE VALUES(4377, '이성래', '이사', NULL, 5000000, 2);
INSERT INTO EMPLOYEE VALUES(3426, '박영권', '과장', 4377, 3000000, 1);
INSERT INTO EMPLOYEE VALUES(3011, '이수민', '부장', 4377, 4000000, 3);
INSERT INTO EMPLOYEE VALUES(3427, '최종철', '사원', 3011, 1500000, 3);
INSERT INTO EMPLOYEE VALUES(1003, '조민희', '과장', 4377, 3000000, 2);
INSERT INTO EMPLOYEE VALUES(2106, '김창섭', '대리', 1003, 2500000, 2);
INSERT INTO EMPLOYEE VALUES(1365, '김상원', '사원', 3426, 1500000, 1);

-- PROJECT 테이블 생성
CREATE TABLE PROJECT (
	PRJNO		INT	NOT NULL,
	PRJNAME	CHAR(10),
	PRIMARY KEY(PRJNO)
);

-- EMP_PROJ 테이블 생성
CREATE TABLE EMP_PROJ (
	EMPNO		INT 	NOT NULL,
	PRJNO		INT	NOT NULL,
	PRIMARY KEY(EMPNO, PRJNO)	-- EMPNO, PRJNO 쌍이 기본키가 된다.
);

-- EMP_PROJ의 EMPNO는 EMPLOYEE의 EMPNO를 참조한다.
ALTER TABLE EMP_PROJ ADD CONSTRAINT FK_EMPNO 
	FOREIGN KEY (EMPNO) REFERENCES EMPLOYEE (EMPNO);

-- EMP_PROJ의 PRJNO는 PROJECT의 PRJNO를 참조한다.
ALTER TABLE EMP_PROJ ADD CONSTRAINT FK_PRJNO 
	FOREIGN KEY (PRJNO) REFERENCES PROJECT (PRJNO);

-- PROJECT 릴레이션에 투플 추가
-- 이 때는 참조되는 릴레이션부터 채워야 한다.
INSERT INTO PROJECT VALUES (100, 'A');
INSERT INTO PROJECT VALUES (200, 'B');
INSERT INTO PROJECT VALUES (300, 'C');

-- EMP_PROJ 릴레이션에 투플 추가
INSERT INTO EMP_PROJ VALUES (2106, 200);
INSERT INTO EMP_PROJ VALUES (3426, 200);
INSERT INTO EMP_PROJ VALUES (2106, 300);
INSERT INTO EMP_PROJ VALUES (1003, 300);

--데이터 검색하기
SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM EMP_PROJ;
SELECT * FROM PROJECT;

--select '프로젝션' from department where '실렉션'
select empname from EMPLOYEE where salary >= 3000000
select avg(salary) from EMPLOYEE;
select title, count(*) as "직급별 사원 수" from EMPLOYEE group by title

-- 동등조인
select * from DEPARTMENT d
join EMPLOYEE a
on d.deptno = a.dno;

-- 자연조인(조인에 참여한 중복 애트리뷰트 삭제)
select c.*, d.deptname, d.buildings_no from DEPARTMENT d
join EMPLOYEE c
on d.deptno = c.dno;

select e.
select *
from department d
join employee e on d.deptno = e.dno
join emp_proj ep on e.empno = ep.empno
join project p on ep.prjno = p.prjno;

select * from department d
join employee e
on d.deptno=e.dno


--테이블 만들기
create table mytable(
col1 int not null,
col2 char (5) default 'hi',
--col3 int check col3 in (1,2,3),
col4 int,
foreign key (col4) references department(deptno),
col3 int primary key
);		

insert into mytable(col1,col3) values(1,1);
insert into mytable values(2,'hi2',4);
select * from mytable;
drop table mytable;

--제약 조건--


CREATE TABLE EMPLOYEE2 (
	EMPNO	INT	NOT NULL,
	EMPNAME	CHAR(10)	UNIQUE,
	TITLE	CHAR(10)	DEFAULT '사원',
	MANAGER	INT,
	SALARY	INT	CHECK (SALARY < 6000000),
	DNO		INT,
	PRIMARY KEY(EMPNO)
);


--제약조건 앞에 constraint를 붙여 이름 부여 가능

CREATE TABLE EMPLOYEE3 (
	EMPNO	INT		constraint nonull NOT NULL,
	EMPNAME	CHAR(10)	constraint uq_ename UNIQUE,
	TITLE	CHAR(10)	constraint def_title DEFAULT '사원',
	MANAGER	INT,
	SALARY	INT		constraint salary_chk CHECK (SALARY < 6000000),
	DNO		INT,
	PRIMARY KEY(EMPNO)
);

INSERT INTO EMPLOYEE3 VALUES(4377, '이성래', '이사', NULL, 5000000, 2);
INSERT INTO EMPLOYEE3 VALUES(3426, '박영권', '과장', 4377, 3000000, 1);
INSERT INTO EMPLOYEE3 VALUES(3011, '이수민', '부장', 4377, 4000000, 3);

drop table employee3

--update cascade
--update restrict
--delete cascade
--delete restrict

CREATE TABLE DEPARTMENT2 (
	DEPTNO		INT,	
	DEPTNAME	CHAR(11),
	FLOOR		INT,	--floor 함수
	PRIMARY KEY (DEPTNO)	--primary key
);

INSERT INTO DEPARTMENT2 VALUES(1, '영업', 8);
INSERT INTO DEPARTMENT2 VALUES(2, '기획', 10);
INSERT INTO DEPARTMENT2 VALUES(3, '개발', 9);
INSERT INTO DEPARTMENT2 VALUES(4, '총무', 7);

drop table department2
drop table employee3
select * from department2

ALTER TABLE EMPLOYEE3 ADD CONSTRAINT FK_EMP 
	FOREIGN KEY (DNO) REFERENCES department2 (deptno)
	on update cascade;
	
update department2 set deptno=10 where deptno=2

select * from employee3


--practice--
create table department(
deptno int primary key,
deptname char(10) constraint random_constraint unique,
floor int default 2
)

create table employee(
empno int,
empname char(20),
dno int,
salary int,
manager int)

alter table employee add constraint uq_cons primary key (empno);
alter table employee add unique (empname);
alter table employee add constraint fk_key 
foreign key (dno) references department(deptno) on update restrict;
alter table employee add check (salary<600000);
alter table employee add constraint fk_manager foreign key (manager) references employee(empno);
alter table employee alter column empname type char(30)
alter table employee drop constraint fk_key
drop table employee
insert into employee(empno,dno) values(2,1)


