-- 1. 다음 칼럼 정보를 이용하여 MEMBERS 테이블을 생성하시오.
--    1) 회원번호: NO, NUMBER
--    2) 회원아이디: ID, VARCHAR2(30), 필수, 중복 불가
--    3) 회원패스워드: PW, VARCHAR2(30), 필수
--    4) 회원포인트: POINT, NUMBER, 기본값 1000
--    5) 회원등급: GRADE, VARCHAR2(10), 도메인('VIP', 'GOLD', 'SILVER', 'BRONZE')
--    6) 회원이메일: EMAIL, VARCHAR2(100), 중복 불가
CREATE TABLE members(
    no NUMBER,
    id VARCHAR2(30) NOT NULL UNIQUE,
    pw VARCHAR2(30) NOT NULL,
    point NUMBER DEFAULT 1000,
    grade VARCHAR2(10) CHECK  (grade IN ('VIP', 'GOLD', 'SILVER', 'BRONZE')),
    email VARCHAR2(100) UNIQUE
);


-- 2. 새로운 칼럼을 추가하시오.
--    1) 회원주소: ADDRESS VARCHAR2(200)
--    2) 회원가입일: REGDATE DATE
ALTER TABLE members ADD address VARCHAR2(200);
ALTER TABLE members ADD regdate DATE;
--ALTER TABLE members drop COLUMN address;


-- 3. 추가된 회원주소 칼럼을 다시 삭제하시오.
ALTER TABLE members DROP COLUMN address;

-- 4. 회원등급 칼럼의 타입을 VARCHAR2(20)으로 수정하시오.
ALTER TABLE members MODIFY grade VARCHAR2(20);


-- 5. 회원패스워드 칼럼의 이름을 PWD로 수정하시오.
ALTER TABLE members RENAME COLUMN pw to pwd;

-- 6. 회원번호 칼럼에 기본키를 설정하시오.
ALTER TABLE members ADD CONSTRAINTS mem_pk PRIMARY KEY(no);

-- 7. 다음 칼럼 정보를 이용하여 BOARD 테이블을 생성하시오.
--    1) 글번호: BOARD_NO, NUMBER
--    2) 글제목: TITLE, VARCHAR2(1000), 필수
--    3) 글내용: CONTENT, VARCHAR2(4000), 필수
--    4) 조회수: HIT, VARCHAR2(1)
--    5) 작성자: WRITER, VARCHAR2(30)
--    6) 작성일자: POSTDATE, DATE
CREATE TABLE board(
    board_no NUMBER,
    title VARCHAR2(1000) NOT NULL,
    content VARCHAR2(4000) NOT NULL,
    hit VARCHAR2(1),
    writer VARCHAR2(30),
    postdate DATE
);

-- 8. 조회수 칼럼의 타입을 NUMBER로 수정하시오.
ALTER TABLE board MODIFY hit NUMBER;


-- 9. 글내용 칼럼의 필수 제약조건을 제거하시오.
ALTER TABLE board MODIFY content VARCHAR2(4000) NULL;


-- 10. 글번호에 기본키 부여, 작성자 칼럼에 MEMBERS 테이블의 회원아이디를 참조하는 외래키를 설정하시오.
ALTER TABLE BOARD ADD CONSTRAINT board_pk PRIMARY KEY(board_no);
ALTER TABLE board ADD CONSTRAINT writer_fk FOREIGN KEY(writer) REFERENCES members(id);


DESC USER_CONSTRAINTS;
SELECT 
    table_name,
    constraint_name
  FROM user_constraints order by table_name;

-- 제약조건 이름 변경하기
ALTER TABLE BOARD RENAME CONSTRAINT SYS_C007173 TO BOARD_TITLE_NN;