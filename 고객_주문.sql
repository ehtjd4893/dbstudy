CREATE TABLE �� -- �θ����̺�
( 
    �����̵� VARCHAR2(30) PRIMARY KEY,
    ���̸� VARCHAR2(30),
    ���� NUMBER(3),
    ��� CHAR(1),
    ���� VARCHAR2(5),
    ������ NUMBER(7)
);

CREATE TABLE �ֹ� -- �ڽ����̺�
(
    �ֹ���ȣ NUMBER PRIMARY KEY,
    �ֹ��� VARCHAR2(30) REFERENCES ��(�����̵�),
    -- �ܷ�Ű(�����̺��� �����̵� Į�� ����), �ܷ�Ű�� �� ���̺� ������ ����
    �ֹ���ǰ VARCHAR2(20),
    ���� NUMBER,
    �ܰ� NUMBER,
    �ֹ����� DATE
);

DROP TABLE ��; -- �θ� ���� ���� �� ����.