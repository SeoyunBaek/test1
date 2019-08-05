1. ���̺� ����
/**********************************/
/* Table Name: ī�װ� */
/**********************************/
-- ���̺� ����
DROP TABLE diecate;
DROP TABLE diecate CASCADE CONSTRAINTS;

CREATE TABLE diecate(
    diecateno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    grpno                             NUMBER(10)     NULL ,
    title                             VARCHAR2(50)     NOT NULL,
    seqno                             NUMBER(5)    NOT NULL,
    visible                           CHAR(1)    DEFAULT 'Y'     NOT NULL,
    id                                VARCHAR2(100)    NOT NULL,
    cnt                               NUMBER(10)     DEFAULT 0     NOT NULL,
    rdate                             DATE     NOT NULL,
  FOREIGN KEY (grpno) REFERENCES diecategrp (grpno)
);

COMMENT ON TABLE diecate is 'ī�װ�';
COMMENT ON COLUMN diecate.diecateno is '�Խ��� ��ȣ';
COMMENT ON COLUMN diecate.grpno is 'ī�װ��׷� ��ȣ';
COMMENT ON COLUMN diecate.title is '�Խ��� �̸�';
COMMENT ON COLUMN diecate.seqno is '��¼���';
COMMENT ON COLUMN diecate.visible is '��¸��';
COMMENT ON COLUMN diecate.id is '���ٰ���';
COMMENT ON COLUMN diecate.cnt is '��ϵ� �ڷ��';
COMMENT ON COLUMN diecate.rdate is '�Խ��� ������';


2. ���
INSERT INTO diecate(diecateno, grpno, title, seqno, visible, id, cnt, rdate)
VALUES((SELECT NVL(MAX(diecateno), 0) + 1 as diecateno FROM diecate),
            2, '�Ͱ���', 1, 'Y', 'master', 0, sysdate);
            
INSERT INTO diecate(diecateno, grpno, title, seqno, visible, id, cnt, rdate)
VALUES((SELECT NVL(MAX(diecateno), 0) + 1 as diecateno FROM diecate),
            2, '�����', 2, 'Y', 'master', 0, sysdate);
            
INSERT INTO diecate(diecateno, grpno, title, seqno, visible, id, cnt, rdate)
VALUES((SELECT NVL(MAX(diecateno), 0) + 1 as diecateno FROM diecate),
            2, '����', 3, 'Y', 'master', 0, sysdate);
            
            
3. ���
-- ��¼����� ���� ��ü ���
SELECT diecateno, grpno, title, seqno, visible, id, cnt, rdate
FROM diecate
ORDER BY seqno ASC;

 DIECATENO GRPNO TITLE SEQNO VISIBLE ID     CNT RDATE
 --------- ----- ----- ----- ------- ------ --- ---------------------
         1     2 �Ͱ���       1 Y       master   0 2019-07-17 18:15:55.0
         2     2 �����       2 Y       master   0 2019-07-17 18:15:56.0
         3     2 ����        3 Y       master   0 2019-07-17 18:15:57.0
         
-- Equal(INNER) JOIN
SELECT c.grpno, c.name, c.seqno,
          t.diecateno, t.grpno, t.title, t.seqno as diecate_seqno, t.visible, t.id, t.cnt, t.rdate
FROM diecategrp c, diecate t
WHERE c.grpno = t.grpno
ORDER BY c.grpno ASC, t.seqno ASC;

 GRPNO NAME SEQNO DIECATENO GRPNO TITLE DIECATE_SEQNO VISIBLE ID     CNT RDATE
 ----- ---- ----- --------- ----- ----- ------------- ------- ------ --- ---------------------
     2 ��ǰ       2         1     2 �Ͱ���               1 Y       master   0 2019-07-17 18:15:55.0
     2 ��ǰ       2         2     2 �����               2 Y       master   0 2019-07-17 18:15:56.0
     2 ��ǰ       2         3     2 ����                3 Y       master   0 2019-07-17 18:15:57.0

-- LEFT Outer JOIN
SELECT c.grpno, c.name, c.seqno,
          t.diecateno, t.grpno, t.title, t.seqno as diecate_seqno, t.visible, t.id, t.cnt, t.rdate
FROM diecategrp c, diecate t
WHERE c.grpno = t.grpno(+)
ORDER BY c.grpno ASC, t.seqno ASC;

 GRPNO NAME SEQNO DIECATENO GRPNO TITLE DIECATE_SEQNO VISIBLE ID     CNT  RDATE
 ----- ---- ----- --------- ----- ----- ------------- ------- ------ ---- ---------------------
     1 ��������     1      NULL  NULL NULL           NULL NULL    NULL   NULL NULL
     2 ��ǰ       2         1     2 �Ͱ���               1 Y       master    0 2019-07-17 18:15:55.0
     2 ��ǰ       2         2     2 �����               2 Y       master    0 2019-07-17 18:15:56.0
     2 ��ǰ       2         3     2 ����                3 Y       master    0 2019-07-17 18:15:57.0
     3 Q&A      3      NULL  NULL NULL           NULL NULL    NULL   NULL NULL
     4 ȸ��       4      NULL  NULL NULL           NULL NULL    NULL   NULL NULL

         
4. ��ȸ
SELECT diecateno, grpno, title, seqno, visible, cnt, rdate
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


9. �˻�



10. ����¡
            
            