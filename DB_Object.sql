---------------------
-- DB OBJECTS
---------------------
-- SYSTEM 계정 CREATE VIEW 권한 부여
-- 해당 권한을 주지 않으면 VIEW를 생성할 수 없다.
GRANT CREATE VIEW TO c##kimjh;

-- SimpleView
-- 단일 테이블, 함수나 연산식을 포함한 컬럼이 없는 단순 뷰
CREATE TABLE emp123 AS SELECT *FROM hr.employees WHERE department_id IN(10,20,30);
SELECT *FROM emp123;
-- emp123테이블에서 department_id가 10번인 사원들을 view로 작성
CREATE OR REPLACE VIEW emp10 AS SELECT employee_id, first_name, last_name, salary FROM emp123 WHERE department_id=10;
DESC emp10;

-- VIEW는 테이블처럼 SELECT 할 수 있다.
-- 다만 실제 데이터는 원본 테이블 내에 있는 데이터 활용
SELECT *FROM emp10;
SELECT first_name ||' '|| last_name, salary FROM emp10;

-- Simple View는 제약 사항에 위배되지 않는다면 내용을 갱신할 수 있다.
-- salary를 2배로 증가
UPDATE emp10 SET salary=salary*2;
ROLLBACK;
SELECT *FROM emp10;
SELECT *FROM emp123;
-- View는 가급적 조회용으로만 사용
-- READ ONLY 옵션 부여 View 생성
CREATE OR REPLACE VIEW emp10 AS SELECT employee_id, first_name, last_name, salary FROM emp123 WHERE department_id=10 WITH READ ONLY;
SELECT *FROM emp10;
UPDATE emp10 SET salary=salary*2; -- 읽기전용 뷰에서는 DML이 수행되지 않는다.

-- 복합 뷰
-- author테이블, book테이블 join
CREATE OR REPLACE VIEW book_detail (book_id, title, author_name, pub_date) AS SELECT book_id, title, author_name, pub_date FROM book b, author a WHERE b.author_id=a.author_id;
DESC book_detail;
SELECT *FROM book_detail;
UPDATE book_detail SET author_name='Unknown'; --복합 뷰에서는 기본 DML을 수행할 수 없다.