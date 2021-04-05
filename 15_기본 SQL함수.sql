--ORACLE 내장 함수

--1.집계 함수
--DROP TABLE score;

CREATE TABLE score(
    kor NUMBER(3),
    eng NUMBER(3),
    mat NUMBER(3)
);

INSERT INTO score VALUES(10, 10, 10);
INSERT INTO score VALUES(50, 25, 65);
INSERT INTO score VALUES(60, 38, 52);
INSERT INTO score VALUES(70, 48, 22);
INSERT INTO score VALUES(40, 58, 32);
SELECT SUM(kor) FROM score;
SELECT SUM(kor) 합계 FROM score;
SELECT SUM(kor) AS 국어점수합계 FROM score;

SELECT SUM(kor) + SUM(eng) + SUM(mat) AS 총점 FROM score; --칼럼은 한개만 지정 가능

SELECT AVG(kor) AS 국어점수평균 FROM score;

SELECT MAX(eng) AS 영어최고점수 FROM score;

SELECT MIN(mat) AS 수학최저점수 FROM score;

ALTER TABLE score ADD name VARCHAR2(30);
UPDATE score SET name = 'JADU' WHERE kor = 10;
UPDATE score SET name = '  jjanggu' WHERE kor = 50;
UPDATE score SET name = 'WILK  ' WHERE kor = 60;
UPDATE score SET name = 'CHOCO' WHERE kor = 60;
UPDATE score SET name = 'cHINTAO' WHERE kor = 60;

UPDATE score SET kor = NULL where name = 'JADU';
UPDATE score SET kor = NULL where name = 'jjanggu';

SELECT COUNT(name) FROM score;
SELECT COUNT(kor) FROM score; -- null값은 무시
SELECT COUNT(*) FROM score;   --

SELECT INITCAP(name) FROM score;
SELECT UPPER(name) FROM score;
SELECT LOWER(name) FROM score;
SELECT * FROM score;

-- 문자열 길이 반환
SELECT LENGTH(name) FROM score;

-- 문자열 일부 반환
SELECT SUBSTR(name,2,3) FROM score; -- 첫글자의 index가 1인 것 주의.

--문자열 특정 문자의 위치 반환
SELECT INSTR(name, 'J') FROM score;  
SELECT INSTR(UPPER(name), 'J') FROM score;  

--왼쪽 패딩
SELECT LPAD(name,10,'#') FROM score;
--오른쪽 패딩
SELECT RPAD(name,15,'@') FROM score;

--모든 name을 다음과 같이 출력
-- JADU : JA**
-- jjanggu : jj*****
-- WILK : WI**
SELECT RPAD(SUBSTR(name,1,2), LENGTH(name), '*') FROM score;


--문자열 연결 함수
--ORACLE 에서 연산자 ||는 OR이 아니라 연결 연산자

--JADU 10 10 10
SELECT name || ' ' || kor || ' ' || eng || ' ' || mat FROM score; 
SELECT CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(name, ' '), kor), ' '), eng),' '), mat) FROM score;

--불필요한 문자열 제거 함수
--맨 앞 또는 맨 뒤만 가능, 중간에 포함된 건 불가
SELECT LTRIM(name) FROM score;
SELECT LENGTH(name), LENGTH(LTRIM(name)) FROM score;

SELECT RTRIM(name) FROM score;
SELECT LENGTH(name), LENGTH(RTRIM(name)) FROM score;

SELECT TRIM(name) FROM score;
SELECT LENGTH(name), LENGTH(TRIM(name)) FROM score;

-- 다음 데이터를 삽입
-- 80, 80, 80, james bond
INSERT INTO score(kor,eng,mat,name) VALUES(80, 80, 80, 'james bond');

-- 아래와 같이 출력
-- first_name last_name
-- james       bond
SELECT SUBSTR(name,1,INSTR(name,' ') - 1) AS first_name, SUBSTR(name,INSTR(name,' ') + 1) AS last_name FROM score;


-- 숫자 함수

-- 1) 반올림 함수 
--( 테이블을 사용하지 않는 SELECT문 )에서는  DUAL 테이블을 사용.
-- ROUND(값, 자릿수)
SELECT ROUND(123.4567, 2) FROM DUAL; -- 소수자리 3째자리에서 반올림. 123.46
SELECT ROUND(123.4567, 1) FROM DUAL;    -- 소수점 2째자리에서 반올림, 123.5
SELECT ROUND(123.4567, 0) FROM DUAL;    -- 소수점 첫째자리에서 반올림, 123
SELECT ROUND(123.4567, -1) FROM DUAL;   -- 일의 자리에서 반올림, 120
SELECT ROUND(123.4567, -2) FROM DUAL;   -- 십의 자리에서 반올림, 100

