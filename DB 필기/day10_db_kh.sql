/* OUTPUT ON (DBMS_OUTPUT.PUT_LINE() 을 사용하기 위해 설정)*/
SET SERVEROUTPUT ON;

/* PL/SQL */
BEGIN
  DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/

/* 이름을 검색하는 PL/SQL 프로시저*/
DECLARE
  ID NUMBER;
  NAME VARCHAR2(20);
  NO VARCHAR2(20);
BEGIN
  SELECT EMP_ID, EMP_NAME, EMP_NO
  INTO ID, NAME, NO
  FROM EMPLOYEE
  WHERE EMP_NAME = '&이름';
  DBMS_OUTPUT.PUT_LINE(ID);
  DBMS_OUTPUT.PUT_LINE(NAME);
  DBMS_OUTPUT.PUT_LINE(NO);
EXCEPTION
  WHEN NO_DATA_FOUND 
  THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다');
END;
/


/* 문제 1
해당 사원의 사원번호를 입력시
이름, 부서코드, 직급코드이 출력되도록 PL/SQL로 만들어 보시오
*/
DECLARE
    NAME VARCHAR2(20);
    DEPTCODE VARCHAR2(20);
    JOBCODE VARCHAR2(10);
BEGIN
    SELECT EMP_NAME, DEPT_CODE, JOB_CODE
    INTO NAME, DEPTCODE, JOBCODE
    FROM EMPLOYEE
    WHERE EMP_ID LIKE '&EMP_ID';
    DBMS_OUTPUT.PUT_LINE(NAME);
    DBMS_OUTPUT.PUT_LINE(DEPTCODE);
    DBMS_OUTPUT.PUT_LINE(JOBCODE);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다');
END;
/

/* 문제 2
해당 사원의 사원번호를 입력시
이름, 부서명, 직급명이 출력되도록 PL/SQL로 만들어 보시오
*/
DECLARE
    NAME VARCHAR2(20);
    DEPTNAME VARCHAR2(20);
    JOBNAME VARCHAR2(10);
BEGIN
    SELECT EMP_NAME, DEPT_TITLE, JOB_NAME
    INTO NAME, DEPTNAME, JOBNAME
    FROM EMPLOYEE E , DEPARTMENT , JOB J
    WHERE E.EMP_ID LIKE '&EMP_ID'
    AND E.DEPT_CODE = DEPT_ID(+)
    AND E.JOB_CODE = J.JOB_CODE;
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || DEPTNAME);
    DBMS_OUTPUT.PUT_LINE('직급명 : ' || JOBNAME);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다');
END;
/

/* 문제 2 스칼라 서브쿼리 방법 */
DECLARE
    NAME VARCHAR2(20);
    D_TITLE VARCHAR2(20);
    J_NAME VARCHAR2(20);
BEGIN
    SELECT EMP_NAME,(SELECT DEPT_TITLE
                    FROM DEPARTMENT D
                    WHERE E.DEPT_CODE = D.DEPT_ID)
                        ,(SELECT JOB_NAME
                            FROM JOB J
                            WHERE J.JOB_CODE = E.JOB_CODE)
    INTO NAME,D_TITLE,J_NAME
    FROM EMPLOYEE E
    WHERE EMP_ID = '&사원번호';
    DBMS_OUTPUT.PUT_LINE('이름: ' || NAME);
    DBMS_OUTPUT.PUT_LINE('부서명: ' || D_TITLE);
    DBMS_OUTPUT.PUT_LINE('직급명: ' || J_NAME);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다.');
END;
/

/*
참조형 변수 (%TYPE)
*/
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE; -- EMPLOYEE 테이블의 EMP_ID 자료형을 사용
    NAME EMPLOYEE.EMP_NAME%TYPE; -- EMPLOYEE 테이블의 EMP_NAME 자료형을 사용
    NO EMPLOYEE.EMP_NO%TYPE; -- EMPLOYEE 테이블의 EMP_NO 자료형을 사용
    SALARY EMPLOYEE.SALARY%TYPE; -- EMPLOYEE 테이블의 EMP_SALARY 자료형을 사용
    HIRE_DATE EMPLOYEE.HIRE_DATE%TYPE; -- EMLOYEE 테이블의 EMP_HIRE_DATE 자료형을 사용
BEGIN
    SELECT EMP_ID, EMP_NAME, EMP_NO, SALARY, HIRE_DATE
    INTO ID, NAME, NO, SALARY, HIRE_DATE
    FROM EMPLOYEE
    WHERE EMP_NAME LIKE '&사원명';
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('주민번호 : ' || NO);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
    DBMS_OUTPUT.PUT_LINE('입사일 : ' || HIRE_DATE); 
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다');
END;
/


