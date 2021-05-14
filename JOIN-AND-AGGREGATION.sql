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

---------------
-- AGGRIGATION
-- 여러 행을 입력으로 데이터를 집계하여 하나의 행으로 반환
---------------
-- COUNT() :갯수 세기
-- employees 테이블에 몇 개의 레코드가 있는지
SELECT COUNT(*) FROM employees; -- *로 카운트 : 모든 레코드의 수(null 포함)
SELECT COUNT(commission_pct) FROM employees; -- 컬럼 명시 카운트 : null값 제외
-- OR
SELECT COUNT(*) FROM employees WHERE commission_pct IS NOT NULL;

-- SUM() : 합계
-- 사원들의 급여 총합
SELECT SUM(salary) FROM employees;

-- AVG() : 평균
-- 사원들의 급여 평균
SELECT AVG(salary) FROM employees;
-- 사원들이 받는 커미션 비율의 평균치
SELECT AVG(commission_pct) FROM employees; -- 22%
-- null을 0으로 치환하고 통계
SELECT AVG(NVL(commission_pct,0)) FROM employees; -- 7%

-- MIN(): 최솟값, MAX(): 최대값, MEDIAN(): 중앙값
-- 사원들이 받는 급여의 최솟값, 최댓값, 평균, 중앙값
SELECT MIN(salary), MAX(salary), AVG(salary), MEDIAN(salary) FROM employees;

-- 흔히 범하는 오류
-- 부서별 평균 급여 산정
SELECT department_id, AVG(salary) FROM employees; -- '단일 그룹의 그룹 함수가 아닙니다' 오류 발생 -> AVG(salary)는 하나의 행으로 결과 반환, department_id는 하나의 행으로 결과를 반환할 수 없어 발생하는 것
SELECT department_id, salary FROM employees ORDER BY department_id;
-- 수정
-- 그룹별 집계를 위해서는 GROUP BY절을 이용
SELECT department_id, ROUND(AVG(salary),2) "Average Salary" FROM employees GROUP BY department_id ORDER BY department_id;

-- 집계 함수를 사용한 쿼리문의 SELECT 컬럼 목록에는
-- 그룹핑에 참여한 필드 or 집계 함수만 올 수 있다.
-- HAVING()절
-- 평균 급여가 7000이상인 부사만 출력
-- 흔히 범하는 오류
SELECT department_id, AVG(salary) FROM employees WHERE AVG(salary)>=7000 GROUP BY department_id; -- '단일 그룹의 그룹 함수가 아닙니다' 오류 발생 
                                                                                                 -- -> WHERE절은 group by, 집계가 일어나기 전에 체크되기 때문에 avg(salary)라는 컬럼이 없는 상태일 때 조건을 확인하게 되어 오류가 발생하는 것
-- 수정
-- HAVING절을 사용 : group by, 집계 함수 이후에 조건을 확인
SELECT department_id, ROUND(AVG(salary),2) FROM employees GROUP BY department_id HAVING AVG(salary)>=7000 ORDER BY department_id;
-- 연습
-- 급여 합계가 20000이상인 부서의 부서 번호와 인원 수, 급여 합계 출력
SELECT department_id, COUNT(*), SUM(salary) FROM employees GROUP BY department_id HAVING SUM(salary)>=20000 ORDER BY SUM(salary) DESC;

-- 분석함수 : group by절과 함께 사용된다.
-- ROLLUP : 그룹핑 된 결과에 대한 좀 더 상세한 요약을 제공, 일종의 ITEM Total 기능 수행
SELECT department_id, job_id, SUM(salary) FROM employees GROUP BY department_id, job_id ORDER BY department_id, job_id;
-- OR
SELECT department_id, job_id, SUM(salary) FROM employees GROUP BY ROLLUP(department_id, job_id) ORDER BY department_id;

-- CUBE : cross tab에 의한 summary 함께 추출
-- rollup 함수에 의해 제공되는 item total과 함께 column total 값을 함께 제공
SELECT department_id, job_id, SUM(salary) FROM employees GROUP BY CUBE(department_id, job_id) ORDER BY department_id;

