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
    
    CURRENT_DATE, LOCALTIMESTAMP, CURRENT_TIMESTAMP
    SELECT CURRENT_DATE FROM DUAL;
    
    SELECT LOCALTIMESTAMP FROM DUAL;
    
    SELECT CURRENT_TIMESTAMP FROM DUAL;
        
    SELECT EMP_NAME AS "이름", FLOOR(MONTHS_BETWEEN (SYSDATE, HIRE_DATE)) AS "개월", HIRE_DATE AS "고용일", SYSDATE AS "오늘"
    FROM EMPLOYEE;
    
    SELECT EMP_NAME AS 이름, HIRE_DATE AS 고용일, ADD_MONTHS(HIRE_DATE, 6) AS "고용일 + 6"
    FROM EMPLOYEE;
    
    SELECT SYSDATE AS "재입대일", ADD_MONTHS(SYSDATE, 18) AS "전역일",  ABS(SYSDATE - ADD_MONTHS(SYSDATE, 18)) * 3 || '그릇' AS "그릇수"
    FROM DUAL;
    
    SELECT SYSDATE, NEXT_DAY (SYSDATE, '월요일') AS "NEXT_DAY"
    FROM DUAL;
    
    SELECT SYSDATE, NEXT_DAY (SYSDATE, 1) AS "NEXT_DAY"
    FROM DUAL;
    
    SELECT SYSDATE, NEXT_DAY (SYSDATE, '월') AS "NEXT_DAY"
    FROM DUAL;
    
    SELECT LAST_DAY(SYSDATE) AS "LAST_DAY"
    FROM DUAL;
    
    SELECT EXTRACT(YEAR FROM SYSDATE) AS 년도
    FROM DUAL;
        
    -- @ 실습문제 1
    -- EMPLOYEE 테이블에서 사원의 이름,입사일,년차를 출력하여라. 
    -- 단, 입사일은 YYYY년M월D일로 출력하도록 하여라.
    -- 년차 출력은 소수점 일경우 올림으로 하여 출력하여라. (28.144 -> 29년차)
    -- (출력시 정렬은 입사일 기준으로 오름차순)
    
    SELECT EMP_NAME AS "이름",
    EXTRACT(YEAR FROM HIRE_DATE) || '년' || EXTRACT(MONTH FROM HIRE_DATE) || '월' || EXTRACT(DAY FROM HIRE_DATE) || '일' AS "입사일",
    CEIL((SYSDATE - HIRE_DATE) / 365) AS "년차"
    FROM EMPLOYEE
    ORDER BY 2;

    -- @ 실습문제 2
    -- 특별 보너스를 지급하기 위하여 자료가 필요하다
    -- 입사일을 기점으로 다음달 1일 부터 6개월을 계산하여 
    -- 출력하시오 (이름,입사일,기준일,기준일+6,기준달(월))
    -- ex) 90년2월6일 입사 -> 90년3월1일 부터 계산
    -- ex) 90년2월26일 입사 -> 90년3월1일 부터 계산
    -- ex) 97년12월1일 입사 -> 98년1월1일 부터 계산
    -- 출력시 입사일 기준으로 정렬하시오
    
    SELECT EMP_NAME AS "이름",
    HIRE_DATE AS "입사일",
    LAST_DAY(HIRE_DATE) + 1 AS "기준일",
    ADD_MONTHS((LAST_DAY(HIRE_DATE) + 1), 6) AS "기준일 + 6",
    EXTRACT(MONTH FROM (ADD_MONTHS((LAST_DAY(HIRE_DATE) + 1), 6))) || '월' AS "기준달(월)"
    FROM EMPLOYEE
    ORDER BY 2;
    
    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "TO CHAR" 
    FROM DUAL;
    
    SELECT EMP_NAME AS "이름", TO_CHAR(HIRE_DATE, 'YYYY/MM/DD" ("DY")"') AS "고용일"
    FROM EMPLOYEE;
    
    SELECT TO_CHAR(1000000000, 'L0,000,000,000') AS "FORMAT"
    FROM DUAL;
    
    SELECT TO_DATE(20010101, 'YYYY/MM/DD') AS "TO_DATE"
    FROM DUAL;
    
    SELECT TO_CHAR(TO_DATE(20010101, 'YYYY/MM/DD'), 'YYYY/MM/DD') AS "날짜"
    FROM DUAL;
    
    SELECT '10' - '2' AS "CHAR"
    FROM  DUAL;
    
    SELECT TO_NUMBER('1,000,000', '9,999,999') - TO_NUMBER('10', '99') AS "TO_NUMBER" 
    FROM DUAL;
    
    SELECT TO_CHAR(TO_NUMBER('1,000,000', '9,999,999') - TO_NUMBER('10', '99'), '999,999,999') AS "TO_NUMBER AND TO_CHAR" 
    FROM DUAL;
    
    SELECT TO_NUMBER('a1,000,000', '9,999,999')
    FROM DUAL; -- 에러
    
    SELECT TO_NUMBER('$1,000,000', '9,999,999')
    FROM DUAL; -- 에러
    
    SELECT TO_NUMBER('$1,000,000', '$9,999,999')
    FROM DUAL; -- 정상
    
    
    
    


 