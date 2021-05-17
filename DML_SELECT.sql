-- 해당 스키마 내의 테이블 확인
SELECT * FROM TAB;
-- 특정 테이블 구문 확인
DESC jobs;

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
SELECT job_title, max_salary FROM jobs ORDER BY max_salary;

-- 3. 담당 매니저가 배정되었으나 커미션비율이 없고, 월급이 3000초과인 직원의 이름, 매니저 아이디, 커미션 비율, 월급을 출력
SELECT first_name, manager_id, commission_pct, salary FROM employees WHERE commission_pct IS NULL AND salary > 3000; --46개행

-- 4. 최고월급(max_salary)이 10000 이상인 업무의 이름과 최고월급을 최고월급의 내림차순으로 정렬하여 출력
SELECT job_title, max_salary FROM jobs WHERE max_salary>=10000 ORDER BY max_salary; 

-- 5. 월급이 14000미만 10000이상인 직원의 이름, 월급, 커미션퍼센트를 월급순(내림차순) 출력
-- 단 커미션퍼센트가 null이면 0으로 나타내시오
SELECT first_name, salary, NVL(commission_pct,0) commission_pct FROM employees WHERE salary >=10000 AND salary<14000 ORDER BY salary DESC;

-- 6. 부서번호가 10, 90, 100인 직원의 이름, 월급, 입사일, 부서번호 출력
-- 입사일은 1977-12와 같이 표시
SELECT first_name, salary, TO_CHAR(hire_date, 'YYYY-MM') as hire_date, department_id FROM employees WHERE department_id IN(10,90,100);

-- 7. 이름에 S또는 s가 들어가는 직원의 이름, 월급 출력
SELECT first_name, salary FROM employees WHERE first_name LIKE '%S%' OR first_name LIKE '%s%'; -- 32개행
-- OR
SELECT first_name, salary FROM employees WHERE upper(first_name) like '%S%';

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

-----------------------------------------------
-- 변환 함수
-----------------------------------------------
-- TO_NUMBER(s, frm) -> s는 문자열, frm 포맷형, 문자열을 포맷형태로 수치화
-- TO_DATE(s, frm) -> s는 문자열, frm 포맷형, 문자열을 데이터 형식으로 
-- TO_CHAR(o, fmt) -> o는 숫자, fmt는 포맷형, 숫자,날짜를 문자형으로

-- TO_CHAR
SELECT first_name, hire_date, TO_CHAR(hire_date, 'YYYY-MM-DD HH24:MI:SS') FROM employees;
-- 현재 날짜의 포맷
SELECT sysdate, TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:SS') FROM dual;
-- 숫자 변환 포맷 
SELECT TO_CHAR(123456789.0123,'999,999,999,999.99') FROM dual;
-- 연봉 정보문자열로포맷팅
SELECT first_name, TO_CHAR(salary*12, '$999,999.99') salary FROM employees;
-- TO_NUMBER : 문자열 - > 숫자
SELECT 1999,1350.99 FROM dual;
SELECT TO_NUMBER('1,999', '999,999'), TO_NUMBER('$1,350.99','$999,999.99') FROM dual;
-- TO_DATE : 문자열 -> 날짜
SELECT '2021-05-05 12:30' FROM dual; -- 문자데이터로 출력
SELECT TO_DATE('2021-05-05 14:30', 'YYYY-MM-DD HH24:MI') FROM dual; -- 날짜데이터로 출력

-- DATE 타입의 연산
-- DATE +(-) Number : 날짜에 일수를 더한다.(뺀다.) -> 데이트 타입 출력
-- DATE - DATE : 날짜에서 날짜를 뺀 일수 확인
-- DATE + Number/24 : 날짜에 시간을 더할 때 시간을 24시간으로 나눈값을 더한다.(뺀다.)
SELECT TO_CHAR(sysdate, 'YY/MM/DD HH24:MI'),
    sysdate + 1, --1 일 후
    sysdate - 1, -- 1일 전
    sysdate - TO_DATE('2021-09-24','YYYY-MM-DD'), -- 두 날짜의 사이 일 수
    TO_CHAR(sysdate + 13/24, 'YY/MM/DD HH24:MI') -- 13시간 후 
FROM dual;

--NULL 관련 함수
-- NVL()
SELECT first_name, salary, commission_pct, salary+(salary*NVL(commission_pct,0)) FROM employees;
--NVL2()
SELECT first_name, salary, commission_pct, salary+(salary*NVL2(commission_pct,salary*commission_pct,0)) FROM employees;
-- CASE 함수
-- 보너스를 지급, AD관련직원 20%, SA관련직원 10%, IT관련직원 8%, 나머지는 5% 지급
SELECT first_name, job_id, salary, SUBSTR(job_id, 1,2),
    CASE SUBSTR(job_id, 1,2) WHEN 'AD' THEN salary*0.2
                            WHEN 'SA' THEN salary*0.1
                            WHEN 'IT' THEN salary*0.08
                            ELSE salary*0.05
    END as bonus
FROM employees;
-- DECODE 함수
SELECT first_name, job_id, salary, DECODE(SUBSTR(job_id, 1,2), 'AD',salary*0.2, 'SA',salary*0.1,
                                    'IT',salary*0.08,salary*0.05) BONUS 
FROM employees;
-- 직원의 이름, 부서, 팀 출력
-- 팀은 코드로 결정, 그룹 이름 출력
-- 부서 코드10~30 ,A그룹 / 부서 코드40~50, B그룹 / 부서 코드60~100, C그룹 / 나머지는 REMAINDER
SELECT first_name, department_id, CASE WHEN department_id <= 30 THEN 'A-GROUP'
                                        WHEN department_id <= 50 THEN 'B-GROUP'
                                        WHEN department_id <= 100 THEN 'C-GROUP'
                                        ELSE 'REMAINDER' END as TEAM
FROM employees ORDER BY TEAM;

-----------------------------------------------
-- 연습문제
-- 8. 전체 부서를 출력, 순서는 부서이름이 긴 순서대로 출력
SELECT * FROM departments ORDER BY LENGTH(department_name) DESC;

-- 9. 나라이름을 대문자로 출력하고 오름차순
SELECT UPPER(country_name) FROM countries ORDER BY country_name;
-- OR
select upper(country_name) country_name 
from countries
order by upper(country_name) asc ;

-- 10. 입사일이 03/12/31일 이전에 입사한 직원의 이름, 월급 ,전화번호, 입사일을 출력
-- 전화번호는 545-343-3433 형태로 출력
SELECT first_name, salary, PEPLACE(phone_number,'.','-'), hire_date FROM employees WHERE hire_date<='03/12/31';
