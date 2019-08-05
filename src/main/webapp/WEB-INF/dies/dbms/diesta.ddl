/**********************************/
/* Table Name: ȸ�� */
/**********************************/
DROP TABLE mem

<ȸ�� ���̺�>
1. ���̺� ����
 
DROP TABLE mem; 
 
CREATE TABLE mem (
  memno             NUMBER(10)     NOT NULL, -- ȸ�� ��ȣ 
  id                    VARCHAR(50)     NOT NULL, -- ���̵�
  passwd            VARCHAR(50)     NOT NULL, -- ��й�ȣ   
  name               VARCHAR(50)     NOT NULL, -- �̸� 
  zipcode            VARCHAR(50)     NULL, -- �����ȣ
  address1          VARCHAR(50)     NULL, -- �⺻ �ּ�
  address2          VARCHAR(50)     NULL, -- �� �ּ�
  phone              VARCHAR(50)     NOT NULL, -- �޴� ��ȭ
  email               VARCHAR(50)    UNIQUE NOT NULL, -- �̸���
  act                   CHAR(1)            DEFAULT 'N' NULL, -- M: ������, Y: �α��� ����, N: �α��� �Ұ�, C: Ż��
  PRIMARY KEY (memno)                
); 

COMMENT ON TABLE mem is 'ȸ��';
COMMENT ON COLUMN mem.memno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN mem.id is '���̵�';
COMMENT ON COLUMN mem.passwd is '��� ��ȣ';
COMMENT ON COLUMN mem.name is '�̸�';
COMMENT ON COLUMN mem.zipcode is '���� ��ȣ';
COMMENT ON COLUMN mem.address1 is '�⺻ �ּ�';
COMMENT ON COLUMN mem.address2 is '�� �ּ�';
COMMENT ON COLUMN mem.phone is '�޴� ��ȭ';
COMMENT ON COLUMN mem.email is '�̸���';
COMMENT ON COLUMN mem.act is '���'; 
 
2. ȸ�� ����
   DELETE FROM mem; 
   
1) id �ߺ� Ȯ��
SELECT COUNT(id) as cnt
FROM mem
WHERE id='ȸ��1';

CNT
 ---
   1
   
2)   -- ������ ȸ�� ����
INSERT INTO mem(memno, id, passwd, name, zipcode, address1, address2, phone, email, act)
VALUES ((SELECT NVL(MAX(memno), 0)+1 as memno FROM mem),
'master1', '123', '������',  '12345', '����� ���α�', '��ö��', '000-1234-0000', 'master1@gmail.com', 'M');
 
INSERT INTO mem(memno, id, passwd, name, zipcode, address1, address2, phone, email, act)
VALUES ((SELECT NVL(MAX(memno), 0)+1 as memno FROM mem),
'master2', '123', '������',  '12345', '��õ�� ���� ', '������', '000-5678-0000', 'master2@gmail.com', 'M');

-- ���� ȸ�� ����
   INSERT INTO mem(memno, id, passwd, name, zipcode, address1, address2, phone, email, act)   
   VALUES((SELECT NVL(MAX(memno), 0)+1 as memno FROM mem), 'mem1', '123', '�ڼ���', '12345', '����� ���α� ��ö��', '13-13', 
               '010-0000-0000', 'cust1@gmail.com', 'Y');
               
   INSERT INTO mem(memno, id, passwd, name, zipcode, address1, address2, phone, email, act)   
   VALUES((SELECT NVL(MAX(memno), 0)+1 as memno FROM mem), 'mem2', '123', 'ȫ�浿', '12345', '����� ���빮��', '14-14', 
               '010-1111-0000', 'cust2@gmail.com', 'Y'); 
               
   INSERT INTO mem(memno, id, passwd, name, zipcode, address1, address2, phone, email, act)   
   VALUES((SELECT NVL(MAX(memno), 0)+1 as memno FROM mem), 'mem3', '123', '������', '12345', '����� ��걸', '15-15', 
               '010-2222-0000', 'cust3@gmail.com', 'Y');
               
   INSERT INTO mem(memno, id, passwd, name, zipcode, address1, address2, phone, email, act)   
   VALUES((SELECT NVL(MAX(memno), 0)+1 as memno FROM mem), 'mem4', '123', '�赵��', '12345', '����� �����', '16-16', 
               '010-3333-0000', 'cust4@gmail.com', 'N');           
 
 
