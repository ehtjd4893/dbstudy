create table school(
    school_code NUMBER(3) PRIMARY KEY,
    school_name VARCHAR2(10) 
);

CREATE TABLE student(
    school_code NUMBER(3) REFERENCES school(school_code),
    student_name VARCHAR2(15)
);

DROP TABLE student;
DROP TABLE school;

CREATE TABLE student(
    student_no VARCHAR2(5) PRIMARY KEY,
    student_name VARCHAR2(15),
    student_age NUMBER(3)
);

CREATE TABLE subject(
    subject_code VARCHAR2(1) PRIMARY KEY,
    subject_name VARCHAR2(12),
    professor VARCHAR2(15)
);

CREATE TABLE enroll(
    enroll_no NUMBER(3) PRIMARY KEY,
    student_no VARCHAR2(5) REFERENCES student(student_no),
    subject_code VARCHAR2(1) REFERENCES subject(subject_code)
);

DROP TABLE enroll;
DROP TABLE subject;
DROP TABLE student;


CREATE TABLE member(
    member_no NUMBER, --PRIMARY KEY,
    member_id VARCHAR2(30),
    member_pw VARCHAR2(30),
    member_name VARCHAR2(15),
    member_email VARCHAR2(50),
    member_phone VARCHAR2(15),
    member_date DATE,
    PRIMARY KEY(member_no)
);

CREATE TABLE board(
    board_no NUMBER,-- PRIMARY KEY,
    board_title VARCHAR2(1000),
    board_content VARCHAR2(4000),
    board_hit NUMBER,
    member_no NUMBER, --REFERENCES member(member_no),
    board_date DATE,
    PRIMARY KEY(board_no),
    FOREIGN KEY(member_no) REFERENCES member(member_no)
);


CREATE TABLE delivery_service(
    delivery_service_no VARCHAR2(12) PRIMARY KEY,
    delivery_service_name VARCHAR2(20),
    delivery_service_phone VARCHAR2(15),
    delivery_service_address VARCHAR2(100)
);

CREATE TABLE delivery(
    delivery_no NUMBER,
    delivery_service VARCHAR2(12),
    delivery_price NUMBER,
    delivery_date DATE,
    PRIMARY KEY(delivery_no),
    FOREIGN KEY(delivery_service) REFERENCES delivery_service(delivery_service_no)
);

CREATE TABLE orders(
    orders_no NUMBER PRIMARY KEY,
    member_no NUMBER REFERENCES member(member_no),
    delivery_no NUMBER REFERENCES delivery(delivery_no),
    orders_pay VARCHAR2(10),
    orders_date DATE
);

CREATE TABLE manufacturer(
    manufacturer_no VARCHAR2(12) PRIMARY KEY,
    manufacturer_name VARCHAR2(100),
    manufacturer_phone VARCHAR2(15)
);

CREATE TABLE warehouse(
    warehouse_no NUMBER PRIMARY KEY,
    warehouse_name VARCHAR2(5),
    warehouse_location VARCHAR2(100),
    warehouse_used VARCHAR2(1)
);

CREATE TABLE product(
    product_code VARCHAR2(10) PRIMARY KEY,
    product_name VARCHAR2(50),
    product_price NUMBER,
    product_category VARCHAR2(15),
    orders_no NUMBER REFERENCES orders(orders_no),
    manufacturer_no VARCHAR2(12) REFERENCES manufacturer(manufacturer_no),
    warehouse_no NUMBER REFERENCES warehouse(warehouse_no)
);


DROP TABLE product;
DROP TABLE warehouse;
DROP TABLE manufacturer;
DROP TABLE orders;
DROP TABLE delivery;
DROP TABLE delivery_service;
DROP TABLE board;
DROP TABLE member;


