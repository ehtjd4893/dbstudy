-- 1. 모든 사원의 LAST_NAME, SALARY, 본인이 근무하는 부서의 평균연봉(SALARY)을 조회하시오.
SELECT
    t.last_name,
    t.salary,
    t.department_id,
    (SELECT 
        ROUND(AVG(me.salary)) AS 평균연봉
       FROM employees me
      WHERE me.department_id = t.department_id) AS 부서평균연봉
  FROM employees t;
-- 2. 부서(DEPARTMENT_ID)별로 DEPARTMENT_ID, DEPARTMENT_NAME, 평균연봉을 조회하시오.
-- 스칼라 서브쿼리
SELECT 
    d.department_id,
    d.department_name,
    (SELECT ROUND(AVG(e.salary))
       FROM employees e
      WHERE d.department_id = e.department_id) AS 평균연봉
  FROM departments d;

-- 3. 모든 사원들의 EMPLOYEE_ID, LAST_NAME, DEPARTMENT_NAME 을 조회하시오.
SELECT
    e.employee_id,
    e.last_name,
    (SELECT d.department_name
       FROM departments d 
      WHERE d.department_id = e.department_id) AS department_name
  FROM employees e;

SELECT
    e.employee_id,
    e.last_name,
    d.department_name
  FROM employees e INNER JOIN departments d
    ON d.department_id = e.department_id;

-- 4. 평균연봉 이상의 연봉을 받는 사원들의 정보를 조회하시오.
SELECT 
    e.employee_id,
    e.last_name,
    e.salary
  FROM employees e
 WHERE e.salary > (SELECT AVG(e2.salary) FROM employees e2);
    

-- 5. Patrick Sully 와 같은 부서에 근무하는 모든 사원정보를 조회하시오.
SELECT 
    e.first_name,
    e.last_name,
    e.department_id
  FROM employees e
 WHERE e.department_id IN (SELECT department_id FROM employees WHERE first_name = 'Patrick' AND last_name = 'Sully');


-- 6. 부서번호가 20인 사원들 중에서 평균연봉 이상의 연봉을 받는 사원정보를 조회하시오.
SELECT 
    e.first_name,
    e.last_name,
    e.department_id,
    e.salary
  FROM employees e
 WHERE department_id = 20
   AND e.salary > (SELECT AVG(salary) FROM employees);

-- 7. 'PU_MAN'의 최대연봉보다 더 많은 연봉을 받은 사원들의 정보를 조회하시오.
SELECT
    e.first_name,
    e.last_name,
    e.department_id,
    e.salary
  FROM employees e
  WHERE e.salary > (SELECT MAX(salary) FROM employees WHERE job_id = 'PU_MAN');
  
SELECT
    e.first_name,
    e.last_name,
    e.department_id,
    e.salary
  FROM employees e
  WHERE e.salary > ALL(SELECT salary FROM employees WHERE job_id = 'PU_MAN');


-- 8. 사원번호가 131인 사원의 JOB_ID와 SALARY가 모두 일치하는 사원들의 정보를 조회하시오.
SELECT
    e.last_name,
    e.department_id,
    e.salary
  FROM employees e
 WHERE e.job_id IN (SELECT job_id FROM employees WHERE employee_id = 131 ) 
   AND e.salary IN (SELECT salary FROM employees WHERE employee_id = 131);

SELECT
    e.last_name,
    e.department_id,
    e.salary
  FROM employees e
 WHERE (e.job_id,e.salary) IN (SELECT job_id,salary FROM employees WHERE employee_id = 131);

SELECT
    e.last_name,
    e.department_id,
    e.salary
  FROM employees e, (SELECT job_id,salary FROM employees WHERE employee_id = 131) e2
 WHERE e.salary = e2.salary 
   AND e.job_id = e2.job_id;

-- 9. LOCATION_ID가 1000~1900인 국가들의 COUNTRY_ID와 COUNTRY_NAME을 조회하시오.
SELECT 
    DISTINCT c.country_id,
    c.country_name
  FROM countries c INNER JOIN  locations l
    ON l.country_id = c.country_id
 WHERE l.location_id BETWEEN 1000 AND 1900;
 
SELECT 
    country_id,
    country_name
  FROM countries 
 WHERE country_id IN((SELECT
                            DISTINCT country_id
                        FROM locations
                       WHERE location_id BETWEEN 1000 AND 1900));


-- 10. 부서가 'Executive'인 모든 사원들의 정보를 조회하시오.
-- 서브쿼리의 WHERE 절에서 사용한 DEPARTMENT_NAME은 PK, UQ가 아니므로 서브쿼리의 결과는 여러 개이다.
SELECT 
    last_name,
    salary,
    department_id
  FROM employees
 WHERE department_id IN(SELECT department_id
                          FROM departments 
                         WHERE department_name = 'Executive');


-- 11. 부서번호가 30인 사원들 중에서 부서번호가 50인 사원들의 최대연봉보다 더 많은 연봉을 받는 사원들을 조회하시오.
SELECT
    last_name,
    salary
  FROM employees
 WHERE department_id = 30
   AND salary > ALL(SELECT salary FROM employees WHERE department_id = 50);
   
SELECT
    last_name,
    salary
  FROM employees
 WHERE department_id = 30
   AND salary > (SELECT MAX(salary) FROM employees WHERE department_id = 50);
              
-- 12. MANAGER가 아닌 사원들의 정보를 조회하시오.
-- MANAGER는 MANAGER_ID를 가지고 있다.
-- 서브쿼리의 결과는 NULL 값을 가질 수 없다.
SELECT 
    employee_id,
    last_name,
    salary,
    department_id
  FROM employees
 WHERE employee_id NOT IN (SELECT DISTINCT manager_id FROM employees WHERE manager_id IS NOT NULL);


-- 13. 근무지가 'Southlake'인 사원들의 정보를 조회하시오.   LOCATIONS
SELECT employee_id,
    last_name
  FROM employees e
 WHERE (SELECT location_id
          FROM departments d
         WHERE d.department_id = e.department_id) IN (SELECT location_id
                                                        FROM locations
                                                       WHERE city = 'Southlake');

SELECT
    employee_id,
    last_name,
    salary,
    department_id
  FROM employees
 WHERE department_id IN (SELECT
                            department_id
                           FROM locations l, departments d
                          WHERE l.location_id = d.location_id
                            AND l.city = 'Southlake');

-- 14. 부서명의 가나다순으로 모든 사원의 정보를 조회하시오.
SELECT
    d.department_name,
    e.employee_id,
    e.last_name,
    e.salary
  FROM employees e, (SELECT department_id,department_name FROM departments ORDER BY department_name) d
 WHERE d.department_id = e.department_id;

-- 15. 가장 많은 사원들이 근무하고 있는 부서의 번호와 근무하는 인원수를 조회하시오.
SELECT 
    COUNT(*) AS 부서원_수,
    department_id AS 부서번호
  FROM employees
 WHERE department_id IS NOT NULL
 GROUP BY department_id 
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                     FROM employees 
                    GROUP BY department_id);



