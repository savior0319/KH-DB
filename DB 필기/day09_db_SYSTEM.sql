/* 데이터 딕셔너리 뷰 */

/*
데이터 베이스 관리자가 접근 가능한 테이블 정보 조회
*/
SELECT *
FROM DBA_TABLES;

/*
자신의 계정이 소유하거나 권한 부여 받은 객체 등에 관한 정보 조회
*/
SELECT *
FROM ALL_TABLES;

/*
자신의 계정이 소유한 객체 등에 관한 정보 조회
*/
SELECT *
FROM USER_TABLES;


/* VIEW */

/*
khlove1에게 kh계정의 EMLOLYEE_HEALTH SELECT 권한 부여
*/
GRANT SELECT ON kh.EMPLOYEE_HEALTH TO khlove1;

/* kh계정에 VIEW 생성권한 부여 */
GRANT CREATE VIEW TO kh;

/* khlove1 계정에 kh계정의 뷰 EMP_HEALTH_VIEW SELECT 권한 부여*/
GRANT SELECT ON KH.EMP_HEALTH_VIEW
TO khlove1;

/*
EMP_INFO_VIEW 뷰 권한 부여
*/
GRANT SELECT ON KH.EMP_INFO_VIEW
TO khlove1;

/*
kh계정에게 동의어 생성 권한 부여
*/
GRANT CREATE SYNONYM TO kh; 

/*
공개 동의어 생성
*/
CREATE PUBLIC SYNONYM DEPT FOR kh.DEPARTMENT;

/*
kh계정에게 공개 동의어 사용 권한 부여
*/
GRANT SELECT ON DEPT TO kh;


/* 실습문제 */
CREATE USER KHTEST  IDENTIFIED BY KHTEST;
GRANT CONNECT TO KHTEST;
GRANT RESOURCE TO KHTEST;
GRANT CREATE SEQUENCE TO KHTEST;
GRANT CREATE VIEW TO KHTEST;
GRANT INDEX TO KHTEST;
GRANT CREATE SYNONYM TO KHTEST;


















