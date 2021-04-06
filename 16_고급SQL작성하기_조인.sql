CREATE TABLE department(
    dept_no NUMBER,
    dept_name VARCHAR2(30),
    location VARCHAR2(15)
);
ALTER TABLE department ADD CONSTRAINTS dept_pk PRIMARY KEY(dept_no);

CREATE TABLE employee(
    emp_no NUMBER,
    name VARCHAR2(30),
    depart NUMBER,
    position VARCHAR2(15),
    gender CHAR(1),
    hire_date DATE,
    salary NUMBER
);
ALTER TABLE employee ADD CONSTRAINTS emp_pk PRIMARY KEY(emp_no);
ALTER TABLE employee ADD CONSTRAINTS emp_dept_fk FOREIGN KEY(depart) REFERENCES department(dept_no);


INSERT INTO department VALUES(1,'영업부','대구');
INSERT INTO department VALUES(2,'인사부','서울');
INSERT INTO department VALUES(3,'영업부','대구');
INSERT INTO department VALUES(4,'기획부','서울');

INSERT INTO employee VALUES(1001,'구창민',1, '과장','M','95/05/01',5000000);
INSERT INTO employee VALUES(1002,'김민서',1, '사원','M','17/09/01',2500000);
INSERT INTO employee VALUES(1003,'이은영',2, '부장','F','90/09/01',5500000);
INSERT INTO employee VALUES(1004,'한성일',2, '과장','M','93/04/01',5000000);


--카테젼 곱
-- 두 테이블의 조인 조건이 잘못되거나 없을 때 나타난다.
SELECT 
    e.emp_no,
    e.name,
    d.dept_name,
    e.position,
    e.hire_date,
    e.salary
  FROM employee e, department d;
  
SELECT 
    e.emp_no,
    e.name,
    d.dept_name,
    e.position,
    e.hire_date,
    e.salary
  FROM employee e 
  CROSS JOIN department d;  
  
  
SELECT
    e.emp_no,
    e.name,
    d.dept_name,
    e.position,
    e.hire_date,
    e.salary
  FROM employee e INNER JOIN department d
    ON e.depart = d.dept_no;
    
    
SELECT
    e.emp_no,
    e.name,
    d.dept_name,
    e.position,
    e.hire_date,
    e.salary
  FROM employee e, department d
    WHERE e.depart = d.dept_no;

ALTER TABLE employee DISABLE CONSTRAINTS emp_dept_fk;
INSERT INTO employee VALUES(1005,'김미나',5,'사원','F','18/05/01',1800000);

DELETE FROM employee WHERE depart = 5;
ALTER TABLE employee ENABLE CONSTRAINTS emp_dept_fk;

--외부조인
--모든 사원의 emp_no, name, dept_name, position을 출력하시오.
SELECT 
    e.emp_no,
    e.name,
    d.dept_name,
    e.position
  FROM employee e LEFT OUTER JOIN department d
  ON e.depart = d.dept_no;

SELECT 
    e.emp_no,
    e.name,
    d.dept_name,
    e.position
  FROM employee e, department d
  WHERE e.depart = d.dept_no(+);
  
  
SELECT 
    e.emp_no,
    e.name,
    d.dept_name,
    e.position
  FROM department d RIGHT OUTER JOIN employee e
  ON e.depart = d.dept_no;
  
SELECT 
    e.emp_no,
    e.name,
    d.dept_name,
    e.position
  FROM department d , employee e
  WHERE e.depart = d.dept_no(+);
  
-- 문제. 아래와 같이 조회하시오.
/*
    dept_no 사원수
    1       2
    2       2
    3       0
    4       0
*/

SELECT
    d.dept_no,
    COUNT(e.depart) AS 사원수
  FROM employee e RIGHT OUTER JOIN department d
    ON e.depart = d.dept_no
 GROUP BY d.dept_no;


SELECT
    d.dept_no,
    COUNT(e.depart) AS 사원수
  FROM employee e, department d
 WHERE e.depart(+) = d.dept_no
 GROUP BY d.dept_no;