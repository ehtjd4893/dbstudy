-- 1. 부서의 위치(location_id)가 1700 인 사원들의 employee_id, last_name, department_id, salary 를 조회한다.
-- 사용할 테이블 (departments, employees)
SELECT 
    e.employee_id, 
    e.last_name, 
    e.department_id, 
    e.salary
  FROM departments d INNER JOIN employees e
    ON e.department_id = d.department_id      -- employees 테이블이 driving 테이블, departments 테이블이 driven 테이블
 WHERE location_id = 1700;                    -- 일반적으로 더 작은 테이블이 driving인 것이 좋다.

SELECT 
    e.employee_id, 
    e.last_name, 
    e.department_id, 
    e.salary
 FROM  employees e, departments d             -- employees 테이블이 driving 테이블, departments 테이블이 driven 테이블
 WHERE d.department_id = e.department_id      -- 일반적으로 더 작은 테이블이 driving인 것이 좋다.
       AND d.location_id = 1700;

-- 2. 부서명(department_name)이 'Executive' 인 부서에 근무하는 모든 사원들의 department_id, last_name, job_id 를 조회한다.
-- 사용할 테이블 (departments, employees)
SELECT
    e.department_id,
    e.last_name,
    e.job_id
  FROM employees e INNER JOIN departments d -- 일반적으로 더 작은 테이블이 driving인 것이 좋다.
    ON d.department_id = e.department_id    -- departments 테이블이 driving 테이블, employees 테이블이 driven 테이블
 WHERE d.department_name = 'Executive';     -- 조건절에서는 왼쪽에 pk 또는 index를 가진 항목이 오는 것이 좋다.
 
 
 SELECT
    e.department_id,
    e.last_name,
    e.job_id
  FROM employees e, departments d            -- departments 테이블이 driving 테이블, employees 테이블이 driven 테이블
 WHERE d.department_id = e.department_id     -- 일반적으로 더 작은 테이블이 driving인 것이 좋다.
   AND d.department_name = 'Executive';     
  
-- 3. 기존의 직업(job_id)을 여전히 가지고 있는 사원들의 employee_id, job_id 를 조회한다.
-- 사용할 테이블 (employees, job_history)
SELECT 
    j.employee_id,
    j.job_id
  FROM employees e INNER JOIN job_history j 
    ON e.employee_id = j.employee_id 
 WHERE e.job_id = j.job_id;


SELECT 
    j.employee_id,
    j.job_id
  FROM employees e, job_history j 
 WHERE e.employee_id = j.employee_id 
   AND e.job_id = j.job_id;

-- 4. 각 부서별 사원수와 평균연봉을 department_name, location_id 와 함께 조회한다.
-- 평균연봉은 소수점 2 자리까지 반올림하여 표현하고, 각 부서별 사원수의 오름차순으로 조회한다.
-- 사용할 테이블 (departments, employees)


-- 5. 도시이름(city)이 T 로 시작하는 지역에서 근무하는 사원들의 employee_id, last_name, department_id, city 를 조회한다.
-- 사용할 테이블 (employees, departments, locations)


-- 6. 자신의 상사(manager_id)의 고용일(hire_date)보다 빨리 입사한 사원을 찾아서 last_name, hire_date, manager_id 를 조회한다. 
-- 사용할 테이블 (employees)


-- 7. 같은 소속부서(department_id)에서 나보다 늦게 입사(hire_date)하였으나 나보다 높은 연봉(salary)을 받는 사원이 존재하는 사원들의
-- department_id, full_name(first_name 과 last_name 사이에 공백을 포함하여 연결), salary, hire_date 를 full_name 순으로 정렬하여 조회한다.
-- 사용할 테이블 (employees)


-- 8. 같은 소속부서(department_id)의 다른 사원보다 늦게 입사(hire_date)하였으나 현재 더 높은 연봉(salary)을 받는 사원들의
-- department_id, full_name(first_name 과 last_name 사이에 공백을 포함하여 연결), salary, hire_date 를 full_name 순으로 정렬하여 조회한다.
-- 사용할 테이블 (employees)
