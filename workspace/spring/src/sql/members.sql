drop table members;
drop sequence members_seq;


create table members(
	mno number,
	mid varchar2(30),
	mname varchar2(30),
	memail varchar2(100),
	mdate date
);

ALTER TABLE members ADD CONSTRAINTS members_pk PRIMARY KEY(mno);
ALTER TABLE members ADD CONSTRAINTS members_uq unique(mid);
ALTER TABLE members ADD CONSTRAINTS members_memail unique(memail);

CREATE SEQUENCE members_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

select * FROM members;
