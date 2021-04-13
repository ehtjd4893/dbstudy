SET SERVEROUTPUT ON;

-- 1. 프로시저
--    1) 한 번에 처리할 수 있는 쿼리문의 집합
--    2) 결과(반환)가 있을 수도, 없을 수도 있다.
--    3) EXECUTE(EXEC)를 통해서 실행한다.

-- 프로시저 정의
CREATE OR REPLACE PROCEDURE proc1
AS c NUMBER(3);
BEGIN 
    dbms_output.put_line('Hello Procedure');
END proc1;


-- 프로시저 실행
EXECUTE proc1();

--프로시저에서 변수 선언하고 사용하기
CREATE OR REPLACE PROCEDURE proc2
AS 
    my_age NUMBER;
BEGIN
    my_age := 20;
    DBMS_OUTPUT.PUT_LINE('I am ' || my_age || 'yeals old');
END proc2;

EXEC proc2();

-- 입력 파라미터
-- 프로시저에 전달하는 값: 인수
-- 문제: employee_id를 입력 파라미터로 전달하면 해당 사원의 last_name 가져오기
CREATE OR REPLACE PROCEDURE proc3(in_employee_id IN NUMBER)
IS 
    v_last_name EMPLOYEES.LAST_NAME%TYPE;
BEGIN
    SELECT last_name INTO v_last_name 
      FROM employees 
     WHERE employee_id = in_employee_id;
    DBMS_OUTPUT.PUT_LINE('결과: '|| v_last_name);
END proc3;

-- 입력 파라미터 100 전달
EXEC proc3(100);

-- 출력 파라미터
-- 프로시저의 실행 결과를 저장하는 파라미터
-- 함수와 비교하면 함수의 반환값
CREATE OR REPLACE PROCEDURE proc4(out_result OUT NUMBER)
IS
BEGIN
    SELECT MAX(salary) INTO out_result 
      FROM employees;
END proc4;

-- 프로시저를 호출할 때
-- 프로시저의 결과를 저장할 변수를 넘겨준다.
DECLARE
    max_salary NUMBER;
BEGIN
    proc4(max_salary);
    DBMS_OUTPUT.PUT_LINE('최고연봉: ' || max_salary);
END;

-- 입출력 파라미터
-- 입력: 사원번호
-- 출력: 연봉
CREATE OR REPLACE PROCEDURE proc5(in_out_param IN OUT NUMBER)
IS 
    v_salary NUMBER;
BEGIN
    SELECT salary INTO v_salary FROM employees WHERE employee_id = in_out_param;
    in_out_param := v_salary;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외코드: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('예외 메시지: ' || SQLERRM);
END proc5;

DECLARE
    in_out NUMBER;
BEGIN
    in_out := 200;
    proc5(in_out);
    DBMS_OUTPUT.PUT_LINE('결과값: '||in_out);
END;

-- 문제 세팅
-- book, customer, orders 테이블 ( DQL_연습문제.sql 참조)
ALTER TABLE customer ADD point NUMBER;
ALTER TABLE book ADD stock NUMBER;
ALTER TABLE orders ADD sales_amount NUMBER;
UPDATE BOOK SET stock = 10;
UPDATE CUSTOMER SET POINT = 1000;
UPDATE ORDERS SET SALES_AMOUNT = 1;
COMMIT;

DESC BOOK;
DESC CUSTOMER;
DESC ORDERS;

--exec proc_order(회원번호, 책번호, 구매수량)
-- 1. ORDERS 테이블에 주문 기록이 삽입된다. (ORDER_NO는 시퀀스 처리, SALES_PRICE는 book table의 price의 90%)
-- 2. CUSTOMER 테이블에 주문 총액( 구매수량 * 판매가격 )의 10%를 POINT에 더해준다.
-- 3. BOOK 테이블 STOCK 감소 
CREATE SEQUENCE proc_order_seq
START WITH 11
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;


CREATE OR REPLACE PROCEDURE proc_order(c_id IN NUMBER, b_id IN NUMBER, how IN NUMBER)
IS 
    s_price NUMBER(6);
    b_stock NUMBER;