3. ���

1)ȸ�� ��ü ���
   SELECT memno, id, passwd, name, zipcode, address1, address2, phone, email, act
   FROM mem
   ORDER BY memno ASC;
   
 MEMNO ID      PASSWD NAME ZIPCODE ADDRESS1    ADDRESS2 PHONE         EMAIL             ACT
 ----- ------- ------ ---- ------- ----------- -------- ------------- ----------------- ---
     1 master1 123    ������  12345   ����� ���α�     ��ö��      000-1234-0000 master1@gmail.com M
     2 master2 123    ������  12345   ��õ�� ����      ������      000-5678-0000 master2@gmail.com M
     3 mem1    123    �ڼ���  12345   ����� ���α� ��ö�� 13-13    010-0000-0000 cust1@gmail.com   Y
     4 mem2    123    ȫ�浿  12345   ����� ���빮��    14-14    010-1111-0000 cust2@gmail.com   Y
     5 mem3    123    ������  12345   ����� ��걸     15-15    010-2222-0000 cust3@gmail.com   Y
     6 mem4    123    �赵��  12345   ����� �����     16-16    010-3333-0000 cust4@gmail.com   N

4. ȸ�� ���� ��ȸ 
   SELECT memno, id, passwd, name, zipcode, address1, address2, phone, email
   FROM mem
   WHERE memno = 1;

5. �н����� ����
1) ���� �н����� �˻�
- DAO: public int countPasswd(int memno, String passwd){ ... }
SELECT count(*) as cnt
FROM mem
WHERE memno = 1 AND passwd='123';
 
2) �н����� ����
- DAO: public int updatePasswd(int memno, String passwd){ ... }
UPDATE mem
SET passwd=''
WHERE memno=1;
 
 
6.  ȸ�� ���� ���� 

UPDATE mem
SET name = '�����' zipcode='56789', address1='����� ���ϱ�', address2='9-11', 
      phone='010-9677-7789'
WHERE memno=1;      

2) ������ ����(admin4DAO: int updateAct(int admin4no, String act))
UPDATE mem 
SET  act='Y'
WHERE memno=6; 

3) ȸ�� Ż��
UPDATE mem
SET zipcode='', address1='', address2=''
WHERE memno = 1;


7. 'mem' ȸ�� ���� 
DELETE FROM mem;
 
DELETE FROM mem
WHERE memno = 4;
   
8. �˻��� ��ü ���ڵ� ��
   - LIKE    : ��Ȯ�ϰ� ��ġ���� �ʾƵ� ��� 
   - =(equal): ��Ȯ�ϰ� ��ġ�ؾ� ��� 
   - �˻��� ���� �ʴ� ���, ��ü ��� ��� 
 
      
9. �˻� ���(S:Search List)  
 
 
10. ����¡
   - ����� ����¡ ������ �ʼ��� �մϴ�.
   
11. �α���
SELECT COUNT(memno) as cnt
FROM mem
WHERE id='mem1' AND passwd='1234';   
   
   
<ȸ�� �α��� ����>   
1. ���̺� ����

DROP TABLE login; 
 
CREATE TABLE login (
  logno              NUMBER(10)     NOT NULL, -- ȸ�� �α��� ���� ��ȣ
  memno            NUMBER(10)     NOT NULL, -- ȸ�� ��ȣ
  id                    VARCHAR(50)   NOT NULL, -- ���̵�
  logdate            DATE               NOT NULL,  -- ȸ�� �α��� ��¥
  
  PRIMARY KEY (logno),
  FOREIGN KEY (memno) REFERENCES mem (memno)
); 

COMMENT ON TABLE login is 'ȸ�� �α��� ����';
COMMENT ON COLUMN login.logno is 'ȸ�� �α��� ���� ��ȣ';
COMMENT ON COLUMN login.memno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN login.id is '���̵�';
COMMENT ON COLUMN login.logdate is 'ȸ�� �α��� ��¥';

