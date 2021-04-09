DROP TABLE BUYS;
DROP TABLE USERS;

-- 사용자(USERS) 테이블 생성
CREATE TABLE USERS (
    USER_NO NUMBER,  -- 사용자번호
    USER_ID VARCHAR2(20) NOT NULL UNIQUE,  -- 아이디
    USER_NAME VARCHAR2(20),  -- 이름
    USER_YEAR NUMBER(4),  -- 태어난년도
    USER_ADDR VARCHAR2(100),  -- 주소
    USER_MOBILE1 VARCHAR2(3),  -- 010, 011 등
    USER_MOBILE2 VARCHAR2(8),  -- 12345678, 11111111 등
    USER_REGDATE DATE  -- 가입일
);

-- 구매(BUYS) 테이블 생성
CREATE TABLE BUYS (
    BUY_NO NUMBER,  -- 구매번호
    USER_ID VARCHAR2(20),  -- 구매자아이디
    PROD_NAME VARCHAR2(20),  -- 제품명
    PROD_CATEGORY VARCHAR2(20),  -- 제품카테고리
    PROD_PRICE NUMBER,  -- 제품가격
    BUY_AMOUNT NUMBER  -- 구매수량
);

--1. 적절한 기본키와 외래키를 지정하시오.
ALTER TABLE BUYS ADD CONSTRAINTS buys_pk PRIMARY KEY(BUY_NO);
ALTER TABLE BUYS ADD CONSTRAINTS buys_users_fk FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID);

ALTER TABLE USERS ADD CONSTRAINTS users_pk PRIMARY KEY(USER_NO);

--2. 아래 INSERT문에서 사용되고 있는 사용자번호와 구매번호 대신 사용할 시퀀스를 생성하고 이를 INSERT문에 적용한 뒤 INSERT문을 실행하시오.
CREATE SEQUENCE users_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

-- USERS 테이블에 레코드(행, ROW) 삽입하기
INSERT INTO USERS VALUES (users_seq.nextval, 'YJS', '유재석', 1972, '서울', '010', '11111111', '08/08/08');
INSERT INTO USERS VALUES (users_seq.nextval, 'KHD', '강호동', 1970, '경북', '011', '22222222', '07/07/07');
INSERT INTO USERS VALUES (users_seq.nextval, 'KKJ', '김국진', 1965, '서울', '019', '33333333', '09/09/09');
INSERT INTO USERS VALUES (users_seq.nextval, 'KYM', '김용만', 1967, '서울', '010', '44444444', '15/05/05');
INSERT INTO USERS VALUES (users_seq.nextval, 'KJD', '김제동', 1974, '경남', NULL, NULL, '13/03/03');
INSERT INTO USERS VALUES (users_seq.nextval, 'NHS', '남희석', 1971, '충남', '016', '55555555', '14/04/04');
INSERT INTO USERS VALUES (users_seq.nextval, 'SDY', '신동엽', 1971, '경기', NULL, NULL, '08/10/10');
INSERT INTO USERS VALUES (users_seq.nextval, 'LHJ', '이휘재', 1972, '경기', '011', '66666666', '06/04/04');
INSERT INTO USERS VALUES (users_seq.nextval, 'LKK', '이경규', 1960, '경남', '018', '77777777', '04/12/12');
INSERT INTO USERS VALUES (users_seq.nextval, 'PSH', '박수홍', 1970, '서울', '010', '88888888', '12/05/05');

CREATE SEQUENCE buys_seq
INCREMENT BY 1
START WITH 1001
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;
-- BUYS 테이블에 레코드(행, ROW) 삽입하기
INSERT INTO BUYS VALUES (buys_seq.nextval, 'KHD', '운동화', '신발', 30, 2);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'KHD', '노트북', '전자', 1000, 1);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'KYM', '모니터', '전자', 200, 1);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'PSH', '모니터', '전자', 200, 5);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'KHD', '청바지', '의류', 50, 3);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'PSH', '메모리', '전자', 80, 10);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'KJD', '책', '의류', 15, 5);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'LHJ', '책', '서적', 15, 2);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'LHJ', '청바지', '의류', 50, 1);
INSERT INTO BUYS VALUES (buys_seq.nextval, 'PSH', '운동화', '신발', 30, 2);

