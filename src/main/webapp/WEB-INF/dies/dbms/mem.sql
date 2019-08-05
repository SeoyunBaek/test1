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
   
ALTER TABLE mem
ADD (cnt NUMBER(6));     
   
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
SET passwd='1234'
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
   
               