2. �α��� ���
   DELETE FROM login; 
   
   INSERT INTO login(logno, memno, id, logdate)   
   VALUES((SELECT NVL(MAX(logno), 0)+1 as logno FROM login), 1, 'mem1', sysdate );
   
   INSERT INTO login(logno, memno, id, logdate)   
   VALUES((SELECT NVL(MAX(logno), 0)+1 as logno FROM login), 2, 'mem2', sysdate );
   
   INSERT INTO login(logno, memno, id, logdate)   
   VALUES((SELECT NVL(MAX(logno), 0)+1 as logno FROM login), 3, 'mem3', sysdate );
   
3. �α��� ���� ��ü ���
   SELECT logno, memno, id, logdate
   FROM login
   ORDER BY logno ASC;   
   
  LOGNO MEMNO ID   LOGDATE
 ----- ----- ---- ---------------------
     1     1 mem1 2019-05-28 17:20:14.0
     2     2 mem2 2019-05-28 17:20:15.0
     3     3 mem3 2019-05-28 17:20:16.0
               
 4. �α��� ���� ��ȸ 
   SELECT logno, memno, id, logdate
   FROM login
   WHERE logno = 1;  

5. 'login' ���� ���� 
DELETE FROM login;
 
DELETE FROM login
WHERE logno = 4;
   
               

/**********************************/
/* Table Name: ī�װ� */
/**********************************/
DROP TABLE diecate

CREATE TABLE diecate(
    diecateno                     NUMBER(10)                          NOT NULL    PRIMARY KEY,
    title                             VARCHAR2(50)                       NOT NULL,
    seqno                          NUMBER(5)                           NOT NULL,
    visible                          CHAR(1)          DEFAULT 'Y'     NOT NULL,
    cnt                              NUMBER(10)     DEFAULT 0      NOT NULL,
    rdate                           DATE                                    NOT NULL
); 

COMMENT ON TABLE diecate is 'ī�װ�';
COMMENT ON COLUMN diecate.diecateno is 'ī�װ� ��ȣ';
COMMENT ON COLUMN diecate.title is 'ī�װ� ����';
COMMENT ON COLUMN diecate.seqno is '��¼���';
COMMENT ON COLUMN diecate.visible is '��¸��';
COMMENT ON COLUMN diecate.cnt is '��ϵ� �ڷ��';
COMMENT ON COLUMN diecate.rdate is 'ī�װ� ������';


2. ���
INSERT INTO diecate(diecateno, title, seqno, visible, cnt, rdate)
VALUES((SELECT NVL(MAX(diecateno), 0) + 1 as diecateno FROM diecate),
            '�Ͱ���', 1, 'Y', 0, sysdate);
            
INSERT INTO diecate(diecateno, title, seqno, visible, cnt, rdate)
VALUES((SELECT NVL(MAX(diecateno), 0) + 1 as diecateno FROM diecate),
            '�����', 2, 'Y', 0, sysdate);
            
INSERT INTO diecate(diecateno, title, seqno, visible, cnt, rdate)
VALUES((SELECT NVL(MAX(diecateno), 0) + 1 as diecateno FROM diecate),
            '����', 3, 'Y', 0, sysdate);
            
            
3. ���
-- ī�װ� ��ȣ�� ����
SELECT diecateno, title, seqno, visible, cnt, rdate
FROM diecate
ORDER BY diecateno ASC;

 DIECATENO TITLE SEQNO VISIBLE CNT RDATE
 --------- ----- ----- ------- --- ---------------------
         1 �Ͱ���       1 Y         0 2019-05-24 13:12:13.0
         2 �����       2 Y         0 2019-05-24 13:12:14.0
         3 ����        3 Y         0 2019-05-24 13:12:15.0

-- ��¼����� ���� ��ü ���
SELECT diecateno, title, seqno, visible, cnt, rdate
FROM diecate
ORDER BY seqno ASC;

 DIECATENO TITLE SEQNO VISIBLE CNT RDATE
 --------- ----- ----- ------- --- ---------------------
         1 �Ͱ���       1 Y         0 2019-05-24 13:12:13.0
         2 �����       2 Y         0 2019-05-24 13:12:14.0
         3 ����        3 Y         0 2019-05-24 13:12:15.0

         
