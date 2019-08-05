DELETE FROM goods;

DELETE FROM custo_qus;

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
            1, 1, '제품명2', '내용2', 19900, 3000, 16900,
            'earring_t.jpg', 'earring.jpg', 0, '귀걸이,악세사리,연예인협찬', 0, 'Y', sysdate);
            
INSERT INTO goods(goodsno,
                  diecateno, memno, title, content, price, dcprice, totprice,
                  thumbs, files, sizes, word, visit, visible, rdate)                  
VALUES((SELECT NVL(MAX(goodsno), 0) + 1 as goodsno FROM goods),
            1, 1, '제품명3', '내용3', 9900, 0, 9900,
            'earring_t.jpg', 'earring.jpg', 0, '귀걸이,악세사리,연예인협찬', 0, 'Y', sysdate);
            
            
SELECT * FROM goods ORDER BY goodsno ASC;            


INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, '회원1', '문의사항', '배송지를 바꿔주세요', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, '회원2', '상품문의', '귀걸이3 재입고가 언제인가요', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, '회원3', '반품문의', '목걸이를 반품하고 싶어요', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);


SELECT * FROM goods ORDER BY goodsno ASC;

 GOODSNO DIECATENO MEMNO TITLE CONTENT PRICE DCPRICE TOTPRICE THUMBS        FILES       SIZES WORD           VISIT VISIBLE RDATE
 ------- --------- ----- ----- ------- ----- ------- -------- ------------- ----------- ----- -------------- ----- ------- ---------------------
       1         1     1 제품명1  내용1     15900    1000    14900 earring_t.jpg earring.jpg 0     귀걸이,악세사리,연예인협찬     0 Y       2019-06-13 18:11:07.0
       2         1     1 제품명2  내용2     19900    3000    16900 earring_t.jpg earring.jpg 0     귀걸이,악세사리,연예인협찬     0 Y       2019-06-13 18:11:08.0
       3         1     1 제품명3  내용3      9900       0     9900 earring_t.jpg earring.jpg 0     귀걸이,악세사리,연예인협찬     0 Y       2019-06-13 18:11:09.0



1. 테이블 구조
/**********************************/
/* Table Name: 상품 컨텐츠 */
/**********************************/

-- 테이블 삭제
DROP TABLE goods;
DROP TABLE goods CASCADE CONSTRAINTS;  -- 제약 조건과 함께 무조건 삭제, 비권장

CREATE TABLE goods(
    goodsno                           NUMBER(10)                      NOT NULL    PRIMARY KEY,
    diecateno                          NUMBER(10)                      NOT NULL,
    memno                            NUMBER(10)                       NOT NULL,
    title                                 VARCHAR2(100)                   NOT NULL,
    content                            CLOB                                 NOT NULL,
    price                                NUMBER(10)     DEFAULT 0    NOT NULL,
    dcprice                             NUMBER(10)     DEFAULT 0           NULL ,
    totprice                            NUMBER(10)     DEFAULT 0     NOT NULL,
    thumbs                            VARCHAR2(1000)                         NULL ,
    files                                 VARCHAR2(1000)                         NULL ,
    sizes                                VARCHAR2(1000)                         NULL ,
    word                               VARCHAR2(100)                           NULL,
    visit                                 NUMBER(10)     DEFAULT 0     NOT NULL,
    visible                              CHAR(1)           DEFAULT 'Y'   NOT NULL,
    rdate                               DATE                                  NOT NULL,
    
  FOREIGN KEY (diecateno) REFERENCES diecate (diecateno),
  FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE goods is '상품 컨텐츠';
COMMENT ON COLUMN goods.goodsno is '상품 번호';
COMMENT ON COLUMN goods.diecateno is '카테고리 번호';
COMMENT ON COLUMN goods.memno is '회원 번호';
COMMENT ON COLUMN goods.title is '제목';
COMMENT ON COLUMN goods.content is '내용';
COMMENT ON COLUMN goods.price is '판매가격';
COMMENT ON COLUMN goods.dcprice is '할인가격';
COMMENT ON COLUMN goods.totprice is '결제금액';
COMMENT ON COLUMN goods.thumbs is 'preview 이미지';
COMMENT ON COLUMN goods.files is '파일명';
COMMENT ON COLUMN goods.sizes is '파일크기';
COMMENT ON COLUMN goods.word is '검색어';
COMMENT ON COLUMN goods.visit is '조회수';
COMMENT ON COLUMN goods.visible is '출력모드';
COMMENT ON COLUMN goods.rdate is '등록일';


2. 등록
-- contents 등록
- diecateno 컬럼 1번 기준
- memno 컬럼 1번 기준
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
            1, 1, '제품명2', '내용2', 19900, 3000, 16900,
            'earring_t.jpg', 'earring.jpg', 0, '귀걸이,악세사리,연예인협찬', 0, 'Y', sysdate);
            
