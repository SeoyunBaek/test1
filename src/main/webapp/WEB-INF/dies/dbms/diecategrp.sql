1. ���̺� ����
/**********************************/
/* Table Name: ī�װ� �׷� */
/**********************************/
DROP TABLE diecategrp;
DROP TABLE diecategrp CASCADE CONSTRAINTS;

CREATE TABLE diecategrp(
    grpno                             NUMBER(10)     NOT NULL    PRIMARY KEY,
    name                              VARCHAR2(50)     NOT NULL,
    seqno                             NUMBER(5)    DEFAULT 0     NOT NULL,
    visible                           CHAR(1)    DEFAULT 'Y'     NOT NULL,
    rdate                             DATE     NOT NULL
);

COMMENT ON TABLE diecategrp is 'ī�װ� �׷�';
COMMENT ON COLUMN diecategrp.grpno is 'ī�װ��׷� ��ȣ';
COMMENT ON COLUMN diecategrp.name is 'ī�װ��׷� �̸�';
COMMENT ON COLUMN diecategrp.seqno is '��¼���';
COMMENT ON COLUMN diecategrp.visible is '��¸��';
COMMENT ON COLUMN diecategrp.rdate is '�׷� ������';


2. ���
- classification: 1-notice, 2-goods, 3-Q&A
- visible: Y, N

INSERT INTO diecategrp(grpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM diecategrp),
            '��������', 1, 'Y', sysdate);

INSERT INTO diecategrp(grpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM diecategrp),
            '��ǰ', 2, 'Y', sysdate);

INSERT INTO diecategrp(grpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM diecategrp),
            'Q&A', 3, 'Y', sysdate);
            
INSERT INTO diecategrp(grpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM diecategrp),
            'ȸ��', 4, 'N', sysdate);
            
 
3. ���
-- grpno ����
SELECT grpno, name, seqno, visible, TO_CHAR(rdate, 'YYYY-MM-DD hh:mi:ss') as rdate
FROM diecategrp
ORDER BY grpno ASC;

 GRPNO NAME SEQNO VISIBLE RDATE
 ----- ---- ----- ------- -------------------
     1 ��������     1 Y       2019-07-17 05:52:48
     2 ��ǰ       2 Y       2019-07-17 05:52:49
     3 Q&A      3 Y       2019-07-17 05:52:50
     4 ȸ��       4 N       2019-07-17 05:52:51


-- ��� ���������� ��ü ���
SELECT grpno, name, seqno, visible, rdate
FROM diecategrp
ORDER BY seqno ASC;


4. ��ȸ
SELECT grpno, name, seqno, visible, rdate 
FROM diecategrp
WHERE grpno = 1;

 GRPNO NAME SEQNO VISIBLE RDATE
 ----- ---- ----- ------- ---------------------
     1 ��������     1 Y       2019-07-17 17:52:48.0

         
5.  ����
UPDATE diecategrp
SET name='�̺�Ʈ', seqno = 4, visible='Y'
WHERE grpno = 1;

SELECT grpno, name, seqno, visible, rdate 
FROM diecategrp
ORDER BY grpno ASC;

 GRPNO NAME SEQNO VISIBLE RDATE
 ----- ---- ----- ------- ---------------------
     1 �̺�Ʈ      4 Y       2019-07-17 17:52:48.0
     2 ��ǰ       2 Y       2019-07-17 17:52:49.0
     3 Q&A      3 Y       2019-07-17 17:52:50.0
     4 ȸ��       4 N       2019-07-17 17:52:51.0


6. ����
-- ��� ���ڵ� ����
DELETE FROM diecategrp;

DELETE FROM diecategrp
WHERE grpno = 1;

SELECT grpno, name, seqno, visible, rdate 
FROM diecategrp
ORDER BY grpno ASC;

 GRPNO NAME SEQNO VISIBLE RDATE
 ----- ---- ----- ------- ---------------------
     2 ��ǰ       2 Y       2019-07-17 17:52:49.0
     3 Q&A      3 Y       2019-07-17 17:52:50.0
     4 ȸ��       4 N       2019-07-17 17:52:51.0

-- ��� ���� ����, 10 -> 1
UPDATE diecategrp
SET seqno = seqno - 1
WHERE grpno=1;

-- ��¼��� ����, 1 -> 10
UPDATE diecategrp
SET seqno = seqno + 1
WHERE grpno=1;

-- ��� ���������� ��ü ���
SELECT grpno, name, seqno
FROM diecategrp
ORDER BY seqno ASC;
 
 GRPNO NAME SEQNO
 ----- ---- -----
     2 ��ǰ       2
     3 Q&A      3
     4 ȸ��       4

          
8) �˻�

         
9) ����¡