/*
참조형 변수 (%ROWTYPE)
*/
DECLARE
  EMP EMPLOYEE%ROWTYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME, EMP_NO
  INTO EMP.EMP_ID, EMP.EMP_NAME, EMP.EMP_NO
  FROM EMPLOYEE
  WHERE EMP_ID LIKE '200';
  DBMS_OUTPUT.PUT_LINE('사원번호 : ' || EMP.EMP_ID);
  DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.EMP_NAME);
  DBMS_OUTPUT.PUT_LINE('주민번호 : ' || EMP.EMP_NO);
EXCEPTION
  WHEN NO_DATA_FOUND
  THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다');
END;
/


/* 레코드 (타입을 스스로 만듦) */

DECLARE
  TYPE MY_ROW_TYPE IS RECORD(
    ID EMPLOYEE.EMP_ID%TYPE,
    NAME VARCHAR2(20),
    SALARY EMPLOYEE.SALARY%TYPE
  );
  EMP MY_ROW_TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME, SALARY
  INTO EMP.ID, EMP.NAME, EMP.SALARY
  FROM EMPLOYEE
  WHERE EMP_ID LIKE '200';
  DBMS_OUTPUT.PUT_LINE('사원번호 : ' || EMP.ID);
  DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.NAME);
  DBMS_OUTPUT.PUT_LINE('급여 : ' || EMP.SALARY);
END;
/

--@실습문제1
--사번, 사원명, 직급코드, 급여를 담을수 있는 참조변수를 통해서 (%TYPE)
--송종기사원의 사번, 사원명, 직급코드,급여를 익명블럭을 통해 스크립트 출력하세요.
DECLARE
  ID EMPLOYEE.EMP_ID%TYPE;
  NAME EMPLOYEE.EMP_NAME%TYPE;
  JOBCODE EMPLOYEE.JOB_CODE%TYPE;
  SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
  INTO ID, NAME, JOBCODE, SALARY
  FROM EMPLOYEE
  WHERE EMP_NAME LIKE '송종기';
  DBMS_OUTPUT.PUT_LINE('사번 -> ' || ID);
  DBMS_OUTPUT.PUT_LINE('이름 -> ' || NAME);
  DBMS_OUTPUT.PUT_LINE('직급 -> ' || JOBCODE);
  DBMS_OUTPUT.PUT_LINE('급여 -> ' || SALARY);
EXCEPTION
  WHEN NO_DATA_FOUND
  THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다');
END;
/

--@실습문제2
--사번, 사원명, 직급명을 담을수 있는 참조변수를 통해서 (record)
-- 사원명을 검색하여 해당 사원의 사번, 사원명, 부서명,직급명을 
-- 익명블럭을 통해 스크립트 출력하세요.
DECLARE
  TYPE EMP_ROW_REC IS RECORD(
    ID EMPLOYEE.EMP_ID%TYPE,
    NAME EMPLOYEE.EMP_NAME%TYPE,
    DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE,
    JOB_NAME JOB.JOB_NAME%TYPE
  );
  REC EMP_ROW_REC;
BEGIN
  SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
  INTO REC.ID, REC.NAME, REC.DEPT_TITLE, REC.JOB_NAME
  FROM EMPLOYEE E, JOB J, DEPARTMENT D
  WHERE DEPT_ID(+) = DEPT_CODE
  AND J.JOB_CODE = E.JOB_CODE
  AND EMP_NAME = '&EMP_NAME';
  DBMS_OUTPUT.PUT_LINE('사원번호 -> ' || REC.ID);
  DBMS_OUTPUT.PUT_LINE('이름 -> ' || REC.NAME);
  DBMS_OUTPUT.PUT_LINE('부서명 -> ' || REC.DEPT_TITLE);
  DBMS_OUTPUT.PUT_LINE('직급명 -> ' || REC.JOB_NAME);
EXCEPTION
  WHEN NO_DATA_FOUND
  THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다');
END;
/

--@실습문제3
-- 사원번호를 입력하여 해당 사원을 찾아  (%ROWTYPE을 사용)
-- 사원명, 주민번호, 입사일, 부서명을  
-- 익명블럭을 통해 스크립트 출력하세요.
DECLARE
  EMP EMPLOYEE%ROWTYPE;
  DEP DEPARTMENT%ROWTYPE;
