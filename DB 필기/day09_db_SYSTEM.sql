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