4. ��ȸ
SELECT diecateno, title, seqno, visible, cnt, rdate
FROM diecate
WHERE diecateno = 1;

 DIECATENO TITLE SEQNO VISIBLE CNT RDATE
 --------- ----- ----- ------- --- ---------------------
         1 �Ͱ���       1 Y         0 2019-05-24 13:12:13.0
         

5. ����
UPDATE diecate
SET title='�����/��Ŀ', seqno = 2, visible='Y'
WHERE diecateno = 2;

SELECT diecateno, title, seqno, visible, cnt, rdate
FROM diecate
ORDER BY seqno ASC;

 DIECATENO TITLE  SEQNO VISIBLE CNT RDATE
 --------- ------ ----- ------- --- ---------------------
         1 �Ͱ���        1 Y         0 2019-05-24 13:12:13.0
         2 �����/��Ŀ     2 Y         0 2019-05-24 13:12:14.0
         3 ����         3 Y         0 2019-05-24 13:12:15.0


6. ����
-- ��� ���ڵ� ����
DELETE FROM diecate;

DELETE FROM diecate
WHERE diecateno = 3;


7. ��¼���
-- ��� ���� ����, 10 -> 1
UPDATE diecate
SET seqno = seqno - 1
WHERE diecateno=1;

-- ��¼��� ����, 1 -> 10
UPDATE diecate
SET seqno = seqno + 1
WHERE diecateno=1;

-- ��� ������ ���� ��ü ���
SELECT diecateno, title, seqno
FROM diecate
ORDER BY seqno ASC;


8. ��ϵ� �� ��
-- ������ �߰��� ���� ��ϵ� �� ���� ����
UPDATE diecate 
SET cnt = cnt + 1 
WHERE diecateno = 1;

-- ������ ������ ���� ��ϵ� �� ���� ����
UPDATE diecate 
SET cnt = cnt - 1 
WHERE diecateno = 1;

-- �� ���� �ʱ�ȭ
UPDATE diecate 
SET cnt = 0;


/**********************************/
/* Table Name: ��ǰ ������ */
/**********************************/
DROP TABLE goods

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
            
-----------------------------------------------------------------------------------------------------------------

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

-----------------------------------------------------------------------------------------------------------------

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
/* Table Name: �ֹ� */
/**********************************/
drop table ordered

CREATE TABLE ordered(
		orderno                       		VARCHAR2(50)		 NOT NULL		 PRIMARY KEY,
		goodsno                       		NUMBER(10)		 NOT NULL,
		memno                         		NUMBER(10)		 NOT NULL,
		orderRec                      		VARCHAR2(50)		 NOT NULL,
		orderAddr1                    		VARCHAR2(20)		 NOT NULL,
		orderAddr2                    		VARCHAR2(50)		 NOT NULL,
		orderAddr3                    		VARCHAR2(50)		 NULL ,
		orderDate                     		DATE		 NOT NULL,
  FOREIGN KEY (memno) REFERENCES mem (memno),
  FOREIGN KEY (goodsno) REFERENCES goods (goodsno)
);

COMMENT ON TABLE ordered is '�ֹ�';
COMMENT ON COLUMN ordered.orderno is '�ֹ� ��ȣ';
COMMENT ON COLUMN ordered.goodsno is '��ǰ ��ȣ';
COMMENT ON COLUMN ordered.memno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN ordered.orderRec is '�޴»��';
COMMENT ON COLUMN ordered.orderAddr1 is '�����ȣ';
COMMENT ON COLUMN ordered.orderAddr2 is '�ּ�';
COMMENT ON COLUMN ordered.orderAddr3 is '���ּ�';
COMMENT ON COLUMN ordered.orderDate is '�ֹ� ��¥';


