DELETE FROM custo_qus;

DELETE FROM ctsanswer;

--PK ���̺� ������ �߰�

INSERT INTO custo_qus(custoqusno, 
                                diecateno, title, askcont, 
                                thumbs, files, sizes, rdate, answerno, memno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, '���ǻ���', '������� �ٲ��ּ���', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                diecateno, title, askcont, 
                                thumbs, files, sizes, rdate, answerno, memno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            2, '��ǰ����', '�Ͱ���3 ���԰� �����ΰ���', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1, 2);
            
INSERT INTO custo_qus(custoqusno, 
                                diecateno, title, askcont, 
                                thumbs, files, sizes, rdate, answerno, memno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            3, '��ǰ����', '����̸� ��ǰ�ϰ� �;��', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1, 3);
            
SELECT * FROM custo_qus ORDER BY custoqusno ASC;

 CUSTOQUSNO DIECATENO TITLE     ASKCONT         THUMBS     FILES    SIZES RDATE                 ANSWERNO MEMNO
 ---------- --------- --------- --------------- ---------- -------- ----- --------------------- -------- -----
          3         3 ��ǰ����      ����̸� ��ǰ�ϰ� �;��   file_t.jpg file.jpg 0     2019-06-25 16:23:16.0        1     3
          4         0 ���� ����     �ּҸ� �ٲ��ּ���.      NULL       NULL     NULL  2019-06-25 18:24:48.0        0     1
          5         0 ���� ����2323 �ּҸ� �ٲ��ּ���.      NULL       NULL     NULL  2019-06-25 18:24:54.0        0     1
          6         1 ���ǻ���      ������� �ٲ��ּ���      file_t.jpg file.jpg 0     2019-06-25 18:38:11.0        1     1
          7         2 ��ǰ����      �Ͱ���3 ���԰� �����ΰ��� file_t.jpg file.jpg 0     2019-06-25 18:38:12.0        1     2
          8         3 ��ǰ����      ����̸� ��ǰ�ϰ� �;��   file_t.jpg file.jpg 0     2019-06-25 18:38:13.0        1     3


CREATE TABLE ctsanswer(
    answerno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    custoqusno                        NUMBER(10)     NOT NULL,
    answer                            VARCHAR2(50)     NOT NULL,
  FOREIGN KEY (custoqusno) REFERENCES custo_qus (custoqusno)
);

COMMENT ON TABLE ctsanswer is '������ �亯';
COMMENT ON COLUMN ctsanswer.answerno is '�亯��ȣ';
COMMENT ON COLUMN ctsanswer.custoqusno is '�����ǹ�ȣ';
COMMENT ON COLUMN ctsanswer.answer is '�亯';

-- ���
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer, rdate)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            1, '����� �����ص�Ƚ��ϴ�.', sysdate);
         
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer, rdate)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            2, '������ �� ���԰� �����Դϴ�.', sysdate);
 
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer, rdate)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            3, '�� �ּҸ� ���� �ֽñ� �ٶ��ϴ�.', sysdate);
            
            
-- ���
SELECT answerno, custoqusno, answer, rdate
FROM ctsanswer
ORDER BY answerno ASC  

 ANSWERNO CUSTOQUSNO ANSWER             RDATE
 -------- ---------- ------------------ ---------------------
        1          1 ����� �����ص�Ƚ��ϴ�.      2019-07-03 13:00:46.0
        2          2 ������ �� ���԰� �����Դϴ�.   2019-07-03 13:01:26.0
        3          3 �� �ּҸ� ���� �ֽñ� �ٶ��ϴ�. 2019-07-03 13:01:27.0
       
-- ��ȸ
SELECT answerno, custoqusno, answer, rdate
FROM ctsanswer
WHERE answerno=1; 

 ANSWERNO CUSTOQUSNO ANSWER        RDATE
 -------- ---------- ------------- ---------------------
        1          1 ����� �����ص�Ƚ��ϴ�. 2019-07-03 13:00:46.0
    
