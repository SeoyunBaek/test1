/**********************************/
/* Table Name: �̺�Ʈ */
/**********************************/
DROP TABLE event

CREATE TABLE event(
    eventno                           NUMBER(10)     NOT NULL    PRIMARY KEY,
    diecateno                           NUMBER(10)     NOT NULL,
    title                             VARCHAR2(50)     NOT NULL,
    contents                          VARCHAR2(2000)     NOT NULL,
    thumbs                            VARCHAR2(1000)     NULL ,
    files                             VARCHAR2(1000)     NULL ,
    sizes                             VARCHAR2(1000)     NULL ,
    rdate                             DATE     NOT NULL,
    word                              VARCHAR2(100)    NULL,
    seqno                             NUMBER(5)    DEFAULT 0     NOT NULL,
    visible                           CHAR(1)    DEFAULT 'Y'     NOT NULL,
    id                                VARCHAR2(100)    NOT NULL,
    cnt                               NUMBER(10)     DEFAULT 0     NOT NULL
    --FOREIGN KEY (diecateno) REFERENCES diecate (diecateno)
);

COMMENT ON TABLE event is '�̺�Ʈ';
COMMENT ON COLUMN event.eventno is '�̺�Ʈ��ȣ';
COMMENT ON COLUMN event.diecateno is 'ī�װ���ȣ';
COMMENT ON COLUMN event.title is '������';
COMMENT ON COLUMN event.contents is '�۳���';
COMMENT ON COLUMN event.thumbs is '�����';
COMMENT ON COLUMN event.files is '����';
COMMENT ON COLUMN event.sizes is '���ϻ�����';
COMMENT ON COLUMN event.rdate is '��¥';
COMMENT ON COLUMN event.word is '�˻���';
COMMENT ON COLUMN event.seqno is '��¼���';
COMMENT ON COLUMN event.visible is '��¸��';
COMMENT ON COLUMN event.id is '���ٰ���';
COMMENT ON COLUMN event.cnt is '��ϵ� �ڷ��';

-- ���
INSERT INTO event(eventno,
                          diecateno, 
                          title, contents, 
                          thumbs, files, sizes, rdate, word,
                          seqno, visible, id, cnt)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event),
           (SELECT NVL(MAX(diecateno), 0)+1 as diecateno FROM event),
            '���� �̺�Ʈ�� �����մϴ�', '�Ͱ���1 ���� ����', 
            'file_t.jpg', 'file.jpg', 0, sysdate, '�̺�Ʈ,����',
            2, 'Y', 'master',0);

INSERT INTO event(eventno,
                          diecateno, 
                          title, contents, 
                          thumbs, files, sizes, rdate, word,
                          seqno, visible, id, cnt)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event),
           (SELECT NVL(MAX(diecateno), 0)+1 as diecateno FROM event),
            '��ۺ� ���� �̺�Ʈ �ȳ�', '�����ϰ� �����1�� �����Ͻø� ��ۺ� �����Դϴ�', 
            'file_t.jpg', 'file.jpg', 0, sysdate, '�̺�Ʈ,��ۺ�,����',
            2, 'Y', 'master', 0);

INSERT INTO event(eventno,
                          diecateno, 
                          title, contents, 
                          thumbs, files, sizes, rdate, word,
                          seqno, visible, id, cnt)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event),
           (SELECT NVL(MAX(diecateno), 0)+1 as diecateno FROM event),
            'SNS �̺�Ʈ', 'SNS�� �ı⸦ �ø��� ��÷�� ���� ������ �帳�ϴ�', 
            'file_t.jpg', 'file.jpg', 0, sysdate, '�̺�Ʈ,SNS,�ı�',
            2, 'Y', 'master',0);

-- ���
SELECT eventno, diecateno, title, contents, thumbs, files, sizes, rdate, word, seqno, visible, id, cnt
FROM event
ORDER BY eventno ASC  

 EVENTNO DIECATENO TITLE         CONTENTS                     THUMBS     FILES    SIZES RDATE                 WORD       SEQNO VISIBLE ID     CNT
 ------- --------- ------------- ---------------------------- ---------- -------- ----- --------------------- ---------- ----- ------- ------ ---
       1         1 ���� �̺�Ʈ�� �����մϴ� �Ͱ���1 ���� ����                   file_t.jpg file.jpg 0     2019-07-30 18:06:30.0 �̺�Ʈ,����         2 Y       master   0
       2         2 ��ۺ� ���� �̺�Ʈ �ȳ� �����ϰ� �����1�� �����Ͻø� ��ۺ� �����Դϴ�  file_t.jpg file.jpg 0     2019-07-30 18:06:31.0 �̺�Ʈ,��ۺ�,����     2 Y       master   0
       3         3 SNS �̺�Ʈ       SNS�� �ı⸦ �ø��� ��÷�� ���� ������ �帳�ϴ� file_t.jpg file.jpg 0     2019-07-30 18:06:32.0 �̺�Ʈ,SNS,�ı�     2 Y       master   0

-- ��ȸ
SELECT eventno, diecateno, title, contents, thumbs, files, sizes, rdate, word, seqno, visible, id, cnt
FROM event
WHERE eventno=1; 

 EVENTNO DIECATENO TITLE         CONTENTS   THUMBS     FILES    SIZES RDATE                 WORD   SEQNO VISIBLE ID     CNT
 ------- --------- ------------- ---------- ---------- -------- ----- --------------------- ------ ----- ------- ------ ---
       1         1 ���� �̺�Ʈ�� �����մϴ� �Ͱ���1 ���� ���� file_t.jpg file.jpg 0     2019-07-30 18:06:30.0 �̺�Ʈ,����     2 Y       master   0