INSERT INTO goods(goodsno,
                  diecateno, memno, title, content, price, dcprice, totprice,
                  thumbs, files, sizes, word, visit, visible, rdate)                  
VALUES((SELECT NVL(MAX(goodsno), 0) + 1 as goodsno FROM goods),
            1, 1, '제품명3', '내용3', 9900, 0, 9900,
            'earring_t.jpg', 'earring.jpg', 0, '귀걸이,악세사리,연예인협찬', 0, 'Y', sysdate);
            

3. 목록
-- 전체 목록 (passwd 제외)
SELECT goodsno,
          diecateno, memno, title, content, price, dcprice, totprice
          thumbs, files, sizes, visit, visible, rdate
FROM goods
ORDER BY goodsno DESC;

  GOODSNO DIECATENO MEMNO TITLE CONTENT PRICE DCPRICE THUMBS FILES       SIZES VISIT VISIBLE RDATE
 ------- --------- ----- ----- ------- ----- ------- ------ ----------- ----- ----- ------- ---------------------
       3         1     1 제품명3  내용3      9900       0   9900 earring.jpg 0         0 Y       2019-06-11 18:09:42.0
       2         1     1 제품명2  내용2     19900    3000  16900 earring.jpg 0         0 Y       2019-06-11 18:09:41.0
       1         1     1 제품명1  내용1     15900    1000  14900 earring.jpg 0         0 Y       2019-06-11 18:09:40.0

-- 목록
SELECT goodsno,
          diecateno, memno, title, content, good, thumbs, files, sizes, visit, rdate
FROM goods
ORDER BY goodsno DESC;

 GOODSNO DIECATENO MEMNO TITLE CONTENT GOOD THUMBS        FILES       VISIT RDATE
 ------- --------- ----- ----- ------- ---- ------------- ----------- ----- ---------------------
       3         1     1 제품명3  내용3        0 earring_t.jpg earring.jpg     0 2019-05-29 12:50:15.0
       2         1     1 제품명2  내용2        0 earring_t.jpg earring.jpg     0 2019-05-29 12:50:14.0
       1         1     1 제품명1  내용1        0 earring_t.jpg earring.jpg     0 2019-05-29 12:50:13.0

-- 파일만 출력
SELECT goodsno, thumbs, files, sizes
FROM goods
ORDER BY goodsno DESC;

 GOODSNO THUMBS        FILES
 ------- ------------- -----------
       3 earring_t.jpg earring.jpg
       2 earring_t.jpg earring.jpg
       1 earring_t.jpg earring.jpg


4. 전체 카운트
SELECT COUNT(*) as count
FROM goods;

 COUNT
 -----
     3
     

5. 조회
SELECT goodsno,
          diecateno, memno, title, content, good, thumbs, files, sizes, visit, rdate 
FROM goods
WHERE goodsno = 2; 

 GOODSNO DIECATENO MEMNO TITLE CONTENT GOOD THUMBS        FILES       VISIT RDATE
 ------- --------- ----- ----- ------- ---- ------------- ----------- ----- ---------------------
       2         1     1 제품명2  내용2        0 earring_t.jpg earring.jpg     0 2019-05-29 12:50:14.0
       

6. 수정
UPDATE goods
SET title='봄귀걸이', content='봄 시즌 한정판매',
     price='11900', dcprice='2000', totprice='9900',
     thumbs='earring_t.jpg', files='earring.jpg', sizes=1000
WHERE goodsno = 3;

SELECT goodsno,
          diecateno, memno, title, content, good, thumbs, files, sizes, visit, rdate
FROM goods
ORDER BY goodsno DESC;

 GOODSNO DIECATENO MEMNO TITLE CONTENT   GOOD THUMBS        FILES       VISIT RDATE
 ------- --------- ----- ----- --------- ---- ------------- ----------- ----- ---------------------
       3         1     1 봄귀걸이  봄 시즌 한정판매    0 earring_t.jpg earring.jpg     0 2019-05-29 12:50:15.0
       2         1     1 제품명2  내용2          0 earring_t.jpg earring.jpg     0 2019-05-29 12:50:14.0
       1         1     1 제품명1  내용1          0 earring_t.jpg earring.jpg     0 2019-05-29 12:50:13.0


