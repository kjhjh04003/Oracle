

-- 소속 부서의 평균 급여보아 적게버는 직원의 last_name, salary
select last_name, salary from employees e, departments d where e.department_id=d.department_id 
and e.salary < ANY(select round(avg(salary),0) avgSalary from employees e group by department_id) order by salary;

select last_name from employees e, departments d where e.department_id=d.department_id;
select round(avg(salary),0) avgSalary from employees e group by department_id;

select e.last_name, salary from employees e, departments d
where e.department_id=d.department_id and
(e.salary < ANY(select round(avg(salary),0) avgSalary from employees e group by department_id) 
order by e.department_id;

select last_name, salary, department_id from employees where last_name='Chen';

select department_id,round(avg(salary),0) avgSalary from employees e group by department_id