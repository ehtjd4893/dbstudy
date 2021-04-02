CREATE TABLE department(
    dept_no NUMBER PRIMARY KEY,
    dept_name VARCHAR2(15) NOT NULL,
    location VARCHAR2(15) NOT NULL
);


CREATE TABLE employee(
    emp_no NUMBER PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    depart NUMBER REFERENCES department(dept_no),
    position VARCHAR2(20),
    gender CHAR(2),
    hire_date DATE,
    salary NUMBER
);