DELETE FROM goods;

DELETE FROM custo_qus;

--PK ���̺� ������ �߰�

INSERT INTO goods(goodsno,
                  diecateno, memno, title, content, price, dcprice, totprice,
                  thumbs, files, sizes, word, visit, visible, rdate)                  
VALUES((SELECT NVL(MAX(goodsno), 0) + 1 as goodsno FROM goods),
            1, 1, '��ǰ��1', '����1', 15900, 1000, 14900,
            'earring_t.jpg', 'earring.jpg', 0, '�Ͱ���,�Ǽ��縮,����������', 0, 'Y', sysdate);
            
INSERT INTO goods(goodsno,
                  diecateno, memno, title, content, price, dcprice, totprice,
                  thumbs, files, sizes, word, visit, visible, rdate)                  
VALUES((SELECT NVL(MAX(goodsno), 0) + 1 as goodsno FROM goods),
            1, 1, '��ǰ��2', '����2', 19900, 3000, 16900,
            'earring_t.jpg', 'earring.jpg', 0, '�Ͱ���,�Ǽ��縮,����������', 0, 'Y', sysdate);
            
INSERT INTO goods(goodsno,
                  diecateno, memno, title, content, price, dcprice, totprice,
                  thumbs, files, sizes, word, visit, visible, rdate)                  
VALUES((SELECT NVL(MAX(goodsno), 0) + 1 as goodsno FROM goods),
            1, 1, '��ǰ��3', '����3', 9900, 0, 9900,
            'earring_t.jpg', 'earring.jpg', 0, '�Ͱ���,�Ǽ��縮,����������', 0, 'Y', sysdate);
            
            
SELECT * FROM goods ORDER BY goodsno ASC;            


INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, 'ȸ��1', '���ǻ���', '������� �ٲ��ּ���', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, 'ȸ��2', '��ǰ����', '�Ͱ���3 ���԰� �����ΰ���', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, 'ȸ��3', '��ǰ����', '����̸� ��ǰ�ϰ� �;��', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);


SELECT * FROM goods ORDER BY goodsno ASC;

 GOODSNO DIECATENO MEMNO TITLE CONTENT PRICE DCPRICE TOTPRICE THUMBS        FILES       SIZES WORD           VISIT VISIBLE RDATE
 ------- --------- ----- ----- ------- ----- ------- -------- ------------- ----------- ----- -------------- ----- ------- ---------------------
       1         1     1 ��ǰ��1  ����1     15900    1000    14900 earring_t.jpg earring.jpg 0     �Ͱ���,�Ǽ��縮,����������     0 Y       2019-06-13 18:11:07.0
       2         1     1 ��ǰ��2  ����2     19900    3000    16900 earring_t.jpg earring.jpg 0     �Ͱ���,�Ǽ��縮,����������     0 Y       2019-06-13 18:11:08.0
       3         1     1 ��ǰ��3  ����3      9900       0     9900 earring_t.jpg earring.jpg 0     �Ͱ���,�Ǽ��縮,����������     0 Y       2019-06-13 18:11:09.0



1. ���̺� ����
/**********************************/
/* Table Name: ��ǰ ������ */
/**********************************/

-- ���̺� ����
DROP TABLE goods;
DROP TABLE goods CASCADE CONSTRAINTS;  -- ���� ���ǰ� �Բ� ������ ����, �����

CREATE TABLE goods(
    goodsno                           NUMBER(10)                      NOT NULL    PRIMARY KEY,
    diecateno                          NUMBER(10)                      NOT NULL,
    memno                            NUMBER(10)                       NOT NULL,
    title                                 VARCHAR2(100)                   NOT NULL,
    content                            CLOB                                 NOT NULL,
    price                                NUMBER(10)     DEFAULT 0    NOT NULL,
    dcprice                             NUMBER(10)     DEFAULT 0           NULL ,
    totprice                            NUMBER(10)     DEFAULT 0     NOT NULL,
    thumbs                            VARCHAR2(1000)                         NULL ,
    files                                 VARCHAR2(1000)                         NULL ,
    sizes                                VARCHAR2(1000)                         NULL ,
    word                               VARCHAR2(100)                           NULL,
    visit                                 NUMBER(10)     DEFAULT 0     NOT NULL,
    visible                              CHAR(1)           DEFAULT 'Y'   NOT NULL,
    rdate                               DATE                                  NOT NULL,
    
  FOREIGN KEY (diecateno) REFERENCES diecate (diecateno),
  FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE goods is '��ǰ ������';
COMMENT ON COLUMN goods.goodsno is '��ǰ ��ȣ';
COMMENT ON COLUMN goods.diecateno is 'ī�װ� ��ȣ';
COMMENT ON COLUMN goods.memno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN goods.title is '����';
COMMENT ON COLUMN goods.content is '����';
COMMENT ON COLUMN goods.price is '�ǸŰ���';
COMMENT ON COLUMN goods.dcprice is '���ΰ���';
COMMENT ON COLUMN goods.totprice is '�����ݾ�';
COMMENT ON COLUMN goods.thumbs is 'preview �̹���';
COMMENT ON COLUMN goods.files is '���ϸ�';
COMMENT ON COLUMN goods.sizes is '����ũ��';
COMMENT ON COLUMN goods.word is '�˻���';
COMMENT ON COLUMN goods.visit is '��ȸ��';
COMMENT ON COLUMN goods.visible is '��¸��';
COMMENT ON COLUMN goods.rdate is '�����';


2. ���
-- contents ���
- diecateno �÷� 1�� ����
- memno �÷� 1�� ����
INSERT INTO goods(goodsno,
                  diecateno, memno, title, content, price, dcprice, totprice,
                  thumbs, files, sizes, word, visit, visible, rdate)                  
VALUES((SELECT NVL(MAX(goodsno), 0) + 1 as goodsno FROM goods),
            1, 1, '��ǰ��1', '����1', 15900, 1000, 14900,
            'earring_t.jpg', 'earring.jpg', 0, '�Ͱ���,�Ǽ��縮,����������', 0, 'Y', sysdate);
            
INSERT INTO goods(goodsno,
                  diecateno, memno, title, content, price, dcprice, totprice,
                  thumbs, files, sizes, word, visit, visible, rdate)                  
VALUES((SELECT NVL(MAX(goodsno), 0) + 1 as goodsno FROM goods),
            1, 1, '��ǰ��2', '����2', 19900, 3000, 16900,
            'earring_t.jpg', 'earring.jpg', 0, '�Ͱ���,�Ǽ��縮,����������', 0, 'Y', sysdate);
            
INSERT INTO goods(goodsno,
                  diecateno, memno, title, content, price, dcprice, totprice,
                  thumbs, files, sizes, word, visit, visible, rdate)                  
VALUES((SELECT NVL(MAX(goodsno), 0) + 1 as goodsno FROM goods),
            1, 1, '��ǰ��3', '����3', 9900, 0, 9900,
            'earring_t.jpg', 'earring.jpg', 0, '�Ͱ���,�Ǽ��縮,����������', 0, 'Y', sysdate);
            

3. ���
-- ��ü ��� (passwd ����)
SELECT goodsno,
          diecateno, memno, title, content, price, dcprice, totprice
          thumbs, files, sizes, visit, visible, rdate
FROM goods
ORDER BY goodsno DESC;

  GOODSNO DIECATENO MEMNO TITLE CONTENT PRICE DCPRICE THUMBS FILES       SIZES VISIT VISIBLE RDATE
 ------- --------- ----- ----- ------- ----- ------- ------ ----------- ----- ----- ------- ---------------------
       3         1     1 ��ǰ��3  ����3      9900       0   9900 earring.jpg 0         0 Y       2019-06-11 18:09:42.0
       2         1     1 ��ǰ��2  ����2     19900    3000  16900 earring.jpg 0         0 Y       2019-06-11 18:09:41.0
       1         1     1 ��ǰ��1  ����1     15900    1000  14900 earring.jpg 0         0 Y       2019-06-11 18:09:40.0

-- ���
SELECT goodsno,
          diecateno, memno, title, content, good, thumbs, files, sizes, visit, rdate
FROM goods
ORDER BY goodsno DESC;

 GOODSNO DIECATENO MEMNO TITLE CONTENT GOOD THUMBS        FILES       VISIT RDATE
 ------- --------- ----- ----- ------- ---- ------------- ----------- ----- ---------------------
       3         1     1 ��ǰ��3  ����3        0 earring_t.jpg earring.jpg     0 2019-05-29 12:50:15.0
       2         1     1 ��ǰ��2  ����2        0 earring_t.jpg earring.jpg     0 2019-05-29 12:50:14.0
       1         1     1 ��ǰ��1  ����1        0 earring_t.jpg earring.jpg     0 2019-05-29 12:50:13.0

-- ���ϸ� ���
SELECT goodsno, thumbs, files, sizes
FROM goods
ORDER BY goodsno DESC;

 GOODSNO THUMBS        FILES
 ------- ------------- -----------
       3 earring_t.jpg earring.jpg
       2 earring_t.jpg earring.jpg
       1 earring_t.jpg earring.jpg


4. ��ü ī��Ʈ
SELECT COUNT(*) as count
FROM goods;

 COUNT
 -----
     3
     

5. ��ȸ
SELECT goodsno,
          diecateno, memno, title, content, good, thumbs, files, sizes, visit, rdate 
FROM goods
WHERE goodsno = 2; 

 GOODSNO DIECATENO MEMNO TITLE CONTENT GOOD THUMBS        FILES       VISIT RDATE
 ------- --------- ----- ----- ------- ---- ------------- ----------- ----- ---------------------
       2         1     1 ��ǰ��2  ����2        0 earring_t.jpg earring.jpg     0 2019-05-29 12:50:14.0
       

6. ����
UPDATE goods
SET title='���Ͱ���', content='�� ���� �����Ǹ�',
     price='11900', dcprice='2000', totprice='9900',
     thumbs='earring_t.jpg', files='earring.jpg', sizes=1000
WHERE goodsno = 3;

SELECT goodsno,
          diecateno, memno, title, content, good, thumbs, files, sizes, visit, rdate
FROM goods
ORDER BY goodsno DESC;

 GOODSNO DIECATENO MEMNO TITLE CONTENT   GOOD THUMBS        FILES       VISIT RDATE
 ------- --------- ----- ----- --------- ---- ------------- ----------- ----- ---------------------
       3         1     1 ���Ͱ���  �� ���� �����Ǹ�    0 earring_t.jpg earring.jpg     0 2019-05-29 12:50:15.0
       2         1     1 ��ǰ��2  ����2          0 earring_t.jpg earring.jpg     0 2019-05-29 12:50:14.0
       1         1     1 ��ǰ��1  ����1          0 earring_t.jpg earring.jpg     0 2019-05-29 12:50:13.0


7. ����
-- ��� ���ڵ� ����
DELETE FROM goods;

DELETE FROM goods
WHERE goodsno = 1;


8. �˻�
-- word LIKE '�Ͱ���' �� word = '�Ͱ���'
   ^�Ͱ���
-- word LIKE '%�Ͱ���' �� word = '�ܵ����� �Ͱ���'
   .*�Ͱ���
-- word LIKE '�Ͱ���%' �� word = '�Ͱ��� 1+1 ���'
   ^�Ͱ���.*
-- word LIKE '%�Ͱ���%' �� word = '�𿡽�Ÿ �Ͱ��� �̺�Ʈ'
   .*�Ͱ���.*
 
-- '�Ͱ���' �÷����� �˻�
SELECT goodsno, diecateno, title, content, totprice, 
          thumbs, files, sizes, visit, rdate, word
FROM goods
WHERE diecateno=1 AND word LIKE '%�Ͱ���%'
 ORDER BY goodsno DESC; 
 
1) �˻� �� ��ü ���ڵ� ����
-- diecateno �÷��� 1���̸� �˻����� �ʴ� ��� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM goods
WHERE diecateno=1;
 