---------------
-- SUBQUERY
---------------
-- 하나의 SQL 내부에서 다른 SQL를 포함하는 형태
-- 임시로 테이블 구성, 임시결과를 바탕으로 최종 쿼리를 수행
-- 사원들의 급여 중앙값보다 많은 급여를 받은 직원들(1. 직원의 중간값 추출 2. 1보다 급여를 많이 받는 직원 추출)
-- 직원의 중간값 추출
SELECT MEDIAN(salary) FROM employees; -- 6200원
-- 위의 결과값 보다 많은 급여를 받는 직원 추출
SELECT first_name, salary FROM employees WHERE salary>6200 ORDER BY salary DESC;
-- 두 쿼리 합치기
SELECT first_name, salary FROM employees WHERE salary > (SELECT MEDIAN(salary) FROM employees) ORDER BY salary DESC; 

-- 단일행 서브쿼리 연습
-- 'Den'보다 급여를 많이 받는 사원의 이름과 급여
SELECT first_name, salary FROM employees WHERE salary > (SELECT salary FROM employees WHERE first_name='Den') ORDER BY salary DESC;
-- Julia 입사일:060624보다 늦게 입사한 사원 출력
SELECT * FROM employees WHERE hire_date>(SELECT hire_date FROM employees WHERE first_name='Susan') ORDER BY hire_date;
SELECT first_name, hire_date FROM employees where first_name='Susan'; -- 02/06/07
-- 급여를 가장 적게 받는 사람의 이름, 급여, 사원번호 출력
SELECT first_name, salary, employee_id FROM employees WHERE salary = (SELECT MIN(salary) FROM employees);
-- 평균 급여보다 적게 받는 사원의 이름, 급여를 출력
SELECT first_name, salary FROM employees WHERE salary < (SELECT ROUND(AVG(NVL(salary,0)),2) FROM employees) ORDER BY salary DESC;

-- 다중행 서브쿼리 연습
-- 서브쿼리의 결과 레코드가 둘 이상인 것 -> 단순 비교 연산자 수행 불가
-- 집합 연산에 관련된 IN, ANY, ALL, EXSIST 등을 이용
-- IN : IN(12008, 8300) -> salary=12008 OR salary=8300
SELECT first_name, salary FROM employees WHERE salary IN(SELECT salary FROM employees where department_id=110);
-- ALL : ALL(12008, 8300) -> salary>12008 AND salary>8300
SELECT first_name, salary FROM employees WHERE salary > ALL(SELECT salary FROM employees where department_id=110);
-- ANY : ANY(12008, 8300) -> salary>12008 OR salary>8300
SELECT first_name, salary FROM employees WHERE salary > ANY(SELECT salary FROM employees where department_id=110);

-- Correlated Query
-- 바깥쪽 쿼리(주쿼리)와 안쪽 쿼리(서브 쿼리)가 서로 연관된 쿼리
-- 의미
-- 자신이 속한 부서의 평균 급여보다 많이 받는 직원 출력
-- 1. 주쿼리에서 부서번호를 추출 -> 2. 서브 쿼리에서 주 쿼리의 부서번호와 서브 쿼리의 부서번호가 같은 것 중, 급여의 평균을 추출 -> 3. 주쿼리에서 급여와 서브쿼리의 평균급여를 비교하여 큰 값 추출
SELECT first_name, salary, department_id FROM employees outer WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id=outer.deptno);

-- 서브쿼리 연습
-- 각 부서별로 최고 급여를 받는 사원 출력
-- 조건절 이용 1. 각 부서의 최고 급여 테이블 2. 1의 결과인 부서 아이디와 최고 급여를 비교해서 최종 쿼쿼리
SELECT department_id, MAX(salary) FROM employees GROUP BY department_id ORDER BY  department_id; -- 1
SELECT department_id, employee_id, first_name, salary FROM employees WHERE (department_id, salary) IN(SELECT department_id, MAX(salary) FROM employees GROUP BY department_id) ORDER BY  department_id;
-- 조인 이용
SELECT emp.department_id, emp.employee_id, first_name, emp.salary 
FROM employees emp, ( SELECT department_id, MAX(salary) salary FROM employees GROUP BY department_id) sal 
WHERE emp.department_id=sal.department_id AND emp.salary=sal.salary ORDER BY emp.department_id; 