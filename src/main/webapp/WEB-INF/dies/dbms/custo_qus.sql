/**********************************/
/* Table Name: ������ */
/**********************************/
DROP TABLE custo_qus
DROP TABLE ctsanswer

CREATE TABLE custo_qus(
    custoqusno                    NUMBER(10)              NOT NULL    PRIMARY KEY,
    diecateno                       NUMBER(10)              NOT NULL,
    title                               VARCHAR2(50)          NOT NULL,
    askcont                          VARCHAR2(2000)       NOT NULL,
    thumbs                          VARCHAR2(1000)       NULL,
    files                              VARCHAR2(1000)        NULL,
    sizes                             VARCHAR2(1000)        NULL,
    replycnt                         NUMBER(7)               DEFAULT 0       NOT NULL,  
    rdate                             DATE                       NOT NULL,
    grpno                           NUMBER(7)               NOT NULL,
    indent                           NUMBER(2)              DEFAULT 0       NOT NULL,
    ansnum                         NUMBER(5)              DEFAULT 0       NOT NULL,
    word                            VARCHAR2(100)         NULL,
    answerno                       NUMBER(10)             NOT NULL,
    memno                         NUMBER(10)             NOT NULL,
    FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE custo_qus is '������';
COMMENT ON COLUMN custo_qus.custoqusno is '�����ǹ�ȣ';
COMMENT ON COLUMN custo_qus.diecateno is 'ī�װ���ȣ';
COMMENT ON COLUMN custo_qus.title is '����';
COMMENT ON COLUMN custo_qus.askcont is '���ǳ���';
COMMENT ON COLUMN custo_qus.thumbs is 'Thumb ����';
COMMENT ON COLUMN custo_qus.files is '����';
COMMENT ON COLUMN custo_qus.sizes is '����ũ��';
COMMENT ON COLUMN custo_qus.replycnt is '�亯��';
COMMENT ON COLUMN custo_qus.rdate is '��¥';
COMMENT ON COLUMN custo_qus.grpno is '�׷��ȣ';
COMMENT ON COLUMN custo_qus.indent is '�亯����';
COMMENT ON COLUMN custo_qus.ansnum is '�亯����';
COMMENT ON COLUMN custo_qus.word is '�˻���';
COMMENT ON COLUMN custo_qus.answerno is '�亯��ȣ';
COMMENT ON COLUMN custo_qus.memno is 'ȸ����ȣ';

-- ���
INSERT INTO custo_qus(custoqusno, 
                                diecateno, title, askcont, thumbs, files, 
                                sizes, replycnt, rdate, grpno, 
                                indent, ansnum, word, answerno, memno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, '���ǻ���', '������� �ٲ��ּ���', 
            'file_t.jpg', 'file.jpg', 0, 0, sysdate, (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM custo_qus),
            0, 0, '���ǻ���,�����,���԰�', 1, 1);

INSERT INTO custo_qus(custoqusno, 
                                diecateno, title, askcont, thumbs, files, 
                                sizes, replycnt, rdate, grpno, 
                                indent, ansnum, word, answerno, memno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            2, '��ǰ����', '�Ͱ���3 ���԰� �����ΰ���', 
            'file_t.jpg', 'file.jpg', 0, 0, sysdate, (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM custo_qus),
            0, 0, '���ǻ���,�����,���԰�', 2, 2);
            
INSERT INTO custo_qus(custoqusno, 
                                diecateno, title, askcont, thumbs, files, 
                                sizes, replycnt, rdate, grpno, 
                                indent, ansnum, word, answerno, memno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            3, '��ǰ����', '����̸� ��ǰ�ϰ� �;��', 
            'file_t.jpg', 'file.jpg', 0, 0, sysdate, (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM custo_qus),
            0, 0, '���ǻ���,�����,���԰�', 3, 3);
 
-- 1) �÷� �߰�
ALTER TABLE custo_qus
ADD (ansnum NUMBER(5));     
 
-- ���
SELECT custoqusno, diecateno, title, askcont, thumbs, files, sizes, replycnt, rdate, 
          grpno, indent, ansnum, word, answerno, memno
FROM custo_qus
ORDER BY custoqusno ASC  

  CUSTOQUSNO DIECATENO TITLE ASKCONT         THUMBS     FILES    SIZES REPLYCNT RDATE                 GRPNO INDENT WORD ANSWERNO MEMNO
 ---------- --------- ----- --------------- ---------- -------- ----- -------- --------------------- ----- ------ ---- -------- -----
          1         1 ���ǻ���  ������� �ٲ��ּ���      file_t.jpg file.jpg 0            0 2019-07-03 12:22:30.0     1      0 0           1     1
          2         2 ��ǰ����  �Ͱ���3 ���԰� �����ΰ��� file_t.jpg file.jpg 0            0 2019-07-03 12:23:18.0     2      0 0           2     2
          3         3 ��ǰ����  ����̸� ��ǰ�ϰ� �;��   file_t.jpg file.jpg 0            0 2019-07-03 12:23:19.0     3      0 0           3     3

  
