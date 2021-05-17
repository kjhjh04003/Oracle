-- 1. 평균 급여보다 적은 급여를 받는 직원은 몇명인지
SELECT COUNT(SALARY) FROM employees WHERE salary < (SELECT AVG(salary) FROM employees);

-- 2. 평균급여 이상, 최대급여 이하의 월급을 받는 사원의 직원번호, 이름, 급여, 평균급여, 최대급여를 급여의 오름차순으로 정렬
-- 평균 급여를 확인하는 임시테이블 생성
SELECT ROUND(AVG(salary),2) avgSalary, MAX(salary) maxSalary FROM employees;
-- 두 테이블을 Theta Join
SELECT e.employee_id, e.first_name, e.salary, t.avgSalary, t.maxSalary
FROM employees e, (SELECT ROUND(AVG(salary),2) avgSalary, MAX(salary) maxSalary FROM employees) t
WHERE  e.salary BETWEEN t.avgSalary AND t.maxSalary
ORDER BY salary;

-- 3. 직원 중 Steven(first_name) King(last_name)이 소속된 부서가 있는 곳의 주소를 알아보는 것
-- 도시아이디, 거리명, 우편번호, 도시명, 주, 나라아이디를 출력
SELECT loc.location_id, loc.street_address, loc.postal_code, loc.city, loc.state_province, loc.country_id
FROM locations loc JOIN departments dept ON loc.location_id=dept.location_id
WHERE dept.department_id=(SELECT department_id FROM employees WHERE first_name='Steven' AND last_name='King');
-- OR
SELECT loc.location_id, loc.street_address, loc.postal_code, loc.city, loc.state_province, loc.country_id
FROM locations loc
WHERE loc.location_id = (SELECT location_id FROM departments WHERE department_id =
                                            (SELECT department_id FROM employees WHERE first_name='Steven'
                                            AND last_name='King'));
                                            
-- 4. job_id가 'ST_MAN'인 직원의 급여보다 작은 사원의 사번, 이름, 급여를 급여의 내림차순으로 출력 - ANY연산자 사용
SELECT employee_id, first_name, salary 
FROM employees WHERE salary < ANY(SELECT salary FROM employees WHERE job_id='ST_MAN') 
ORDER BY salary DESC; -- 74 개행

-- 5. 각 부서별로 최고의 급여를 받는 사원의 직원번호, 이름, 급여, 부서번호 조회
-- 조회결과는 급여의 내림차순으로 정렬, 조건절 비교, 조인비교 2가지 방법으로 작성
-- 조건벌 비교
SELECT employee_id, first_name, department_id FROM employees 
WHERE (department_id, salary) IN(SELECT department_id, MAX(salary) FROM employees GROUP BY department_id)
ORDER BY salary DESC; -- 11 개행
-- OR
-- JOIN
SELECT emp.employee_id, emp.first_name, emp.department_id FROM employees emp JOIN (SELECT department_id, MAX(salary) salary FROM employees GROUP BY department_id) sal
ON emp.department_id=sal.department_id WHERE emp.salary=sal.salary;

-- 6. 각 업무(job)별로 연봉(salary)의 총 합
-- 연봉 총합이 가장 높은 업무부터 업무명과 연봉 총합 조회
SELECT job_id, SUM(salary*12) as sumSalary FROM employees GROUP BY job_id;
SELECT j.job_title, t.sumSalary, t.job_id, j.job_id
FROM jobs j, (SELECT job_id, SUM(salary*12) as sumSalary FROM employees GROUP BY job_id) t
WHERE j.job_id=t.job_id ORDER BY sumSalary DESC;

-- 7. 자신의 부서 평균 급여보다 연봉이 많은 직원의 직원번호, 이름, 급여 조회
-- 나의부서
SELECT employee_id, first_name, e.department_id, d.department_id FROM employees e, departments d
WHERE e.department_id=d.department_id;
-- 부서평균급여보다 연봉높은사람
SELECT  department_id, AVG(salary) avgSalary FROM employees GROUP BY department_id;

SELECT e.employee_id, e.first_name, e.salary
FROM employees e, (SELECT  department_id, AVG(salary) avgSalary FROM employees GROUP BY department_id) t
WHERE e.department_id=t.department_id AND (e.salary*12) > t.avgSalary;

-- 8. 직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력
SELECT rownum, hire_date FROM (SELECT hire_date FROM employees ORDER BY hire_date);

SELECT rn, employee_id, first_name, salary, hire_date
FROM (SELECT rownum rn , employee_id, first_name, salary, hire_date
FROM (SELECT employee_id, first_name, salary, hire_date FROM employees ORDER BY hire_date))
WHERE rn >= 11 AND rn <=15;
