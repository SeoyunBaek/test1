DROP TABLE review

DROP TABLE goods

DELETE FROM review

DELETE FROM goods

--PK 테이블 데이터 추가

INSERT INTO goods(goodsno,
                  diecateno, memno, title, content, price, dcprice, totprice,
                  thumbs, files, sizes, word, visit, visible, rdate)                  
VALUES((SELECT NVL(MAX(goodsno), 0) + 1 as goodsno FROM goods),
            1, 1, '제품명1', '내용1', 15900, 1000, 14900,
            'earring_t.jpg', 'earring.jpg', 0, '귀걸이,악세사리,연예인협찬', 0, 'Y', sysdate);
            
INSERT INTO goods(goodsno,
                  diecateno, memno, title, content, price, dcprice, totprice,
                  thumbs, files, sizes, word, visit, visible, rdate)                  
VALUES((SELECT NVL(MAX(goodsno), 0) + 1 as goodsno FROM goods),
            2, 1, '제품명2', '내용2', 19900, 3000, 16900,
            'earring_t.jpg', 'earring.jpg', 0, '귀걸이,악세사리,연예인협찬', 0, 'Y', sysdate);
            
INSERT INTO goods(goodsno,
                  diecateno, memno, title, content, price, dcprice, totprice,
                  thumbs, files, sizes, word, visit, visible, rdate)                  
VALUES((SELECT NVL(MAX(goodsno), 0) + 1 as goodsno FROM goods),
            3, 1, '제품명3', '내용3', 9900, 0, 9900,
            'earring_t.jpg', 'earring.jpg', 0, '귀걸이,악세사리,연예인협찬', 0, 'Y', sysdate);

SELECT * FROM goods ORDER BY goodsno ASC;

 GOODSNO DIECATENO MEMNO TITLE CONTENT   PRICE DCPRICE TOTPRICE THUMBS        FILES       SIZES WORD           VISIT VISIBLE RDATE
 ------- --------- ----- ----- --------- ----- ------- -------- ------------- ----------- ----- -------------- ----- ------- ---------------------
    1         1     1 제품명1  내용1       15900    1000    14900 earring_t.jpg earring.jpg 0     귀걸이,악세사리,연예인협찬     0 Y       2019-07-04 17:51:26.0
    2         1     1 제품명2  내용2       19900    3000    16900 earring_t.jpg earring.jpg 0     귀걸이,악세사리,연예인협찬     0 Y       2019-07-04 17:51:28.0
    3         1     1 봄귀걸이  봄 시즌 한정판매 11900    2000     9900 earring_t.jpg earring.jpg 1000  귀걸이,악세사리,연예인협찬     0 Y       2019-07-04 17:51:29.0


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

COMMENT ON TABLE review is '리뷰';
COMMENT ON COLUMN review.reviewno is '리뷰번호';
COMMENT ON COLUMN review.goodsno is '상품 번호';
COMMENT ON COLUMN review.thumbs is 'Thumb 파일';
COMMENT ON COLUMN review.files is '파일';
COMMENT ON COLUMN review.sizes is '파일크기';
COMMENT ON COLUMN review.writing is '글리뷰';
COMMENT ON COLUMN review.grade is '평점';
COMMENT ON COLUMN review.rdate is '날짜';

-- 등록
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, grade, rdate)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            1, 'review_t.jpg', 'review.jpg', 0, '배송이 빠르고 좋아요', '4.7', sysdate);
            
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, grade, rdate)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            2, 'review2_t.jpg', 'review2.jpg', 0, '귀걸이가 무겁지 않아요', '4.5', sysdate);
 
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, grade, rdate)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            3, 'review3_t.jpg', 'review3.jpg', 0, '목걸이가 예뻐요', '4.0', sysdate);
            
            
-- 목록
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, rdate
FROM review
ORDER BY reviewno ASC  

 REVIEWNO GOODSNO THUMBS        FILES       SIZES WRITING      GRADE RDATE
 -------- ------- ------------- ----------- ----- ------------ ----- ---------------------
        1       1 review_t.jpg  review.jpg  0     배송이 빠르고 좋아요  4.7   2019-07-04 18:18:30.0
        2       1 review2_t.jpg review2.jpg 0     귀걸이가 무겁지 않아요 4.5   2019-07-04 18:18:31.0
        3       1 review3_t.jpg review3.jpg 0     목걸이가 예뻐요     4.0   2019-07-04 18:18:32.0

          
-- 조회
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, rdate
FROM review
WHERE reviewno=1; 

 REVIEWNO GOODSNO THUMBS       FILES      SIZES WRITING     GRADE RDATE
 -------- ------- ------------ ---------- ----- ----------- ----- ---------------------
        1       1 review_t.jpg review.jpg 0     배송이 빠르고 좋아요 4.7   2019-07-04 18:18:30.0

-- 수정
UPDATE review
SET grade='4.2'
WHERE reviewno=1;

-- 수정 확인
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, rdate
FROM review
WHERE reviewno=1; 

 REVIEWNO GOODSNO THUMBS       FILES      SIZES WRITING     GRADE RDATE
 -------- ------- ------------ ---------- ----- ----------- ----- ---------------------
        1       1 review_t.jpg review.jpg 0     배송이 빠르고 좋아요 4.2   2019-07-04 18:18:30.0

-- 삭제
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
       1 제품명1  배송이 빠르고 좋아요
       2 제품명2  귀걸이가 무겁지 않아요
       3 제품명3  목걸이가 예뻐요







