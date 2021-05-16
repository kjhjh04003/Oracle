-- 1. 매니저가 있는 직원은 몇 명입니까?
SELECT COUNT(*) as haveMngCnt FROM employees emp JOIN employees man ON emp.manager_id=man.employee_id;

-- 2. 직원중에 최고임금과 최저임금을 "최고임금","최저임금" 타이틀로 출력
-- 두 임금 차이는 얼마인지를 "최고임금-최저임금" 타이틀로 출력
SELECT MAX(salary) as "최고임금", MIN(salary) as "최저임금", MAX(salary)-MIN(salary) as "최고임금-최저임금"
FROM employees;

-- 3. 마지막으로 신입사원이 들어온 날은 언제인지 2014년 07월 10일 형식으로 출력
SELECT TO_CHAR(hire_date, 'YYYY"년"MM"월"DD"일"') as hire_date FROM (SELECT hire_date FROM employees ORDER BY hire_date DESC)
WHERE rownum<2;

-- 4. 부서별로 평균임금, 최고임금, 최저임음을 부서아이디와 함께 출력
-- 정렬 순서는 부서번호 내림차순
SELECT department_id, ROUND(AVG(salary),2) as 평균임금, MAX(salary) as 최고임금, MIN(salary) as 최저임금
FROM employees GROUP BY department_id ORDER BY department_id DESC;

-- 5. 업무(job_id)별로 평균임금, 최고임금, 최저임금을 업무아이디(job_id)와 함께 출력
-- 최저임금 내림차순, 평균임금(소수점 반올림) 오름차순 으로 정렬
-- 정렬 순서 : 최소임금 2500구간일때부터 확인
SELECT job_id, ROUND(AVG(salary),0) as "평균임금", MAX(salary) as "최고임금", MIN(salary) as "최소임금"
FROM employees GROUP BY job_id HAVING MIN(salary)>2500 ORDER BY 최소임금 DESC, 평균임금;

-- 6. 가장 오래 근속한 직원의 입사일은 언제인지 2001-01-13 토요일 형식으로 출력
SELECT TO_CHAR(hire_date, 'YYYY-MM-DD DAY') as 입사일
FROM (SELECT hire_date FROM employees ORDER BY hire_date) WHERE rownum<2;

-- 7. 평균임금과 최저임금의 차이가 2000 미만인 부서, 평균임금, 최저임금, (평균임금-최저임금)을 (평균임금-최저임금) 내임차순으로 출력
SELECT department_id, ROUND(AVG(salary),2) as 평균임금, MIN(salary) as 최저임금, ROUND((AVG(salary)-MIN(salary)),2) as "평균임금-최저임금"
FROM employees GROUP BY department_id HAVING AVG(salary)-MIN(salary)<2000 ORDER BY 평균임금-최저임금 DESC;

-- 8. 업무별로 최고임금과 최저임금의 차이를 내림차순으로 출력
SELECT job_id as 업무, MAX(salary) as 최고임금, MIN(salary) as 최저임금, MAX(salary)-MIN(salary) as "최고임금-최저임금"
FROM employees GROUP BY job_id ORDER BY "최고임금-최저임금" DESC;

-- 9. 2005년 이후 입사자 중 관리자별로 평균급여가 5000이상 중 평균급여 최소급여 최대급여 출력
-- 평균급여 내림차순 , 첫번째 자리까지 반올림
SELECT manager_id, ROUND(AVG(salary),1) 평균급여, MIN(salary) 최소급여, MAX(salary) 최대급여
FROM employees WHERE hire_date >= (SELECT hire_date FROM employees WHERE hire_date LIKE '05%')
GROUP BY manager_id HAVING AVG(salary)>=5000 AND hire_date >'05/01/01'
ORDER BY 평균급여 DESC;

-- 10. 입사일이 02/12/31일 이전이면 '창립멤버', 03년은 '03년입사', 04년은 '04년입사' 이후 입사자는 '상장이후입사'를 optDate 컬럼에 출력
-- 정렬은 입사일로 오름차순
SELECT first_name, hire_date, CASE WHEN hire_date <= '02/12/31' THEN '창립멤버'
            WHEN hire_date <= '03/12/31' THEN '03년입사'
            WHEN hire_date <= '04/12/31' THEN '04년입사'
            WHEN hire_date >= '05/01/01' THEN '상장이후입사'
            END as optDate
FROM employees ORDER BY hire_date;   