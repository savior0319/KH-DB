/*
kh 계정의 EMPLOYEE_HEALTH 테이블 조회 
(kh 계정 EMPLOYEE_HEALTH에서 내용을 추가 해도 업데이트 안됨)
*/
SELECT * 
FROM kh.EMPLOYEE_HEALTH;

/*
kh 계정에서 만든 EMP_HEALTH_VIEW 뷰 조회
(kh 계정에서 내용 추가 해도 반영 됨 *COMMIT을 해주어야 됨)
*/
SELECT *
FROM kh.EMP_HEALTH_VIEW;

/* EMP_INFO_VIEW 뷰 조회 */
SELECT *
FROM kh.EMP_INFO_VIEW;