/**********************************/
/* Table Name: �̺�Ʈ */
/**********************************/
CREATE TABLE event(
    eventno                           NUMBER(10)     NOT NULL    PRIMARY KEY,
    title                             VARCHAR2(50)     NOT NULL,
    contents                          VARCHAR2(2000)     NOT NULL,
    thumbs                            VARCHAR2(1000)     NULL ,
    files                             VARCHAR2(1000)     NULL ,
    sizes                             VARCHAR2(1000)     NULL ,
    rdate                             DATE     NOT NULL,
    word                              VARCHAR2(100)    NULL,
    diecateno                         NUMBER(10)             NOT NULL,
    FOREIGN KEY (diecateno) REFERENCES diecate (diecateno)
);

COMMENT ON TABLE event is '�̺�Ʈ';
COMMENT ON COLUMN event.eventno is '�̺�Ʈ��ȣ';
COMMENT ON COLUMN event.title is '������';
COMMENT ON COLUMN event.contents is '�۳���';
COMMENT ON COLUMN event.thumbs is '�����';
COMMENT ON COLUMN event.files is '����';
COMMENT ON COLUMN event.sizes is '���ϻ�����';
COMMENT ON COLUMN event.rdate is '��¥';
COMMENT ON COLUMN event.word is '�˻���';

-- ���
INSERT INTO event(eventno, 
                          title, contents, 
                          thumbs, files, sizes, rdate, word)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event),
            '���� �̺�Ʈ�� �����մϴ�', '�Ͱ���1 ���� ����', 
            'file_t.jpg', 'file.jpg', 0, sysdate, '�̺�Ʈ,����');

INSERT INTO event(eventno, 
                          title, contents, 
                          thumbs, files, sizes, rdate, word)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event),
            '��ۺ� ���� �̺�Ʈ �ȳ�', '�����ϰ� �����1�� �����Ͻø� ��ۺ� �����Դϴ�', 
            'file_t.jpg', 'file.jpg', 0, sysdate, '�̺�Ʈ,��ۺ�,����');
            
INSERT INTO event(eventno, 
                          title, contents, 
                          thumbs, files, sizes, rdate, word)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event),
            'SNS �̺�Ʈ', 'SNS�� �ı⸦ �ø��� ��÷�� ���� ������ �帳�ϴ�', 
            'file_t.jpg', 'file.jpg', 0, sysdate, '�̺�Ʈ,SNS,�ı�');
 
-- ���
SELECT eventno, title, contents, thumbs, files, sizes, rdate, word
FROM event
ORDER BY eventno ASC  

 EVENTNO TITLE         CONTENTS                     THUMBS     FILES    SIZES RDATE                 WORD
 ------- ------------- ---------------------------- ---------- -------- ----- --------------------- ----------
       1 ���� �̺�Ʈ�� �����մϴ� �Ͱ���1 ���� ����                   file_t.jpg file.jpg 0     2019-07-26 15:46:32.0 �̺�Ʈ,����
       2 ��ۺ� ���� �̺�Ʈ �ȳ� �����ϰ� �����1�� �����Ͻø� ��ۺ� �����Դϴ�  file_t.jpg file.jpg 0     2019-07-26 15:46:33.0 �̺�Ʈ,��ۺ�,����
       3 SNS �̺�Ʈ       SNS�� �ı⸦ �ø��� ��÷�� ���� ������ �帳�ϴ� file_t.jpg file.jpg 0     2019-07-26 15:46:34.0 �̺�Ʈ,SNS,�ı�
  
-- ��ȸ
SELECT eventno, title, contents, thumbs, files, sizes, rdate, word
FROM event
WHERE eventno=1; 

 EVENTNO TITLE         CONTENTS   THUMBS     FILES    SIZES RDATE                 WORD
 ------- ------------- ---------- ---------- -------- ----- --------------------- ------
       1 ���� �̺�Ʈ�� �����մϴ� �Ͱ���1 ���� ���� file_t.jpg file.jpg 0     2019-07-26 15:46:32.0 �̺�Ʈ,����

-- ����
UPDATE event
SET title='���� �̺�Ʈ ����', contents='�����ϰ� �Ͱ���1�� �����Ͻø� 10%�����ص帳�ϴ�.'
WHERE eventno=1;

-- ���� Ȯ��
SELECT eventno, title, contents, thumbs, files, sizes, rdate, word
FROM event
WHERE eventno=1; 

 EVENTNO TITLE     CONTENTS                     THUMBS     FILES    SIZES RDATE                 WORD
 ------- --------- ---------------------------- ---------- -------- ----- --------------------- ------
       1 ���� �̺�Ʈ ���� �����ϰ� �Ͱ���1�� �����Ͻø� 10%�����ص帳�ϴ�. file_t.jpg file.jpg 0     2019-07-26 15:46:32.0 �̺�Ʈ,����

-- ����
DELETE FROM event
WHERE eventno=1;

-- �˻�+����¡
SELECT eventno, title, contents, thumbs, files, sizes, rdate, word, r
FROM(
         SELECT eventno, title, contents, thumbs, files, sizes, rdate, word, rownum as r
         FROM(
                  SELECT eventno, title, contents, thumbs, files, sizes, rdate, word
                  FROM event
                  WHERE eventno=1 AND word LIKE '%�̺�Ʈ%'
                  ORDER BY eventno DESC
         )
)
WHERE r >=1 AND r <= 3;

 EVENTNO TITLE     CONTENTS                     THUMBS     FILES    SIZES RDATE                 WORD   R
 ------- --------- ---------------------------- ---------- -------- ----- --------------------- ------ -
       1 ���� �̺�Ʈ ���� �����ϰ� �Ͱ���1�� �����Ͻø� 10%�����ص帳�ϴ�. file_t.jpg file.jpg 0     2019-07-26 15:46:32.0 �̺�Ʈ,���� 1

SELECT c.diecateno, c.title,
          t.title
FROM diecate c, event t
WHERE c.diecateno = t.diecateno
ORDER BY c.diecateno ASC, t.eventno