-- 3. 제품명이 '책'인데 제품카테고리가 '서적'이 아닌 구매 목록을 찾아서 제품카테고리를 '서적'으로 수정하시오.
UPDATE buys SET prod_category = '서적' WHERE prod_name = '책' AND prod_category != '서적';

-- 4. 연락처1이 '011'인 사용자의 연락처1을 '010'으로 수정하시오.
UPDATE users SET user_mobile1 = '010' WHERE user_mobile1 = '011';

-- 5. 구매 테이블에서 사용자번호가 5인 사용자의 구매 정보를 삭제하시오.
DELETE FROM buys WHERE user_id IN (SELECT user_id 
                                     FROM users 
                                    WHERE user_no = 5);

-- 6. 연락처1이 없는 사용자를 조회하시오.
SELECT * FROM users WHERE user_mobile1 IS NULL;

-- 7. 연락처2가 '5'로 시작하는 사용자를 조회하시오.
SELECT * FROM users WHERE user_mobile2 LIKE '5%';

-- 8. 구매 이력이 있는 사용자들의 이름, 제품명, 제품가격, 구매수량을 조회하시오.
SELECT 
    u.user_name,
    b.prod_name,
    b.prod_price,
    b.buy_amount
  FROM users u INNER JOIN buys b 
    ON u.user_id = b.user_id;
    
-- 9. 제품카테고리별로 그룹화하여 제품카테고리, 구매횟수, 총구매수량을 조회하시오.
SELECT 
    b.prod_category,
    COUNT(*) AS 구매횟수,
    SUM(b.buy_amount) AS 총구매수량
  FROM buys b
 GROUP BY b.prod_category;

-- 10. 구매 이력이 있는 고객을 대상으로 어떤 고객이 어떤 제품을 구매했는지 알 수 있도록 고객명, 구매제품을 조회하시오.
SELECT 
    u.user_name, 
    b.prod_name
  FROM users u INNER JOIN buys b
    ON u.user_id = b.user_id;
    
-- 11. 제품을 구매한 이력이 있는 고객아이디, 고객명, 총구매횟수를 조회하시오.
SELECT
    u.user_id,
    u.user_name,
    COUNT(*) AS 총구매횟수
  FROM users u INNER JOIN buys b
    ON u.user_id = b.user_id
 GROUP BY u.user_id, u.user_name;

-- 12. 구매 이력과 상관 없이 고객별 구매횟수를 조회하시오. 구매 이력이 없으면 구매횟수는 0으로 조회하시오.
SELECT
    u.user_id,
    u.user_name,
    NVL(COUNT(b.user_id),0)
  FROM users u LEFT OUTER JOIN buys b
    ON u.user_id = b.user_id
 GROUP BY u.user_id, u.user_name;
 
 
SELECT
    u.user_id,
    u.user_name,
    NVL(COUNT(b.user_id),0)
  FROM users u, buys b
 WHERE u.user_id(+) = b.user_id
 GROUP BY u.user_id, u.user_name; 
 
-- 13. 구매 이력에 상관 없이 고객별 총 구매액을 조회하시오. 구매 이력이 없으면 총 구매액은 0으로 조회하시오.
SELECT 
    u.user_id,
    u.user_name,
    NVL(SUM(b.buy_amount * prod_price),0)
  FROM users u LEFT OUTER JOIN buys b
    ON u.user_id = b.user_id
 GROUP BY u.user_id, u.user_name;

-- 14. 카테고리가 '전자'인 제품을 구매한 고객명과 총 구매액을 조회하시오.
SELECT
    u.user_name,
    SUM(b.buy_amount * b.prod_price) as 총구매액
  FROM  users u, buys b
 WHERE u.user_id = b.user_id
   AND u.user_id IN (SELECT user_id FROM buys WHERE prod_category = '전자')
 GROUP BY u.user_name;
 
 SELECT
    u.user_name,
    SUM(b.buy_amount * b.prod_price) as 총구매액
  FROM  users u, buys b
 WHERE u.user_id = b.user_id
   AND b.prod_category = '전자'
 GROUP BY u.user_name, u.user_id;

