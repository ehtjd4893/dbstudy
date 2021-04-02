CREATE TABLE 고객 -- 부모테이블
( 
    고객아이디 VARCHAR2(30) PRIMARY KEY,
    고객이름 VARCHAR2(30),
    나이 NUMBER(3),
    등급 CHAR(1),
    직업 VARCHAR2(5),
    적립금 NUMBER(7)
);

CREATE TABLE 주문 -- 자식테이블
(
    주문번호 NUMBER PRIMARY KEY,
    주문고객 VARCHAR2(30) REFERENCES 고객(고객아이디),
    -- 외래키(고객테이블의 고객아이디 칼럼 참조), 외래키는 한 테이블에 여러개 가능
    주문제품 VARCHAR2(20),
    수량 NUMBER,
    단가 NUMBER,
    주문일자 DATE
);

DROP TABLE 고객; -- 부모 먼저 죽일 수 없음.