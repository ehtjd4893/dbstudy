drop table boards;
drop table members;
create table members(
	mno number,
	mid varchar2(30),
	mname varchar2(30),
	mdate date
);

create table sequence members_seq
increment by 1
start with 1
nomaxvalue
nominvalue
nocycle
nocache;