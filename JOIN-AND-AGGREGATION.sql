---------------
-- JOIN
---------------
-- employees, departments join
-- department_id가 각각 외래키, 기본키
DESC employees;
DESC departments;
SELECT * FROM employees; -- 107개행
SELECT * FROM departments; -- 27개행

-- 두 테이블의 조합 가능한 모든 쌍이 출력
-- 카디전 프로덕트, Cross Join
-- 일반적으로는 이런 결과를 원하지는 않을 것
SELECT department_name FROM employees, departments;

-- 두 테이블의 연결 조건을 WHERE에 부여 -> Simple Join
SELECT * FROM employees, departments WHERE employees.department_id = departments.department_id ;-- 106개행
-- 필드의 모호성을 해소하기 위해 테이블명 혹은 alias를 부여
SELECT first_name, department_id, department_name FROM employees, departments WHERE employees.department_id=departments.department_id; -- 열의 정의가 애매하다는 오류발생
SELECT first_name, emp.department_id, dept.department_id, department_name FROM employees emp, departments dept WHERE emp.department_id=dept.department_id; -- 106 개행

-- INNER JOIN
SELECT emp.first_name, dept.department_name FROM employees emp JOIN departments dept USING (department_id);
SELECT first_name, department_name FROM employees emp JOIN departments dept ON emp.department_id=dept.department_id;
-- NATURAL JOIN : 같은 이름을 가진 컬럼을 기준으로 JOIN
SELECT first_name, department_name FROM employees NATURAL JOIN departments;
-- 연습
-- hr.meployees and hr.departments를 이용하여 department_id를 기준으로 join
-- first_name, department_id, department_name 출력
SELECT first_name, dept.department_id, department_name FROM employees emp JOIN departments dept ON dept.department_id=dept.department_id;

-- Thera JOIN
-- 특정 조건을 기준으로 JOIN을 하되 조건이 == 이 아닌 경우
SELECT * FROM jobs WHERE job_id='FI_MGR';
SELECT first_name, salary FROM employees emp, jobs j WHERE j.job_id='FI_MGR' AND salary BETWEEN j.min_salary AND j.max_salary;

-- OUTER JOIN
-- 조건이 만족하는 짝이 없는 레코드도 null을 포함해서 결과를 출력
-- -모든 레코드를 출력할 테이블이 어느 위치에 있는가에 따라 LEFT, RIGHT, FULL
-- ORACLE SQL의 경우 NULL이 출력될 수 있는 쪽 조건에 (+)를 붙인다.
-- 전체 사원의 수
SELECT COUNT(*) FROM employees; -- 107명
-- INNER JOIN 106개행 : 두 테이블 중 짝이없는 한명의 사원이 있다는 것
SELECT first_name, emp.department_id, dept.department_id, department_name FROM employees emp, departments dept WHERE emp.department_id=dept.department_id; 
-- 부서 id가 null인 직원
SELECT first_name, department_id FROM employees WHERE department_id IS NULL;
-- LEFT OUTER JOIN : 짝이 없어도 왼쪽 테이블 전체 출력
-- ORACLE SQL
SELECT first_name, emp.department_id, dept.department_id, department_name FROM employees emp, departments dept WHERE emp.department_id=dept.department_id (+); -- 107개행
-- ANSI SQL
SELECT first_name, emp.department_id, dept.department_id, department_name FROM employees emp LEFT OUTER JOIN departments dept ON emp.department_id=dept.department_id; -- 107개행

-- RIGHT OUTER JOIN
-- 오른쪽 테이블의 모든 레코드 출력 ->왼쪽 테이블에 매칭되는 짝이 없는 경우
-- 왼쪽 테이블 컬럼이 null 표시
-- 부서 개수
SELECT * FROM departments;
-- ORACLE SQL
SELECT first_name, emp.department_id, dept.department_id, department_name FROM employees emp, departments dept WHERE emp.department_id (+) = dept.department_id;
-- ANSI SQL
SELECT first_name, emp.department_id, dept.department_id, department_name FROM employees emp RIGHT OUTER JOIN departments dept ON emp.department_id=dept.department_id;

-- FULL OUTER JOIN -> ANSI SQL에서만 가능
-- 양쪽 테이블 모두 짝이 없어도 출력에 참여
-- ORACLE SQL -> 오류난다.
SELECT first_name, emp.department_id, dept.department_id, department_name FROM employees emp, departments dept WHERE emp.department_id(+)=dept.department_id(+);
--  ANSI SQL
SELECT first_name, emp.department_id, dept.department_id, department_name FROM employees emp FULL OUTER JOIN departments dept ON emp.department_id=dept.department_id;

-- JOIN 연습
-- 부서ID, 부서명, 부서가 속한 도시명, 도시가 속한 국가명을 출력
SELECT department_id, department_name, city, country_name FROM departments dept, locations loc JOIN countries co ON loc.country_id=co.country_id WHERE dept.location_id=loc.location_id ORDER BY dept.department_id asc;
-- OR
SELECT department_id, department_name, city, country_name FROM departments dept, locations loc, countries co WHERE dept.location_id=loc.location_id AND loc.country_id=co.country_id ORDER BY department_id;

-- Self Join
-- 자기 자신과 join하는 경우
-- 한개 테이블을 두 번 이상 사용해야 하므로 반드시 alias를 사용
-- 연습
SELECT *FROM employees; --107명
-- self join을 이용하여 employee_id, first_name, manager의 employee_id, manager의 first_name
SELECT emp.employee_id, emp.first_name, emp.manager_id, man.first_name FROM employees emp JOIN employees man ON emp.manager_id=man.employee_id; -- 106 개행
-- OR
SELECT emp.employee_id, emp.first_name, emp.manager_id, man.first_name FROM employees emp, employees man WHERE emp.manager_id=man.employee_id;
-- manager가 없는 사람?
SELECT *FROM employees WHERE manager_id IS NULL; -- 1 개행
-- manager가 없는 사람도 출력
SELECT emp.employee_id, emp.first_name, emp.manager_id, man.first_name FROM employees emp, employees man WHERE emp.manager_id=man.employee_id (+);