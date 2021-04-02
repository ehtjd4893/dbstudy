CREATE TABLE department(
    dept_no NUMBER PRIMARY KEY,
    dept_name VARCHAR2(15) NOT NULL,
    location VARCHAR2(15) NOT NULL
);


CREATE TABLE employee(
    emp_no NUMBER PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    depart NUMBER REFERENCES department(dept_no),
    position VARCHAR2(20),
    gender CHAR(2),
    hire_date DATE,
    salary NUMBER
);

INSERT INTO department (dept_no, dept_name, location) VALUES (1,'영업부','대구');
INSERT INTO department (dept_no, dept_name, location) VALUES (2,'인사부','서울');
INSERT INTO department (dept_no, dept_name, location) VALUES (3,'총무부','대구');
INSERT INTO department (dept_no, dept_name, location) VALUES (4,'기획부','서울');

--날짜 타입 작성법
--1. '2021-04-02'
--2. '21-04-02'
--3. '2021/04/02'
--4. '21/04/02' -- 오라클 기본값
INSERT INTO employee VALUES(1001,'구창민',1,'과장','M','95-05-01',500000);
INSERT INTO employee VALUES(1002,'김민서',1,'사원','M','17-09-01',250000);
INSERT INTO employee VALUES(1003,'이은영',2,'부장','F','90-09-01',550000);
INSERT INTO employee VALUES(1004,'한성실',2,'과장','M','93-04-01',500000);

--행(row) 수정
--1. 영업부의 위치를 인천으로 수정하시오.
--UPDATE department SET location = '인천' WHERE dept_name = '영업부';
UPDATE department SET location = '인천' WHERE dept_no = 1;

--2. 과장과 부장의 월급을 10% 인상하시오.
--UPDATE employee SET salary = salary * 1.1 WHERE position = '과장' OR position = '부장'; -- 비추천
UPDATE employee SET salary = salary * 1.1 WHERE position in('과장','부장'); -- 추천

--3. 부서이름을 총무부 -> 총괄팀으로 바꾸고, 지역을 대구 -> 광주로 수정하시오.
UPDATE department SET location = '광주', dept_name = '총무부' where dept_no = 3;

--행(row) 삭제
--1. 모든 employee를 삭제한다.
DELETE FROM employee; -- ROLLBACK으로 취소할 수 있다. (DML)
--TRUNCATE TABLE employee; -- 빠르게 삭제되지만 취소는 불가능하다. (DDL)

--2. 기획부 삭제
DELETE FROM department WHERE dept_no = 4;