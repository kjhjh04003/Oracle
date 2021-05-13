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
SELECT first_name 이름, salary 급여 FROM employees WHERE salary<=14000 OR salary>=17000; --107개행
-- 위의 문제의 반대 : 여집합
SELECT first_name 이름, salary 급여 FROM employees WHERE NOT(salary<=14000 OR salary>=17000); --0개행
-- 부서ID가 90인 사원 중, 급여가 20000이상인 사원
SELECT * FROM employees WHERE department_id=90 and salary>=20000; -- 1개행
-- BETWEEN 연산자
-- 입사일이 07/01/01 ~ 07/12/31 구간에 있는 사원의 목록 출력
SELECT first_name 이름, hire_date 입사일 FROM employees WHERE hire_date BETWEEN '07/01/01' and '07/12/31' ORDER BY hire_date; --19개행
-- 부서 ID가 10,20,40인 사원 명단 출력
SELECT *FROM employees WHERE department_id IN(10,20,40); --4개행
-- MANAGER_ID가 100,120,147인 사원 명단 출력
-- 비교 연산자 사용
SELECT * FROM employees WHERE manager_id=100 OR manager_id=120 OR manager_id=147; --28개행
-- IN 연산자 사용
SELECT * FROM employees WHERE manager_id IN(100,120,147); --28개행
-- LIKE 검색
-- % : 임의의 길이의 지정되지 않은 문자열
-- _ : 한개의 임의의 문자
-- 이름에 am을 포함한 사원의 이름과 급여 출력
SELECT first_name 이름, salary 급여 FROM employees WHERE first_name LIKE '%am%'; --7개행
-- 이름의 두번째 글자가 a인 사원의 이름과 급여를 출력
SELECT first_name 이름, salary 급여 FROM employees WHERE first_name LIKE '_a%'; -- 32개행
-- 이름의 네번째 글자가 a인 사원의 이름 출력
SELECT first_name 이름 FROM employees WHERE first_name LIKE '___a%'; -- 12개행
-- 이름이 4글자인 사원 중 끝에서 두 번째 글자가 a인 사원의 이름 출력
SELECT first_name 이름 FROM employees WHERE first_name LIKE '__a_'; -- 2개행

-- ORDER BY절 : 정렬
-- ASC : 오름차순, 기본설정, 작은 값 -> 큰 값
-- DESC : 내림차순, 큰 값 -> 작은 값
-- 연습
-- 부서번호를 오름차순으로 정렬하고, 부서번호, 급여, 이름을 출력
SELECT department_id, salary, first_name FROM employees ORDER BY department_id;
-- 급여가 10000이상인 직원의 이름을 급여 내림차순으로 출력
SELECT first_name, salary FROM employees WHERE salary>=10000 ORDER BY salary DESC;
-- 부서 번호, 급여, 이름 순으로 출력하되 부서번호 오름차순, 급여 내림차순으로 출력
SELECT department_id, salary, first_name FROM employees ORDER BY department_id, salary DESC;

-----------------------------------------------
-- 연습문제
-- 1. 전체직원의 정보 조회
-- 정렬은 입사일의 오름차순으로 가장 선임부터 출력
-- 이름, 월급, 전화번호, 입사일 순서이고 "이름","월급","전화번호","입사일"로 컬럼 이름 대체
SELECT first_name ||' '|| last_name 이름, salary 월급, phone_number 전화번호, hire_date 입사일 FROM employees ORDER BY hire_date;

--2. 업무별로 업무이름과 최고월급을 월급의 내림차순으로 정렬
SELECT JOB_ID, MAX(salary) as 최고월급 FROM employees ORDER BY salary DESC;

-- 3. 담당 매니저가 배정되었으나 커미션비율이 없고, 월급이 3000초과인 직원의 이름, 매니저 아이디, 커미션 비율, 월급을 출력
SELECT first_name, manager_id, commission_pct, salary FROM employees WHERE commission_pct IS NULL AND salary > 3000; --46개행

-- 4. 최고월급(max_salary)이 10000 이상인 업무의 이름과 최고월급을 최고월급의 내림차순으로 정렬하여 출력