-- '�Ͱ���' �˻� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM goods
WHERE diecateno=1 AND word LIKE '%�Ͱ���%';


9. ����¡
-- step 1
SELECT goodsno, diecateno, title, content, totprice, 
          thumbs, files, sizes,
          visit, rdate, word
FROM goods
WHERE diecateno=1
ORDER BY goodsno DESC;
 
-- step 2         
SELECT goodsno, diecateno, title, content, totprice, 
          thumbs, files, sizes, visit, rdate, word, rownum as r
FROM(
         SELECT goodsno, diecateno, title, content, totprice, 
                   thumbs, files, sizes, visit, rdate, word
          FROM goods
          WHERE diecateno=1
          ORDER BY goodsno DESC
);
 
-- step 3         
SELECT goodsno, diecateno, title, content, totprice, 
          thumbs, files, sizes, visit, rdate, word, r
FROM(
         SELECT goodsno, diecateno, title, content, totprice, 
                   thumbs, files, sizes, visit, rdate, word, rownum as r
         FROM(
                  SELECT goodsno, diecateno, title, content, totprice, 
                            thumbs, files, sizes, visit, rdate, word
                  FROM goods
                  WHERE diecateno=1
                  ORDER BY goodsno DESC            
         )
)
WHERE r >=1 AND r <= 3;
            
