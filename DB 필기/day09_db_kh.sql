/* TCL (COMMIT & ROLLBACK)*/

CREATE TABLE USERTBL(
  USERNO NUMBER UNIQUE,
  ID VARCHAR2(20) PRIMARY KEY,
  PASSWORD CHAR(20) NOT NULL
); -- USERTBL 테이블 생성

COMMIT; -- 커밋(테이블 생성)

INSERT INTO USERTBL
VALUES(1, 'test1', 'password1');

INSERT INTO USERTBL
VALUES(2, 'test2', 'password2');

INSERT INTO USERTBL
VALUES(3, 'test3', 'password2');

SELECT *
FROM USERTBL; -- 조회

ROLLBACK; -- 롤백(삽입한 데이터 사라짐)

/* 데이터 다시 삽입*/
INSERT INTO USERTBL
VALUES(1, 'test1', 'password1');

INSERT INTO USERTBL
VALUES(2, 'test2', 'password2');

INSERT INTO USERTBL
VALUES(3, 'test3', 'password2');

COMMIT; -- 커밋(데이터)

SELECT *
FROM USERTBL; -- 조회

UPDATE USERTBL
SET PASSWORD = 'pass11'
WHERE id = 'test1';

SELECT *
FROM USERTBL; -- 조회

ROLLBACK; -- 롤백(바꾼 test1 의 비밀번호  pass11 -> password1)


SAVEPOINT SP1; -- 세이브 포인트

UPDATE USERTBL
SET PASSWORD = 'pass22'
WHERE id = 'test3'; -- 잘못해서 test3로 입력

ROLLBACK TO SP1; -- 세이브 포인트 SP1으로 되돌아감 

SELECT *
FROM USERTBL; -- 조회

UPDATE USERTBL
SET PASSWORD = 'pass22'
WHERE ID = 'test2'; -- 정상적으로 입력
COMMIT; -- 커밋(최종완료)

SELECT *
FROM USERTBL; -- 조회


/* 데이터 딕셔너리 뷰 */

/*
자신의 계정이 소유한 객체 등에 관한 정보 조회
*/
SELECT *
FROM USER_TABLES;

/*
자신의 계정이 소유하거나 권한 부여 받은 객체 등에 관한 정보 조회
*/
SELECT *
FROM ALL_TABLES;


/*
-- VIEW -- 
회사와 협력한 헬스장
EMPLOYEE 테이블을 편집한 정보를 가지고 있는 별도의 테이블 생성
*/
CREATE TABLE EMPLOYEE_HEALTH AS
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE;

/* kh 계정 EMPLOYEE_HEALTH에서 내용을 추가 해도 업데이트 안됨
khlove1에서 내용 추가 후 조회 해도 반영 안됨
*/

INSERT INTO EMPLOYEE
VALUES('223', '정수지', '920101-1000000', 'email@email.mail', '01000000000', 'D1', 'J6', 'S4', 4000000, 0.1, 217,  SYSDATE , NULL, 'N');

/* 뷰 생성 */
CREATE VIEW EMP_HEALTH_VIEW AS
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE;

/* 뷰 확인 */
SELECT *
FROM EMP_HEALTH_VIEW;

/* 뷰 삭제 */
DROP VIEW EMP_HEALTH_VIEW;

/* 뷰 수정 (EMPLOYEE 원본 테이블의 내용도 변경됨) */
UPDATE EMP_HEALTH_VIEW
SET EMP_NAME = '정지수'
WHERE EMP_NAME LIKE '정수지';

SELECT * FROM EMPLOYEE; -- 원본 테이블 (정수지 -> 정지수)

/* 뷰 - 연봉 포함된 급여 */
CREATE VIEW EMP_SALARY AS 
SELECT SALARY * BONUS "연봉"
FROM EMPLOYEE;


 /* 뷰 실습
특정 업체 (KHLOVE1) 에서
직원 ID, 직원이름, 부서명 정보가 필요하여 본사에 요청하였음
본사에서는 각정보를 가지고 있는 별도의 VIEW를 생성하여
khlove1에게 SELECT 할 수 있는 권한을 주고자 한다

KHLOVE1 계정에서 SELECT * FROM EMP_INFO_VIEW;
라는 SQL을 작성하였을 때 직원 ID, 직원이름, 부서명 정보가 보일 수 있도록 VIEW를 만들어 보아라
*/
SELECT * 
FROM EMPLOYEE;
CREATE VIEW EMP_INFO_VIEW
AS SELECT E.EMP_ID "사원번호", E.EMP_NAME "이름", NVL(D.DEPT_TITLE, '부서없음') "부서명"
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+);