BEGIN
    SELECT stock INTO b_stock FROM BOOK WHERE BOOK_ID = B_ID;
    SELECT price INTO s_price FROM BOOK WHERE book_id = b_id;
    
    INSERT INTO ORDERS VALUES(proc_order_seq.nextval, c_id, b_id, s_price, sysdate, how);
    UPDATE customer SET point = point + (s_price * how) * 0.1 WHERE customer_id = c_id;
    UPDATE book SET stock = stock - how WHERE book_id = b_id;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('에러코드: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('에러메세지: ' || SQLERRM);
END proc_order;


DECLARE
    c_id NUMBER;
    b_id NUMBER;
    how NUMBER;
BEGIN
    c_id := 1;
    b_id := 2;
    how := 3;
    proc_order(c_id,b_id,how);
END;
-- 2. 사용자 함수
--  1) 하나의 결과값이 있다. (RETURN값이 있다.)
--  2) 주로 쿼리문에 포함된다.
CREATE OR REPLACE FUNCTION get_total(n NUMBER)
RETURN NUMBER
IS -- 또는 AS, 변수 선언부
    i NUMBER;
    total NUMBER;
BEGIN
    total := 0;
    FOR i IN 1 .. n LOOP
        total := total + i;
    END LOOP;
    RETURN total;
END get_total;

-- 함수의 확인
SELECT get_total(100) FROM DUAL;


CREATE OR REPLACE FUNCTION get_grade(n NUMBER)
RETURN CHAR
IS 
    res CHAR(1);
BEGIN
    IF n >= 90 THEN res := 'A';
    ELSIF n >= 80 THEN res := 'B';
    ELSIF n >= 70 THEN res := 'C';
    ELSIF n >= 60 THEN res := 'D';
    ELSE res := 'F';
    END IF;
    RETURN res;
END get_grade ;

-- 함수 확인
SELECT get_grade(90) FROM DUAL; -- A 출력

-- 3. 트리거
--  1) INSERT, UPDATE, DELETE 작업을 수행하면 자동으로 실행되는 작업이다.
--  2) BEFORE, AFTER 트리거를 많이 사용한다.

CREATE OR REPLACE TRIGGER trig1
    BEFORE -- 수행 이전에 자동으로 실행된다.
    INSERT OR UPDATE OR DELETE -- 트리거가 동작할  작업을 고르면 됨ㅇㅇ.
    ON employees    -- 트리거가 동작할 테이블
    FOR EACH ROW -- 한 행씩 적용된다.
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello Trigger');
END trig1;

UPDATE employees SET salary = 25000 WHERE employee_id = 100;
DELETE employees WHERE employee_id = 206;


CREATE OR REPLACE TRIGGER trig2
    AFTER
    UPDATE OR INSERT OR DELETE
    ON employees
    FOR EACH ROW
BEGIN 
    IF INSERTING THEN -- 삽입이었다면
        DBMS_OUTPUT.PUT_LINE('INSERT 했군요.');
    ELSIF UPDATING THEN -- UPDATE 했다면
        DBMS_OUTPUT.PUT_LINE('UPDATE 했군요.');
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('DELETE 했군요.');
    END IF;
END trig2;

UPDATE employees SET salary = 25000 WHERE employee_id = 100;

-- 트리거 삭제
DROP TRIGGER trig1;
DROP TRIGGER trig2;

-- 문제.
-- employees 테이블에서 삭제된 데이터는 퇴사자(retire) 테이블에 자동으로 저장되는 트리거 작성
--      INSERT    UPDATE      DELETE
-- :OLD NULL      수정전값    삭제전값
-- :NEW 추가된값  수정후값    NULL

CREATE TABLE retire(
    retire_id NUMBER,
    employee_id NUMBER,
    last_name VARCHAR2(25),
    department_id NUMBER,
    hire_date DATE,
    retire_date DATE
);
ALTER TABLE retire ADD CONSTRAINTS retire_pk PRIMARY KEY(retire_id);

CREATE SEQUENCE retire_seq
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

CREATE OR REPLACE TRIGGER trig3
    AFTER
    DELETE
    ON employees
    FOR EACH ROW
BEGIN
    INSERT INTO retire(retire_id, employee_id, last_name, department_id,hire_date,retire_date)
        VALUES(retire_seq.nextval, :OLD.employee_id, :OLD.last_name, :OLD.department_id, :OLD.hire_date, SYSDATE);
    DBMS_OUTPUT.PUT_LINE('DELETE 완료.');
END trig3;

DELETE FROM employees WHERE department_id = 50;
SELECT * FROM retire;