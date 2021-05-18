-- 1. 담당 매니저가 배정되었으나 커미션비율이 없고, 월급이 3000초과인 직원의 이름, 매니저아이디, 커미션비율, 월급 출력
SELECT first_name, manager_id, commission_pct, salary FROM employees
WHERE manager_id IS NOT NULL AND commission_pct IS NULL AND salary > 3000; -- 45 개행

-- 2. 각 부서별로 최고의 급여를 받는 사원의 직원번호, 이름, 급여, 입사일, 전화번호, 부서번호를 조회
-- 조건절비교 방법 / 급여 내림차순 / 입사일은 2000-01-13 토요일 형식으로 / 전화번호 000-000-0000 형식으로
-- 부서별 최고 급여
SELECT department_id, MAX(salary) FROM employees GROUP BY department_id;

SELECT e.employee_id, e.first_name, e.salary, TO_CHAR(e.hire_date, 'YYYY-MM-DD DAY'), REPLACE(e.phone_number,'.','-'), e.department_id
FROM employees e, (SELECT department_id, MAX(salary) salary FROM employees GROUP BY department_id) t
WHERE e.department_id=t.department_id AND e.salary=t.salary
ORDER BY salary DESC;

-- 3. 매니저별로 평균급여, 최소급여, 최대급여 알아보기
-- 직원은 2005년 이후 입사자
-- 매니저별 평균급여가 5000이상만 출력
-- 매니저별 평균급여 내림차순
-- 매니저별 평균급여는 소수점 첫번쨰에서 반올림
-- 매니저아이디, 매니저 이름, 매니저별 평균급여, 매니저별최소급여, 매니저별최대급여 츨력
--SELECT manager_id, ROUND(AVG(salary),1) avgSalary, MIN(salary) minSalary, MAX(salary) maxSalary
--FROM employees WHERE hire_date >= '2005/01/01' GROUP BY manager_id HAVING AVG(salary) >= 5000; -- 9 개행
-- 
--select  t.manager_id,
--        e.first_name,
--        t.avgSalary,
--        t.minSalary,
--        t.maxSalary
--from employees e, ( select  manager_id, 
--                            round(avg(salary),0) avgSalary, 
--                            min(salary) minSalary, 
--                            max(salary) maxSalary
--                    from employees
--                    where hire_date > '05/01/01'
--                    group by manager_id
--                    having avg(salary) >= 5000
--                    order by avg(salary) desc ) t
--where e.employee_id = t.manager_id
--order by avgSalary desc;

-- 4. 각 사원에 대해서 사번, 이름, 부서명, 매니저이름, 조회
-- 부서가 없는 직원도 표시
SELECT e.employee_id, e.first_name, d.department_name, m.first_name
FROM employees e, departments d, employees m
WHERE e.department_id=d.department_id(+) AND e.manager_id=m.employee_id;

-- 5. 2005년 이후 입사한 직원 중에 입사일이 11번째에서 20번째의 직원의 사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력
SELECT rn, hire_date FROM (SELECT hire_date FROM employees ORDER BY hire_date);
SELECT rn, employee_id, first_name, salary, hire_date
FROM (SELECT rownum rn, employee_id, first_name, salary, hire_date 
FROM (SELECT rownum rn, employee_id, first_name, salary, hire_date FROM employees WHERE hire_date>'2005/12/31' ORDER BY hire_date))
WHERE rn BETWEEN 11 AND 20 ORDER BY hire_date;

-- 6. 가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름
SELECT MIN(hire_date) FROM employees;

SELECT first_name ||' '|| last_name name, salary*12 pay, department_name
FROM employees e, departments d
WHERE e.department_id=d.department_id;

-- 7. 평균 연봉이 가장 높은 부서 직원들의 직원번호, 이름, 성과 업무, 연봉 조회

-- 8. 평균 급여가 가장 높은 부서는?
SELECT department_name FROM (SELECT department_id, avg(salary) avgSalary FROM employees GROUP BY department_id order by avgSalary DESC) t, departments d
WHERE d.department_id=t.department_id AND rownum<2;

-- 9. 평균 급여가 가장 높은 지역
-- regions.region_id=countries.region_id / countries.country_id=locations.country_id / locations.location_id=departments.departments_location_id
-- departments_department_id=employees.department_id\
select region_name from regions;


-- 10. 평균 급여가 가장 높은 업무
SELECT job_title FROM (SELECT avg(salary) avgSalary FROM employees GROUP BY job_id order by avgSalary DESC) t, jobs WHERE rownum<2;