BEGIN
  SELECT EMP_NAME, EMP_NO, HIRE_DATE, DEPT_TITLE
  INTO EMP.EMP_NAME, EMP.EMP_NO, EMP.HIRE_DATE, DEP.DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
  WHERE DEPT_ID(+) = DEPT_CODE
  AND EMP_ID = '&EMP_ID';
  DBMS_OUTPUT.PUT_LINE('사원명 -> ' || EMP.EMP_NAME);
  DBMS_OUTPUT.PUT_LINE('주민번호 -> ' || EMP.EMP_NO);
  DBMS_OUTPUT.PUT_LINE('입사일 -> ' || TO_CHAR(EMP.HIRE_DATE, 'YYYY-MM-DD')); 
  DBMS_OUTPUT.PUT_LINE('부서명 -> ' || DEP.DEPT_TITLE);
EXCEPTION
  WHEN NO_DATA_FOUND
  THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다');
END;
/

/* 조건문 IF */

/*
사원 번호를 가지고 사원의 사번, 이름, 보너스율을 출력하고
보너스율이 없으면 '보너스를 지급 받지않는 사원입니다'를 출력

1. 사원번호를 가지고 해당 사원의 사번, 이름, 급여, 보너스율을 출력
2. 보너스율이 0%라면 ?
    -> 보너스를 지급 받지 않는 사원입니다.
*/

DECLARE
  EMPNUM EMPLOYEE.EMP_ID%TYPE;
  EMPNAME EMPLOYEE.EMP_NAME%TYPE;
  EMPSALARY EMPLOYEE.SALARY%TYPE;
  EMPBONUS EMPLOYEE.BONUS%TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
  INTO EMPNUM , EMPNAME, EMPSALARY, EMPBONUS
  FROM EMPLOYEE
  WHERE EMP_ID = '&EMP_ID';
  DBMS_OUTPUT.PUT_LINE('사원번호 -> ' || EMPNUM);
  DBMS_OUTPUT.PUT_LINE('이름 -> ' || EMPNAME);
  DBMS_OUTPUT.PUT_LINE('급여 -> ' || EMPSALARY);
  DBMS_OUTPUT.PUT_LINE('보너스율 -> ' || LTRIM(TO_CHAR(EMPBONUS * 100, 'FM99D0'), '.') || '%');
  IF(EMPBONUS = 0)
  THEN  DBMS_OUTPUT.PUT_LINE('보너스를 지급 받지 않는 사원입니다');
  END IF;
END;
/

/*
  예제 ) 사원번호를 가지고 사원의 사버느 이름, 급여, 보너스율을 출력 함
  이때, 보너스율이 없으면 '보너스를 지급 받지 않는 사원 입니다'를 출력하고
  보너스율이 있다면 보너스율을 출력함
  (즉, 보너스율이 0%라면 보너스율을 출력하지 않음)
*/

DECLARE
  EMPNUM EMPLOYEE.EMP_ID%TYPE;
  EMPNAME EMPLOYEE.EMP_NAME%TYPE;
  EMPSALARY EMPLOYEE.SALARY%TYPE;
  EMPBONUS EMPLOYEE.BONUS%TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
  INTO EMPNUM , EMPNAME, EMPSALARY, EMPBONUS
  FROM EMPLOYEE
  WHERE EMP_ID = '&EMP_ID';
  DBMS_OUTPUT.PUT_LINE('사원번호 -> ' || EMPNUM);
  DBMS_OUTPUT.PUT_LINE('이름 -> ' || EMPNAME);
  DBMS_OUTPUT.PUT_LINE('급여 -> ' || EMPSALARY);
  IF(EMPBONUS = 0)
  THEN  DBMS_OUTPUT.PUT_LINE('보너스를 지급 받지 않는 사원입니다');
  ELSE  DBMS_OUTPUT.PUT_LINE('보너스율 -> ' || LTRIM(TO_CHAR(EMPBONUS * 100, 'FM99D0'), '.') || '%');
  END IF;
END;
/

/*
사원 번호를 가지고 해당 사원을 조회
이때 사원명, 부서명을 출력하여라
만약 부서가 없다면 부서명을 출력하지 않고,
'부서가 없는 사원입니다'를 출력하고 
부서가 있다면 부서명을 출력하여라
*/
DECLARE
  NAME EMPLOYEE.EMP_NAME%TYPE;
  DEPT_TITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
  SELECT EMP_NAME, DEPT_TITLE
  INTO NAME, DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
  WHERE EMP_ID LIKE '&EMP_ID'
  AND DEPT_CODE = DEPT_ID(+);
  DBMS_OUTPUT.PUT_LINE('사원명 -> ' || NAME);
  IF (DEPT_TITLE IS NULL)
  THEN DBMS_OUTPUT.PUT_LINE('부서가 없는 사원입니다');
  ELSE DBMS_OUTPUT.PUT_LINE('부서명 -> ' || DEPT_TITLE);
  END IF;
