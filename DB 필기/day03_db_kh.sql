    SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
    FROM EMPLOYEE;
    
    -- INSTR --
    SELECT  INSTR('aha aaA HaHa', 'H', 1, 1) AS "INSTR"
    FROM DUAL;
    
    SELECT  INSTR('Hello World HI High', 'H', 1, 2) AS "INSTR"
    FROM DUAL;
    
    -- 문제 1 (@의 위치)
    SELECT INSTR(EMAIL, '@', 1, 1) || '번째' AS "@위치"
    FROM EMPLOYEE;


    -- PAD --
    -- 왼쪽 패딩
    SELECT LPAD('mslove', 20, '@') AS "LPAD"
    FROM DUAL;
    
    SELECT LPAD(EMAIL, 20, ' ') AS "LPAD"
    FROM EMPLOYEE;
    
    
    
    -- TRIM --
    SELECT LTRIM('           KHLOVE', ' ') AS "LTRIM"
    FROM DUAL;
    
    SELECT LTRIM('0000000000HAHA', '0') AS "LTRIM"
    FROM DUAL;
    
    SELECT LENGTH(LTRIM('____MSLOVE', '_')) AS "TRIM and LENGTH"
    FROM DUAL;
    
    SELECT LTRIM('1121321231231', '123') AS "LTRIM"
    FROM DUAL;
    
    SELECT RTRIM('1234', '4') AS "RTRIM"
    FROM DUAL;
    
    SELECT TRIM('  KH  ') AS "TRIM"
    FROM DUAL;
    
    SELECT TRIM('1' FROM '1KH1') AS "TRIM"
    FROM DUAL;
    
    SELECT TRIM(LEADING '1' FROM '1KH1') AS "TRIM"
    FROM DUAL;
    
    SELECT TRIM(TRAILING '1' FROM '1KH1') AS "TRIM"
    FROM DUAL;
    
    SELECT TRIM(BOTH '1' FROM '1KH1') AS "TRIM"
    FROM DUAL;
    
    
    -- 실습문제 1
    SELECT (RTRIM ('Hello KH Java', 'Java')) AS "RTRIM" 
    FROM DUAL;
    
    -- 실습 문제 2
    SELECT (LTRIM('Hello KH Java', 'Hello KH')) AS "LTRIM"
    FROM DUAL;
    
    -- 실습 문제 3
    SELECT TRIM(TRAILING '부' FROM DEPT_TITLE) AS "RTRIM"
    FROM DEPARTMENT;

    -- 실습 문제 4
    SELECT LTRIM(RTRIM('982341678934509hello89798739273402', '1234567890'), '1234567890') AS "REMOVE NUMBER"
    FROM DUAL;
    
    -- SUBSTR --
    SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) AS "SUBSTR"
    FROM DUAL;

    SELECT SUBSTR('SHOWMETHEMONEY', 5) AS "SUBSTR"
    FROM DUAL;

    SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) AS "SUBSTR"
    FROM DUAL;
    
    SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) AS "SUBSTR"
    FROM DUAL;
    
    SELECT EMP_NAME "NAME", SUBSTR(EMP_NO, 1, 6) "BIRTH"
    FROM EMPLOYEE;
    
    -- 실습 문제 1
    SELECT DISTINCT SUBSTR(EMP_NAME, 1, 1) AS "성" 
    FROM EMPLOYEE
    ORDER BY 1;
    
    -- 실습 문제 2
    SELECT EMP_ID AS "사원번호", EMP_NAME AS "사원명", RPAD(LPAD(EMP_NO, 8), 14,'*') AS "주민번호", SALARY AS "연봉"
    FROM EMPLOYEE
    WHERE EMP_NO LIKE '______-1%' OR EMP_NO LIKE'______-3%';
    
    
    SELECT UPPER('koREa') as "UPPER"
    FROM DUAL;
    
    SELECT UPPER('Welcome To My Oracle World') as "UPPER"
    FROM DUAL;
    
    SELECT LOWER('Welcome To My Oracle World') as "LOWER"
    FROM DUAL;
    
    SELECT INITCAP('welcome to my oracle world') as "INITCAP"
    FROM DUAL;
    
    SELECT CONCAT('A', '1') AS "CONCAT"
    FROM DUAL;
    
    SELECT 'A' || '1' || '2' AS "||"
    FROM DUAL;
    
    SELECT REPLACE ('Hello World', 'Hello', 'Hell' ) AS "REPLACE"
    FROM DUAL;
    
    SELECT EMP_NAME AS "이름", EMP_NO AS "주민번호", REPLACE(EMAIL, 'kh', 'iei') AS "이메일"
    FROM EMPLOYEE;
    
    SELECT ABS(-1), ABS(1)
    FROM DUAL;
    
    SELECT MOD(10, 3)  AS "MOD"
    FROM DUAL;
    
    SELECT ROUND(123.456, 2) AS "ROUND" 
    FROM DUAL;
    
    SELECT ROUND(123.456, -1) AS "ROUND" 
    FROM DUAL;
    
    SELECT ROUND(123.456, -2) AS "ROUND" 
    FROM DUAL;
    
    SELECT TRUNC(123.456, 2) AS "TRUNC" 
    FROM DUAL;
    
    SELECT TRUNC(123.456, -1) AS "TRUNC" 
    FROM DUAL;
    
    SELECT TRUNC(123.456, -2) AS "TRUNC" 
    FROM DUAL;
    
    
    
    
    
    