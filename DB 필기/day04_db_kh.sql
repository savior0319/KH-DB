SELECT EMP_NAME AS "이름",
EMAIL AS "이메일",
LENGTH(EMAIL) AS "이메일길이"
FROM EMPLOYEE;

SELECT SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) AS "아이디"
FROM EMPLOYEE;

SELECT EMP_NAME AS "이름", SUBSTR(EMP_NO, 1, 2) AS"년생", NVL(BONUS, 0) AS "보너스"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 1, 2) BETWEEN 60 AND 69;

SELECT  EMP_NAME AS "이름" , TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월"') AS "입사년월"
FROM EMPLOYEE;

SELECT COUNT(*) AS "NOT LIKE 010"
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

SELECT EMP_NAME AS "직원명", RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') AS "주민번호"
FROM EMPLOYEE;

SELECT EMP_NAME AS "직원명", DEPT_CODE AS "직급코드",
TO_CHAR(SALARY * 12 + NVL(SALARY * BONUS * 12, 0), 'L999,999,999') AS "연봉(원)"
FROM EMPLOYEE;

DESCRIBE EMPLOYEE;

SELECT EMP_ID AS "사번", EMP_NAME AS "이름", DEPT_CODE AS "부서코드", HIRE_DATE AS "입사일"
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D9') AND EXTRACT(YEAR FROM HIRE_DATE) = '2004';

SELECT EMP_NAME AS "직원명", HIRE_DATE AS "입사일", FLOOR(SYSDATE - HIRE_DATE) AS "근무일수"
FROM EMPLOYEE;

SELECT MAX(LTRIM(EXTRACT(YEAR FROM SYSDATE) - SUBSTR(EMP_NO, 1, 2), '19') + 1) AS "나이MAX",
MIN(LTRIM(EXTRACT(YEAR FROM SYSDATE) - SUBSTR(EMP_NO, 1, 2), '19') + 1) AS "나이MIN"
FROM EMPLOYEE;

SELECT EMP_NAME AS "이름", DEPT_CODE AS "부서코드", 
NVL(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(DEPT_CODE, 'D5', '야근'), 'D6', '야근'), 'D9', '야근'),
'D1', '야근없음'), 'D2', '야근없음'), 'D8', '야근없음'), '야근없음')
AS "야근여부"
FROM EMPLOYEE
ORDER BY 2;


SELECT NVL(DEPT_CODE, '없음')  "부서번호", 
TO_CHAR(SUM(SALARY), 'L999,999,999') "부서별 월급 합계", 
TO_CHAR(AVG(SALARY), 'L999,999,999') AS "부서별 월급 평균"
FROM EMPLOYEE
GROUP BY DEPT_CODE, NVL(DEPT_CODE, '없음')
ORDER BY "부서번호";

/*직급별 연봉 - 급여*/
SELECT JOB_CODE AS "직급", TO_CHAR(SUM(SALARY), 'L999,999,999') AS "총 급여", 
TO_CHAR(SUM(SALARY * 12), 'L999,999,999') AS "연봉"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY "직급";

SELECT NVL(DEPT_CODE, '없음') "부서코드", TO_CHAR(SUM(SALARY), 'L999,999,999') "급여 합계",
TO_CHAR(ROUND(AVG(SALARY), 0), 'L999,999,999') "급여 평균", COUNT(*) AS "인원수"
FROM EMPLOYEE
GROUP BY DEPT_CODE, NVL(DEPT_CODE, '없음');

SELECT NVL(DEPT_CODE, '없음') AS "부서코드", COUNT(*) || '명' AS "보너스 인원"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE, NVL(DEPT_CODE, '없음');

SELECT JOB_CODE AS "직급", COUNT(*) AS "사원 수", 
TO_CHAR(ROUND(AVG(SALARY), 0), 'L999,999,999') AS "평균급여"
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT NVL(DEPT_CODE, '없음') "부서코드", CASE WHEN SUBSTR(EMP_NO, 8, 1)  = 1 
THEN '남' ELSE '여' END "성별",  COUNT (*) ||'명' "명"
FROM EMPLOYEE
GROUP BY DEPT_CODE, SUBSTR(EMP_NO, 8, 1), EMP_NO, 8, 1, 
NVL(DEPT_CODE, '없음'), CASE WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '남' ELSE '여' END
ORDER BY "부서코드";

SELECT DEPT_CODE AS "부서코드", ROUND(AVG(SALARY), 0) AS "평균급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING DEPT_CODE = 'D1'OR DEPT_CODE = 'D6'
ORDER BY 2 DESC;

SELECT DEPT_CODE "부서코드", TO_CHAR(ROUND(AVG(SALARY), 0), 'L999,999,999') "급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

/* 부서별 집계 */
SELECT DEPT_CODE "부서코드", COUNT(*) "ROLLUP"
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE);

SELECT DEPT_CODE "부서코드", COUNT(*) "CUBE"
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE);
/* */

SELECT DEPT_CODE "부서코드", COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;


SELECT DEPT_CODE "부서코드", TO_CHAR(SUM(SALARY), 'L999,999,999') "급여"
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE)
ORDER BY 2;

SELECT JOB_CODE "부서코드", TO_CHAR(SUM(SALARY), 'L999,999,999') "급여"
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE) 
ORDER BY 2;

/*부서 내 직급 별 - ROLLUP */
SELECT DEPT_CODE AS "부서코드", JOB_CODE "직급", COUNT(*) AS "인원"
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

/*직급별 집계*/
SELECT JOB_CODE "직급", DEPT_CODE AS "부서코드", COUNT(*) AS "인원"
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE, DEPT_CODE)
ORDER BY 1;

/*부서별 집계와 직급별 집계 - CUBE*/
SELECT DEPT_CODE AS "부서코드", JOB_CODE "직급", COUNT(*) AS "인원"
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE AS "직급", SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE AS "직급", SUM(SALARY), GROUPING(DEPT_CODE)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;

SELECT DEPT_CODE AS "부서", COUNT(*) AS "인원", DECODE(GROUPING(DEPT_CODE), '1', '총 집계', '부서별') AS "GROUPING"
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE) ;

SELECT NVL(DECODE(GROUPING(DEPT_CODE), 0, DEPT_CODE, 1, '총집계'), '부서없음') AS "부서", COUNT(*) AS "인원"
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE);

SELECT DEPT_CODE AS "부서번호", JOB_CODE AS "직급", 
COUNT(*) AS "인원", 
    CASE WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1 THEN '부서별 집계' 
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0 THEN '직급별 집계' 
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 1 THEN '총 집계' 
    ELSE ' '
    END AS "집계"
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;          

DESCRIBE EMPLOYEE;
DESCRIBE DEPARTMENT;

/* ORACLE */
SELECT E.EMP_NAME, D.DEPT_TITLE
FROM DEPARTMENT D, EMPLOYEE E
WHERE D.DEPT_ID = E.DEPT_CODE;

SELECT E.EMP_NAME, D.DEPT_TITLE
FROM DEPARTMENT D, EMPLOYEE E
WHERE D.DEPT_ID = E.DEPT_CODE;

/* ANSI */
SELECT E.EMP_NAME, D.DEPT_TITLE
FROM DEPARTMENT D
JOIN EMPLOYEE E ON (D.DEPT_ID = E.DEPT_CODE);

/* INNER JOIN */
SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE, DEPT_ID
FROM DEPARTMENT D
INNER JOIN EMPLOYEE E ON (D.DEPT_ID = E.DEPT_CODE);

/* LEFT JOIN */
SELECT E.EMP_NAME, D.DEPT_TITLE
FROM DEPARTMENT D, EMPLOYEE E
WHERE E.DEPT_CODE(+) = D.DEPT_ID;

SELECT E.EMP_NAME, D.DEPT_TITLE
FROM DEPARTMENT D
LEFT JOIN EMPLOYEE E ON (D.DEPT_ID = E.DEPT_CODE);


SELECT NULL + 123123
FROM DUAL;
