    SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
    FROM EMPLOYEE;
    
    -- INSTR --
    SELECT  INSTR('aha aaA HaHa', 'H', 1, 1) AS "INSTR"
    FROM DUAL;
    
    SELECT  INSTR('Hello World HI High', 'H', 1, 2) AS "INSTR"
    FROM DUAL;
    
    -- ���� 1 (@�� ��ġ)
    SELECT INSTR(EMAIL, '@', 1, 1) || '��°' AS "@��ġ"
    FROM EMPLOYEE;


    -- PAD --
    -- ���� �е�
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
    
    
    -- �ǽ����� 1
    SELECT (RTRIM ('Hello KH Java', 'Java')) AS "RTRIM" 
    FROM DUAL;
    
    -- �ǽ� ���� 2
    SELECT (LTRIM('Hello KH Java', 'Hello KH')) AS "LTRIM"
    FROM DUAL;
    
    -- �ǽ� ���� 3
    SELECT TRIM(TRAILING '��' FROM DEPT_TITLE) AS "RTRIM"
    FROM DEPARTMENT;

    -- �ǽ� ���� 4
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
    
    -- �ǽ� ���� 1
    SELECT DISTINCT SUBSTR(EMP_NAME, 1, 1) AS "��" 
    FROM EMPLOYEE
    ORDER BY 1;
    
    -- �ǽ� ���� 2
    SELECT EMP_ID AS "�����ȣ", EMP_NAME AS "�����", RPAD(LPAD(EMP_NO, 8), 14,'*') AS "�ֹι�ȣ", SALARY AS "����"
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
    
    SELECT EMP_NAME AS "�̸�", EMP_NO AS "�ֹι�ȣ", REPLACE(EMAIL, 'kh', 'iei') AS "�̸���"
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
        
    SELECT EMP_NAME AS "�̸�", FLOOR(MONTHS_BETWEEN (SYSDATE, HIRE_DATE)) AS "����", HIRE_DATE AS "�����", SYSDATE AS "����"
    FROM EMPLOYEE;
    
    SELECT EMP_NAME AS �̸�, HIRE_DATE AS �����, ADD_MONTHS(HIRE_DATE, 6) AS "����� + 6"
    FROM EMPLOYEE;
    
    SELECT SYSDATE AS "���Դ���", ADD_MONTHS(SYSDATE, 18) AS "������",  ABS(SYSDATE - ADD_MONTHS(SYSDATE, 18)) * 3 || '�׸�' AS "�׸���"
    FROM DUAL;
    
    SELECT SYSDATE, NEXT_DAY (SYSDATE, '������') AS "NEXT_DAY"
    FROM DUAL;
    
    SELECT SYSDATE, NEXT_DAY (SYSDATE, 1) AS "NEXT_DAY"
    FROM DUAL;
    
    SELECT SYSDATE, NEXT_DAY (SYSDATE, '��') AS "NEXT_DAY"
    FROM DUAL;
    
    SELECT LAST_DAY(SYSDATE) AS "LAST_DAY"
    FROM DUAL;
    
    SELECT EXTRACT(YEAR FROM SYSDATE) AS �⵵
    FROM DUAL;
        
    -- @ �ǽ����� 1
    -- EMPLOYEE ���̺��� ����� �̸�,�Ի���,������ ����Ͽ���. 
    -- ��, �Ի����� YYYY��M��D�Ϸ� ����ϵ��� �Ͽ���.
    -- ���� ����� �Ҽ��� �ϰ�� �ø����� �Ͽ� ����Ͽ���. (28.144 -> 29����)
    -- (��½� ������ �Ի��� �������� ��������)
    
    SELECT EMP_NAME AS "�̸�",
    EXTRACT(YEAR FROM HIRE_DATE) || '��' || EXTRACT(MONTH FROM HIRE_DATE) || '��' || EXTRACT(DAY FROM HIRE_DATE) || '��' AS "�Ի���",
    CEIL((SYSDATE - HIRE_DATE) / 365) AS "����"
    FROM EMPLOYEE
    ORDER BY 2;

    -- @ �ǽ����� 2
    -- Ư�� ���ʽ��� �����ϱ� ���Ͽ� �ڷᰡ �ʿ��ϴ�
    -- �Ի����� �������� ������ 1�� ���� 6������ ����Ͽ� 
    -- ����Ͻÿ� (�̸�,�Ի���,������,������+6,���ش�(��))
    -- ex) 90��2��6�� �Ի� -> 90��3��1�� ���� ���
    -- ex) 90��2��26�� �Ի� -> 90��3��1�� ���� ���
    -- ex) 97��12��1�� �Ի� -> 98��1��1�� ���� ���
    -- ��½� �Ի��� �������� �����Ͻÿ�
    
    SELECT EMP_NAME AS "�̸�",
    HIRE_DATE AS "�Ի���",
    LAST_DAY(HIRE_DATE) + 1 AS "������",
    ADD_MONTHS((LAST_DAY(HIRE_DATE) + 1), 6) AS "������ + 6",
    EXTRACT(MONTH FROM (ADD_MONTHS((LAST_DAY(HIRE_DATE) + 1), 6))) || '��' AS "���ش�(��)"
    FROM EMPLOYEE
    ORDER BY 2;
    
    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "TO CHAR" 
    FROM DUAL;
    
    SELECT EMP_NAME AS "�̸�", TO_CHAR(HIRE_DATE, 'YYYY/MM/DD" ("DY")"') AS "�����"
    FROM EMPLOYEE;
    
    SELECT TO_CHAR(1000000000, 'L0,000,000,000') AS "FORMAT"
    FROM DUAL;
    
    SELECT TO_DATE(20010101, 'YYYY/MM/DD') AS "TO_DATE"
    FROM DUAL;
    
    SELECT TO_CHAR(TO_DATE(20010101, 'YYYY/MM/DD'), 'YYYY/MM/DD') AS "��¥"
    FROM DUAL;
    
    SELECT '10' - '2' AS "CHAR"
    FROM  DUAL;
    
    SELECT TO_NUMBER('1,000,000', '9,999,999') - TO_NUMBER('10', '99') AS "TO_NUMBER" 
    FROM DUAL;
    
    SELECT TO_CHAR(TO_NUMBER('1,000,000', '9,999,999') - TO_NUMBER('10', '99'), '999,999,999') AS "TO_NUMBER AND TO_CHAR" 
    FROM DUAL;
    
    SELECT TO_NUMBER('a1,000,000', '9,999,999')
    FROM DUAL; -- ����
    
    SELECT TO_NUMBER('$1,000,000', '9,999,999')
    FROM DUAL; -- ����
    
    SELECT TO_NUMBER('$1,000,000', '$9,999,999')
    FROM DUAL; -- ����
    
    
    
    


 