-- ��ȸ
SELECT custoqusno, diecateno, title, askcont, thumbs, files, sizes, replycnt, rdate, 
          grpno, indent, ansnum, word, answerno, memno
FROM custo_qus
WHERE custoqusno=1; 

 CUSTOQUSNO DIECATENO TITLE ASKCONT    THUMBS     FILES    SIZES REPLYCNT RDATE                 GRPNO INDENT WORD ANSWERNO MEMNO
 ---------- --------- ----- ---------- ---------- -------- ----- -------- --------------------- ----- ------ ---- -------- -----
          1         1 ���ǻ���  ������� �ٲ��ּ��� file_t.jpg file.jpg 0            0 2019-07-03 12:22:30.0     1      0 0           1     1

-- ����
UPDATE custo_qus
SET title='���� ����', askcont='������� �������ּ���'
WHERE custoqusno=1;

-- ���� Ȯ��
SELECT custoqusno, diecateno, title, askcont, thumbs, files, sizes, replycnt, rdate, 
          grpno, indent, ansnum, word, answerno, memno
FROM custo_qus
WHERE custoqusno=1; 

 CUSTOQUSNO DIECATENO TITLE ASKCONT     THUMBS     FILES    SIZES REPLYCNT RDATE                 GRPNO INDENT WORD ANSWERNO MEMNO
 ---------- --------- ----- ----------- ---------- -------- ----- -------- --------------------- ----- ------ ---- -------- -----
          1         1 ���� ���� ������� �������ּ��� file_t.jpg file.jpg 0            0 2019-07-03 12:22:30.0     1      0 0           1     1

-- ����
DELETE FROM custo_qus
WHERE custoqusno=1;

-- �˻�+����¡
SELECT custoqusno, title, askcont, thumbs, files, sizes, replycnt, rdate, answerno, memno, word, r
FROM(
         SELECT custoqusno, title, askcont, thumbs, files, sizes, replycnt, rdate, answerno, memno, word, rownum as r
         FROM(
                  SELECT custoqusno, title, askcont, thumbs, files, sizes, replycnt, rdate, answerno, memno, word
                  FROM custo_qus
                  WHERE memno=1 AND word LIKE '%����%'
                  ORDER BY custoqusno DESC
         )
)
WHERE r >=1 AND r <= 3;

 CUSTOQUSNO TITLE    ASKCONT    THUMBS     FILES    SIZES  RDATE                 ANSWERNO MEMNO WORD        R
 ---------- -------- ---------- ---------- -------- ------ --------------------- -------- ----- ----------- -
         14 ���� ����    �ּҸ� �ٲ��ּ���. NULL       NULL     NULL   2019-07-01 16:38:37.0        0     1 ����,�ּ�,���,�԰� 1
         13 ���� ���פ����� �ּҸ� �ٲ��ּ���. sw21_t.jpg sw21.jpg 100669 2019-07-01 16:27:20.0        0     1 ����,�ּ�,���,�԰� 2
         12 ���� ����    �ּҸ� �ٲ��ּ���. sw09_t.jpg sw09.jpg 278237 2019-07-01 16:26:42.0        0     1 ����,�ּ�,���,�԰� 3

         
-- �亯         
    INSERT INTO custo_qus(custoqusno, 
                                    diecateno, title, askcont, thumbs, files, 
                                    sizes, replycnt, rdate, 
                                    word, grpno, 
                                    indent, ansnum, answerno, memno) 
VALUES((SELECT NVL(MAX(custoqusno), 0) + 1 as custoqusno FROM custo_qus),
            2, 're: ��ǰ����', '�Ͱ���3�� ������ �Ŀ� ���԰� �˴ϴ�', 'file_t.jpg', 'file.jpg', 
            0, 0, sysdate, 
            '', (SELECT NVL(MAX(diecateno), 0) + 1 as diecateno FROM custo_qus), 
            1, 1, 2, 2);



SELECT custoqusno, diecateno, title, askcont, thumbs, files, sizes, rdate, answerno, memno, word
FROM custo_qus
WHERE memno=6 AND word LIKE '%����%'
ORDER BY custoqusno DESC;

