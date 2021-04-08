--인덱스
--1. 빠른 검색을 위하여 특정 칼럼에 설정하는 색인
--2. 검색 속도를 높이지만, 삽입/갱신/삭제 시 인덱스의 갱신 때문에 성능이 떨어진다.
--3. 기본키(pk)와 UNIQUE 칼럼은 자동으로 인덱스가 설정된다.
--4. WHERE절에서 자주 사용되는 칼럼은 인덱스로 설정하는 것이 좋다.


--고유인덱스
--department 테이블의 dept_name 칼럼에 고유인덱스를 idx_name으로 설정한다.
CREATE UNIQUE INDEX idx_dept_name ON department(dept_name);

--비고유인덱스(인덱스 부착 칼럼의 중복 허용)
--employee 테이블의 name 칼럼에 비고유인덱스 idx_name을 설정한다.
CREATE INDEX idx_name ON employee(name);


--인덱스 조회
--사용자가 작성한 인덱스 목록 : user_% ,user_indexes , user_tables, user_constraints
--관리자가 작성한 인덱스 목록 : db_%
DESC user_indexes;

SELECT index_name, uniqueness 
  FROM user_indexes 
 WHERE table_name = 'DEPARTMENT';

SELECT index_name, uniqueness
  FROM user_indexes 
 WHERE table_name = 'EMPLOYEE';
 
 
--인덱스 삭제
DROP INDEX idx_name;
DROP INDEX idx_dept_name;