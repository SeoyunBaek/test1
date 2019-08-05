DELETE FROM goods;

DELETE FROM custo_qus;

--PK ���̺� ������ �߰�

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
            
            
SELECT * FROM mem ORDER BY memno ASC;            


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



/**********************************/
/* Table Name: ������ */
/**********************************/
DROP TABLE custo_qus

CREATE TABLE custo_qus(
    custoqusno                        NUMBER(10)           NOT NULL    PRIMARY KEY,
    goodsno                           NUMBER(10)           NULL ,
    memno                             NUMBER(10)           NOT NULL,
    title                                 VARCHAR2(50)           NOT NULL,
    askcont                           VARCHAR2(100)        NOT NULL,
    thumbs                         VARCHAR2(1000)       NULL ,
    files                             VARCHAR2(1000)         NULL ,
    sizes                             VARCHAR2(1000)        NULL ,
    rdate                               DATE                        NOT NULL,
    answerno                          NUMBER(10)          NOT NULL,
  FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE custo_qus is '������';
COMMENT ON COLUMN custo_qus.custoqusno is '�����ǹ�ȣ';
COMMENT ON COLUMN custo_qus.goodsno is '��ǰ ��ȣ';
COMMENT ON COLUMN custo_qus.memno is 'ȸ����ȣ';
COMMENT ON COLUMN custo_qus.title is '����';
COMMENT ON COLUMN custo_qus.askcont is '���ǳ���';
COMMENT ON COLUMN custo_qus.thumbs is 'Thumb ����';
COMMENT ON COLUMN custo_qus.files is '����';
COMMENT ON COLUMN custo_qus.sizes is '����ũ��';
COMMENT ON COLUMN custo_qus.rdate is '��¥';
COMMENT ON COLUMN custo_qus.answerno is '�亯��ȣ';

-- ���
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, '���ǻ���', '������� �ٲ��ּ���', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, '��ǰ����', '�Ͱ���3 ���԰� �����ΰ���', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, '��ǰ����', '����̸� ��ǰ�ϰ� �;��', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
-- ���
SELECT custoqusno, goodsno, memno, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
ORDER BY custoqusno ASC  

 CUSTOQUSNO GOODSNO MEMNO NAME TITLE ASKCONT         THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ------- ----- ---- ----- --------------- ---------- -------- ----- --------------------- --------
          1       1     1 ȸ��1  ���ǻ���  ������� �ٲ��ּ���      file_t.jpg file.jpg 0     2019-06-04 17:24:22.0        1
          2       1     1 ȸ��2  ��ǰ����  �Ͱ���3 ���԰� �����ΰ��� file_t.jpg file.jpg 0     2019-06-04 17:24:23.0        1
          3       1     1 ȸ��3  ��ǰ����  ����̸� ��ǰ�ϰ� �;��   file_t.jpg file.jpg 0     2019-06-04 17:24:24.0        1
         
-- ��ȸ
SELECT custoqusno, goodsno, memno, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
WHERE custoqusno=1; 

 CUSTOQUSNO GOODSNO MEMNO NAME TITLE ASKCONT    THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ------- ----- ---- ----- ---------- ---------- -------- ----- --------------------- --------
          1       1     1 ȸ��1  ���ǻ���  ������� �ٲ��ּ��� file_t.jpg file.jpg 0     2019-06-04 17:24:22.0        1

-- ����
UPDATE custo_qus
SET title='����'
WHERE custoqusno=1;

-- ���� Ȯ��
SELECT custoqusno, goodsno, memno, title, askcont, thumbs, files, sizes, rdate, answerno
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
    


SELECT c.memno, c.name,
          t.askcont
FROM mem c, custo_qus t  
WHERE c.memno = t.memno
ORDER BY c.memno ASC, t.custoqusno ASC;

 MEMNO NAME ASKCONT
 ----- ---- ---------------
     1 ������  ������� �ٲ��ּ���
     2 ������  �Ͱ���3 ���԰� �����ΰ���
     3 �ڼ���  ����̸� ��ǰ�ϰ� �;��





