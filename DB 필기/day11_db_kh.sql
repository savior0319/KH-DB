   /* 반목문 */
   DECLARE
  	i NUMBER := 1;

  BEGIN
  	LOOP
  		DBMS_OUTPUT.PUT_LINE(i);
  		i := i + 1;
  		IF i > 5 THEN EXIT;
  		END IF;
  	END LOOP;
  END;
  /
 
  BEGIN
      FOR I IN 1..5 LOOP
          DBMS_OUTPUT.PUT_LINE(I);
      END LOOP;
  END;
  /
  
/*
REVERSE
*/  
   BEGIN
      FOR I IN REVERSE 1..5 LOOP
          DBMS_OUTPUT.PUT_LINE(I);
      END LOOP;
  END;
  /
  
/*
문제
PL / SQL 반목문을 이용하여 사번을 입력하였을 때
입력한 사번부터 사번이 1씩 증가하여 5명을 출력하여라
ex) 200번 출력했을 때 200 ~ 204번 출력
*/

DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    HIRE EMPLOYEE.HIRE_DATE%TYPE;
    I NUMBER;
    J NUMBER;
BEGIN
    I := '&EMP_ID';
    J := I + 4;
    LOOP
    SELECT EMP_ID, EMP_NAME, HIRE_DATE
    INTO ID, NAME, HIRE
    FROM EMPLOYEE
    WHERE EMP_ID LIKE I;
    DBMS_OUTPUT.PUT_LINE('사번 -> ' || ID);
    DBMS_OUTPUT.PUT_LINE('이름 -> ' || NAME);
    DBMS_OUTPUT.PUT_LINE('고용일-> ' || HIRE);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    I := I + 1;
    IF I > J THEN EXIT;
    END IF;
    END LOOP;
END;
 /
 
/*
문제
1 ~ 10까지 반복하여 TEST 1 테이블에 데이터가 저장되게 하시오

CREATE TABLE TEST1
(
NUM NUMBER(3),
DAY VARCHAR2(10)
);

1 sysdate
2 sysdate
3... 10 개 데이터 삽입
*/

-- 테이블 생성
CREATE TABLE TEST1
(
NUM NUMBER(3),
DAY VARCHAR2(10)
);

-- 반복 데이터 삽입
DECLARE
  I NUMBER;
BEGIN
  I := 1; LOOP
  INSERT INTO TEST1
  VALUES(I, SYSDATE);
  I := I + 1;
  IF I > 10 THEN EXIT;
  END IF; END LOOP; 
  END;
/


/*
TOP N 분석을 위한 PL/SQL을 만들어라
보너스, 급여, 입사일 무조건 1 ~ 5위 까지 출력하는 PL/SQL
*/
DECLARE
  NAME EMPLOYEE.EMP_NAME%TYPE;
  SAL EMPLOYEE.SALARY%TYPE;
  BON EMPLOYEE.BONUS%TYPE;
  HIRE EMPLOYEE.HIRE_DATE%TYPE;
  RAN NUMBER;
  SEARCH VARCHAR(30);
BEGIN
SEARCH := '&검색';
CASE WHEN SEARCH = '급여'
THEN
  RAN := 1;
  LOOP
/* 급여 */
  SELECT EMP_NAME, SALARY
  INTO NAME, SAL
  FROM(SELECT ROW_NUMBER () OVER (ORDER BY SALARY DESC) AS RANK, EMP_NAME, SALARY
  FROM EMPLOYEE)
  WHERE RANK = RAN
  ORDER BY SALARY;
  DBMS_OUTPUT.PUT_LINE('랭킹 : ' || RAN || ' / 이름 : ' || NAME ||' / 급여 : ' || SAL);
  RAN := RAN + 1;
  IF RAN > 5 THEN EXIT;
  END IF;
  END LOOP;
WHEN SEARCH = '보너스'
THEN
  RAN := 1;
  LOOP
/* 보너스 */
  SELECT EMP_NAME, BONUS
  INTO NAME, BON
  FROM(SELECT ROW_NUMBER () OVER (ORDER BY BONUS DESC) AS RANK, EMP_NAME, BONUS
  FROM EMPLOYEE
  WHERE BONUS IS NOT NULL)
  WHERE RANK = RAN
  ORDER BY BONUS;
  DBMS_OUTPUT.PUT_LINE('랭킹 : ' || RAN || ' / 이름 : ' || NAME ||' / 보너스 : ' || BON * 100 || '%');
  RAN := RAN + 1;
  IF RAN > 5 THEN EXIT;
  END IF;
  END LOOP;
WHEN SEARCH = '입사일'
THEN
  RAN := 1;
  LOOP
/* 입사일 */
  SELECT EMP_NAME, HIRE_DATE
  INTO NAME, HIRE
  FROM(SELECT ROW_NUMBER () OVER (ORDER BY HIRE_DATE) AS RANK, EMP_NAME, HIRE_DATE
  FROM EMPLOYEE)
  WHERE RANK = RAN
  ORDER BY HIRE_DATE;
  DBMS_OUTPUT.PUT_LINE('랭킹 : ' || RAN || ' / 이름 : ' || NAME ||' / 입사일 : ' || HIRE);
  RAN := RAN + 1;
  IF RAN > 5 THEN EXIT;
  END IF;
  END LOOP;
END CASE;
END;
/


/*
PROCEDURE 연습용 테이블 생성
*/
CREATE TABLE EMP AS(
SELECT *
FROM EMPLOYEE
);

/* 사원번호 입력해서 삭제하는 PROCEDURE 생성 */
CREATE PROCEDURE EMP_ID_DEL(ID EMP.EMP_ID%TYPE)
IS
BEGIN
  DELETE FROM EMP WHERE EMP_ID = ID;
END;
/

/* 사원 삭제 */
EXEC EMP_ID_DEL('&사원번호');


/*
부서코드, 직급코드를 입력하여 사번, 이름을 검색하는 PROCEDURE
*/

CREATE OR REPLACE PROCEDURE EMP_SEARCH
(ID_CODE EMP.DEPT_CODE%TYPE := 'D9', J_CODE EMP.JOB_CODE%TYPE := 'J2')
IS
    ID EMP.EMP_ID%TYPE;
    NAME EMP.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO ID, NAME
    FROM EMP
    WHERE DEPT_CODE = ID_CODE AND JOB_CODE = J_CODE
    AND ROWNUM = 1;
    DBMS_OUTPUT.PUT_LINE('사번 -> ' || ID);
    DBMS_OUTPUT.PUT_LINE('이름 -> ' || NAME);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN  DBMS_OUTPUT.PUT_LINE('데이터가 없습니다');
END;
/

/* 사원 검색 */
EXEC EMP_SEARCH('&부서코드', '&직급코드');
EXEC EMP_SEARCH('D9'); -- D9와 DEFAULT 값 J2
EXEC EMP_SEARCH(); -- DEFAULT 값 D9 / J2 


/*
아래와 같이 프로시저를 실행 시 해당 ID를 가진 직원의 급여가 3000000원으로 
변경 되도록 만들어라
*/
EXEC EMP_MODIFY_SALARY('201', 3000000);
/*
실행 시 출력 결과 (실제 EMP 테이블의 값도 변경 됨)
송종기 사원의 급여 변경
6000000 -> 3000000
*/
CREATE OR REPLACE PROCEDURE EMP_MODIFY_SALARY
(IDCNG EMP.EMP_ID%TYPE, SALCNG EMP.SALARY%TYPE)
IS 
NAME VARCHAR2(20);
SAL NUMBER;

BEGIN 
SELECT EMP_NAME, SALARY
INTO NAME, SAL 
FROM EMP
WHERE EMP_ID = IDCNG;

UPDATE EMP 
SET SALARY = SALCNG
WHERE EMP_ID = IDCNG;

DBMS_OUTPUT.PUT_LINE(NAME || '사원의 급여 변경');
DBMS_OUTPUT.PUT_LINE(SAL || ' -> ' || SALCNG);
END;
/

/*
사번을 입력받아 해당 직원의 이름을 리턴하는 함수를 제작
*/
CREATE OR REPLACE FUNCTION R_NAME(ID EMP.EMP_ID%TYPE)
RETURN EMP.EMP_NAME%TYPE
IS
  NAME EMP.EMP_NAME%TYPE;
BEGIN
  SELECT EMP_NAME
  INTO NAME
  FROM EMP
  WHERE EMP_ID = ID;
  RETURN NAME;
END;
/

/*
R_NAME에서 사번 220 조회
*/
SELECT R_NAME(220)
FROM DUAL;

/* 익명블록 검색 */
DECLARE
  ID EMP.EMP_ID%TYPE;
BEGIN
  ID := '&사원번호';
  DBMS_OUTPUT.PUT_LINE('이름 -> ' || R_NAME(ID));
END;
/

/* 에러 조회 (= 뒤에 ALL_ERRORS) */
SELECT *
FROM ALL_ERRORS;

/*
실습문제 1
사번을 입력 받아 해당 사원의 연봉을 계산하여 리턴하는 저장함수를 만들어 출력하시오
PL/SQL에서 BONUS_CALC('&사번'); 처리 시 연봉을 리턴하여 출력할 수 있도록
만들어라
*/
CREATE OR REPLACE FUNCTION BONUS_CALC(ID EMPLOYEE.EMP_ID%TYPE)
RETURN EMPLOYEE.SALARY%TYPE
IS
  NAME EMPLOYEE.EMP_NAME%TYPE;
  SALYEAR EMPLOYEE.SALARY%TYPE;
BEGIN
  SELECT EMP_NAME, CASE WHEN BONUS IS NOT NULL THEN SALARY * 12 + SALARY * 12 * BONUS
  ELSE SALARY * 12 END
  INTO NAME, SALYEAR
  FROM EMPLOYEE
  WHERE EMP_ID = ID;
  RETURN SALYEAR;
END;
/
 
DECLARE
  ID EMPLOYEE.EMP_ID%TYPE;
  NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
  ID := '&사번';
  SELECT EMP_NAME
  INTO NAME
  FROM EMPLOYEE
  WHERE EMP_ID = ID;
  DBMS_OUTPUT.PUT_LINE('이름 -> ' || NAME);
  DBMS_OUTPUT.PUT_LINE('연봉 -> ' || BONUS_CALC(ID));
END;
/ 

/*
실습문제 2
사번을 전달받아 사원에게 특별 보너스를 지급하려고 함
SALARY_BONUS('&사번', '&특별보너스율');
보너스율은 % 단위로 입력하여 처리 될 수 있도록 만들어라 (ex. 30% 입력 시 -> 0.3)
PL/SQL에서 SALARY_BONUS 함수를 호출하여 값을 넘기게 되면
지급되는 보너스 값이 얼마인지 출력되도록 하시오 (급여 x 보너스율)
*/

CREATE OR REPLACE FUNCTION SALARY_BONUS
(ID EMPLOYEE.EMP_ID%TYPE, BON EMPOYEE.BONUS%TYPE)
RETURN EMPLOYEE.SALARY%TYPE
IS
  NAME EMPLOYEE.EMP_NAME%TYPE;
  BON EMPLOYEE.BONUS%TYPE;
BEGIN
  UPDATE EMPLOYEE
  SET BONUS = BON / 100
  WHERE EMP_ID = ID;
  RETURN SALARY * BONUS;
END;
/


