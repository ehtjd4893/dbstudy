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