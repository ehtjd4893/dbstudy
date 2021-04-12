CREATE TABLESPACE user_exam
DATAFILE 'C:/Exam/user_exam.dbf'
SIZE 10M;


--drop tablespace user_exam
--including contents and datafiles
--cascade CONSTRAINTS;


SELECT * FROM v$logfile;

CREATE USER exam IDENTIFIED BY 1111;

GRANT CONNECT, RESOURCE TO exam;

SELECT tablespace_name, status, contents FROM dba_tablespaces;


CREATE TABLE member_log(
    logno NUMBER,
    memberno NUMBER,
    login DATE,
    logout DATE
);
CREATE TABLE member(
    memberno NUMBER,
    id VARCHAR2(30),
    pw VARCHAR2(30),
    name VARCHAR2(30),
    phone varchar2(15)
);

ALTER TABLE member_log ADD CONSTRAINT member_log_pk PRIMARY KEY(logno);
ALTER TABLE member ADD CONSTRAINT member_pk PRIMARY KEY(memberno);

ALTER TABLE member ADD CONSTRAINT member_id_un UNIQUE(id);
ALTER TABLE member_log ADD CONSTRAINT member_log_member_fk FOREIGN KEY(memberno) REFERENCES member(memberno);


SELECT * FROM user_objects;
