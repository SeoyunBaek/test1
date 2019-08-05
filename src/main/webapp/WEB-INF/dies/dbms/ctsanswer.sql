/**********************************/
/* Table Name: ������ �亯 */
/**********************************/
DROP TABLE ctsanswer;
DELETE FROM ctsanswer

CREATE TABLE ctsanswer(
    answerno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    custoqusno                        NUMBER(10)     NOT NULL,
    answer                            VARCHAR2(50)     NOT NULL,
    ansnum                         NUMBER(5)              DEFAULT 0       NOT NULL,
    rdate                             DATE                       NOT NULL,
  FOREIGN KEY (custoqusno) REFERENCES custo_qus (custoqusno)
);

COMMENT ON TABLE ctsanswer is '������ �亯';
COMMENT ON COLUMN ctsanswer.answerno is '�亯��ȣ';
COMMENT ON COLUMN ctsanswer.custoqusno is '�����ǹ�ȣ';
COMMENT ON COLUMN ctsanswer.answer is '�亯';
COMMENT ON COLUMN ctsanswer.ansnum is '�亯����';
COMMENT ON COLUMN ctsanswer.rdate is '��¥';

-- ����
1) �÷� �߰�
ALTER TABLE ctsanswer
ADD (rdate DATE);
COMMENT ON COLUMN ctsanswer.grpno is '�׷��ȣ';
COMMENT ON COLUMN ctsanswer.indent is '�亯����';
ALTER TABLE ctsanswer
DROP COLUMN indent;

-- ���
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer, grpno, 
                                indent, ansnum, rdate)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            1, '����� �����ص�Ƚ��ϴ�.', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM ctsanswer),
            0, 0, sysdate);
         
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer, grpno, 
                                indent, ansnum, rdate)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            2, '������ �� ���԰� �����Դϴ�.', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM ctsanswer),
            0, 0, sysdate);
 
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer, grpno, 
                                indent, ansnum, rdate)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            3, '�� �ּҸ� ���� �ֽñ� �ٶ��ϴ�.', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM ctsanswer),
            0, 0, sysdate);
            
            
-- ���
SELECT answerno, custoqusno, answer, grpno, indent, ansnum, rdate
FROM ctsanswer
ORDER BY answerno ASC  

 ANSWERNO CUSTOQUSNO ANSWER             RDATE
 -------- ---------- ------------------ ---------------------
        1          1 ������� �����߽��ϴ�.       2019-07-03 13:00:46.0
        2          2 ������ �� ���԰� �����Դϴ�.   2019-07-03 13:01:26.0
        3          3 �� �ּҸ� ���� �ֽñ� �ٶ��ϴ�. 2019-07-03 13:01:27.0

          
-- ��ȸ
SELECT answerno, custoqusno, answer, rdate
FROM ctsanswer
WHERE answerno=1; 

 ANSWERNO CUSTOQUSNO ANSWER
 -------- ---------- -------------
        1          1 ����� �����ص�Ƚ��ϴ�.


-- ����
UPDATE ctsanswer
SET answer='������� �����߽��ϴ�.'
WHERE answerno=1;

-- ���� Ȯ��
SELECT answerno, custoqusno, answer, rdate
FROM ctsanswer
WHERE answerno=1; 

 ANSWERNO CUSTOQUSNO ANSWER
 -------- ---------- ------------
        1          1 ������� �����߽��ϴ�.


-- ����
DELETE FROM ctsanswer
WHERE answerno=1;

-- �亯
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer, rdate)  
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            1, '�� �ּҸ� ���� �ֽñ� �ٶ��ϴ�.', sysdate);
            
            
            