/**********************************/
/* Table Name: ��ٱ��� */
/**********************************/
CREATE TABLE cart(
		cartno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		goodsno                       		NUMBER(10)		 NOT NULL,
		memno                         		NUMBER(10)		 NOT NULL,
		goodsqty                      		NUMBER(10)		 NOT NULL,
		addDate                       		DATE		 NOT NULL,
  FOREIGN KEY (goodsno) REFERENCES goods (goodsno),
  FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE cart is '��ٱ���';
COMMENT ON COLUMN cart.cartno is '��ٱ��� ��ȣ';
COMMENT ON COLUMN cart.goodsno is '��ǰ ��ȣ';
COMMENT ON COLUMN cart.memno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN cart.goodsqty is '��ǰ ����';
COMMENT ON COLUMN cart.addDate is '��¥';


/**********************************/
/* Table Name: ������ */
/**********************************/
DROP TABLE custo_qus

CREATE TABLE custo_qus(
		custoqusno                    		NUMBER(10)		       NOT NULL		 PRIMARY KEY,
		diecateno                       NUMBER(10)           NOT NULL,
		name                          		VARCHAR2(10)		       NOT NULL,
		title                             		VARCHAR2(50)		       NOT NULL,
		askcont                       		VARCHAR2(2000)		     NOT NULL,
		thumbs                         VARCHAR2(1000)       NULL ,
		files                         		VARCHAR2(1000)		      NULL ,
		sizes                             VARCHAR2(1000)        NULL ,
		rdate                         	  	DATE		                    NOT NULL,
		answerno                      		NUMBER(10)		      NOT NULL,
		memno                             NUMBER(10)     NOT NULL,
    FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE custo_qus is '������';
COMMENT ON COLUMN custo_qus.custoqusno is '�����ǹ�ȣ';
COMMENT ON COLUMN custo_qus.diecateno is 'ī�װ���ȣ';
COMMENT ON COLUMN custo_qus.name is 'ȸ���̸�';
COMMENT ON COLUMN custo_qus.title is '����';
COMMENT ON COLUMN custo_qus.askcont is '���ǳ���';
COMMENT ON COLUMN custo_qus.thumbs is 'Thumb ����';
COMMENT ON COLUMN custo_qus.files is '����';
COMMENT ON COLUMN custo_qus.sizes is '����ũ��';
COMMENT ON COLUMN custo_qus.rdate is '��¥';
COMMENT ON COLUMN custo_qus.answerno is '�亯��ȣ';
COMMENT ON COLUMN custo_qus.memno is 'ȸ����ȣ';

-- ���
INSERT INTO custo_qus(custoqusno, 
                                diecateno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno, memno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 'ȸ��1', '���ǻ���', '������� �ٲ��ּ���', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                diecateno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            2, 'ȸ��2', '��ǰ����', '�Ͱ���3 ���԰� �����ΰ���', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                diecateno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            3, 'ȸ��3', '��ǰ����', '����̸� ��ǰ�ϰ� �;��', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
-- ���
SELECT custoqusno, diecateno, name, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
ORDER BY custoqusno ASC  

 CUSTOQUSNO NAME TITLE ASKCONT         THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ---- ----- --------------- ---------- -------- ----- --------------------- --------
          1 ȸ��1  ���ǻ���  ������� �ٲ��ּ���      file_t.jpg file.jpg 0     2019-06-17 16:06:49.0        1
          2 ȸ��2  ��ǰ����  �Ͱ���3 ���԰� �����ΰ��� file_t.jpg file.jpg 0     2019-06-17 16:06:50.0        1
          3 ȸ��3  ��ǰ����  ����̸� ��ǰ�ϰ� �;��   file_t.jpg file.jpg 0     2019-06-17 16:06:51.0        1
          
         16         1 ȸ��1  ���ǻ���     ������� �ٲ��ּ���      file_t.jpg file.jpg 0     2019-06-18 16:53:53.0        1
         17         2 ȸ��2  ��ǰ����     �Ͱ���3 ���԰� �����ΰ��� file_t.jpg file.jpg 0     2019-06-18 16:53:54.0        1
         18         3 ȸ��3  ��ǰ����     ����̸� ��ǰ�ϰ� �;��   file_t.jpg file.jpg 0     2019-06-18 16:53:55.0        1
      
-- ��ȸ
SELECT custoqusno, diecateno, name, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
WHERE custoqusno=16; 

 CUSTOQUSNO NAME TITLE ASKCONT    THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ---- ----- ---------- ---------- -------- ----- --------------------- --------
          1 ȸ��1  ���ǻ���  ������� �ٲ��ּ��� file_t.jpg file.jpg 0     2019-06-17 16:06:49.0        1

-- ����
UPDATE custo_qus
SET name='ȸ��11', title='��', askcont='dd'
WHERE custoqusno=16;

-- ���� Ȯ��
SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
WHERE custoqusno=16; 

 CUSTOQUSNO GOODSNO MEMNO NAME TITLE ASKCONT    THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ------- ----- ---- ----- ---------- ---------- -------- ----- --------------------- --------
          1       1     1 ȸ��11 ���ǻ���  ������� �ٲ��ּ��� file_t.jpg file.jpg 0     2019-06-04 17:24:22.0        1

-- ����
DELETE FROM custo_qus
WHERE custoqusno=16;

-- ����¡
SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
WHERE custoqusno=6
ORDER BY custoqusno ASC;
 
-- step 2         
SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno, rownum as r
FROM(
         SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno
         FROM custo_qus
         WHERE custoqusno=6
         ORDER BY custoqusno ASC
);
 
-- step 3         
SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno, r
FROM(
         SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno, rownum as r
         FROM(
                  SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno
                           FROM custo_qus
                           WHERE custoqusno=6
                           ORDER BY custoqusno ASC
         )
)
WHERE r >=6 AND r <= 9;

SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno, r
FROM(
         SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno, rownum as r
         FROM(
                  SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno
                  FROM custo_qus
                  WHERE custoqusno=6 AND askcont LIKE '%����%'
                  ORDER BY custoqusno DESC
         )
)
WHERE r >=1 AND r <= 3;


/**********************************/
/* Table Name: ������ �亯 */
/**********************************/
DROP TABLE ctsanswer

CREATE TABLE ctsanswer(
		answerno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		custoqusno                    		NUMBER(10)		 NOT NULL,
		answer                        		VARCHAR2(50)		 NOT NULL,
  FOREIGN KEY (custoqusno) REFERENCES custo_qus (custoqusno)
);

COMMENT ON TABLE ctsanswer is '������ �亯';
COMMENT ON COLUMN ctsanswer.answerno is '�亯��ȣ';
COMMENT ON COLUMN ctsanswer.custoqusno is '�����ǹ�ȣ';
COMMENT ON COLUMN ctsanswer.answer is '�亯';

-- ���
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            1, '����� �����ص�Ƚ��ϴ�.');
            
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            1, '������ �� ���԰� �����Դϴ�.');
 
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            1, '�� �ּҸ� ���� �ֽñ� �ٶ��ϴ�.');
            
            
-- ���
SELECT answerno, custoqusno, answer
FROM ctsanswer
ORDER BY answerno ASC  

 ANSWERNO CUSTOQUSNO ANSWER
 -------- ---------- ------------------
        1          1 ����� �����ص�Ƚ��ϴ�.
        2          1 ������ �� ���԰� �����Դϴ�.
        3          1 �� �ּҸ� ���� �ֽñ� �ٶ��ϴ�.

          