END;
/

/*
사원 코드를 입력 받았을 때 사번, 이름, 부서코드, 부서명, 소속 값을 출력하시오
그 때, 소속값은 J1, J2, 는 임원진 그 외에는 일반직원으로 출력 되게 하시오
*/
DECLARE
  NUM EMPLOYEE.EMP_ID%TYPE;
  NAME EMPLOYEE.EMP_NAME%TYPE;
  DEPTCODE EMPLOYEE.DEPT_CODE%TYPE;
  DEPTNAME DEPARTMENT.DEPT_TITLE%TYPE;
  JOBCODE EMPLOYEE.JOB_CODE%TYPE;
  TEAM VARCHAR2(20); -- 변수 TEAM
BEGIN
  SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, D.DEPT_TITLE, E.JOB_CODE
  INTO NUM, NAME, DEPTCODE, DEPTNAME, JOBCODE
  FROM EMPLOYEE E , DEPARTMENT D
  WHERE DEPT_CODE = DEPT_ID(+)
  AND EMP_ID = '&EMP_ID';
    DBMS_OUTPUT.PUT_LINE('사번 -> ' || NUM);
    DBMS_OUTPUT.PUT_LINE('이름 -> ' || NAME);
    DBMS_OUTPUT.PUT_LINE('부서코드 -> ' || NVL(DEPTCODE, '부서없음'));
    DBMS_OUTPUT.PUT_LINE('부서명 -> ' || NVL(DEPTNAME, '부서없음'));
    IF(JOBCODE IN ('J1', 'J2'))
      THEN TEAM := '임원진';
      ELSE TEAM := '일반직원';
    END IF;
    DBMS_OUTPUT.PUT_LINE('소속 값 -> ' || TEAM);
EXCEPTION 
  WHEN NO_DATA_FOUND
  THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다');
END;
/

/*
사원번호로 사원을 조회 하였을 때
급여 레벨 S1, S2인 경우 고임금
급여 레벨  S3, S4 평균임금
급여 레벨  S5, S6 저임금으로 출력
*/

DECLARE
  ID EMPLOYEE.EMP_ID%TYPE;
  NAME EMPLOYEE.EMP_NAME%TYPE;
  SLEV EMPLOYEE.SAL_LEVEL%TYPE;
  SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME, SAL_LEVEL, SALARY
  INTO ID, NAME, SLEV, SALARY
  FROM EMPLOYEE
  WHERE EMP_ID LIKE '&EMP_ID';
  DBMS_OUTPUT.PUT_LINE('사원번호 -> ' || ID);
  DBMS_OUTPUT.PUT_LINE('이름 -> ' || NAME);
  DBMS_OUTPUT.PUT_LINE('급여레벨-> ' || SLEV);
  DBMS_OUTPUT.PUT_LINE('급여 -> ' || SALARY);
IF(SLEV IN ('S1', 'S2'))
THEN DBMS_OUTPUT.PUT_LINE('급여수준 -> 고임금');
ELSIF(SLEV IN ('S3', 'S4'))
THEN DBMS_OUTPUT.PUT_LINE('급여수준 -> 평균임금');
ELSE
DBMS_OUTPUT.PUT_LINE('저임금');
END IF;
END;
/

/*
## 실습문제 ##
사번을 입력 받은 후 급여에 따라 등급을 나누어 출력하도록 하시오
그 때 출력 값은 사번, 이름, 급여, 급여등급을 출력하시오

0만원 ~ 99만원 : F
100만원 ~ 199만원 : E
200만원 ~ 299만원 : D
300만원 ~ 399만원 : C
400만원 ~ 499만원 : B
500만원 이상(그 외) : A
*/

DECLARE
  ID EMPLOYEE.EMP_ID%TYPE;
  NAME EMPLOYEE.EMP_NAME%TYPE;
  SALARY EMPLOYEE.SALARY%TYPE;
  GRADE CHAR(1);