-- �˻� + ����¡       
SELECT goodsno, diecateno, title, content, totprice, 
          thumbs, files, sizes, visit, rdate, word, r
FROM(
         SELECT goodsno, diecateno, title, content, totprice, 
                   thumbs, files, sizes, visit, rdate, word, rownum as r
         FROM(
                  SELECT goodsno, diecateno, title, content, totprice, 
                            thumbs, files, sizes, visit, rdate, word
                  FROM goods
                  WHERE diecateno=1 AND word LIKE '%�Ͱ���%'
                  ORDER BY goodsno DESC
         )
)
WHERE r >=1 AND r <= 3;





/**********************************/
/* Table Name: ������ */
/**********************************/
DROP TABLE custo_qus

CREATE TABLE custo_qus(
    custoqusno                        NUMBER(10)           NOT NULL    PRIMARY KEY,
    goodsno                           NUMBER(10)           NULL ,
    memno                             NUMBER(10)           NOT NULL,
    name                              VARCHAR2(10)           NOT NULL,
    title                                 VARCHAR2(50)           NOT NULL,
    askcont                           VARCHAR2(100)        NOT NULL,
    thumbs                         VARCHAR2(1000)       NULL ,
    files                             VARCHAR2(1000)         NULL ,
    sizes                             VARCHAR2(1000)        NULL ,
    rdate                               DATE                        NOT NULL,
    answerno                          NUMBER(10)          NOT NULL,
  FOREIGN KEY (memno) REFERENCES mem (memno),
  FOREIGN KEY (goodsno) REFERENCES goods (goodsno)
);

COMMENT ON TABLE custo_qus is '������';
COMMENT ON COLUMN custo_qus.custoqusno is '�����ǹ�ȣ';
COMMENT ON COLUMN custo_qus.goodsno is '��ǰ ��ȣ';
COMMENT ON COLUMN custo_qus.memno is 'ȸ����ȣ';
COMMENT ON COLUMN custo_qus.name is 'ȸ���̸�';
COMMENT ON COLUMN custo_qus.title is '����';
COMMENT ON COLUMN custo_qus.askcont is '���ǳ���';
COMMENT ON COLUMN custo_qus.thumbs is 'Thumb ����';
COMMENT ON COLUMN custo_qus.files is '����';
COMMENT ON COLUMN custo_qus.sizes is '����ũ��';
COMMENT ON COLUMN custo_qus.rdate is '��¥';
COMMENT ON COLUMN custo_qus.answerno is '�亯��ȣ';