-- ��ȸ
SELECT answerno, custoqusno, answer
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
SELECT answerno, custoqusno, answer
FROM ctsanswer
WHERE answerno=1; 

 ANSWERNO CUSTOQUSNO ANSWER
 -------- ---------- ------------
        1          1 ������� �����߽��ϴ�.


-- ����
DELETE FROM ctsanswer
WHERE answerno=1;


/**********************************/
/* Table Name: ���� */
/**********************************/
DROP TABLE review

CREATE TABLE review(
		reviewno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		goodsno                       		NUMBER(10)		 NULL ,
		thumbs                         		VARCHAR2(1000)		 NULL ,
		files                             VARCHAR2(1000)     NULL ,
		sizes                             VARCHAR2(1000)     NULL ,
		writing                       		VARCHAR2(50)		 NOT NULL,
		grade                         		VARCHAR2(10)		 NOT NULL,
  FOREIGN KEY (goodsno) REFERENCES goods (goodsno)
);

COMMENT ON TABLE review is '����';
COMMENT ON COLUMN review.reviewno is '�����ȣ';
COMMENT ON COLUMN review.goodsno is '��ǰ ��ȣ';
COMMENT ON COLUMN review.thumbs is 'Thumb ����';
COMMENT ON COLUMN review.files is '����';
COMMENT ON COLUMN review.sizes is '����ũ��';
COMMENT ON COLUMN review.writing is '�۸���';
COMMENT ON COLUMN review.grade is '����';

