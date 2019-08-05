/**********************************/
/* Table Name: ���� */
/**********************************/
DROP TABLE review

CREATE TABLE review(
    reviewno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    goodsno                           NUMBER(10)     NOT NULL ,
    thumbs                            VARCHAR2(1000)     NULL ,
    files                             VARCHAR2(1000)     NULL ,
    sizes                             VARCHAR2(1000)     NULL ,
    writing                          VARCHAR2(50)     NOT NULL,
    grade                            VARCHAR2(10)     NOT NULL,    
    grpno                           NUMBER(7)               NOT NULL,
    indent                           NUMBER(2)              DEFAULT 0       NOT NULL,
    ansnum                         NUMBER(5)              DEFAULT 0       NOT NULL,
    word                             VARCHAR2(100)           NULL,
    rdate                             DATE                  NOT NULL,
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
COMMENT ON COLUMN review.grpno is '�׷��ȣ';
COMMENT ON COLUMN review.indent is '�亯����';
COMMENT ON COLUMN review.ansnum is '�亯����';
COMMENT ON COLUMN review.word is '�˻���';
COMMENT ON COLUMN review.rdate is '��¥';


ALTER TABLE review
ADD (word VARCHAR2(100));  

-- ���
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, 
                                grade, grpno, 
                                indent, ansnum, word, rdate)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            1, 'review_t.jpg', 'review.jpg', 0, '����� ������ ���ƿ�', 
            '4.7', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM review),
            0, 0, '�Ͱ���,���', sysdate);
            
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, 
                                grade, grpno, 
                                indent, ansnum, word, rdate)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            2, 'review2_t.jpg', 'review2.jpg', 0, '�Ͱ��̰� ������ �ʾƿ�', 
            '4.5', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM review),
            0, 0, '�Ͱ���,���', sysdate);
 
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, 
                                grade, grpno, 
                                indent, ansnum, word, rdate)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            3, 'review3_t.jpg', 'review3.jpg', 0, '����̰� ������', 
            '4.0', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM review),
            0, 0, '�Ͱ���,���', sysdate);
            
            
-- ���
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, grpno, indent, ansnum, word, rdate
FROM review
ORDER BY reviewno ASC  

 REVIEWNO GOODSNO THUMBS        FILES       SIZES WRITING      GRADE GRPNO INDENT ANSNUM WORD   RDATE
 -------- ------- ------------- ----------- ----- ------------ ----- ----- ------ ------ ------ ---------------------
        1       1 review_t.jpg  review.jpg  0     ����� ������ ���ƿ�  4.7       1      0      0 �Ͱ���,��� 2019-07-17 16:55:28.0
        2       2 review2_t.jpg review2.jpg 0     �Ͱ��̰� ������ �ʾƿ� 4.5       2      0      0 �Ͱ���,��� 2019-07-17 16:55:29.0
        3       3 review3_t.jpg review3.jpg 0     ����̰� ������     4.0       3      0      0 �Ͱ���,��� 2019-07-17 16:55:30.0

        
-- ��ȸ
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, grpno, indent, ansnum, word, rdate
FROM review
WHERE reviewno=1; 

 REVIEWNO GOODSNO THUMBS       FILES      SIZES WRITING     GRADE GRPNO INDENT ANSNUM WORD   RDATE
 -------- ------- ------------ ---------- ----- ----------- ----- ----- ------ ------ ------ ---------------------
        1       1 review_t.jpg review.jpg 0     ����� ������ ���ƿ� 4.7       1      0      0 �Ͱ���,��� 2019-07-17 16:55:28.0

-- ����
UPDATE review
SET grade='4.2'
WHERE reviewno=1;

UPDATE review
SET writing='����3'
WHERE reviewno=1;

-- ���� Ȯ��
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, grpno, indent, ansnum, word, rdate
FROM review
WHERE reviewno=1; 

 REVIEWNO GOODSNO THUMBS       FILES      SIZES WRITING     GRADE GRPNO INDENT ANSNUM WORD   RDATE
 -------- ------- ------------ ---------- ----- ----------- ----- ----- ------ ------ ------ ---------------------
        1       1 review_t.jpg review.jpg 0     ����� ������ ���ƿ� 4.2       1      0      0 �Ͱ���,��� 2019-07-17 16:55:28.0

-- ����
DELETE FROM review
WHERE reviewno=1;


-- join
SELECT c.goodsno, c.title,
          t.writing
FROM goods c, review t
WHERE c.goodsno = t.goodsno
ORDER BY c.goodsno ASC, t.reviewno

 GOODSNO TITLE WRITING
 ------- ----- ------------
       1 ��ǰ��1  ����� ������ ���ƿ�
       2 ��ǰ��2  �Ͱ��̰� ������ �ʾƿ�
       3 ��ǰ��3  ����̰� ������


-- �˻�+����¡
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, grpno, indent, ansnum, word, rdate, r
FROM(
         SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, grpno, indent, ansnum, word, rdate, rownum as r
         FROM(
                  SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, grpno, indent, ansnum, word, rdate
                  FROM review
                  WHERE goodsno=1 AND word LIKE '%���%'
                  ORDER BY reviewno DESC
         )
)
WHERE r >=1 AND r <= 3;

 REVIEWNO GOODSNO THUMBS       FILES      SIZES WRITING     GRADE GRPNO INDENT ANSNUM WORD   RDATE                 R
 -------- ------- ------------ ---------- ----- ----------- ----- ----- ------ ------ ------ --------------------- -
        1       1 review_t.jpg review.jpg 0     ����� ������ ���ƿ� 4.2       1      0      0 �Ͱ���,��� 2019-07-17 16:55:28.0 1


