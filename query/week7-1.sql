select dno, count(*) as num, avg(salary) from employee
group by dno
having avg(salary)>3000000 

select dno,count(*),avg(salary),max(salary) from employee 
where salary<=5000000 and dno is not null
group by dno
having count(*)>2 and dno<>2

-- 합집합 union
-- (select...from...) union (select...from...)
-- 월급이 200만원 미만이거나 2번 부서에서 근무하는 직원들의 이름
-- 합집합 호환조건이 만족해야 함
(select empname from employee where salary < 2000000)
union
(select empname from employee where dno = 2);
 
--밑의 구문과 같음
select empname from employee where salary < 2000000 or dno =2;

--예제
(select dno from employee where empname='박영권' or empname='이수민')
union all	--union all은 중복을 제거하지 않음
(select deptno from department where deptname='영업')

--intersect 예제
(select dno from employee where empname='김영희' or empname='이민호')
intersect
(select deptno from department where deptname='영업')


--except: 차집합
(select dno from employee where empname='김영희' or empname='이민호')
except
(select deptno from department where deptname='영업')

--limit or offset: postgresql에서 상위 n개 혹은 상위 n개를 제외한 구문
select * from employee offset 1;

--예제
--직원중에서 제일 많은 연봉을 받는 직원의 이름과 제일 적은 연봉을 받는 직원의 이름을 표시하시오.
(select empname, salary from employee order by salary limit 1)
union
(select empname, salary from employee order by salary desc limit 1)

--where 절에서는 집계 함수를 사용할 수 없음
--having 절에서는 집계 함수를 이용한 필터링이 가능
--다만, having 절은 group by 이후에 등장 
--그루핑을 하지 않고, 집계 함수를 적용하여 필터링하는 방법 --> 부속 질의
--select empname from employee where salary = min(salary) 계산 불가

(select empname, salary from employee 
where salary = (select min(salary) from employee))
union
(select empname, salary from employee 
where salary = (select max(salary) from employee))

--조인
--부모 릴레이션 R, 자식 릴레이션 S가 있을때
--R 과 S의 조인
select *
from employee as e
join department as s
ON e.primarykey = s.foreignkey

select *
from department as d
join employee as e
on d.deptno=e.dno;

select d.deptname, e.empno
from department as d
join employee as e
on d.deptno=e.dno
--일반적으로 부모 릴레이션을 왼쪽에 명시, department join employee
select r.*,s.*
from R as r
join S as s
on r.A = s.B 
join L as l
on s.C=l.D

--조인한 테이블에 where 절을 사용하여 실렉션 가능
select * 
from employee as e
join department as d
on e.dno>d.deptno
where title='부장'

-- 사원 테이블과 프로젝트-사원 테이블, 프로젝트 테이블을 조인하시오. 
-- 즉, 사원의 이름과 해당 사원이 수행하는 프로젝트의 번호 및 이름을 검색하시오.

select * 	--따로 e.*, ep.*, p.* 을 설정안하고 * 하나만 써도 됨
from employee as e
join emp_proj as ep
on e.empno=ep.empno
join project as p
on p.projno=ep.prjno
order by e.empname;

--practice
select * from employee;
select * from department;
select e.dno
from employee as e
join department as d
on e.dno=d.deptno;