-- 2) 올림 함수
-- CEIL(값) : 정수로 올림
-- 자릿수 조정을 계산을 통해 처리
SELECT CEIL(123.4567) FROM DUAL; -- 124

-- (1) 소수자리수 2자리로 올림
-- 100을 곱한다.(10의 제곱) -> CEIL() 처리한다. -> 100으로 나눈다.
-- 만약, 소수자리수 3자리로 올리려면 1000을 곱하고, 1000으로 나눈다.
SELECT CEIL(123.4567 * 100) / 100 FROM DUAL;
SELECT CEIL(123.4567 * 1000) / 1000 FROM DUAL;
SELECT CEIL(123.4567 / 10) * 10 FROM DUAL;  -- 10의 자릿수에서 올림
SELECT CEIL(123.4567 * 0.1) / 0.1 FROM DUAL;




-- 3) 내림 함수
-- FLOOR(값) : 정수로 내림
SELECT FLOOR(123.4567 * 100) / 100 FROM DUAL;
SELECT FLOOR(123.4567 * 10) / 10 FROM DUAL;
SELECT FLOOR(123.4567 * 0.1) / 0.1 FROM DUAL;


-- 4) 절사 함수
-- TRUNC(값,자릿수)
SELECT TRUNC(567.8989, 2) FROM DUAL;
SELECT TRUNC(567.8989, 1) FROM DUAL;
SELECT TRUNC(567.8989, 0) FROM DUAL;
SELECT TRUNC(567.8989) FROM DUAL;
SELECT TRUNC(567.8989, -1) FROM DUAL;
SELECT TRUNC(567.8989, -2) FROM DUAL;


-- 내림과 절사의 차이는 있다.
-- 음수에서 차이가 발생한다.
SELECT FLOOR(-1.5) FROM DUAL;  -- -1.5보다 작은 정수 : -2
SELECT TRUNC(-1.5) FROM DUAL;  -- -1.5의 소수점 아래부분 절사 : -1

-- 5) 절대값
-- ABS(값)
SELECT ABS(-5) FROM DUAL;

-- 6) 부호 판별
-- SIGN(값) 
-- 값이 양수이면 1, 음수이면 -1, 0일 때는 0
SELECT SIGN(5) FROM DUAL;
SELECT SIGN(0) FROM DUAL;
SELECT SIGN(-5) FROM DUAL;

-- 7) 나머지
-- MOD(A,B)
-- A를 B로 나눈 나머지
SELECT MOD(10,7) FROM DUAL;

-- 8) 제곱
-- POWER(A,B) : A의 B제곱
SELECT POWER(10,2) FROM DUAL;
SELECT POWER(10,1) FROM DUAL;
SELECT POWER(10,0) FROM DUAL;
SELECT POWER(10,-1) FROM DUAL;
SELECT POWER(10,-2) FROM DUAL;

-- 4. 날짜 함수
-- 1) 현재 날짜 (타입이 DATE)
-- SYSDATE
SELECT SYSDATE FROM DUAL;

-- 2) 현재 날짜 (타입이 TIMESTAMP)
-- SYSTIMESTAMP
SELECT SYSTIMESTAMP FROM DUAL;

-- 3) 년/ 월 / 일 / 시 / 분 / 초 추출
-- EXTRACT(단위 FROM 날짜)
SELECT EXTRACT(YEAR FROM SYSDATE) AS 현재년도, 
        EXTRACT(MONTH FROM SYSDATE) AS 현재월,
        EXTRACT(DAY FROM SYSDATE) AS 현재일,
        EXTRACT(HOUR FROM SYSTIMESTAMP) + 9 AS 현재시간,
        EXTRACT(MINUTE FROM SYSTIMESTAMP) AS 현재분,
        EXTRACT(SECOND FROM SYSTIMESTAMP) AS 현재초
    FROM DUAL;
    
-- 4) 날짜 연산(이전 이후)
-- 1일 : 숫자 1
-- 12시간 : 0.5
SELECT SYSDATE + 1 AS 내일,
    SYSDATE - 1 AS 어제,
    SYSDATE - 0.5 AS 열두시간전,
    SYSDATE + 0.5 AS 열두시간후,
    SYSTIMESTAMP + 0.5 AS 열두시간후
    FROM DUAL;