/* SEQUENCE */
CREATE SEQUENCE USERTBL_NO_SEQ        -- USERTBL_NO_SEQ 객체 생성
START WITH 1                          -- 시작번호는 1부터
INCREMENT BY 1                       -- 1씩 증가
MAXVALUE 100                          -- 최대 100까지
NOCYCLE                               -- 100 이후에는 증가하지 않고 에러 발생
NOCACHE;                              -- 캐시 X

SELECT * FROM USER_SEQUENCES;

/* 증가 후의 숫자 */
SELECT USERTBL_NO_SEQ.NEXTVAL FROM DUAL;

/* 현재 숫자*/
SELECT USERTBL_NO_SEQ.CURRVAL FROM DUAL;

SELECT * FROM USERTBL;

/* 자동적으로 번호 입력*/
INSERT INTO USERTBL 
VALUES(USERTBL_NO_SEQ.NEXTVAL, 'USER4', 'PASSWORD4');

INSERT INTO USERTBL 
VALUES(USERTBL_NO_SEQ.NEXTVAL, 'USER5', 'PASSWORD5');

/*
 시퀸스 간단 예제

KH_MEMBER 테이블을 생성

컬럼

MEMEBER_ID  NUMBER
MEMBER_NAME VARCHAR2(20)         
MEMBER_AGE NUMBER
MEMBER_JOIN_COM NUMBER

이떄 해당 사원들의 정보를 INSERT 해야 함
ID 값과 JOIN_COM은 SEQUNCE를 이용하여 정보를 넣고자 함

ID 값은 500번 부터 시작하여 10씩 증가한 값을 저장 하고자 함
JOIN_COM 값은 1번 부터 시작하여 1씩 증가한 값을 저장해야 됨
(ID 값과 JOIN_COM 값의 MAX는 10000으로 설정)

 결과 값 
 
  MEMBER_ID         MEMBER_NAME         MEMBER_AGE          MEMBER_JOIN_COM
  500                      홍길동                        20                             1 
  510                      김말똥                        30                             2
  520                      삼식이                        40                             3
  530                      고길동                        50                             4
*/

/* KH_MEMBER 테이블 생성 */
CREATE TABLE KH_MEMBER(
MEMEBER_ID  NUMBER PRIMARY KEY,
MEMBER_NAME VARCHAR2(20) NOT NULL,  
MEMBER_AGE NUMBER NOT NULL,
MEMBER_JOIN_COM NUMBER NOT NULL
);

/* MEMBER_ID_SEQ 시퀸스 생성 */
CREATE SEQUENCE MEMBER_ID_SEQ
START WITH 500
INCREMENT BY 10
MAXVALUE 10000
NOCYCLE
NOCACHE;

/* MEMBER_JOIN_COM_SEQ 시퀸스 생성 */
CREATE SEQUENCE MEMBER_JOIN_COM_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE;

/* 데이터 삽입 */
INSERT INTO KH_MEMBER
VALUES(MEMBER_ID_SEQ.NEXTVAL, '홍길동', 20, MEMBER_JOIN_COM_SEQ.NEXTVAL);

INSERT INTO KH_MEMBER
VALUES(MEMBER_ID_SEQ.NEXTVAL, '김말똥', 30, MEMBER_JOIN_COM_SEQ.NEXTVAL);

INSERT INTO KH_MEMBER
VALUES(MEMBER_ID_SEQ.NEXTVAL, '삼식이', 40, MEMBER_JOIN_COM_SEQ.NEXTVAL);

INSERT INTO KH_MEMBER
VALUES(MEMBER_ID_SEQ.NEXTVAL, '고길동', 50, MEMBER_JOIN_COM_SEQ.NEXTVAL);

/* 조회 */
SELECT * 
FROM KH_MEMBER;

/* SEQUENCE 딕셔너리 */
SELECT *
FROM USER_SEQUENCES;
