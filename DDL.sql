---------------
-- 테이블 생성
---------------
CREATE TABLE book( -- 컬럼 정의
    book_id NUMBER(5), -- 5자기 정수 타입 -> PK로 변경할 예정
    title VARCHAR2(50), -- 50자리 가변 문자열
    author VARCHAR2(10), --날짜 타입(기본값 - 현재 날짜와 시간)
    pub_date DATE DEFAULT sysdate
);
DESC book;

-- subquery를 이용한 새 테이블 생성
-- hr.employees 테이블에서 일부 데이터를 추출, 새 테이블 만들기
SELECT * FROM hr.employees WHERE job_id LIKE 'IT_%'; -- 5 개행
CREATE TABLE it_emp AS ( SELECT * FROM hr.employees WHERE job_id LIKE 'IT_%');
DESC it_emp;
SELECT * FROM it_emp;

-- 내가 가진 테이블의 목록
SELECT * FROM tab;

---------------
-- 테이블 삭제
---------------
DROP TABLE it_emp;
-- 휴지통 비우기
PURGE RECYCLEBIN;

-- author 테이블 추가
CREATE TABLE author (
    author_id NUMBER(10),
    author_name VARCHAR2(100) NOT NULL, --컬럼 제약 조건 not null
    author_desc VARCHAR2(500),
    PRIMARY KEY (author_id) -- 테이블 제약 조건
);
DESC author;
DESC book;

-- book 테이블의 author 컬럼 삭제
ALTER TABLE book DROP(author);
-- author.author_id를 참조하기 위한 book 테이블에 author.author_id컬럼 추가 -> 외래키 기능
--  author.author_id와 같은 형식으로 지정
ALTER TABLE book ADD(author_id  NUMBER(10));
-- book 테이블의 book_id 타입을 NUMBER(10)으로 수정
ALTER TABLE book MODIFY(book_id NUMBER(10));
-- book.author_id->author.author_id를 참조하도록 변경(외래키:FK)
ALTER TABLE book ADD CONSTRAINT fk_author_id FOREIGN KEY(author_id) REFERENCES author(author_id);

---------------
-- DATA DICTIONARY
---------------
-- 오라클이 관리하는 데이터베이스 관련 정보들을 모아둔 특별한 용도의 테이블
-- USER : 현재 로그인한 사용자 레벨의 객체들
-- ALL : 사용자 전체 대상의 정보
-- DBA : 데이터베이스 전체에 관련된 정보들(관리자 전용)

-- 모든 딕셔너리 확인
SELECT * FROM DICTIONARY;
-- 사용자 스키마 객체 확인 : USER_OBJECTS
SELECT * FROM USER_OBJECTS;
SELECT object_name, object_type FROM USER_OBJECTS;

-- 내가 가진 제약 조건 확인 : USER_CONSTRAINTS
SELECT * FROM USER_CONSTRAINTS;

-- book 테이블에 걸려 있는 제약조건 확인
SELECT constraint_name, constraint_type, search_condition FROM USER_CONSTRAINTS WHERE table_name='BOOK';