-- ����
UPDATE ctsanswer
SET answer='������� �����߽��ϴ�.'
WHERE answerno=1;

-- ���� Ȯ��
SELECT answerno, custoqusno, answer, rdate
FROM ctsanswer
WHERE answerno=1; 

 ANSWERNO CUSTOQUSNO ANSWER       RDATE
 -------- ---------- ------------ ---------------------
        1          1 ������� �����߽��ϴ�. 2019-07-03 13:00:46.0

-- ����
DELETE FROM ctsanswer
WHERE answerno=1;



 CUSTOQUSNO GOODSNO MEMNO NAME TITLE ASKCONT         THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ------- ----- ---- ----- --------------- ---------- -------- ----- --------------------- --------
          1       1     1 ȸ��11 ���ǻ���  ������� �ٲ��ּ���      file_t.jpg file.jpg 0     2019-06-04 17:35:46.0        1
          2       1     1 ȸ��2  ��ǰ����  �Ͱ���3 ���԰� �����ΰ��� file_t.jpg file.jpg 0     2019-06-04 17:35:47.0        1
          3       1     1 ȸ��3  ��ǰ����  ����̸� ��ǰ�ϰ� �;��   file_t.jpg file.jpg 0     2019-06-04 17:35:48.0        1
          4       1     1 ȸ��1  ���ǻ���  ������� �ٲ��ּ���      file_t.jpg file.jpg 0     2019-06-12 17:43:22.0        1
          5       1     1 ȸ��2  ��ǰ����  �Ͱ���3 ���԰� �����ΰ��� file_t.jpg file.jpg 0     2019-06-12 17:43:23.0        1
          6       1     1 ȸ��3  ��ǰ����  ����̸� ��ǰ�ϰ� �;��   file_t.jpg file.jpg 0     2019-06-12 17:43:24.0        1

          
SELECT c.custoqusno, c.askcont,
          t.answer
FROM custo_qus c, ctsanswer t  
ORDER BY c.custoqusno ASC, t.answerno ASC;

 CUSTOQUSNO ASKCONT         ANSWER
 ---------- --------------- ------------------
          1 ������� �ٲ��ּ���      ����� �����ص�Ƚ��ϴ�.
          1 ������� �ٲ��ּ���      ������ �� ���԰� �����Դϴ�.
          1 ������� �ٲ��ּ���      �� �ּҸ� ���� �ֽñ� �ٶ��ϴ�.
          2 �Ͱ���3 ���԰� �����ΰ��� ����� �����ص�Ƚ��ϴ�.
          2 �Ͱ���3 ���԰� �����ΰ��� ������ �� ���԰� �����Դϴ�.
          2 �Ͱ���3 ���԰� �����ΰ��� �� �ּҸ� ���� �ֽñ� �ٶ��ϴ�.
          3 ����̸� ��ǰ�ϰ� �;��   ����� �����ص�Ƚ��ϴ�.
          3 ����̸� ��ǰ�ϰ� �;��   ������ �� ���԰� �����Դϴ�.
          3 ����̸� ��ǰ�ϰ� �;��   �� �ּҸ� ���� �ֽñ� �ٶ��ϴ�.

--!!!!!�´� �ڵ�
SELECT c.custoqusno, c.askcont,
          t.answer
FROM custo_qus c, ctsanswer t  
WHERE c.custoqusno = t.custoqusno
ORDER BY c.custoqusno ASC, t.answerno ASC;

 CUSTOQUSNO ASKCONT         ANSWER
 ---------- --------------- ------------------
          1 ������� �ٲ��ּ���      ������� �����߽��ϴ�.
          2 �Ͱ���3 ���԰� �����ΰ��� ������ �� ���԰� �����Դϴ�.
          3 ����̸� ��ǰ�ϰ� �;��   �� �ּҸ� ���� �ֽñ� �ٶ��ϴ�.