-- 5) 개월 연산
-- ADD_MONTHS(날짜,N) : N개월 후
SELECT ADD_MONTHS(SYSDATE, 3) AS 삼개월후,
        ADD_MONTHS(SYSDATE,-3) AS 삼개월전
    FROM DUAL;
-- MONTHS_BETWEEN(최근날짜, 이전날짜) : 두 날짜 사이 경과한 개월수 반환

SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2021-01-01')) AS 개월차이 FROM DUAL;

-- 5. 형변환 함수
-- 1) 날짜 변환 함수
-- TO_DATE(문자열, [형식])
SELECT TO_DATE('2021-04-01'), 
        TO_DATE('2021/03/01'),
        TO_DATE('2021/01/01', 'YYYY/DD/MM'),
        TO_DATE('20210402','YYYYMMDD'),
        TO_DATE('0401, 21','MMDD, YY')
    FROM DUAL;
    
-- 2) 숫자 변환 함수
-- TO_NUMBER(문자열)
SELECT TO_NUMBER('100') FROM DUAL;

SELECT name, kor 
    FROM score 
 WHERE kor >= '50'; -- TO_NUMBER('50')으로 처리되어 문제가 없다.
 
-- 3) 문자열 변환 함수
-- TO_CHAR(값, [형식])
-- (1) 숫자형식
SELECT TO_CHAR(123),
        TO_CHAR(123, '999999'), -- 문자열 '   123'
        TO_CHAR(123, '000000'), -- 문자열 '000123'
        TO_CHAR(1234, '9,999'), -- 문자열 '1,234'
        TO_CHAR(12345, '9,999'), -- 문자열 '######' 형식이 숫자보다 작은 경우  
        TO_CHAR(12345, '99,999'), -- 문자열 '12,345'
        TO_CHAR(3.14, '9.999'), -- 3.140
        TO_CHAR(3.14, '9.99'), -- 3.14
        TO_CHAR(3.14, '9.9'), -- 3. 1
        TO_CHAR(3.14, '9'), -- 3
        TO_CHAR(3.5, '9') --4 (반올림 후 반환)
    FROM DUAL;
    
-- (2) 날짜 형식
SELECT TO_CHAR(SYSDATE, 'YYYY. MM. DD.'), 
        TO_CHAR(SYSDATE, 'YEAR MONTH DAY'),
        TO_CHAR(SYSDATE, 'HH:MI:SS')
    FROM DUAL;
    
SELECT * FROM SCORE;
UPDATE score SET kor = NULL WHERE TRIM(name) = 'JADU';
UPDATE score SET eng = NULL WHERE TRIM(name) = 'cHINTAO';

-- 1) NULL 처리 함수
-- NVL(값, 값이 NULL일 때 사용할 값)
SELECT kor, NVL(kor,0) FROM score;

-- 집계함수(SUM, AVG, MAX, MIN, COUNT 등)들은 NULL값을 무시합니다.
SELECT AVG(kor) AS 평균1,     -- NULL값 제외하고 평균 구함 (5개의 평균)
        AVG(NVL(kor,0)) AS 평균2 --NULL값을 0으로 바꿔서 평균 구함 (6개의 평균)
    FROM score;
    

-- 2) NVL2(값, 값이 NULL이 아닐 때 쓸 값, 값이 NULL일 때 쓸 값)
SELECT NVL(kor, 0) + eng + mat AS 총점 FROM score;
SELECT kor,
        NVL2(kor,kor + eng + mat, eng+mat) AS 총점
FROM score;

-- 2) 분기 함수
-- DECODE(표현식, 조건1, 결과1, 조건2, 결과2, ..., 기본값)
SELECT DECODE('겨울', -- 표현식(칼럼을 이용한 식)
            '봄','꽃놀이',
            '여름','물놀이',
            '가을','단풍놀이',
            '겨울','눈싸움') AS 계절별놀이
    FROM DUAL;

-- 분기표현식 
-- CASE 표현식
--     WHEN 비교식 THEN 결과값
--      ...
--     ELSE 나머지경우
--     END;
-- WHEN >= 90 THEN 'A학점'
SELECT name,
        (NVL(kor,0) + eng + mat) / 3 AS 평균,
        (CASE
            WHEN (NVL(kor,0) + eng + mat) / 3 >= 90 THEN 'A학점'
            WHEN (NVL(kor,0) + eng + mat) / 3 >= 80 THEN 'B학점'
            WHEN (NVL(kor,0) + eng + mat) / 3 >= 70 THEN 'C학점'
            WHEN (NVL(kor,0) + eng + mat) / 3 >= 60 THEN 'D학점'
            ELSE 'F학점'
        END) AS 학점
 FROM score;