-- 15. 구매횟수가 2회 이상인 고객명과 구매횟수를 조회하시오.
SELECT 
    u.user_id,
    u.user_name,
    t.구매횟수
  FROM users u ,(SELECT 
                    user_id, 
                    COUNT(user_id) as 구매횟수 
                   FROM buys 
                  GROUP BY user_id) t
  WHERE u.user_id = t.user_id
    AND t.구매횟수 >= 2;

SELECT   
    u.user_name,
    COUNT(b.buy_no) as 구매횟수
  FROM users u INNER JOIN buys b
    ON u.user_id = b.user_id
 GROUP BY u.user_name, u.user_id
 HAVING COUNT(b.buy_no) >= 2;
 

-- 16. USERS 테이블과 BUYS 테이블 각각 종속 관계를 확인하고 필요하다면 정규화하시오.
-- buys는 users에 종속되어있다.
-- buys 테이블에서 prod_id를 새로 추가하고, 
--product 테이블을 만들어서 (prod_id,prod_name,prod_category,prod_price)를 저장하게 한다.
desc buys;
desc users;
CREATE TEBLE buys(
    buy_no NUMBER,
    user_id VARCHAR2(20),   -- references users(user_id)
    prod_id VARCHAR2(20),   -- references product(prod_id)
    buy_amount NUMBER
);

1) buys 테이블의 이름 카테고리 가격 칼럼을 이용해 product 테이블 생성
--drop table product;
CREATE TABLE product AS (SELECT DISTINCT prod_name, prod_category, prod_price FROM buys);

ALTER TABLE product ADD prod_no NUMBER;

CREATE SEQUENCE product_seq INCREMENT BY 1 START WITH 1 NOMAXVALUE NOMINVALUE NOCYCLE NOCACHE;
--운동화 모니터 메모리 책 노트북 청바지

UPDATE product SET prod_no = product_seq.nextval WHERE prod_name = '운동화';
UPDATE product SET prod_no = product_seq.nextval WHERE prod_name = '모니터';
UPDATE product SET prod_no = product_seq.nextval WHERE prod_name = '메모리';
UPDATE product SET prod_no = product_seq.nextval WHERE prod_name = '책';
UPDATE product SET prod_no = product_seq.nextval WHERE prod_name = '노트북';
UPDATE product SET prod_no = product_seq.nextval WHERE prod_name = '청바지';

ALTER TABLE product ADD CONSTRAINTS prod_pk PRIMARY KEY(prod_no);

ALTER TABLE buys ADD prod_no NUMBER;
 
UPDATE buys set prod_no = (SELECT p.prod_no FROM product p WHERE prod_name = '운동화') WHERE prod_name = '운동화';
UPDATE buys set prod_no = (SELECT p.prod_no FROM product p WHERE prod_name = '모니터') WHERE prod_name = '모니터';
UPDATE buys set prod_no = (SELECT p.prod_no FROM product p WHERE prod_name = '메모리')  WHERE prod_name = '메모리';
UPDATE buys set prod_no = (SELECT p.prod_no FROM product p WHERE prod_name = '책')  WHERE prod_name = '책';
UPDATE buys set prod_no = (SELECT p.prod_no FROM product p WHERE prod_name = '노트북')  WHERE prod_name = '노트북';
UPDATE buys set prod_no = (SELECT p.prod_no FROM product p WHERE prod_name = '청바지')  WHERE prod_name = '청바지';

ALTER TABLE buys ADD CONSTRAINTS buys_prod_fk FOREIGN KEY(prod_no) REFERENCES product(prod_no);

ALTER TABLE buys DROP COLUMN prod_name;
ALTER TABLE buys DROP COLUMN prod_price;
ALTER TABLE buys DROP COLUMN prod_category;