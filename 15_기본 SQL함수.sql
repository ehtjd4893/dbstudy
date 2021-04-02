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

SELECT SUM(kor) FROM score;
SELECT SUM(kor) 합계 FROM score;
SELECT SUM(kor) AS 국어점수합계 FROM score;

SELECT SUM(kor) + SUM(eng) + SUM(mat) AS 총점 FROM score; --칼럼은 한개만 지정 가능

SELECT AVG(kor) AS 국어점수평균 FROM score;

SELECT MAX(eng) AS 영어최고점수 FROM score;

SELECT MIN(mat) AS 수학최저점수 FROM score;

ALTER TABLE score ADD name VARCHAR2(30);
UPDATE score SET name = '박도성' WHERE kor = 10;
UPDATE score SET name = '이해창' WHERE kor = 50;
UPDATE score SET name = '이세은' WHERE kor = 60;

UPDATE score SET kor = NULL where name = '박도성';
UPDATE score SET kor = NULL where name = '이세은';

SELECT COUNT(name) FROM score;
SELECT COUNT(kor) FROM score; -- null값은 무시
SELECT COUNT(*) FROM score;   --
