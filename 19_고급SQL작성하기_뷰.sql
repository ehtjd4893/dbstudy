-- 뷰
-- 1. 기존 테이블을 이용해서 생성한 가상테이블
-- 2. 디스크 대신 데이터사전에만 등록된다.


-- 뷰 생성 연습
CREATE VIEW test_view 
    AS (SELECT emp_no, name 
          FROM employee);

CREATE VIEW test_view2 
    AS (SELECT * FROM employee 
         WHERE position = '과장');

SELECT /* HINT */
    emp_no,
    name
  FROM test_view;
  
SELECT *
  FROM test_view2;
  
  
CREATE VIEW depart_view
    AS (SELECT e.emp_no, e.name, d.dept_name, e.position 
          FROM department d, employee e
         WHERE d.dept_no(+) = e.depart);
  
SELECT *
  FROM depart_view;

DROP VIEW depart_view;