-- ���
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, 'ȸ��1', '���ǻ���', '������� �ٲ��ּ���', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, 'ȸ��2', '��ǰ����', '�Ͱ���3 ���԰� �����ΰ���', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, 'ȸ��3', '��ǰ����', '����̸� ��ǰ�ϰ� �;��', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
-- ���
SELECT custoqusno, goodsno, memno, name, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
ORDER BY custoqusno ASC  

 CUSTOQUSNO GOODSNO MEMNO NAME TITLE ASKCONT         THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ------- ----- ---- ----- --------------- ---------- -------- ----- --------------------- --------
          1       1     1 ȸ��1  ���ǻ���  ������� �ٲ��ּ���      file_t.jpg file.jpg 0     2019-06-04 17:24:22.0        1
          2       1     1 ȸ��2  ��ǰ����  �Ͱ���3 ���԰� �����ΰ��� file_t.jpg file.jpg 0     2019-06-04 17:24:23.0        1
          3       1     1 ȸ��3  ��ǰ����  ����̸� ��ǰ�ϰ� �;��   file_t.jpg file.jpg 0     2019-06-04 17:24:24.0        1
         
-- ��ȸ
SELECT custoqusno, goodsno, memno, name, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
WHERE custoqusno=1; 

 CUSTOQUSNO GOODSNO MEMNO NAME TITLE ASKCONT    THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ------- ----- ---- ----- ---------- ---------- -------- ----- --------------------- --------
          1       1     1 ȸ��1  ���ǻ���  ������� �ٲ��ּ��� file_t.jpg file.jpg 0     2019-06-04 17:24:22.0        1

-- ����
UPDATE custo_qus
SET name='ȸ��11'
WHERE custoqusno=1;

-- ���� Ȯ��
SELECT custoqusno, goodsno, memno, name, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
WHERE custoqusno=1; 

 CUSTOQUSNO GOODSNO MEMNO NAME TITLE ASKCONT    THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ------- ----- ---- ----- ---------- ---------- -------- ----- --------------------- --------
          1       1     1 ȸ��11 ���ǻ���  ������� �ٲ��ּ��� file_t.jpg file.jpg 0     2019-06-04 17:24:22.0        1

-- ����
DELETE FROM custo_qus
WHERE custoqusno=1;


  goodsno                           NUMBER(10)                      NOT NULL    PRIMARY KEY,
    diecateno                          NUMBER(10)                      NOT NULL,
    memno                            NUMBER(10)                       NOT NULL,
    title                                 VARCHAR2(100)                   NOT NULL,
    content                            CLOB                                 NOT NULL,
    price                                NUMBER(10)     DEFAULT 0    NOT NULL,
    dcprice                             NUMBER(10)     DEFAULT 0           NULL ,
    totprice                            NUMBER(10)     DEFAULT 0     NOT NULL,
    thumbs                            VARCHAR2(1000)                         NULL ,
    files                                 VARCHAR2(1000)                         NULL ,
    sizes                                VARCHAR2(1000)                         NULL ,
    word                               VARCHAR2(100)                           NULL,
    visit                                 NUMBER(10)     DEFAULT 0     NOT NULL,
    visible                              CHAR(1)           DEFAULT 'Y'   NOT NULL,
    rdate                               DATE                                  NOT NULL,
    


SELECT c.goodsno, c.content,
          t.askcont
FROM goods c, custo_qus t  
WHERE c.goodsno = t.goodsno
ORDER BY c.goodsno ASC, t.custoqusno ASC;

 GOODSNO CONTENT ASKCONT
 ------- ------- ---------------
       1 ����1     ������� �ٲ��ּ���
       2 ����2     �Ͱ���3 ���԰� �����ΰ���
       3 ����3     ����̸� ��ǰ�ϰ� �;��





