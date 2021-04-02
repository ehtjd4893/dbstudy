-------------------------4월 1일 수업 시작-----------------------------------
CREATE TABLE bank(
    bank_code VARCHAR2(20),-- PRIMARY KEY,
    bank_name VARCHAR2(30)
   -- CONSTRAINT bank_pk PRIMARY KEY(bank_code) -- 테이블명_pk 
);

-- 테이블 변경
-- ALTER TABLE 테이블명 (ADD, REMOVE, MODIFY) 등
ALTER TABLE bank ADD CONSTRAINT bank_pk PRIMARY KEY(bank_code);

CREATE TABLE customer(
    no NUMBER,-- PRIMARY KEY,
    name VARCHAR2(30) NOT NULL,
    phone VARCHAR2(30),
    age NUMBER, --CHECK (age >= 0 AND age <= 100),
    -- age NUMBER CHECK (age BETWEEN 0 AND 100),
    bank_code VARCHAR2(20)-- REFERENCES bank(bank_code),
--    CONSTRAINT customer_pk PRIMARY KEY(no),
--    CONSTRAINT customer_phone_uq UNIQUE(phone),
--    CONSTRAINT customer_age_ck CHECK(age BETWEEN 0 AND 100),
--    CONSTRAINT customer_bank_code_fk FOREIGN KEY(bank_code) REFERENCES bank(bank_code)
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY(no);
ALTER TABLE customer ADD CONSTRAINT customer_phone_uq UNIQUE(phone);
ALTER TABLE customer ADD CONSTRAINT customer_age_ck CHECK(age BETWEEN 0 AND 100);
ALTER TABLE customer ADD CONSTRAINT customer_bank_code_fk FOREIGN KEY (bank_code) REFERENCES bank(bank_code);

--DROP TABLE customer;
--DROP TABLE bank;

--칼럼 추가
--ALTER TABLE 테이블명 ADD 칼럼명 타입;
ALTER TABLE bank ADD bank_phone VARCHAR2(15);

--칼럼 수정
ALTER TABLE bank MODIFY bank_name VARCHAR2(15);
ALTER TABLE bank MODIFY bank_phone VARCHAR2(30) NOT NULL;
ALTER TABLE bank MODIFY bank_phone VARCHAR2(15) NULL;
--칼럼 내용 조회
DESC bank;

ALTER TABLE customer MODIFY age NUMBER(3);

DESC customer;


--칼럼 삭제
--ALTER TABLE 테이블명 DROP COLUMN 칼럼명;
ALTER TABLE bank DROP COLUMN bank_phone;


--칼럼 이름 변경
ALTER TABLE customer RENAME COLUMN phone to contact;