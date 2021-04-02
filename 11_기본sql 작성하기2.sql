------------------------4월 2일 작업 시작--------------------------------------
CREATE TABLE nation(
    nation_code NUMBER(3),
    nation_name VARCHAR2(30),
    nation_prev_rank NUMBER,
    nation_curr_rank NUMBER,
    nation_parti_person NUMBER,
    nation_parti_event NUMBER
);

ALTER TABLE nation ADD CONSTRAINT nation_pk PRIMARY KEY(nation_code);

CREATE TABLE event(
    event_code NUMBER(5),
    event_name VARCHAR2(30),
    event_info VARCHAR2(1000),
    event_first_year NUMBER(4)
);

ALTER TABLE event ADD CONSTRAINT event_pk PRIMARY KEY(event_code);

CREATE TABLE player(
    player_code NUMBER(5),
    nation_code NUMBER(3),
    event_code NUMBER(5),
    player_name VARCHAR2(30),
    player_age NUMBER(3),
    player_rank NUMBER
);

ALTER TABLE player ADD CONSTRAINT player_pk PRIMARY KEY(player_code);
ALTER TABLE player ADD CONSTRAINT player_nation_fk FOREIGN KEY(nation_code) REFERENCES nation(nation_code);
ALTER TABLE player ADD CONSTRAINT player_event_fk FOREIGN KEY(event_code) REFERENCES event(event_code);


CREATE TABLE schedule(
    nation_code NUMBER(3),
    event_code NUMBER(5),
    schedule_info VARCHAR2(1000),
    schedule_begin DATE,
    schedule_end DATE
);

ALTER TABLE schedule ADD CONSTRAINT schedule_pk PRIMARY KEY(nation_code,event_code);
ALTER TABLE schedule ADD CONSTRAINT schedule_nation_fk FOREIGN KEY(nation_code) REFERENCES nation(nation_code);
ALTER TABLE schedule ADD CONSTRAINT schedule_event_fk FOREIGN KEY(event_code) REFERENCES event(event_code);

--DROP TABLE schedule;
--DROP TABLE player;
--DROP TABLE event;
--DROP TABLE nation;


--제약조건 삭제
--ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건_이름;
ALTER TABLE player DROP CONSTRAINT player_nation_fk;
ALTER TABLE schedule DROP CONSTRAINT schedule_nation_fk;
ALTER TABLE nation DROP CONSTRAINT nation_pk;   -- 외래키 삭제한 후에 실행 가능.

ALTER TABLE player DROP CONSTRAINT player_event_fk;
ALTER TABLE schedule DROP CONSTRAINT schedule_event_fk;
ALTER TABLE event DROP CONSTRAINT event_pk;

ALTER TABLE player DROP CONSTRAINT player_pk;
ALTER TABLE schedule DROP CONSTRAINT schedule_pk;


--제약조건 확인
--제약조건을 저장하고 있는 DD(Data Dictionary) :  USER_CONSTRAINTS 테이블
DESC USER_CONSTRAINTS;

SELECT constraint_name, table_name FROM user_constraints WHERE table_name = 'PLAYER';


--제약조건 비활성화
ALTER TABLE player DISABLE CONSTRAINT player_nation_fk;

--제약조건 활성화
ALTER TABLE player ENABLE CONSTRAINT player_nation_fk;