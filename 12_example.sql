CREATE TABLE professor(
    professor_no NUMBER,
    professor_name VARCHAR2(15),
    professor_major VARCHAR2(30)
);
ALTER TABLE professor ADD CONSTRAINT professor_pk PRIMARY KEY(professor_no);

CREATE TABLE student(
    student_no NUMBER,
    student_name VARCHAR2(15),
    student_address VARCHAR2(100),
    student_grade NUMBER,
    std_professor NUMBER
);
ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY(student_no);
ALTER TABLE student ADD CONSTRAINT student_professor_fk FOREIGN KEY(std_professor) REFERENCES professor(professor_no);

CREATE TABLE course(
    course_no NUMBER,
    course_name VARCHAR2(50) NOT NULL,
    course_score NUMBER
);
ALTER TABLE course ADD CONSTRAINT course_pk PRIMARY KEY(course_no);
ALTER TABLE course ADD CONSTRAINT course_uq UNIQUE(course_name);


CREATE TABLE enroll(
    enroll_no NUMBER,
    student NUMBER,
    course_no NUMBER,
    enroll_date DATE
);
ALTER TABLE enroll ADD CONSTRAINT enroll_pk PRIMARY KEY(enroll_no);
ALTER TABLE enroll ADD CONSTRAINT enroll_student_fk FOREIGN KEY(student) REFERENCES student(student_no);
ALTER TABLE enroll ADD CONSTRAINT enroll_course_fk FOREIGN KEY(course_no) REFERENCES course(course_no);


CREATE TABLE lecture(
    lecture_no NUMBER,
    professor NUMBER,
    enroll_no NUMBER,
    lecture_name VARCHAR2(50),
    lecture_room VARCHAR2(30)
);
ALTER TABLE lecture ADD CONSTRAINT lecture_pk PRIMARY KEY(lecture_no);
ALTER TABLE lecture ADD CONSTRAINT lecture_professor_fk FOREIGN KEY(professor) REFERENCES professor(professor_no);
ALTER TABLE lecture ADD CONSTRAINT lecture_course_fk FOREIGN KEY(lecture_name) REFERENCES course(course_name);
ALTER TABLE lecture ADD CONSTRAINT lecture_enroll_fk FOREIGN KEY(enroll_no) REFERENCES enroll(enroll_no);

INSERT INTO professor VALUES(1,'권구인','컴퓨터공학');
INSERT INTO professor VALUES(2,'최원석','전기공학');
INSERT INTO professor VALUES(3,'마동석','체육교육과');

INSERT INTO student VALUES(1,'박도성','인천','4',1);
INSERT INTO student VALUES(2,'이해창','부산','4',2);
INSERT INTO student VALUES(3,'장혁','일산','2',3);

INSERT INTO course VALUES(1,'컴퓨터보안',3);
INSERT INTO course VALUES(2,'논리회로',3);
INSERT INTO course VALUES(3,'호신술',3);

INSERT INTO enroll VALUES(1,1,1,SYSDATE);
INSERT INTO enroll VALUES(2,2,1,'21/04/01');
INSERT INTO enroll VALUES(3,1,2,'20/03/27');
INSERT INTO enroll VALUES(4,3,3,'20/03/27');

INSERT INTO lecture VALUES(1,1,1,'컴퓨터보안','하121');
INSERT INTO lecture VALUES(2,1,2,'컴퓨터보안','하121');
INSERT INTO lecture VALUES(3,2,3,'논리회로','하321');
INSERT INTO lecture VALUES(4,3,4,'호신술','5동321');