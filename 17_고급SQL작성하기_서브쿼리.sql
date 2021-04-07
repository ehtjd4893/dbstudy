--서브쿼리
--쿼리문 내부에 다른 쿼리문을 포함하는 것

--단일 행 서브쿼리
--1. 서브쿼리의 결과가 1개인 쿼리
--2. 단일 행 서브쿼리 연산자: =, !=, >, >=, <, <=

--문제1. 평균급여보다 더 높은 급여를 받는 사원들의 정보 조회
DESC employee;
DESC department;
SELECT 
    name,
    position,
    salary
  FROM employee
 WHERE salary > (SELECT
                    AVG(salary) 
                   FROM employee);

-- 문제2. 사원번호가 1001인 사원과 같은 직급을 가진 사원들 정보 조회
SELECT
    name,
    depart,
    position,
    gender,
    hire_date,
    salary
  FROM  employee
 WHERE position = (SELECT
                        position
                     FROM employee 
                    WHERE emp_no = 1001);

--문제3. 가장 급여가 높은 사원과 가장 급여가 낮은 사원 조회
SELECT
    name,
    position,
    salary
  FROM employee
 WHERE salary = (SELECT MAX(salary) FROM employee) 
    OR salary = (SELECT MIN(salary) FROM employee);
    
SELECT
    name,
    position,
    salary
  FROM employee
 WHERE salary IN( (SELECT MAX(salary) FROM employee), (SELECT MIN(salary) FROM employee) );
 
 -- 1. 서브쿼리의 결과가 여러개인 쿼리
 -- 2. 다중행 서브쿼리 연산자: IN, ANY, ALL, EXISTS

 --문제1. 부서번호가 1인 부서에 존재하는 직급과 같은 직급을 가진 직원 이름 검색
 
 SELECT
    name
  FROM employee
 WHERE position IN ( SELECT position FROM employee WHERE depart = 1);

 --문제2. 구창민과 같은 부서에서 근무하는 사원 조회
SELECT 
    name,
    depart,
    position
  FROM employee
 WHERE depart IN ( SELECT depart FROM employee WHERE name = '구창민')
   AND name != '구창민';
   
--문제3. 부서번호가 1인 부서에서 근무하는 사원들의 모든 급여보다 큰 급여를 받는 사원 조회
SELECT 
    name,
    depart,
    position
  FROM employee
 WHERE salary > ALL( SELECT salary
                       FROM employee 
                      WHERE depart = 1);

-- 단일행 서브쿼리를 이용한 방법
SELECT
    name,
    depart,
    position
  FROM employee
 WHERE salary > (SELECT MAX(salary) FROM employee WHERE depart = 1);

-- 스칼라 서브쿼리
-- 1. SELECT절에서 사용하는 서브쿼리이다.
-- 2. 단일행 서브쿼리여야 한다.

--문제1. 모든 사원들의 평균연봉과 부서수를 조회하시오.
SELECT
    (SELECT AVG(e.salary) FROM employee e) AS 평균연봉,
    (SELECT COUNT(d.dept_no) FROM department d) AS 부서수
  FROM dual;
  
--인라인 뷰(inline view)
--1. FROM절에서 사용하는 서브쿼리이다.
--2. 일종의 임시테이블이다.(뷰)
--3. 인라인 뷰에서 SELECT한 칼럼만 메인쿼리에서 사용할 수 있다.

--문제. 부서번호가 1인 사원 조회. 이름순 정렬
--1)일반적 풀이
SELECT 
    depart,
    name
  FROM employee
 WHERE depart = 1
 ORDER BY name;
 
--2)인라인 뷰를 이용 (정렬 후 조건 제시)
SELECT
    depart,
    name
  FROM (SELECT depart, name FROM employee ORDER BY name) e
 WHERE e.depart = 1;
 
-- CREATE문과 서브쿼리
-- 1. 서브쿼리의 결과를 이용해서 새로운 테이블을 생성할 수 있다.
-- 2. 데이터를 포함할 수도, 제외할 수도 있다.

DESC employee;
-- 문제1. employee 테이블의 구조와 데이터를 모두 복사해서 새로운 employee2 테이블을 생성하시오.
CREATE TABLE employee2
    AS (SELECT * FROM employee);
    
--문제2. employee테이블의 데이터를 제외하고 구조만 복사해서 employee3 테이블 생성
CREATE TABLE employee3
    AS (SELECT * FROM employee WHERE 1 = 2); 
    -- 1 = 2는 항상 거짓이므로 어떤 데이터도 조회되지 않는다.