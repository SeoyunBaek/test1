/**********************************/
/* Table Name: 리뷰 */
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

COMMENT ON TABLE review is '리뷰';
COMMENT ON COLUMN review.reviewno is '리뷰번호';
COMMENT ON COLUMN review.goodsno is '상품 번호';
COMMENT ON COLUMN review.thumbs is 'Thumb 파일';
COMMENT ON COLUMN review.files is '파일';
COMMENT ON COLUMN review.sizes is '파일크기';
COMMENT ON COLUMN review.writing is '글리뷰';
COMMENT ON COLUMN review.grade is '평점';
COMMENT ON COLUMN review.grpno is '그룹번호';
COMMENT ON COLUMN review.indent is '답변차수';
COMMENT ON COLUMN review.ansnum is '답변순서';
COMMENT ON COLUMN review.word is '검색어';
COMMENT ON COLUMN review.rdate is '날짜';


ALTER TABLE review
ADD (word VARCHAR2(100));  

-- 등록
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, 
                                grade, grpno, 
                                indent, ansnum, word, rdate)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            1, 'review_t.jpg', 'review.jpg', 0, '배송이 빠르고 좋아요', 
            '4.7', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM review),
            0, 0, '귀걸이,배송', sysdate);
            
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, 
                                grade, grpno, 
                                indent, ansnum, word, rdate)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            2, 'review2_t.jpg', 'review2.jpg', 0, '귀걸이가 무겁지 않아요', 
            '4.5', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM review),
            0, 0, '귀걸이,배송', sysdate);
 
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, 
                                grade, grpno, 
                                indent, ansnum, word, rdate)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            3, 'review3_t.jpg', 'review3.jpg', 0, '목걸이가 예뻐요', 
            '4.0', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM review),
            0, 0, '귀걸이,배송', sysdate);
            
            
-- 목록
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, grpno, indent, ansnum, word, rdate
FROM review
ORDER BY reviewno ASC  

 REVIEWNO GOODSNO THUMBS        FILES       SIZES WRITING      GRADE GRPNO INDENT ANSNUM WORD   RDATE
 -------- ------- ------------- ----------- ----- ------------ ----- ----- ------ ------ ------ ---------------------
        1       1 review_t.jpg  review.jpg  0     배송이 빠르고 좋아요  4.7       1      0      0 귀걸이,배송 2019-07-17 16:55:28.0
        2       2 review2_t.jpg review2.jpg 0     귀걸이가 무겁지 않아요 4.5       2      0      0 귀걸이,배송 2019-07-17 16:55:29.0
        3       3 review3_t.jpg review3.jpg 0     목걸이가 예뻐요     4.0       3      0      0 귀걸이,배송 2019-07-17 16:55:30.0

        
-- 조회
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, grpno, indent, ansnum, word, rdate
FROM review
WHERE reviewno=1; 

 REVIEWNO GOODSNO THUMBS       FILES      SIZES WRITING     GRADE GRPNO INDENT ANSNUM WORD   RDATE
 -------- ------- ------------ ---------- ----- ----------- ----- ----- ------ ------ ------ ---------------------
        1       1 review_t.jpg review.jpg 0     배송이 빠르고 좋아요 4.7       1      0      0 귀걸이,배송 2019-07-17 16:55:28.0

-- 수정
UPDATE review
SET grade='4.2'
WHERE reviewno=1;

UPDATE review
SET writing='리뷰3'
WHERE reviewno=1;

-- 수정 확인
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, grpno, indent, ansnum, word, rdate
FROM review
WHERE reviewno=1; 

 REVIEWNO GOODSNO THUMBS       FILES      SIZES WRITING     GRADE GRPNO INDENT ANSNUM WORD   RDATE
 -------- ------- ------------ ---------- ----- ----------- ----- ----- ------ ------ ------ ---------------------
        1       1 review_t.jpg review.jpg 0     배송이 빠르고 좋아요 4.2       1      0      0 귀걸이,배송 2019-07-17 16:55:28.0

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


-- 검색+페이징
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, grpno, indent, ansnum, word, rdate, r
FROM(
         SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, grpno, indent, ansnum, word, rdate, rownum as r
         FROM(
                  SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade, grpno, indent, ansnum, word, rdate
                  FROM review
                  WHERE goodsno=1 AND word LIKE '%배송%'
                  ORDER BY reviewno DESC
         )
)
WHERE r >=1 AND r <= 3;

 REVIEWNO GOODSNO THUMBS       FILES      SIZES WRITING     GRADE GRPNO INDENT ANSNUM WORD   RDATE                 R
 -------- ------- ------------ ---------- ----- ----------- ----- ----- ------ ------ ------ --------------------- -
        1       1 review_t.jpg review.jpg 0     배송이 빠르고 좋아요 4.2       1      0      0 귀걸이,배송 2019-07-17 16:55:28.0 1


