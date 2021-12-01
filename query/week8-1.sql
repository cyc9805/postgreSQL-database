--사원들의 평균 급여보다 적게 급여를 받고있는 직원들의 이름을 검색하시오
select empname, salary
from employee
where salary< (select avg(salary) from employee)

--직원들이 2명 이상 소속된 부서에서 근무하는 직원들의 이름을 검색하시오.
select empname
from employee
where dno in (select dno from employee group by dno having count(*)>=2 )
-- where dno in (1,3,2)


--상관 부속 질의
--외부 질의의 테이블에 별칭을 적용
-- 별칭이 부속 질의에 참조되어 연산
-- 외부 질의의 각 행에 대하여 
--직원 수가 2명 이상인 부서 이름을 검색하시오.
select deptname
from department as d
where 2 <= (select count(*) from employee where d.deptno = dno)

--조인을 사용
select deptname
from employee e
join department d
on e.dno=d.deptno
group by deptname
having count(*)>=2

-- 사원 이름과 소속 부서의 이름
-- 상관부속질의를 이용
-- select 절에도 상관부속질의를 적용할 수 있음
select e.empname, (select d.deptname from department d where d.deptno=e.dno)
from employee e 

-- 프로젝트를 수행하는 사원들의 평균 급여보다 급여를 적게 받는 사원들의 이름을 검색하시오.
select empname 
from employee 
where salary < (select avg(salary) 
				from employee e 
			    join emp_proj ep
			   on e.empno = ep.empno)
			   
-- 부하직원이 2명 이상인 사원들의 이름을 검색하시오.
--상관부속 질의
select empname
from employee e 
where 2 < (select count(*) from employee where 
		  manager=e.empno)
	
	
--exists 구문을 이용하여 기획 부서에서 근무하는 사원들의 모든 정보를 검색하시오
select * 
from employee e 
where exists (select * from department d where e.dno=d.deptno and deptname = '기획') )


--소속 직원이 하나도 없는 부서 번호와 부서명을 검색하시오
select deptno, deptname
from department d
where not exists 
(select * from employee where d.deptno=dno)