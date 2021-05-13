DESC employees;
DESC departments;
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

-- 2-1. 문제 2에서 부서가 없는 사번 178을 표시
select * from employees where department_id IS NULL;

-- 3. 도시별로 위치한 부서들을 파악
-- 도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순) 정렬
-- 부서가 없는 도시는 표시하지 않음
