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

DROP TABLE customer;
DROP TABLE bank;

