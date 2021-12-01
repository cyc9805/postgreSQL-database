--select * - : 모든 행을 보여주세요
select * from employee;
--전체 사원 수를 계산하시오.
--count(*): 모든 행(튜플)의 갯수
select count(*) as num_employee from employee;
--count(column): 해당 컬럼의 값이 널🙈이 아닌 행들의 갯수
--부서에 소속된 직원들의 수를 구하시오
select count(dno) from employee;

--직속상관이 있는 직원들의 수를 구하시오
select count(manager) from employee;

--직급의 총 갯수를 구하시오(distinct 이용)
select count(distinct title) from employee

--sum: 합계
--avg: 평균
--variance, stddev: 분산과 표준편차
--max, min: 최대 최소

--사원들의 평균 월급을 계산하시오.
select variance(salary), avg(salary) from employee;

--평균
select sum(salary), count(*), (sum(salary)/count(*)) as cal, avg(salary) as avg_sal from employee;

--분산: 
--자유도
select sum(power((salary-2750000),2))/7 from employee;
select variance(salary) from employee;

--group by
--group by 절에 명시된 컬럼들을 이용하여, 해당 칼럼들을 기준으로 동일한 값을 갖는 투플들이 묶여 하나의 그룹 형성

--직급을 기준으로 그루핑
--group by 절에 명시된 칼럼들은 항상 select 절에 와야 함
--group by는 데이터를 묶는 기능이기 때문에, group by에 사용된 칼럼 이후에는 반드시 집계함수만 적용될 수 있음
--직급별 사원 수, 직급별 평균 급여, 급여별 
select title, count(*),avg(salary) from employee
group by title


update employee set salary = 1900000 where empno=5000
select * from employee order by title, salary desc;

--직속상관 별로, 관리하는 직원들의 평균 월급과 관리하는 직원들의 수를 계산하시오.

select manager,avg(salary), count(*) from employee where manager is not null group by manager
order by avg(salary) desc

--having
--group by에 의해 그루핑된 튜플들에 적용되는 조건 절
--having절 후에 컬럼이 만들어짐
--부서 번호별로 그루핑하고, 부서별 사원수가 2명 이상인 부서번호와 사원 수, 평균 급여를 보이시오



select dno, count(*) as many,avg(salary)
from employee
where dno is not null
group by dno
having count(*)>2
order by dno;

--부서 번호별로 사원 수를 보여주세요. 이 때 1번 부서는 제외하시오
select dno, count(*)
from employee
group by dno
having dno <> 1


--사원들이 속한 부서 번호별로 그룹화 하고, 평균 급여가 3000000(3 백만)원을 초과하는 부서에 대해서 부서별 사원 수와 평균 급여를 검색하시오. 
--단, 부서별 사원 수로 정렬하여 보여주시오.
select count(*)as num, avg(salary) as avgsalary,dno
from employee
group by dno
having avg(salary)>3000000
order by num

--[예제] 급여가 5000000(5 백만)원 이하이고 부서가 있는 사원들에 대해서 사원들이 속한 부서 번호별로 그룹화 하고, 
--사원 수가 2 명 이상이면서 2 번 부서가 아닌 부서에 대해서 부서 번호, 부서별 사원 수, 평균 급여, 최대 급여를 검색하시오.
select dno, count(*) as num, avg(salary), max(salary)
from employee
where salary<=5000000 and dno is not null
group by dno 
having count(*)>= 2 and dno <> 2 
order by num


