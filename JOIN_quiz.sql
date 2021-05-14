DESC employees;
DESC departments;

SELECT *FROM locations;
-- 1. 직원들의 사번, 이름, 성과 부서명을 조회하여 부서이름, 오름차순, 사번 내림차순 정렬
SELECT emp.employee_id, emp.first_name, emp.last_name, dept.department_name 
FROM employees emp 
JOIN departments dept ON emp.department_id=dept.department_id ORDER BY dept.department_name, emp.employee_id DESC; -- 106 개행

-- 2. 직원 테이블의 job_id는 현재의 업무 아이디
-- 직원들의 사번, 이름, 급여, 부서명, 현재업무를 사번 오름차순으로 정렬
-- 부서가 없는 사번 178은 표시하지 않는다.
SELECT emp.employee_id, first_name, salary, department_name, job_title, emp.department_id
FROM departments dept, employees emp 
JOIN jobs j ON emp.job_id=j.job_id 
WHERE emp.department_id=dept.department_id AND emp.department_id IS NOT NULL ORDER BY employee_id; -- 106개행
-- OR
SELECT emp.employee_id, first_name, salary, department_name, job_title, emp.department_id
FROM employees emp JOIN departments dept ON emp.department_id=dept.department_id JOIN jobs j ON emp.job_id=j.job_id WHERE emp.department_id IS NOT NULL ORDER BY employee_id;

-- 2-1. 문제 2에서 부서가 없는 사번 178을 표시
-- select * from employees where department_id IS NULL;

-- 3. 도시별로 위치한 부서들을 파악
-- 도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순) 정렬
-- 부서가 없는 도시는 표시하지 않음
SELECT loc.location_id, city, department_name, department_id FROM locations loc, departments dept WHERE loc.location_id=dept.location_id AND dept.location_id IS NOT NULL ORDER BY loc.location_id; -- 27 개행

-- 3-1. 문제3에서 부서가 없는 도시 표시
-- 

-- 4. 지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 출력하되 지역이름 오름차순, 나라이름 내림차순으로 정렬
SELECT region_name, country_name FROM regions reg JOIN countries c ON reg.region_id=c.region_id ORDER BY region_name, c.country_name DESC; -- 25 개행

-- 5. 자신의 매니저보다 채용일(hire_date)이 빠른 사원의 사번, 이름, 채용일, 매니저이름(first_name), 매니저 입사일을 조회