7. 삭제
-- 모든 레코드 삭제
DELETE FROM goods;

DELETE FROM goods
WHERE goodsno = 1;


8. 검색
-- word LIKE '귀걸이' → word = '귀걸이'
   ^귀걸이
-- word LIKE '%귀걸이' → word = '단델리온 귀걸이'
   .*귀걸이
-- word LIKE '귀걸이%' → word = '귀걸이 1+1 행사'
   ^귀걸이.*
-- word LIKE '%귀걸이%' → word = '디에스타 귀걸이 이벤트'
   .*귀걸이.*
 
-- '귀걸이' 컬럼으로 검색
SELECT goodsno, diecateno, title, content, totprice, 
          thumbs, files, sizes, visit, rdate, word
FROM goods
WHERE diecateno=1 AND word LIKE '%귀걸이%'
 ORDER BY goodsno DESC; 
 
1) 검색 및 전체 레코드 갯수
-- diecateno 컬럼이 1번이며 검색하지 않는 경우 레코드 개수
SELECT COUNT(*) as cnt
FROM goods
WHERE diecateno=1;
 
-- '귀걸이' 검색 레코드 개수
SELECT COUNT(*) as cnt
FROM goods
WHERE diecateno=1 AND word LIKE '%귀걸이%';


9. 페이징
-- step 1
SELECT goodsno, diecateno, title, content, totprice, 
          thumbs, files, sizes,
          visit, rdate, word
FROM goods
WHERE diecateno=1
ORDER BY goodsno DESC;
 
-- step 2         
SELECT goodsno, diecateno, title, content, totprice, 
          thumbs, files, sizes, visit, rdate, word, rownum as r
FROM(
         SELECT goodsno, diecateno, title, content, totprice, 
                   thumbs, files, sizes, visit, rdate, word
          FROM goods
          WHERE diecateno=1
          ORDER BY goodsno DESC
);
 
-- step 3         
SELECT goodsno, diecateno, title, content, totprice, 
          thumbs, files, sizes, visit, rdate, word, r
FROM(
         SELECT goodsno, diecateno, title, content, totprice, 
                   thumbs, files, sizes, visit, rdate, word, rownum as r
         FROM(
                  SELECT goodsno, diecateno, title, content, totprice, 
                            thumbs, files, sizes, visit, rdate, word
                  FROM goods
                  WHERE diecateno=1
                  ORDER BY goodsno DESC            
         )
)
WHERE r >=1 AND r <= 3;
            
-- 검색 + 페이징       
SELECT goodsno, diecateno, title, content, totprice, 
          thumbs, files, sizes, visit, rdate, word, r
FROM(
         SELECT goodsno, diecateno, title, content, totprice, 
                   thumbs, files, sizes, visit, rdate, word, rownum as r
         FROM(
                  SELECT goodsno, diecateno, title, content, totprice, 
                            thumbs, files, sizes, visit, rdate, word
                  FROM goods
                  WHERE diecateno=1 AND word LIKE '%귀걸이%'
                  ORDER BY goodsno DESC
         )
)
WHERE r >=1 AND r <= 3;





/**********************************/
/* Table Name: 고객문의 */
/**********************************/
DROP TABLE custo_qus

CREATE TABLE custo_qus(
    custoqusno                        NUMBER(10)           NOT NULL    PRIMARY KEY,
    goodsno                           NUMBER(10)           NULL ,
    memno                             NUMBER(10)           NOT NULL,
    name                              VARCHAR2(10)           NOT NULL,
    title                                 VARCHAR2(50)           NOT NULL,
    askcont                           VARCHAR2(100)        NOT NULL,
    thumbs                         VARCHAR2(1000)       NULL ,
    files                             VARCHAR2(1000)         NULL ,
    sizes                             VARCHAR2(1000)        NULL ,
    rdate                               DATE                        NOT NULL,
    answerno                          NUMBER(10)          NOT NULL,
  FOREIGN KEY (memno) REFERENCES mem (memno),
  FOREIGN KEY (goodsno) REFERENCES goods (goodsno)
);

