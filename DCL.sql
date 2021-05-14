---------------
-- 사용자 관련
---------------
-- SYSTEM 계정으로 수행
-- CREATE(생성) /ALTER(수정) / DROP(삭제) 키워드

-- 사용자 생성
-- oracle12버전 이상부터 사용자 생성 시 C##을 붙여야 한다.
CREATE USER C##KIMJH IDENTIFIED BY 1234;
-- 사용자 비밀번호 변경
ALTER USER C##KIMJH IDENTIFIED BY test;
-- 사용자 삭제
DROP USER C##KIMJH;
-- 사용자 삭제 시 데이터베이스 내부에 해당 사용자의 테이블 등 데이터베이스 객체가 이미 만들어져 있으면 그냥 삭제가 안된다.
DROP USER C##KIMJH CASCADE; -- CASCADE(폭포수)

-- 다시 사용자 생성
CREATE USER C##KIMJH IDENTIFIED BY 1234;
-- SQLplus로 접속 시도( cmdc창 이용 > sqlplus 계정명/비밀번호)
-- 사용자 생성 시 권한을 부여하지 않으면 아무 일도 할 수 없다.

-- 사용자 정보 확인
-- USER_USERS : 현재 사용자 정보(로그온 한 사용자 정보)
-- ALL_USERS : DB 전체 사용자 정보
-- DBA_USERS : 모든 사용자 상세 정보, DBA 전용
DESC USER_USERS;
SELECT *FROM USER_USERS;

DESC ALL_USERS;
SELECT *FROM ALL_USERS;

DESC DBA_USERS;
SELECT *FROM DBA_USERS;

-- 시스템 권한의 부여
-- GRANT 권한(역할) TO 사용자;
-- 스키마 객체의 권한 부여
-- GRANT 권한 ON 객체 TO 사용자;
-- 사용자 계정에게 로그인(접속) 권한 부여
GRANT create session TO C##KIMJH;
-- sqlplus에서 테이블 만들기 시도 -> 오류난다.
-- 일반적으로 데이터베이스 접속 후 테이블을 만들고 사용하려면
-- CONNECT, RESOURCE 롤을 부여해야 한다.
GRANT connect, resource TO C##KIMJH;
-- sqlplus에서 테이블에 데이터 삽입 시도 -> 오류난다.
-- oracle12이상에서는 사용자 테이블 스페이스에 공간 부여 필요
ALTER USER C##KIMJH DEFAULT TABLESPACE USERS QUOTA unlimited ON USERS;

GRANT select ON hr.employees TO C##KIMJH;
GRANT select ON hr.departments TO C##KIMJH;

-- 시스템 권한 회수
-- REVOKE 권한(역할) FROM 사용자;
-- 스키마 객체 권한 회수
-- REVOKE 권한 ON 객체 FROM 사용자;

-- 이하, 사용자 계정으로 수행
SELECT *FROM hr.employees;
SELECT *FROM hr.departments;

-- system 계정으로 c##kimjh 사용자의 hr.departments select 권한 회수
REVOKE select ON hr.departments FROM C##KIMJH;

-- 현재 사용자에게 부여된 role 확인
SELECT * FROM user_role_privs;
