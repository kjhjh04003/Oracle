DESC employees;
DESC departments;

SELECT *FROM locations;
-- 1. 직원들의 사번, 이름, 성과 부서명을 조회하여 부서이름, 오름차순, 사번 내림차순 정렬
SELECT emp.employee_id, emp.first_name, emp.last_name, dept.department_name 
FROM employees emp 
JOIN departments dept ON emp.department_id=dept.department_id ORDER BY dept.department_name, emp.employee_id DESC; -- 106 개행
-- OR
SELECT emp.employee_id, emp.first_name, emp.last_name, dept.department_name
FROM employees emp, departments dept
WHERE emp.department_id=dept.department_id
ORDER BY dept.department_name, emp.employee_id DESC;

-- 2. 직원 테이블의 job_id는 현재의 업무 아이디
-- 직원들의 사번, 이름, 급여, 부서명, 현재업무를 사번 오름차순으로 정렬
-- 부서가 없는 사번 178은 표시하지 않는다.
SELECT emp.employee_id, first_name, salary, department_name, job_title
FROM departments dept, employees emp 
JOIN jobs j ON emp.job_id=j.job_id 
WHERE emp.department_id=dept.department_id ORDER BY employee_id; -- 106개행
-- OR
SELECT emp.employee_id, first_name, salary, department_name, job_title, emp.department_id
FROM employees emp JOIN departments dept ON emp.department_id=dept.department_id JOIN jobs j ON emp.job_id=j.job_id ORDER BY employee_id;
-- OR
SELECT emp.employee_id, first_name, salary, department_name, job_title, emp.department_id
FROM departments dept, employees emp, jobs j
WHERE emp.job_id=j.job_id AND emp.department_id=dept.department_id ORDER BY employee_id;

-- 2-1. 문제 2에서 부서가 없는 사번 178을 표시
-- OUTER JOIN
-- oracle : null이 포함될 수 있는 쪽에 (+) / ANSI : lef outer join or right outer join
-- oracle
SELECT emp.employee_id, first_name, salary, department_name, job_title, emp.department_id
FROM departments dept, employees emp, jobs j
WHERE emp.job_id=j.job_id AND emp.department_id = dept.department_id (+) ORDER BY employee_id; -- 107 개행
-- ANSI
SELECT emp.employee_id, first_name, salary, department_name, job_title, emp.department_id
FROM employees emp LEFT JOIN departments dept ON emp.department_id=dept.department_id JOIN jobs j ON emp.job_id=j.job_id;

-- 3. 도시별로 위치한 부서들을 파악
-- 도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순) 정렬
-- 부서가 없는 도시는 표시하지 않음
SELECT loc.location_id, city, department_name, department_id FROM locations loc, departments dept WHERE loc.location_id=dept.location_id; -- 27 개행
-- OR
SELECT loc.location_id, city, department_name, department_id FROM locations loc JOIN departments dept ON loc.location_id=dept.location_id;

-- 3-1. 문제3에서 부서가 없는 도시 표시
SELECT loc.location_id, city, department_name, department_id FROM locations loc, departments dept WHERE loc.location_id=dept.location_id(+); --43 개행
-- OR
SELECT loc.location_id, city, department_name, department_id FROM locations loc LEFT JOIN departments dept ON loc.location_id=dept.location_id;

-- 4. 지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 출력하되 지역이름 오름차순, 나라이름 내림차순으로 정렬
SELECT region_name, country_name FROM regions reg JOIN countries c ON reg.region_id=c.region_id ORDER BY region_name, c.country_name DESC; -- 25 개행
-- OR
SELECT region_name, country_name FROM regions reg, countries c WHERE reg.region_id=c.region_id ORDER BY region_name, c.country_name DESC;

-- 5. 자신의 매니저보다 채용일(hire_date)이 빠른 사원의 사번, 이름, 채용일, 매니저이름(first_name), 매니저 입사일을 조회
-- 자신의 매니저 찾기
SELECT emp.employee_id, emp.first_name, emp.hire_date, man.first_name, man.hire_date FROM employees emp, employees man
WHERE emp.manager_id=man.employee_id AND emp.hire_date < man.hire_date; -- 37 개행
-- OR
SELECT emp.employee_id, emp.first_name, emp.hire_date, man.first_name, man.hire_date FROM employees emp JOIN employees man
ON emp.manager_id=man.employee_id WHERE emp.hire_date < man.hire_date;

-- 6. 나라별로 어떠한 부서들이 위치하고 있는지 파악
-- 나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디를 나라명(오름차순)으로 정렬
-- 값이 없는 경우 표시x
SELECT c.country_name, c.country_id, loc.city, loc.location_id, dept.department_name, dept.department_id 
FROM countries c, locations loc JOIN departments dept ON loc.location_id=dept.location_id 
WHERE c.country_id=loc.country_id ORDER BY c.country_name; -- 27 개행
-- OR
SELECT c.country_name, c.country_id, loc.city, loc.location_id, dept.department_name, dept.department_id 
FROM countries c, locations loc, departments dept
WHERE loc.location_id=dept.location_id  AND c.country_id=loc.country_id ORDER BY c.country_name;

-- 7.job_history 테이블은 과거 담당자의 데이터
-- 과거의 업무아이디(job_id)가 'AC_ACCOUNT'로 근무한 사번의 사번, 이름(풀네임), 업무아이디, 시작일, 종료일 출력
SELECT emp.employee_id,emp.first_name ||' '|| emp.last_name as "name", his.job_id, his.start_date, his.end_date
FROM employees emp JOIN job_history his ON emp.employee_id=his.employee_id
WHERE his.job_id='AC_ACCOUNT'; -- 2 개행

-- 8. 각 부서에 대해서 부서번호, 부서이름, 매니저의 이름, 위치한 도시, 나라의 이름, 지역구분 이름까지 전부 출력

--9. 각 사원에 대해서 사번, 이름, 부서명, 매니저의 이름 조회
-- 부서가 없는 직원도 표시
SELECT emp.employee_id, emp.first_name, dept.department_name, man.first_name
FROM employees emp, departments dept, employees man
WHERE emp.manager_id=man.employee_id AND emp.department_id=dept.department_id(+);
-- or
SELECT emp.employee_id, emp.first_name, dept.department_name, man.first_name
FROM employees man, employees emp LEFT OUTER JOIN departments dept
ON emp.department_id=dept.department_id WHERE emp.manager_id=man.employee_id;