-- ����
UPDATE event
SET title='���� �̺�Ʈ ����', contents='�����ϰ� �Ͱ���1�� �����Ͻø� 10%�����ص帳�ϴ�.'
WHERE eventno=1;

-- ���� Ȯ��
SELECT eventno, diecateno, title, contents, thumbs, files, sizes, rdate, word, seqno, visible, id, cnt
FROM event
WHERE eventno=1; 

 EVENTNO DIECATENO TITLE     CONTENTS                     THUMBS     FILES    SIZES RDATE                 WORD   SEQNO VISIBLE ID     CNT
 ------- --------- --------- ---------------------------- ---------- -------- ----- --------------------- ------ ----- ------- ------ ---
       1         1 ���� �̺�Ʈ ���� �����ϰ� �Ͱ���1�� �����Ͻø� 10%�����ص帳�ϴ�. file_t.jpg file.jpg 0     2019-07-30 18:06:30.0 �̺�Ʈ,����     2 Y       master   0

-- ����
DELETE FROM event
WHERE eventno=1;
DELETE FROM event
WHERE eventno=2;
DELETE FROM event
WHERE eventno=3;

-- �˻�+����¡
SELECT eventno, diecateno, title, contents, thumbs, files, sizes, rdate, word, seqno, visible, id, cnt, r
FROM(
         SELECT eventno, diecateno, title, contents, thumbs, files, sizes, rdate, word, seqno, visible, id, cnt, rownum as r
         FROM(
                  SELECT eventno, diecateno, title, contents, thumbs, files, sizes, rdate, word, seqno, visible, id, cnt
                  FROM event
                  WHERE diecateno=1 AND word LIKE '%�̺�Ʈ%'
                  ORDER BY eventno DESC
         )
)
WHERE r >=1 AND r <= 3;

 EVENTNO DIECATENO TITLE     CONTENTS                     THUMBS     FILES    SIZES RDATE                 WORD   SEQNO VISIBLE ID     CNT R
 ------- --------- --------- ---------------------------- ---------- -------- ----- --------------------- ------ ----- ------- ------ --- -
       1         1 ���� �̺�Ʈ ���� �����ϰ� �Ͱ���1�� �����Ͻø� 10%�����ص帳�ϴ�. file_t.jpg file.jpg 0     2019-07-30 18:06:30.0 �̺�Ʈ,����     2 Y       master   0 1


       
SELECT c.diecateno, c.title,
          t.contents
FROM diecate c, event t
WHERE c.diecateno = t.diecateno
ORDER BY c.diecateno ASC, t.eventno
       
 DIECATENO TITLE  CONTENTS
 --------- ------ ----------------------------
         1 �Ͱ���    �����ϰ� �Ͱ���1�� �����Ͻø� 10%�����ص帳�ϴ�.
         2 �����/��Ŀ �����ϰ� �����1�� �����Ͻø� ��ۺ� �����Դϴ�
         3 ����     SNS�� �ı⸦ �ø��� ��÷�� ���� ������ �帳�ϴ�


       
       
       

-- Equal(INNER) JOIN
SELECT c.grpno, c.name, c.seqno,
          t.eventno, t.grpno, t.title, t.seqno as diecate_seqno, t.visible, t.id, t.cnt, t.rdate
FROM diecategrp c, event t
WHERE c.grpno = t.grpno
ORDER BY c.grpno ASC, t.seqno ASC;
-- �߰� �� ���� : grpno, seqno, visible, id, cnt
SELECT c.grpno, c.name, c.seqno,
          t.diecateno, t.grpno, t.title, t.seqno as diecate_seqno, t.visible, t.id, t.cnt, t.rdate

 GRPNO NAME SEQNO EVENTNO GRPNO TITLE         DIECATE_SEQNO VISIBLE ID     CNT RDATE
 ----- ---- ----- ------- ----- ------------- ------------- ------- ------ --- ---------------------
     1 �̺�Ʈ      4       3     1 SNS �̺�Ʈ                   2 Y       master   0 2019-07-29 17:54:40.0
     1 �̺�Ʈ      4       1     1 ���� �̺�Ʈ ����                 2 Y       master   0 2019-07-29 17:54:38.0
     1 �̺�Ʈ      4       2     1 ��ۺ� ���� �̺�Ʈ �ȳ�             2 Y       master   0 2019-07-29 17:54:39.0


-- LEFT Outer JOIN
SELECT c.grpno, c.name, c.seqno,
          t.eventno, t.grpno, t.title, t.seqno as diecate_seqno, t.visible, t.id, t.cnt, t.rdate
FROM diecategrp c, event t
WHERE c.grpno = t.grpno(+)
ORDER BY c.grpno ASC, t.seqno ASC;

 GRPNO NAME SEQNO EVENTNO GRPNO TITLE         DIECATE_SEQNO VISIBLE ID     CNT  RDATE
 ----- ---- ----- ------- ----- ------------- ------------- ------- ------ ---- ---------------------
     1 �̺�Ʈ      4       1     1 ���� �̺�Ʈ ����                 2 Y       master    0 2019-07-29 17:54:38.0
     1 �̺�Ʈ      4       2     1 ��ۺ� ���� �̺�Ʈ �ȳ�             2 Y       master    0 2019-07-29 17:54:39.0
     1 �̺�Ʈ      4       3     1 SNS �̺�Ʈ                   2 Y       master    0 2019-07-29 17:54:40.0
     2 ��ǰ       2    NULL  NULL NULL                   NULL NULL    NULL   NULL NULL
     3 Q&A      3    NULL  NULL NULL                   NULL NULL    NULL   NULL NULL
     4 ȸ��       4    NULL  NULL NULL                   NULL NULL    NULL   NULL NULL



