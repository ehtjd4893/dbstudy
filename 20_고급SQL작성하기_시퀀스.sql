--시퀀스
--1. 일련번호 생성 객체
--2. 주로 기본키(인공키)에서 사용한다.
--3. currval : 시퀀스가 생성해서 사용한 현재 번호
--4. nextval : 시퀀스가 생성해야 할 다음 번호

-- 시퀀스 생성

CREATE SEQUENCE employee_seq
INCREMENT BY 1 -- 번호가 1씩 증가한다.
START WITH 1000
NOMAXVALUE --최대값 없음 (MAXVALUE 999999)
NOMINVALUE --최소값 없음
NOCYCLE -- 번호 순환 없다.
NOCACHE;

-- employee3 테이블에 행 삽입
-- emp_no는 시퀀스로 입력

INSERT INTO employee3
    (emp_no, name, depart, position, gender, hire_date, salary)
VALUES
    (employee_seq.nextval, '구창민',1,'과장','M','95-05-01',5000000);
    
INSERT INTO employee3
    (emp_no, name, depart, position, gender, hire_date, salary)
VALUES
    (employee_seq.nextval, '구창민',1,'과장','M','95-05-01',5000000);
    
SELECT employee_seq.currval
  FROM dual;

SELECT *
  FROM user_sequences;

-- ROWNUM : 가상 행 번호
-- ROWID : 데이터가 저장된 물리적 위치 정보
SELECT 
    rownum,
    rowid,
    emp_no,
    name
  FROM employee;
  
SELECT 
    emp_no,
    name
  FROM employee
 WHERE rowid = 'AAAFD7AABAAALDZAAC';

SELECT
    emp_no,
    name
  FROM employee
 WHERE emp_no = 1003;
 
-- ROWNUM WHERE절 사용
-- 주의.
-- 1. 1을 포함하는 검색만 가능
-- 2. 순서대로 몇 건을 추출하기 위한 목적이다.
-- 3.

SELECT 
    emp_no,
    name
  FROM employee
 WHERE ROWNUM BETWEEN 1 AND 3; -- 가능
 
SELECT 
    emp_no,
    name
  FROM employee
 WHERE ROWNUM BETWEEN 3 AND 5; -- 불가능

-- 1 이외의 번호로 시작하는 모든 ROWNUM을 사용하기 위해서는
-- ROWNUM에 별명을 주고 별명을 사용한다.
SELECT 
    e.emp_no,
    e.name
  FROM (SELECT ROWNUM AS rn,
            emp_no,
            name
          FROM employee) e
 WHERE e.rn = 2;     
 
-- 연습문제
-- 1. 다음 테이블 생성
-- 게시판(글번호, 글제목, 글작성자, 글내용, 글작성자, 작성일자)
-- 회원(회원번호, 아이디, 이름, 가입일자)

CREATE TABLE board(
    b_no NUMBER,
    b_title VARCHAR2(50),
    b_content VARCHAR2(1000),
    b_writer NUMBER(6),
    b_date DATE
);

CREATE TABLE b_member(
    m_no NUMBER(6),
    m_id VARCHAR2(30),
    m_name VARCHAR2(30),
    m_sign_date DATE
);

-- 2. 각 테이블에서 사용할 시퀀스를 생성
-- 게시판시퀀스(1~ 무제한)
-- 회원시퀀스(100000 ~ 999999)

CREATE SEQUENCE board_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

CREATE SEQUENCE b_member_seq
INCREMENT BY 1
START WITH 100000
MAXVALUE 999999
MINVALUE 100000
NOCYCLE
NOCACHE;



-- 3. 각 테이블에 적절한 기본키 외래키 데이터(5개) 추가
ALTER TABLE b_member ADD CONSTRAINTS b_member_pk PRIMARY KEY(m_no);
ALTER TABLE b_member ADD CONSTRAINTS b_member_uq UNIQUE(m_id);

ALTER TABLE board ADD CONSTRAINTS board_pk PRIMARY KEY(b_no);
ALTER TABLE board ADD CONSTRAINTS board_writer_fk FOREIGN KEY(b_writer) REFERENCES b_member(m_no);

INSERT INTO b_member VALUES(b_member_seq.nextval, 'nb1000', '구인수', '03/04/05');
INSERT INTO b_member VALUES(b_member_seq.nextval, 'nb1007', '란두인', '04/04/05');
INSERT INTO b_member VALUES(b_member_seq.nextval, 'nsop4893', '세릴다', '05/04/05');
INSERT INTO b_member VALUES(b_member_seq.nextval, 'ehtjd4893', '스테락', '06/04/05');
INSERT INTO b_member VALUES(b_member_seq.nextval, 'gudwns3264', '오른', '07/04/05');


INSERT INTO board VALUES(board_seq.nextval, '이것 좀 보세요', '세상사람들 이것좀 봐요', 100000 ,'03/04/05');
INSERT INTO board VALUES(board_seq.nextval, '오오니~?', '내 이름은 탐정', 100001 ,'04/04/05');
INSERT INTO board VALUES(board_seq.nextval, '명탐정 도난', '꼬마죠', 100002 ,'07/04/05');
INSERT INTO board VALUES(board_seq.nextval, '방어막', '생성해준다', 100003 ,'06/04/05');
INSERT INTO board VALUES(board_seq.nextval, '아이템 사세요', '레벨 14부터 가능~', 100004 ,'05/04/05');

-- 4. 게시판을 글제목 가나다순으로 정렬, 첫 번째 글 조회.
SELECT
    b_no,
    b_title,
    b_content,
    b_writer,
    b_date    
  FROM (SELECT b_no,b_title,b_content,b_writer,b_date 
          FROM board ORDER BY b_title ASC) 
 WHERE ROWNUM = 1;

-- 5. 게시판을 글번호의 가나다순으로 정렬하고 1~3번째 글 조회.
SELECT
    b_no,
    b_title,
    b_content,
    b_writer,
    b_date    
  FROM (SELECT b_no,b_title,b_content,b_writer,b_date 
          FROM board ORDER BY b_no ASC)
 WHERE ROWNUM <= 3;

-- 6. 게시판을 최근 작성일자순으로 정렬하고 3~5번째 글을 조회

SELECT
    b_no,
    b_title,
    b_content,
    b_writer,
    b_date    
  FROM (SELECT b_no, b_title, b_content, b_writer, b_date, ROWNUM AS rn
          FROM (SELECT * FROM board ORDER BY b_date DESC)) t
 WHERE t.rn BETWEEN 3 AND 5;


-- 7. 가장 먼저 가입한 회원 조회
SELECT *
  FROM (SELECT * FROM b_member ORDER BY m_sign_date ASC) m
 WHERE ROWNUM = 1;

-- 8. 3번째로 가입한 회원 조회
SELECT y.m_no, y.m_id, y.m_name, y.m_sign_date
  FROM (SELECT x.m_no, x.m_id, x.m_name, x.m_sign_date, ROWNUM AS rn 
          FROM (SELECT * FROM b_member ORDER BY m_sign_date ASC) x ) y
 WHERE y.rn = 3;


-- 9. 가장 나중에 가입한 회원 조회
SELECT *
  FROM (SELECT * FROM b_member ORDER BY m_sign_date DESC) 
 WHERE ROWNUM = 1;



