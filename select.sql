-- 해당 스키마 내의 테이블 확인
SELECT * FROM TAB;
-- 특정 테이블 구문 확인
DESC employees;

-- SELECT문
-- employees 테이블 전체 데이터 검색
SELECT *FROM employees; -- 50개행
-- departments 테이블 전체 데이터 검색
SELECT *FROM departments; -- 27개행

-- 특정 컬럼 데이터 출력
SELECT employee_id, first_name, last_name FROM employees;
-- 연습
-- 사원이름(first_name)과 전화번호, 입사일, 급여 출력
SELECT first_name, phone_number, hire_date, salary FROM employees;
-- 사원의 이름(first_name), 성(last_name), 급여, 전화번호, 입사일 출력
SELECT first_name, last_name, salary, phone_number, hire_date FROM employees;

-- 산술 연산
-- 컬럼에 없는 산술 연산을 수행할 시 dual사용 -> dual은 가상테이블
SELECT 10+20 FROM dual;
-- 필드값 계산
SELECT salary, salary*12 FROM employees;
SELECT job_id*12 FROM employees; -- 오류발생 > 데이터 타입이 호환되어야 한다.

-- NULL
-- COMMISSION_PCT컬럼에는 NULL 데이터가 포함된다.
SELECT salary, commission_pct FROM employees;
-- NULL 데이터 산술 연산
SELECT first_name, salary, salary+salary*commission_pct FROM employees;
-- NULL 데이터 연산 개선 -> NVL(expr1, expr2)
-- expr1이 NULL이면 expr2 출력
-- expr1과 expr2의 데이터 타입이 호환 가능해야한다.
SELECT first_name, salary, salary+salary*NVL(commission_pct, 0) FROM employees;

-- 문자열 연결 ||
-- first_name, last_name을 연결하여 출력
SELECT first_name ||' '|| last_name FROM employees;

-- Alias : 컬럼 별칭
SELECT first_name 이름, last_name as 성, first_name ||' '|| last_name "전체 이름" FROM employees;
-- 연습
-- 이름 : first_name last_name, 입사일 : hire_date, 전화번호 : phone_number, 급여 : salary, 연봉 : salary*12
SELECT first_name||' '||last_name 이름, hire_date 입사일, phone_number 전화번호, salary 급여, salary*12 연봉 FROM employees;

-- WHERE절 : 조건절
-- 연습
-- 급여가 15000이상인 사원들의 이름과 연봉 출력
SELECT first_name 이름, salary*12 연봉 FROM employees WHERE salary>=15000;
-- 07/01/01일 이후 입사자들의 이름과 입사일을 출력
SELECT first_name 이름, hire_date 입사일 FROM employees WHERE hire_date>='07/01/01';
-- 이름이 'Lex'인 사원의 연봉과 입사일, 부서 ID 출력
SELECT first_name 이름, salary*12 연봉, hire_date 입사일, department_id 부서 FROM employees WHERE first_name='Lex';
-- 부서 ID가 10인 사원의 명단
SELECT * FROM employees WHERE department_id=10;
-- 논리 조합 : 급여가 14000이하이거나 17000이상인 사원의 이름과 급여 출력
SELECT first_name 이름, salary 급여 FROM employees WHERE salary<=14000 OR salary>=17000; --50개행
-- 부서ID가 90인 사원 중, 급여가 20000이상인 사원
SELECT * FROM employees WHERE department_id=90 and salary>=20000;
-- 입사일이 07/01/01 ~ 07/12/31 구간에 있는 사원의 목록 출력
SELECT * FROM employees WHERE hire_date BETWEEN '07/01/01' and '07/12/31' ORDER BY hire_date;
-- 부서 ID가 10,20,40인 사원 명단 출력
SELECT *FROM employees WHERE department_id IN(10,20,40);
-- MANAGER_ID가 100,120,147인 사원 명단 출력
-- 비교 연산자 사용
SELECT * FROM employees WHERE MANAGER_ID=100 OR MANAGER_ID=120 OR MANAGER_ID=147;
-- IN 연산자 사용
SELECT * FROM employees WHERE MANAGER_ID IN(100,120,147);
-- 이름에 am을 포함한 사원의 이름과 급여 출력
SELECT first_name 이름, salary 급여 FROM employees WHERE first_name LIKE '%am%';
-- 이름의 두번째 글자가 a인 사원의 이름과 급여를 출력
SELECT first_name 이름, salary 급여 FROM employees WHERE first_name LIKE '_a%';
-- 이름의 네번째 글자가 a인 사원의 이름 출력
SELECT first_name 이름 FROM employees WHERE first_name LIKE '___a%';
-- 이름이 4글자인 사원 중 끝에서 두 번째 글자가 a인 사원의 이름 출력
SELECT first_name 이름 FROM employees WHERE first_name LIKE '__a_';