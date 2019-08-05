/**********************************/
/* Table Name: ä����� */
/**********************************/
DROP TABLE employ

CREATE TABLE employ(
		employno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		diecateno                         NUMBER(10)     NOT NULL,
		title                         		VARCHAR2(50)		 NOT NULL,
		contents                      		VARCHAR2(2000)		 NOT NULL,
		thumbs                            VARCHAR2(1000)     NULL ,
    files                             VARCHAR2(1000)     NULL ,
    sizes                             VARCHAR2(1000)     NULL ,
		id                                VARCHAR2(100)    NOT NULL,
		rdate                         		DATE		 NOT NULL
);

COMMENT ON TABLE employ is 'ä�����';
COMMENT ON COLUMN employ.employno is '�����ȣ';
COMMENT ON COLUMN employ.diecateno is 'ī�װ���ȣ';
COMMENT ON COLUMN employ.title is '������';
COMMENT ON COLUMN employ.contents is '�۳���';
COMMENT ON COLUMN employ.thumbs is '�����';
COMMENT ON COLUMN employ.files is '����';
COMMENT ON COLUMN employ.sizes is '���ϻ�����';
COMMENT ON COLUMN employ.id is '���ٰ���';
COMMENT ON COLUMN employ.rdate is '��¥';

-- ���
INSERT INTO employ(employno, 
                            diecateno, 
                            title, contents, thumbs, files, sizes, id, rdate)
VALUES((SELECT NVL(MAX(employno), 0)+1 as employno FROM employ),
           (SELECT NVL(MAX(diecateno), 0)+1 as diecateno FROM employ),
           'ä�� ����1', '�ڰ� ���: ���伥 ������ ���', 'file_t.jpg', 'file.jpg', 0, 'master', sysdate);

INSERT INTO employ(employno, 
                            diecateno, 
                            title, contents, thumbs, files, sizes, id, rdate)
VALUES((SELECT NVL(MAX(employno), 0)+1 as employno FROM employ),
           (SELECT NVL(MAX(diecateno), 0)+1 as diecateno FROM employ),
           'ä�� ����2', '�ڰ� ���: ���� ������ ���', 'file_t.jpg', 'file.jpg', 0, 'master', sysdate);
            
INSERT INTO employ(employno, 
                            diecateno, 
                            title, contents, thumbs, files, sizes, id, rdate)
VALUES((SELECT NVL(MAX(employno), 0)+1 as employno FROM employ),
           (SELECT NVL(MAX(diecateno), 0)+1 as diecateno FROM employ),
           'ä�� ����3', '�ڰ� ���: �Ϸ���Ʈ ������ ���', 'file_t.jpg', 'file.jpg', 0, 'master', sysdate);

-- ���
SELECT employno, diecateno, title, contents, thumbs, files, sizes, id, rdate
FROM employ
ORDER BY employno ASC  

 EMPLOYNO TITLE  CONTENTS           ID     RDATE
 -------- ------ ------------------ ------ ---------------------
        1 ä�� ����1 �ڰ� ���: ���伥 ������ ���  master 2019-08-01 15:13:59.0
        2 ä�� ����2 �ڰ� ���: ���� ������ ���   master 2019-08-01 15:14:00.0
        3 ä�� ����3 �ڰ� ���: �Ϸ���Ʈ ������ ��� master 2019-08-01 15:14:01.0

-- ��ȸ
SELECT employno, diecateno, title, contents, thumbs, files, sizes, id, rdate
FROM employ
WHERE employno=1; 

 EMPLOYNO TITLE  CONTENTS          ID     RDATE
 -------- ------ ----------------- ------ ---------------------
        1 ä�� ����1 �ڰ� ���: ���伥 ������ ��� master 2019-08-01 15:13:59.0

-- ����
UPDATE employ
SET title='���� ����', contents='���伥 �ڰ��� ������ ������'
WHERE employno=1;

-- ���� Ȯ��
SELECT employno, diecateno, title, contents, thumbs, files, sizes, id, rdate
FROM employ
WHERE employno=1;

 EMPLOYNO DIECATENO TITLE CONTENTS        ID      RDATE
 -------- --------- ----- --------------- ------- ---------------------
        1         1 ���� ���� ���伥 �ڰ��� ������ ������ master1 2019-08-01 15:53:07.0

-- ����
DELETE FROM employ
WHERE employno=1;


