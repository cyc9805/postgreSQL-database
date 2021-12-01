select empname, 
(select deptname from department d where e.dno=d.deptno)
from employee e 

select d.deptno, d.deptname from department d 
where not exists (select 1 from employee e where e.dno=d.deptno)


--insert 문
insert into high_salary(epname,title,salary) 
select empname,title,salary
from employee 
where salary>= 3500000


create table high_salary(
empname char(10),
title char(10),
salary int check (salary > 3500000))


--delete
delete from department 
where deptno=6

--update
alter table high_salary add column sal_raise int default 300000
alter table high_salary alter column salary 
insert into high_salary(empname,title,salary,sal_raise)
select empname,title,salary,salary*1.1
from employee

update high_salary
set sal_raise=salary*1.1

update high_salary
set title='이사', sal_raise=salary*1.2
where empname='김영희'


--practice
select * from emp_proj o
select * from project

select distinct empname
from employee e 
join emp_proj ep
on e.empno=ep.empno
join project p
on ep.prjno=p.prjno

select empname, (select count(*) from emp_proj ep where ep.empno=e.empno)
from employee e

 SELECT *
FROM employee E JOIN emp_proj EP ON e.empno = EP.empno GROUP BY E.empname

alter table project add column budget money 

select dno,p.prjname,count(*)
from department d
join employee e on e.dno=d.deptno
join emp_proj ep on e.empno=ep.empno
join project p on ep.prjname=p.prjname
group by dno
order by dno

select distinct empname 
from employee e
join emp_proj ep
on e.empno=ep.empno
join project p on p.prjno=ep.prjno
where p.prjno <> 300


select 
join project p on ep.prjno=p.prjno

select prjname
from project p
where (select 0.1*count(*) from employee) <=
(select count(*) from emp_proj ep where p.prjno=ep.prjno)


 SELECT EP.prjno
FROM emp_proj EP
GROUP BY EP.prjno
HAVING count(EP.empno) >= 2;

select e.empno, e.empname, count(*)
from employee e
join emp_proj ep
on e.empno=ep.empno
group by e.empno
order by count(*) desc
limit 1


SELECT E.empname, count(E.empno)
FROM employee E JOIN emp_proj EP ON e.empno = EP.empno GROUP BY E.empname
ORDER BY count(E.empno) DESC
LIMIT 1

select * from department
insert into department values(5,'아무거나',14)


delete from department d
where deptno not in (select distinct dno from employee)

-- [조인 이용] SELECT E.empname
(select distinct empname from employee)
except
(SELECT E.empname
FROM employee E
INNER JOIN emp_proj EP ON E.empno = EP.empno WHERE EP.prjno = 300);

select ep.empno,count(*)
from emp_proj ep
group by empno
having count(*)=1

-- 각 부서에서 최대 급여를 받는 사원의 이름과 급여, 부서명칭을 검색하시오.
select empname,deptname,salary 
from department d join employee e on e.dno=d.deptno 
where salary=(select max(salary) from employee e where e.dno=d.deptno)

-- 각 부서에서 최대 급여를 받는 사원의 이름과 급여, 부서명칭을 검색하시오.
