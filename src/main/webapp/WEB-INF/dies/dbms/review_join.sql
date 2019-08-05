DROP TABLE review

DROP TABLE goods

DELETE FROM review

DELETE FROM goods

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
            2, 1, '��ǰ��2', '����2', 19900, 3000, 16900,
            'earring_t.jpg', 'earring.jpg', 0, '�Ͱ���,�Ǽ��縮,����������', 0, 'Y', sysdate);
            
INSERT INTO goods(goodsno,
                  diecateno, memno, title, content, price, dcprice, totprice,
                  thumbs, files, sizes, word, visit, visible, rdate)                  
VALUES((SELECT NVL(MAX(goodsno), 0) + 1 as goodsno FROM goods),
            3, 1, '��ǰ��3', '����3', 9900, 0, 9900,
            'earring_t.jpg', 'earring.jpg', 0, '�Ͱ���,�Ǽ��縮,����������', 0, 'Y', sysdate);

SELECT * FROM goods ORDER BY goodsno ASC;

 GOODSNO DIECATENO MEMNO TITLE CONTENT   PRICE DCPRICE TOTPRICE THUMBS        FILES       SIZES WORD           VISIT VISIBLE RDATE
 ------- --------- ----- ----- --------- ----- ------- -------- ------------- ----------- ----- -------------- ----- ------- ---------------------
    1         1     1 ��ǰ��1  ����1       15900    1000    14900 earring_t.jpg earring.jpg 0     �Ͱ���,�Ǽ��縮,����������     0 Y       2019-07-04 17:51:26.0
    2         1     1 ��ǰ��2  ����2       19900    3000    16900 earring_t.jpg earring.jpg 0     �Ͱ���,�Ǽ��縮,����������     0 Y       2019-07-04 17:51:28.0
    3         1     1 ���Ͱ���  �� ���� �����Ǹ� 11900    2000     9900 earring_t.jpg earring.jpg 1000  �Ͱ���,�Ǽ��縮,����������     0 Y       2019-07-04 17:51:29.0


CREATE TABLE review(
    reviewno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    goodsno                           NUMBER(10)     NULL ,
    thumbs                            VARCHAR2(1000)     NULL ,
    files                             VARCHAR2(1000)     NULL ,
    sizes                             VARCHAR2(1000)     NULL ,
    writing                           VARCHAR2(50)     NOT NULL,
    grade                             VARCHAR2(10)     NOT NULL,
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
COMMENT ON COLUMN review.rdate is '��¥';

-- ���
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, grade, rdate)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            1, 'review_t.jpg', 'review.jpg', 0, '����� ������ ���ƿ�', '4.7', sysdate);
            
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, grade, rdate)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            2, 'review2_t.jpg', 'review2.jpg', 0, '�Ͱ��̰� ������ �ʾƿ�', '4.5', sysdate);
 
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, grade, rdate)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            3, 'review3_t.jpg', 'review3.jpg', 0, '����̰� ������', '4.0', sysdate);
            
            
-- ���
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, rdate
FROM review
ORDER BY reviewno ASC  

 REVIEWNO GOODSNO THUMBS        FILES       SIZES WRITING      GRADE RDATE
 -------- ------- ------------- ----------- ----- ------------ ----- ---------------------
        1       1 review_t.jpg  review.jpg  0     ����� ������ ���ƿ�  4.7   2019-07-04 18:18:30.0
        2       1 review2_t.jpg review2.jpg 0     �Ͱ��̰� ������ �ʾƿ� 4.5   2019-07-04 18:18:31.0
        3       1 review3_t.jpg review3.jpg 0     ����̰� ������     4.0   2019-07-04 18:18:32.0

          
-- ��ȸ
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, rdate
FROM review
WHERE reviewno=1; 

 REVIEWNO GOODSNO THUMBS       FILES      SIZES WRITING     GRADE RDATE
 -------- ------- ------------ ---------- ----- ----------- ----- ---------------------
        1       1 review_t.jpg review.jpg 0     ����� ������ ���ƿ� 4.7   2019-07-04 18:18:30.0

-- ����
UPDATE review
SET grade='4.2'
WHERE reviewno=1;

-- ���� Ȯ��
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, rdate
FROM review
WHERE reviewno=1; 

 REVIEWNO GOODSNO THUMBS       FILES      SIZES WRITING     GRADE RDATE
 -------- ------- ------------ ---------- ----- ----------- ----- ---------------------
        1       1 review_t.jpg review.jpg 0     ����� ������ ���ƿ� 4.2   2019-07-04 18:18:30.0

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