-- 5. 월급이 14000미만 10000이상인 직원의 이름, 월급, 커미션퍼센트를 월급순(내림차순) 출력
-- 단 커미션퍼센트가 null이면 0으로 나타내시오
SELECT first_name, salary, NVL(commission_pct,0) commission_pct FROM employees WHERE salary >=10000 AND salary<14000 ORDER BY salary DESC;

-- 6. 부서번호가 10, 90, 100인 직원의 이름, 월급, 입사일, 부서번호 출력
-- 입사일은 1977-12와 같이 표시

-- 7. 이름에 S또는 s가 들어가는 직원의 이름, 월급 출력
SELECT first_name, salary FROM employees WHERE first_name LIKE '%S%' OR first_name LIKE '%s%'; -- 32개행
-----------------------------------------------

-----------------------------------------------
-- 단일행 함수 : 레코드를 입력으로 받음
-----------------------------------------------

-- 문자열 단일행 함수
-- CONCAT : 문자열 결합
SELECT first_name, last_name, CONCAT(first_name, CONCAT(' ', last_name)) FROM employees;
-- INITCAP : 첫 글자 대문자)
SELECT INITCAP(first_name ||' '|| last_name) FROM employees;
-- LOSER : 소문자
SELECT LOWER(first_name)FROM employees;
-- UPPER : 대문자
SELECT UPPER(first_name) FROM employees;
-- LPAD(n만큼 자리 확보 후 왼쪽을 s2로 채움)
SELECT LPAD(first_name, 20, '*') FROM employees;
-- RPAD
SELECT RPAD(first_name, 20, '*') FROM employees;

--
SELECT '     ORACLE       ', '*********Database*******' FROM dual;

SELECT LTRIM('     ORACLE       '),  -- 왼쪽의 공백 제거
    RTRIM('        ORACLE       '), -- 오른쪽의 공백 제거
    TRIM('*' FROM '*********Database*******'), --양쪽의 지정된 문자 제거
    SUBSTR('Oracle Database',8,4), -- 8번째부터 4개문자
    SUBSTR('Oracle Database',-8,4) -- 뒤에서 8번째 문자부터 4문자
FROM dual;

-- 수치형 단일행 함수
SELECT ABS(-3.14), -- 절대값
    CEIL(3.14), -- 소수점 올림
    FLOOR(3.14), -- 소수점 버림
    MOD(7,3), -- 7을 3으로 나눈 나머지
    POWER(2,4), -- 제곱
    ROUND(3.5), --반올림
    ROUND(3.4567, 2), -- 소수점 2번째 자리까지 반올림으로 표시
    TRUNC(3.5), -- 소수점 아래 버림
    TRUNC(3.4567,2) -- 소수점 2번째 자리까지 버림으로 표시
FROM dual;

-----------------------------------------------
-- DATE Format
-----------------------------------------------
-- 날짜 형식 확인
SELECT * FROM nls_session_parameters WHERE parameter='NLS_DATE_FORMAT';
-- 현재 날짜와 시간
SELECT sysdate FROM dual; --dual 가상 테이블로부터 확인
SELECT sysdate FROM employees; -- 테이블의 레코드 수만큼 sysdate가 출력된다.
-- DATE 관련 함수
SELECT sysdate, -- 현재 날짜와 시간
    ADD_MONTHS(sysdate, 2), -- 현재날짜으로부터 2개월 후 출력
    MONTHS_BETWEEN('99/12/31',sysdate), --1999/12/31 ~ 현재까지의 달 수
    NEXT_DAY(sysdate, 7), -- 현재 날짜 이후의 첫 번째 7요일
    ROUND(sysdate,'MONTH'), -- MONTH 정보로 반올림
    TRUNC(sysdate, 'MONTH'),
    ROUND(TO_DATE('2021-05-17', 'YYYY-MM-DD'),'MONTH'),
    TRUNC(TO_DATE('2021-05-17', 'YYYY-MM-DD'),'MONTH')
FROM dual;
-- 현재 날짜 기준, 입사한지 몇 개월이 지났는가
SELECT first_name, hire_date, ROUND(MONTHS_BETWEEN(sysdate, hire_date)) FROM employees;
