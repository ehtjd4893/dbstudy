/*
    보기 좋은 쿼리문
    
    1. SELECT절 바로 직전이나 SELECT절 오른쪽에 테이블 주석을 작성한다.
    2. SELECT절, FROM절, WHERE절, GROUP BY절, ORDER BY절 모두 라인을 맞춘다.
    3. 칼럼은 라인당 한 칼럼이거나(주석을 함께 작성), 한 라인에 모은다.
    4. 칼럼이나 테이블을 대문자로 작성한다. 소문자로 작성한다면 항상 소문자로 작성.
    
*/

--SELECT /* 무슨무슨 테이블 */
--        A
--       ,B
--       ,C
--  FROM table
-- WHERE A = 'xx'
-- GROUP BY A
--HAVING COUNT(*) > 2
-- ORDER BY C;

-- 26. 연봉(salary) 총액과 연봉(salary) 평균을 조회한다.
SELECT
    SUM(salary) AS 연봉총액,
    ROUND(AVG(salary),2) AS 연봉평균
  FROM employees;

-- 27. 최대연봉(salary)과 최소연봉의 차이를 조회한다.
SELECT
    (MAX(salary)-MIN(salary)) AS 연봉차이
  FROM employees;
  
-- 28. 직업(job_id) 이 ST_CLERK 인 사원들의 전체 수를 조회한다.
SELECT 
    COUNT(*) AS 사원수
  FROM employees
 WHERE job_id = 'ST_CLERK';

-- 29. 매니저(manager_id)로 근무하는 사원들의 전체 수를 조회한다.
-- 누군가의 상사인 사원들의 수(중복을 제거한)
-- GROUP BY절
SELECT
    manager_id AS 매니저
  FROM employees
 WHERE manager_id IS NOT NULL
 GROUP BY manager_id;

-- COUNT()
SELECT
    COUNT(DISTINCT manager_id) AS 매니저수
  FROM employees;

-- 30. 회사 내에 총 몇 개의 부서가 있는지 조회한다.
SELECT
    COUNT(DISTINCT department_id) AS 부서개수
  FROM employees;

-- 그룹화 연습

-- << departments 테이블 >>
SELECT department_id
  FROM employees
 WHERE department_id IS NOT NULL
 GROUP BY department_id
 ORDER BY department_id DESC;


-- 31. 같은 지역(location_id) 끼리 모아서 조회한다.
SELECT DISTINCT location_id
  FROM departments;

-- 32. 같은 지역(location_id) 끼리 모아서 각 지역(location_id) 마다 총 몇 개의 부서가 있는지 개수를 함께 조회한다.
SELECT 
    location_id,      -- select절에서 location_id를 사용하려면
    COUNT(department_id)
  FROM departments
 GROUP BY location_id;  -- 반드시 GROUP BY 절에서 location_id를 사용해야 한다.

-- 33. 같은 지역(location_id) 끼리 모아서 해당 지역(location_id) 에 어떤 부서(department_name) 가 있는지 조회한다.
SELECT 
    location_id,
    department_id
  FROM departments
 GROUP BY location_id, department_id; -- 억지로 실행을 만든 쿼리, 사실 문제 자체가 그룹핑이 불가한 상황.
-- << employees 테이블 >>

-- 34. 각 부서(department_id)별로 그룹화하여 department_id 와 부서별 사원의 수를 출력한다.
SELECT 
    department_id,
    COUNT(employee_id) AS 사원수
  FROM employees
 GROUP BY department_id;
 
-- 35. 부서(department_id)별로 집계하여 department_id 와 급여평균을 department_id 순으로 오름차순 정렬해서 출력한다.
SELECT 
    department_id,
    ROUND(AVG(salary),2) AS 급여평균
  FROM employees
 GROUP BY department_id
 ORDER BY department_id;

-- 36. 동일한 직업(job_id)을 가진 사원들의 job_id 와 인원수와 급여평균을 급여평균의 오름차순 정렬하여 출력한다.

-- FROM -> GROUP BY -> SELECT -> ORDER BY 순으로 처리된다.
SELECT
    job_id,
    COUNT(*) AS 인원수,
    AVG(salary) AS 급여평균
  FROM employees
 GROUP BY job_id
 ORDER BY 급여평균; -- 또는 AVG(salary)   ORDER BY 절은 제일 마지막에 실행되기 때문에 가능.

-- 불가능한 쿼리
--SELECT
--    job_id AS 직업,
--    COUNT(*) AS 인원수,
--    AVG(salary) AS 급여평균
--  FROM employees
-- GROUP BY 직업          -- SELECT 절보다 GROUP BY절을 먼저 실행하기 때문에, GROUP BY는 별명으로 입력할 수 없다. 
-- ORDER BY 급여평균; 


-- 37. 직업(job_id)이 SH_CLERK 인 직원들의 인원수와 최대급여 및 최소급여를 출력한다.
SELECT
    COUNT(*) AS 인원수,
    MAX(salary) AS 최대급여,
    MIN(salary) AS 최소급여
  FROM employees
 WHERE job_id IN('SH_CLERK');
-- GROUP BY job_id;

-- 38. 근무 중인 사원수가 5명 이상인 부서의 department_id 와 해당 부서의 사원수를 department_id 의 오름차순으로 정렬하여 출력한다.
-- 근무중인 사원수는 GROUP BY 이후에 알 수 있기 때문에
-- WHERE 절로 처리할 수 없다.
-- HAVING 절로 처리해야 한다.
SELECT
    DISTINCT department_id,
    COUNT(*) AS 사원수
  FROM employees
 GROUP BY department_id 
 HAVING COUNT(*) >= 5
 ORDER BY department_id;

-- 39. 평균급여가 10000 이상인 부서의 department_id 와 급여평균을 출력한다.
SELECT
    department_id,
    ROUND(AVG(salary),2) AS 평균급여
  FROM employees
 GROUP BY department_id
 HAVING AVG(salary) >= 10000;

-- 40. 부서(department_id)마다 같은 직업(job_id)을 가진 사원수를 department_id 순으로 정렬하여 출력한다.
-- 단, department_id 가 없는 사원은 출력하지 않는다.
SELECT
    department_id,
    job_id,
    COUNT(*) AS 같은직업
  FROM employees
 WHERE department_id IS NOT NULL
 GROUP BY department_id, job_id 
 ORDER BY department_id;