COMMENT ON TABLE custo_qus is '고객문의';
COMMENT ON COLUMN custo_qus.custoqusno is '고객문의번호';
COMMENT ON COLUMN custo_qus.goodsno is '상품 번호';
COMMENT ON COLUMN custo_qus.memno is '회원번호';
COMMENT ON COLUMN custo_qus.name is '회원이름';
COMMENT ON COLUMN custo_qus.title is '제목';
COMMENT ON COLUMN custo_qus.askcont is '문의내용';
COMMENT ON COLUMN custo_qus.thumbs is 'Thumb 파일';
COMMENT ON COLUMN custo_qus.files is '파일';
COMMENT ON COLUMN custo_qus.sizes is '파일크기';
COMMENT ON COLUMN custo_qus.rdate is '날짜';
COMMENT ON COLUMN custo_qus.answerno is '답변번호';

-- 등록
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, '회원1', '문의사항', '배송지를 바꿔주세요', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, '회원2', '상품문의', '귀걸이3 재입고가 언제인가요', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, '회원3', '반품문의', '목걸이를 반품하고 싶어요', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
-- 목록
SELECT custoqusno, goodsno, memno, name, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
ORDER BY custoqusno ASC  

 CUSTOQUSNO GOODSNO MEMNO NAME TITLE ASKCONT         THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ------- ----- ---- ----- --------------- ---------- -------- ----- --------------------- --------
          1       1     1 회원1  문의사항  배송지를 바꿔주세요      file_t.jpg file.jpg 0     2019-06-04 17:24:22.0        1
          2       1     1 회원2  상품문의  귀걸이3 재입고가 언제인가요 file_t.jpg file.jpg 0     2019-06-04 17:24:23.0        1
          3       1     1 회원3  반품문의  목걸이를 반품하고 싶어요   file_t.jpg file.jpg 0     2019-06-04 17:24:24.0        1
         
-- 조회
SELECT custoqusno, goodsno, memno, name, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
WHERE custoqusno=1; 

 CUSTOQUSNO GOODSNO MEMNO NAME TITLE ASKCONT    THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ------- ----- ---- ----- ---------- ---------- -------- ----- --------------------- --------
          1       1     1 회원1  문의사항  배송지를 바꿔주세요 file_t.jpg file.jpg 0     2019-06-04 17:24:22.0        1

-- 수정
UPDATE custo_qus
SET name='회원11'
WHERE custoqusno=1;

-- 수정 확인
SELECT custoqusno, goodsno, memno, name, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
WHERE custoqusno=1; 

 CUSTOQUSNO GOODSNO MEMNO NAME TITLE ASKCONT    THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ------- ----- ---- ----- ---------- ---------- -------- ----- --------------------- --------
          1       1     1 회원11 문의사항  배송지를 바꿔주세요 file_t.jpg file.jpg 0     2019-06-04 17:24:22.0        1

-- 삭제
DELETE FROM custo_qus
WHERE custoqusno=1;


  goodsno                           NUMBER(10)                      NOT NULL    PRIMARY KEY,
    diecateno                          NUMBER(10)                      NOT NULL,
    memno                            NUMBER(10)                       NOT NULL,
    title                                 VARCHAR2(100)                   NOT NULL,
    content                            CLOB                                 NOT NULL,
    price                                NUMBER(10)     DEFAULT 0    NOT NULL,
    dcprice                             NUMBER(10)     DEFAULT 0           NULL ,
    totprice                            NUMBER(10)     DEFAULT 0     NOT NULL,
    thumbs                            VARCHAR2(1000)                         NULL ,
    files                                 VARCHAR2(1000)                         NULL ,
    sizes                                VARCHAR2(1000)                         NULL ,
    word                               VARCHAR2(100)                           NULL,
    visit                                 NUMBER(10)     DEFAULT 0     NOT NULL,
    visible                              CHAR(1)           DEFAULT 'Y'   NOT NULL,
    rdate                               DATE                                  NOT NULL,
    


SELECT c.goodsno, c.content,
          t.askcont
FROM goods c, custo_qus t  
WHERE c.goodsno = t.goodsno
ORDER BY c.goodsno ASC, t.custoqusno ASC;

 GOODSNO CONTENT ASKCONT
 ------- ------- ---------------
       1 내용1     배송지를 바꿔주세요
       2 내용2     귀걸이3 재입고가 언제인가요
       3 내용3     목걸이를 반품하고 싶어요





