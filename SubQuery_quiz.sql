-- 1. 평균 급여보다 적은 급여를 받는 직원은 몇명인지
SELECT COUNT(SALARY) FROM employees WHERE salary < (SELECT AVG(salary) FROM employees);

-- 2. 평균급여 이상, 최대급여 이하의 월급을 받는 사원의 직원번호, 이름, 급여, 평균급여, 최대급여를 급여의 오름차순으로 정렬

-- 3. 직원 중 Steven(first_name) King(last_name)이 소속된 부서가 있는 곳의 주소를 알아보는 것
-- 도시아이디, 거리명, 우편번호, 도시명, 주, 나라아이디를 출력
SELECT loc.location_id, loc.street_address, loc.postal_code, loc.city, loc.state_province, loc.country_id
FROM locations loc JOIN departments dept ON loc.location_id=dept.location_id
WHERE dept.department_id=(SELECT department_id FROM employees WHERE first_name='Steven' AND last_name='King');

-- 4. job_id가 'ST_MAN'인 직원의 급여보다 작은 사원의 사번, 이름, 급여를 급여의 내림차순으로 출력 - ANY연산자 사용
SELECT employee_id, first_name, salary FROM employees WHERE salary < ANY(SELECT salary FROM employees WHERE job_id='ST_MAN') ORDER BY salary DESC; -- 74 개행

-- 5. 각 부서별로 최고의 급여를 받는 사원의 직원번호, 이름, 급여, 부서번호 조회
-- 조회결과는 급여의 내림차순으로 정렬, 조건절 비교, 조인비교 2가지 방법으로 작성
SELECT employee_id, first_name, department_id FROM employees;
SELECT department_id, MAX(salary) FROM employees GROUP BY department_id;