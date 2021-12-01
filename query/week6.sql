--데이터 조작어
--select
--테이블 혹은 테이블 조합(조인)에서 보고자 하는 컬럼 혹은 값 검색
--문자열이나 사칙연산 수행
select 'hello-';
select 3+5;
select deptno, deptname from department;

select empno, salary, empname from employee;

--관계대수 연산자 projection 결과에는 중복값이 포함되지 않으나
--sql의 select 구문에서는 중복값을 포함한다.
--중복값을 제거하려면, distinct 활용

select distinct empno from employee;
select distinct empno, salary from employee

--where: 조건절
--특정 조건을 만족하는 튜플들을 검색할 때 활용(필터링)
--=,>,<=등의 비교연산자 적용
--like: 문자열의 포함관계 검색
--in,not in: 집합의 포함관계
--between a and b: a 와 b 사이에 해당하는 값

--사원이름이 '이'로 시작하는 사원들의 모든 정보를 검색하시오
select empname from employee where empname like '이%'

--컬럼의 타입 바꾸기
--1. 테이블 수정
--2. 컬럼 수정
alter table employee alter column empname type varchar(10)
--varchar(x): 최대 x의 길이를 갖는 유동 크기 문자열
--char(x) x의 고정 길이를 갖는 문자열

--이름에 '수'가 들어가는 사원이름 검색
select * from employee where empname like '%수%';

--성이 '이'로 시작하고 이름이 3글자인 사원들의 모든 정보: 
select * from employee where empname like '이__';

--이름이 3글자이면서 '이'로 끝나는 사원들의 모든 정보: 
select * from employee where empname like '__권';

--만약에 고정 길이 문자열로 컬럼이 되어있고, 컬럼의 타입을 수정하지 않는 상태에서
--공백을 제거하고 특정문자의 포함여부를 검색할 수 있나요?
--trim 메소드: 문자열의 공백을 제거
select * from employee
--'원'으로 끝나는 직급에 해당하는 사원들의 모든 정보를 검색
select * from employee where trim(title) like '%원' 

--1번 부서가 아닌 사원들의 모든 정보를 검색하시오
select * from employee where dno != 1;

--null을 조건에 넣기 위해선 
select * from employee where dno <> 1 or dno is null;

insert into employee values (5000,'김정현','부장',2106,1500000,null);

--1,2번 부서 중 어떠한 부서에도 속하지 않은 사원의 모든 정보
select * from employee where dno not in (1,2)

--사원들의 이름과 월급과 월급의 10%의 인상액을 검색하시오.
--select 구문은 산술연산이 가능하며 as 키워드를 통해 별칭 가능 
select empname, salary, 1.1*salary as new_salary from employee;

--월급 순으로 정렬
select * 
from employee 
order by salary

--내림차순으로 하고 싶다면
select * 
from employee 
where dno=3
order by salary desc

--limit,offset
--limit: 상위 n개만
--offset: 상위 n개 제외

select * from employee
order by salary
limit 5;

select * from employee
order by salary
offset 5;