BEGIN
  SELECT EMP_ID, EMP_NAME, SALARY
  INTO ID, NAME, SALARY
  FROM EMPLOYEE
  WHERE EMP_ID LIKE '&EMP_ID';
  DBMS_OUTPUT.PUT_LINE('사번 -> ' || ID);
  DBMS_OUTPUT.PUT_LINE('이름 -> ' || NAME);
  DBMS_OUTPUT.PUT_LINE('급여 -> ' || '\' || TO_CHAR(SALARY, '9,999,999'));
  IF(SALARY BETWEEN 0 AND 990000)
  THEN GRADE := 'F';
  ELSIF (SALARY BETWEEN 1000000 AND 1990000)
  THEN GRADE := 'E';
  ELSIF (SALARY BETWEEN 2000000 AND 2990000)
  THEN GRADE := 'D';
  ELSIF (SALARY BETWEEN 3000000 AND 3990000)
  THEN GRADE := 'C';
  ELSIF (SALARY BETWEEN 4000000 AND 4990000)
  THEN GRADE := 'B';
  ELSE GRADE := 'A';
  END IF;
  DBMS_OUTPUT.PUT_LINE('등급 -> ' || GRADE);
END;
/


-- CASE 문으로 변경


DECLARE
  ID EMPLOYEE.EMP_ID%TYPE;
  NAME EMPLOYEE.EMP_NAME%TYPE;
  SALARY EMPLOYEE.SALARY%TYPE;
  GRADE CHAR(1);
  SALARYCHECK NUMBER;
BEGIN
  SELECT EMP_ID, EMP_NAME, SALARY
  INTO ID, NAME, SALARY
  FROM EMPLOYEE
  WHERE EMP_ID LIKE '&EMP_ID';
  DBMS_OUTPUT.PUT_LINE('사번 -> ' || ID);
  DBMS_OUTPUT.PUT_LINE('이름 -> ' || NAME);
  DBMS_OUTPUT.PUT_LINE('급여 -> ' || '\' || TO_CHAR(SALARY, '9,999,999'));
  SALARYCHECK := (SALARY / 1000000);
  CASE FLOOR(SALARYCHECK)
  WHEN 0 THEN  GRADE := 'F';
  WHEN 1 THEN  GRADE := 'E';
  WHEN 2 THEN  GRADE := 'D';
  WHEN 3 THEN  GRADE := 'C';
  WHEN 4 THEN  GRADE := 'B';
  ELSE GRADE := 'A';
  END CASE;
  DBMS_OUTPUT.PUT_LINE('등급 -> ' || GRADE);
END;
/

/* CASE 
예시) 1 ~ 3 까지의 수를 입력 받고
  1을 입력 받으면 '안녕하세요'
  2를 입력 받으면 '반갑습니다'
  3을 입력 받으면 '행복하세요'
그 외 입력 시는 '잘못 입력하셨습니다'를 출력하는 코드
*/
DECLARE
  DATA NUMBER;
BEGIN
  DATA := '&DATA';
  CASE DATA
  WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('안녕하세요');
  WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('반갑습니다');
  WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('행복하세요');
  ELSE DBMS_OUTPUT.PUT_LINE('잘못 입력했습니다');
  END CASE;
  END;
/

/*
## 실습문제 1 ##
-- 사원번호를 입력받아서 사원의 사번,이름,급여,보너스율을 출력히자.
-- (추가)대표님인 경우, '저희회사 대표님이십니다.'를 출력. (직급코드변수 추가.)
*/
DECLARE
  ID EMPLOYEE.EMP_ID%TYPE;
  NAME EMPLOYEE.EMP_NAME%TYPE;
  SAL EMPLOYEE.SALARY%TYPE;
  BO EMPLOYEE.BONUS%TYPE;
BEGIN
  SELECT EMP_ID, EMP_NAME, SALARY, BONUS
  INTO ID, NAME, SAL, BO
  FROM EMPLOYEE
  WHERE EMP_ID = '&EMP_ID';
  DBMS_OUTPUT.PUT_LINE(ID);
    DBMS_OUTPUT.PUT_LINE(NAME);
      DBMS_OUTPUT.PUT_LINE(SAL);
        DBMS_OUTPUT.PUT_LINE(BO);
END;
/


/*
## 실습문제 2 ##
-- 해당 사원 번호를 입력받아 해당 사원이 소속된 부서에서 
-- 가장 높은 급여를 받고 있는 사원을 출력하여라
-- 출력 값은 
-- 검색된 사원명, 검색된 사원 부서, 
-- 소속부서에서 가장 높은 급여를 받은 사원명 및 급여,부서 정보를 출력 하여라.

ex) 

사원번호 '207'번을 입력시

### 검색된 사원 정보 ###
검색된 사원명 : 하이유
소속된 부서명 : 해외영업1부
-------------------------------
### 해외영업1부에서 급여가 가장 높은 사원 정보 ###
사원명 : 대북혼
급여 : 3760000 원
소속된 부서 : 해외영업1부
*/