-- ���
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, grade)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            1, 'review_t.jpg', 'review.jpg', 0, '����� ������ ���ƿ�', '4.7');
            
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, grade)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            1, 'review2_t.jpg', 'review2.jpg', 0, '�Ͱ��̰� ������ �ʾƿ�', '4.5');
 
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, grade)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            1, 'review3_t.jpg', 'review3.jpg', 0, '����̰� ������', '4.0');
            
            
-- ���
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade
FROM review
ORDER BY reviewno ASC  

 REVIEWNO GOODSNO THUMBS        FILES       SIZES WRITING      GRADE
 -------- ------- ------------- ----------- ----- ------------ -----
        1       1 review_t.jpg  review.jpg  0     ����� ������ ���ƿ�  4.7
        2       1 review2_t.jpg review2.jpg 0     �Ͱ��̰� ������ �ʾƿ� 4.5
        3       1 review3_t.jpg review3.jpg 0     ����̰� ������     4.0

          
-- ��ȸ
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade
FROM review
WHERE reviewno=1; 

 REVIEWNO GOODSNO PHOTO      WRITING     GRADE
 -------- ------- ---------- ----------- -----
        1       1 review.jpg ����� ������ ���ƿ� 4.7


-- ����
UPDATE review
SET grade='4.2'
WHERE reviewno=1;

-- ���� Ȯ��
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade
FROM review
WHERE reviewno=1; 

 REVIEWNO GOODSNO PHOTO      WRITING     GRADE
 -------- ------- ---------- ----------- -----
        1       1 review.jpg ����� ������ ���ƿ� 4.2


-- ����
DELETE FROM review
WHERE reviewno=1;


/**********************************/
/* Table Name: �������� */
/**********************************/
drop table notice

CREATE TABLE notice(
		noticeno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		diecateno                     		NUMBER(10)		 NOT NULL,
		title                         		VARCHAR2(50)		 NOT NULL,
		content                       		CLOB(4000)		 NOT NULL,
		passwd                        		VARCHAR2(20)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		file                          		VARCHAR2(1000)		 NULL ,
		map                           		VARCHAR2(1024)		 NULL ,
		visit                         		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (diecateno) REFERENCES diecate (diecateno)
);

COMMENT ON TABLE notice is '��������';
COMMENT ON COLUMN notice.noticeno is '�������� ��ȣ';
COMMENT ON COLUMN notice.diecateno is 'ī�װ� ��ȣ';
COMMENT ON COLUMN notice.title is '�������� ����';
COMMENT ON COLUMN notice.content is '�������� ����';
COMMENT ON COLUMN notice.passwd is '��й�ȣ';
COMMENT ON COLUMN notice.rdate is '�����';
COMMENT ON COLUMN notice.file is '�̹��� ����';
COMMENT ON COLUMN notice.map is '����';
COMMENT ON COLUMN notice.visit is '��ȸ��';


/**********************************/
/* Table Name: ȸ�� �α��� ���� */
/**********************************/
CREATE TABLE login(
		logno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memno                         		NUMBER(10)		 NOT NULL,
		id                            		VARCHAR2(50)		 NOT NULL,
		logdate                       		DATE		 NOT NULL,
  FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE login is 'ȸ�� �α��� ����';
COMMENT ON COLUMN login.logno is 'ȸ�� �α��� ���� ��ȣ';
COMMENT ON COLUMN login.memno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN login.id is '���̵�';
COMMENT ON COLUMN login.logdate is 'ȸ�� �α��� ��¥';


