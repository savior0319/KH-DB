SELECT T1.TNAME, T2.TABLE_NAME
FROM TAB T1 JOIN TABS T2
ON T1.TNAME = T2.TABLE_NAME;

/* INNER JOIN */
SELECT E.EMP_NAME, D.DEPT_TITLE
FROM EMPLOYEE E INNER JOIN DEPARTMENT D
ON E.DEPT_CODE = D.DEPT_ID;

/* LEFT JOIN */
SELECT E.EMP_NAME, D.DEPT_TITLE
FROM EMPLOYEE E LEFT JOIN DEPARTMENT D
ON E.DEPT_CODE = D.DEPT_ID;

SELECT E.EMP_NAME, D.DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+);

/* RIGHT JOIN */
SELECT E.EMP_NAME, D.DEPT_TITLE
FROM EMPLOYEE E RIGHT JOIN DEPARTMENT D
ON E.DEPT_CODE = D.DEPT_ID;

SELECT E.EMP_NAME, D.DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE(+) = D.DEPT_ID;

/* FULL OUTER JOIN */
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
FULL JOIN DEPARTMENT 
ON DEPT_CODE = DEPT_ID;

/* Cartensian Product */
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT;

/* NON_EQUI JOIN */
SELECT EMP_ID, EMP_NAME, SALARY, E.SAL_LEVEL, S.SAL_LEVEL
FROM EMPLOYEE E JOIN SAL_GRADE S
ON  E.SALARY BETWEEN 3000000 AND 4000000
WHERE E.SAL_LEVEL = S.SAL_LEVEL
ORDER BY 1;

/* SELF JOIN (ORACLE) */
SELECT E2.EMP_ID "직원 ID", E2.EMP_NAME "직원이름", E2.MANAGER_ID"매니저 ID", E1.EMP_ID "매니저 ID", E1.EMP_NAME "매니저이름"
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE E1.EMP_ID = E2.MANAGER_ID
ORDER BY 5;

/* SELF JOIN (ANSI) */
SELECT E.EMP_ID "직원 ID", E.EMP_NAME "직원이름", E.MANAGER_ID"매니저 ID", E1.EMP_ID "매니저 ID", E1.EMP_NAME "매니저이름"
FROM EMPLOYEE E JOIN EMPLOYEE E1
ON E.MANAGER_ID = E1.EMP_ID
ORDER BY 5;

/* SELF JOIN 문제 */
SELECT  E1.EMP_NAME "매니저", 
E2.EMP_NAME "직원" , 
TO_CHAR(E2.SALARY, 'L999,999,999') "급여", 
E2.JOB_CODE "직급"
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE E1.EMP_ID = E2.MANAGER_ID
ORDER BY 1;

/* 다중 조인 */
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT 
ON DEPT_CODE = DEPT_ID;

/* 다중 조인 ORACLE */
SELECT EMP_ID "사번", EMP_NAME "이름", DEPT_CODE "부서번호", DEPT_TITLE "부서", LOCATION_ID "지역 ID", LOCAL_NAME "지역"
FROM LOCATION, DEPARTMENT, EMPLOYEE
WHERE LOCAL_CODE = LOCATION_ID AND DEPT_CODE = DEPT_ID;

/* 다중 조인 ANSI */
SELECT EMP_ID "사번", EMP_NAME "이름", DEPT_CODE "부서번호", DEPT_TITLE "부서", LOCATION_ID "지역 ID", LOCAL_NAME "지역"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON  LOCAL_CODE = LOCATION_ID;



/* ORACLE */
SELECT EMP_NAME "이름", 18 - SUBSTR(EMP_NO, 1, 2) + 101 "나이", NVL(DEPT_TITLE, '부서없음') "부서명", JOB_NAME "직급"
FROM EMPLOYEE E, JOB J, DEPARTMENT
WHERE E.JOB_CODE = J.JOB_CODE AND DEPT_CODE = DEPT_ID(+)
ORDER BY 2 DESC;

/* ANSI */
SELECT EMP_NAME "이름", 18 - SUBSTR(EMP_NO, 1, 2) + 101 "나이", NVL(DEPT_TITLE, '부서없음') "부서명", JOB_NAME "직급"
FROM EMPLOYEE E 
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE  
LEFT JOIN DEPARTMENT ON  DEPT_CODE = DEPT_ID
ORDER BY "나이" DESC;


-- 1번
SELECT TO_CHAR(TO_DATE('2020/12/25'),'DY') "요일"
FROM DUAL;

-- 2번
SELECT EMP_NAME AS "이름", EMP_NO AS "주민번호", DEPT_TITLE AS "부서", JOB_NAME AS "직급"
FROM EMPLOYEE E, JOB J, DEPARTMENT
WHERE J.JOB_CODE = E.JOB_CODE AND DEPT_CODE = DEPT_ID AND EMP_NAME LIKE '전%' 
AND SUBSTR(EMP_NO, 8 ,1) = 2 AND SUBSTR(EMP_NO,1 ,2) BETWEEN 70 AND 79;

-- 3번
SELECT EMP_ID "사번", EMP_NAME "사원명", DEPT_TITLE "부서명"
FROM EMPLOYEE E, DEPARTMENT D
WHERE (D.DEPT_ID = E.DEPT_CODE) AND E.EMP_NAME LIKE '%형%';

-- 4번
SELECT EMP_NAME "사원명", JOB_NAME "직급명", DEPT_CODE "부서코드", DEPT_TITLE "부서명"
FROM EMPLOYEE E , DEPARTMENT, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND DEPT_CODE = DEPT_ID AND DEPT_TITLE LIKE '해외영업_부';

-- 5번
SELECT EMP_NAME "이름", BONUS "보너스포인트", DEPT_TITLE "부서명", LOCAL_NAME "근무지역명"
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_ID = DEPT_CODE AND LOCATION_ID = LOCAL_CODE AND BONUS IS NOT NULL;

-- 6번
SELECT EMP_NAME "이름", JOB_NAME "직급명", DEPT_TITLE "부서명", LOCAL_NAME "근무지역명"
FROM EMPLOYEE E, JOB J, DEPARTMENT, LOCATION
WHERE DEPT_ID = DEPT_CODE AND LOCATION_ID = LOCAL_CODE AND E.JOB_CODE = J.JOB_CODE AND DEPT_CODE LIKE 'D2';

-- 7번
SELECT EMP_NAME "사원명", JOB_NAME "직급명", SALARY "급여", SALARY * 12 "연봉"
FROM EMPLOYEE E, JOB J, SAL_GRADE S
WHERE E.SAL_LEVEL = S.SAL_LEVEL AND E.JOB_CODE = J.JOB_CODE AND S.MAX_SAL- 500000 < E.SALARY;

-- 8번
SELECT EMP_NAME "사원명", DEPT_TITLE "부서명", LOCAL_NAME "지역명", NATIONAL_CODE "국가명"
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_ID = DEPT_CODE AND LOCAL_CODE = LOCATION_ID AND NATIONAL_CODE IN ('KO', 'JP');

-- 9번
SELECT E2.EMP_NAME "사원", DEPT_TITLE "부서명", E1.EMP_NAME "동료"
FROM EMPLOYEE E1, EMPLOYEE E2, DEPARTMENT
WHERE E1.DEPT_CODE = DEPT_ID AND E1.DEPT_CODE = E2.DEPT_CODE AND E1.EMP_NAME <> E2.EMP_NAME
ORDER BY 1, 2, 3;

-- 10번
SELECT EMP_NAME "직원명", JOB_NAME "직급", TO_CHAR(SALARY, 'L999,999,999') "급여"
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND BONUS IS NULL AND JOB_NAME IN ('차장', '사원');

-- 11번
SELECT CASE WHEN ENT_YN LIKE 'Y' THEN '퇴사' 
ELSE '재직' END "재직여부", COUNT(*) || '명' "인원"
FROM EMPLOYEE
GROUP BY ENT_YN, CASE WHEN ENT_YN LIKE 'Y' THEN '퇴사' ELSE '재직' END;


/* UNION */
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- 6개
UNION -- 12개
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;  -- 8개


/* UNION ALL*/
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- 6개
UNION ALL -- 14개
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;  -- 8개

/* INTERSECT */
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- 6개
INTERSECT -- 교집합
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;  -- 8개


/* MINUS */
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' -- 6개
MINUS -- 차집합
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;  -- 8개


/* 전지연 관리자 출력 */
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID LIKE 
(SELECT MANAGER_ID 
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전지연');

/* 평균 급여 이상인 월급 도둑놈들 - 단일 행 서브쿼리 */
SELECT EMP_ID "사번", EMP_NAME "이름", JOB_CODE "직급코드", TO_CHAR(SALARY, 'L999,999,999') "급여" 
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

/* 윤은해와 급여가 같은 직원 */
SELECT EMP_ID "사번", EMP_NAME "직원 명", TO_CHAR(SALARY, 'L999,999,999') "급여"
FROM EMPLOYEE
WHERE SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '윤은해')
AND EMP_NAME <> '윤은해'; 

-- 실습 문제 1
-- employee 테이블에서 기본급여가 제일 많은 사람과 제일 적은 사람의 정보를 
-- 사번, 사원명, 기본급여를 나타내세요.
SELECT EMP_ID "사번", EMP_NAME "직원 명", TO_CHAR(SALARY, 'L999,999,999') "급여"
FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE) OR SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE) ;

-- 실습 문제 2
-- D1, D2부서에 근무하는 사원들 중에서
-- 기본급여가 D5 부서 직원들의 '평균월급' 보다 많은 사람들만 
-- 부서번호, 사원번호, 사원명, 월급을 나타내세요.
SELECT DEPT_CODE "부서번호", EMP_ID "사번", EMP_NAME "직원 명", TO_CHAR(SALARY,'L999,999,999') "급여"
FROM EMPLOYEE 
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = 'D5')
AND DEPT_CODE IN ('D1', 'D2');


/* 다중행 서브쿼리 */
SELECT EMP_NAME "직원 명", DEPT_CODE "부서코드"
FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME IN('송종기','박나라'));

/* @ 실습문제
차태연, 전지연 사원의 급여등급(EMPLOYEE테이블의 SAL_LEVEL컬럼)과
같은 사원의 직급명, 사원명을 출력*/
SELECT JOB_NAME "직급명", EMP_NAME "사원명"
FROM EMPLOYEE E, JOB J
WHERE (E.JOB_CODE = J.JOB_CODE) AND SAL_LEVEL IN (SELECT SAL_LEVEL FROM EMPLOYEE WHERE EMP_NAME IN('차태연', '전지연'))
AND EMP_NAME <>  '차태연' AND EMP_NAME <>  '전지연';


/* @ 실습문제
1. 직급 대표, 부사장이 아닌 모든 사원을
이름, 부서명, 직급코드 출력하고 부서별로 출력*/
SELECT EMP_NAME "직원명", DEPT_TITLE "부서명", E.JOB_CODE "직급"
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_ID = DEPT_CODE AND E.JOB_CODE = J.JOB_CODE AND J.JOB_NAME IN (SELECT JOB_NAME FROM JOB WHERE JOB_NAME NOT IN ('대표', '부사장'));