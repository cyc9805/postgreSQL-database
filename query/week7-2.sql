select * from department; 
select * from employee;
insert into department values(4, 'sound', 6)
-- 카티션 곱: 크로스 조인 
--d.*, e.* = *
select d.*,e.*
from department d
cross join employee e
where d.deptno=e.dno

--김정현과 sound는 조인에 포함 되지 않음-> 외부 조인 사용

--1. 사원과 모든 부서를 표시 
select * 
from department d
left join employee e
on d.deptno=e.dno;

--2. 부서와 모든 사원을 표시
select * 
from department d
right join employee e
on d.deptno=e.dno;

--3. 모든 부서와 모든 사원을 표시
select * 
from department d
full join employee e
on d.deptno=e.dno;

--4. 모든 사원들과 각 사원들이 수행하는 프로젝트의 이름을 보여주시오
--항상 왼쪽 조인을 유지해야함!
select *
from employee e
left join proj_emp emp
on e.empno=emp.empno
left join project p
on emp.prjno=p.prjno
order by empname

--세미 조인: 관계대수 연산에만 정의

--왼쪽 세미
select distinct d.* 
from department d
join employee e
on d.deptno=e.dno

--오른쪽 세미
select distinct e.* 
from department d
join employee e
on d.deptno=e.dno

--자체 조인: 자기 자신과 조인, 별칭을 반드시 사용해야함
select * from employee 

--직원의 이름과 해당 직원의 사수의 이름을 검색하시오.
select e1.empname as '내이름', e2.empname as '사수이름'
from employee as e1
join employee e2
on e1.manager=e2.empno

--서브쿼리
--조민희 사원의 직급과 같은 직급을 가진 사원들이 근무하는 부서 이름들을 검색하시오
--1.조민희 사원의 직급
select title from employee where empname='조민희'

--2. 조민희 사원의 직급과 같은 직급의 사원
select e.dno 
from employee e
where title=
(select title from employee where empname='조민희')

--3. 조민희 사원의 직급(과장)과 같은 직급의 사원들이 근무하는 부서(1,2) 이름들을 검색하시오
--select * from employee
select d.deptname
from employee as e
join department as d
on e.dno=d.deptno
where e.title=(select title from employee where empname='조민희')




select deptname
from department 
where deptno in
(select dno from employee where title=
(select title from employee where empname='조민희'))

