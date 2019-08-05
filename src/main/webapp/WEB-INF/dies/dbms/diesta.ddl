/**********************************/
/* Table Name: 회원 */
/**********************************/
DROP TABLE mem

<회원 테이블>
1. 테이블 구조
 
DROP TABLE mem; 
 
CREATE TABLE mem (
  memno             NUMBER(10)     NOT NULL, -- 회원 번호 
  id                    VARCHAR(50)     NOT NULL, -- 아이디
  passwd            VARCHAR(50)     NOT NULL, -- 비밀번호   
  name               VARCHAR(50)     NOT NULL, -- 이름 
  zipcode            VARCHAR(50)     NULL, -- 우편번호
  address1          VARCHAR(50)     NULL, -- 기본 주소
  address2          VARCHAR(50)     NULL, -- 상세 주소
  phone              VARCHAR(50)     NOT NULL, -- 휴대 전화
  email               VARCHAR(50)    UNIQUE NOT NULL, -- 이메일
  act                   CHAR(1)            DEFAULT 'N' NULL, -- M: 마스터, Y: 로그인 가능, N: 로그인 불가, C: 탈퇴
  PRIMARY KEY (memno)                
); 

COMMENT ON TABLE mem is '회원';
COMMENT ON COLUMN mem.memno is '회원 번호';
COMMENT ON COLUMN mem.id is '아이디';
COMMENT ON COLUMN mem.passwd is '비밀 번호';
COMMENT ON COLUMN mem.name is '이름';
COMMENT ON COLUMN mem.zipcode is '우편 번호';
COMMENT ON COLUMN mem.address1 is '기본 주소';
COMMENT ON COLUMN mem.address2 is '상세 주소';
COMMENT ON COLUMN mem.phone is '휴대 전화';
COMMENT ON COLUMN mem.email is '이메일';
COMMENT ON COLUMN mem.act is '등급'; 
 
2. 회원 가입
   DELETE FROM mem; 
   
1) id 중복 확인
SELECT COUNT(id) as cnt
FROM mem
WHERE id='회원1';

CNT
 ---
   1
   
2)   -- 관리용 회원 기준
INSERT INTO mem(memno, id, passwd, name, zipcode, address1, address2, phone, email, act)
VALUES ((SELECT NVL(MAX(memno), 0)+1 as memno FROM mem),
'master1', '123', '박지영',  '12345', '서울시 종로구', '관철동', '000-1234-0000', 'master1@gmail.com', 'M');
 
INSERT INTO mem(memno, id, passwd, name, zipcode, address1, address2, phone, email, act)
VALUES ((SELECT NVL(MAX(memno), 0)+1 as memno FROM mem),
'master2', '123', '최지원',  '12345', '인천시 동구 ', '만석동', '000-5678-0000', 'master2@gmail.com', 'M');

-- 개인 회원 기준
   INSERT INTO mem(memno, id, passwd, name, zipcode, address1, address2, phone, email, act)   
   VALUES((SELECT NVL(MAX(memno), 0)+1 as memno FROM mem), 'mem1', '123', '박수영', '12345', '서울시 종로구 관철동', '13-13', 
               '010-0000-0000', 'cust1@gmail.com', 'Y');
               
   INSERT INTO mem(memno, id, passwd, name, zipcode, address1, address2, phone, email, act)   
   VALUES((SELECT NVL(MAX(memno), 0)+1 as memno FROM mem), 'mem2', '123', '홍길동', '12345', '서울시 서대문구', '14-14', 
               '010-1111-0000', 'cust2@gmail.com', 'Y'); 
               
   INSERT INTO mem(memno, id, passwd, name, zipcode, address1, address2, phone, email, act)   
   VALUES((SELECT NVL(MAX(memno), 0)+1 as memno FROM mem), 'mem3', '123', '정수정', '12345', '서울시 용산구', '15-15', 
               '010-2222-0000', 'cust3@gmail.com', 'Y');
               
   INSERT INTO mem(memno, id, passwd, name, zipcode, address1, address2, phone, email, act)   
   VALUES((SELECT NVL(MAX(memno), 0)+1 as memno FROM mem), 'mem4', '123', '김도영', '12345', '서울시 노원구', '16-16', 
               '010-3333-0000', 'cust4@gmail.com', 'N');           
 
 
3. 목록

1)회원 전체 목록
   SELECT memno, id, passwd, name, zipcode, address1, address2, phone, email, act
   FROM mem
   ORDER BY memno ASC;
   
 MEMNO ID      PASSWD NAME ZIPCODE ADDRESS1    ADDRESS2 PHONE         EMAIL             ACT
 ----- ------- ------ ---- ------- ----------- -------- ------------- ----------------- ---
     1 master1 123    박지영  12345   서울시 종로구     관철동      000-1234-0000 master1@gmail.com M
     2 master2 123    최지원  12345   인천시 동구      만석동      000-5678-0000 master2@gmail.com M
     3 mem1    123    박수영  12345   서울시 종로구 관철동 13-13    010-0000-0000 cust1@gmail.com   Y
     4 mem2    123    홍길동  12345   서울시 서대문구    14-14    010-1111-0000 cust2@gmail.com   Y
     5 mem3    123    정수정  12345   서울시 용산구     15-15    010-2222-0000 cust3@gmail.com   Y
     6 mem4    123    김도영  12345   서울시 노원구     16-16    010-3333-0000 cust4@gmail.com   N

4. 회원 정보 조회 
   SELECT memno, id, passwd, name, zipcode, address1, address2, phone, email
   FROM mem
   WHERE memno = 1;

5. 패스워드 변경
1) 기존 패스워드 검사
- DAO: public int countPasswd(int memno, String passwd){ ... }
SELECT count(*) as cnt
FROM mem
WHERE memno = 1 AND passwd='123';
 
2) 패스워드 변경
- DAO: public int updatePasswd(int memno, String passwd){ ... }
UPDATE mem
SET passwd=''
WHERE memno=1;
 
 
6.  회원 정보 수정 

UPDATE mem
SET name = '김수연' zipcode='56789', address1='서울시 성북구', address2='9-11', 
      phone='010-9677-7789'
WHERE memno=1;      

2) 권한의 변경(admin4DAO: int updateAct(int admin4no, String act))
UPDATE mem 
SET  act='Y'
WHERE memno=6; 

3) 회원 탈퇴
UPDATE mem
SET zipcode='', address1='', address2=''
WHERE memno = 1;


7. 'mem' 회원 삭제 
DELETE FROM mem;
 
DELETE FROM mem
WHERE memno = 4;
   
8. 검색된 전체 레코드 수
   - LIKE    : 정확하게 일치하지 않아도 출력 
   - =(equal): 정확하게 일치해야 출력 
   - 검색을 하지 않는 경우, 전체 목록 출력 
 
      
9. 검색 목록(S:Search List)  
 
 
10. 페이징
   - 목록은 페이징 구현을 필수로 합니다.
   
11. 로그인
SELECT COUNT(memno) as cnt
FROM mem
WHERE id='mem1' AND passwd='1234';   
   
   
<회원 로그인 내역>   
1. 테이블 구조

DROP TABLE login; 
 
CREATE TABLE login (
  logno              NUMBER(10)     NOT NULL, -- 회원 로그인 내역 번호
  memno            NUMBER(10)     NOT NULL, -- 회원 번호
  id                    VARCHAR(50)   NOT NULL, -- 아이디
  logdate            DATE               NOT NULL,  -- 회원 로그인 날짜
  
  PRIMARY KEY (logno),
  FOREIGN KEY (memno) REFERENCES mem (memno)
); 

COMMENT ON TABLE login is '회원 로그인 내역';
COMMENT ON COLUMN login.logno is '회원 로그인 내역 번호';
COMMENT ON COLUMN login.memno is '회원 번호';
COMMENT ON COLUMN login.id is '아이디';
COMMENT ON COLUMN login.logdate is '회원 로그인 날짜';

2. 로그인 등록
   DELETE FROM login; 
   
   INSERT INTO login(logno, memno, id, logdate)   
   VALUES((SELECT NVL(MAX(logno), 0)+1 as logno FROM login), 1, 'mem1', sysdate );
   
   INSERT INTO login(logno, memno, id, logdate)   
   VALUES((SELECT NVL(MAX(logno), 0)+1 as logno FROM login), 2, 'mem2', sysdate );
   
   INSERT INTO login(logno, memno, id, logdate)   
   VALUES((SELECT NVL(MAX(logno), 0)+1 as logno FROM login), 3, 'mem3', sysdate );
   
3. 로그인 내역 전체 목록
   SELECT logno, memno, id, logdate
   FROM login
   ORDER BY logno ASC;   
   
  LOGNO MEMNO ID   LOGDATE
 ----- ----- ---- ---------------------
     1     1 mem1 2019-05-28 17:20:14.0
     2     2 mem2 2019-05-28 17:20:15.0
     3     3 mem3 2019-05-28 17:20:16.0
               
 4. 로그인 내역 조회 
   SELECT logno, memno, id, logdate
   FROM login
   WHERE logno = 1;  

5. 'login' 내역 삭제 
DELETE FROM login;
 
DELETE FROM login
WHERE logno = 4;
   
               

/**********************************/
/* Table Name: 카테고리 */
/**********************************/
DROP TABLE diecate

CREATE TABLE diecate(
    diecateno                     NUMBER(10)                          NOT NULL    PRIMARY KEY,
    title                             VARCHAR2(50)                       NOT NULL,
    seqno                          NUMBER(5)                           NOT NULL,
    visible                          CHAR(1)          DEFAULT 'Y'     NOT NULL,
    cnt                              NUMBER(10)     DEFAULT 0      NOT NULL,
    rdate                           DATE                                    NOT NULL
); 

COMMENT ON TABLE diecate is '카테고리';
COMMENT ON COLUMN diecate.diecateno is '카테고리 번호';
COMMENT ON COLUMN diecate.title is '카테고리 제목';
COMMENT ON COLUMN diecate.seqno is '출력순서';
COMMENT ON COLUMN diecate.visible is '출력모드';
COMMENT ON COLUMN diecate.cnt is '등록된 자료수';
COMMENT ON COLUMN diecate.rdate is '카테고리 생성일';


2. 등록
INSERT INTO diecate(diecateno, title, seqno, visible, cnt, rdate)
VALUES((SELECT NVL(MAX(diecateno), 0) + 1 as diecateno FROM diecate),
            '귀걸이', 1, 'Y', 0, sysdate);
            
INSERT INTO diecate(diecateno, title, seqno, visible, cnt, rdate)
VALUES((SELECT NVL(MAX(diecateno), 0) + 1 as diecateno FROM diecate),
            '목걸이', 2, 'Y', 0, sysdate);
            
INSERT INTO diecate(diecateno, title, seqno, visible, cnt, rdate)
VALUES((SELECT NVL(MAX(diecateno), 0) + 1 as diecateno FROM diecate),
            '팔찌', 3, 'Y', 0, sysdate);
            
            
3. 목록
-- 카테고리 번호로 정렬
SELECT diecateno, title, seqno, visible, cnt, rdate
FROM diecate
ORDER BY diecateno ASC;

 DIECATENO TITLE SEQNO VISIBLE CNT RDATE
 --------- ----- ----- ------- --- ---------------------
         1 귀걸이       1 Y         0 2019-05-24 13:12:13.0
         2 목걸이       2 Y         0 2019-05-24 13:12:14.0
         3 팔찌        3 Y         0 2019-05-24 13:12:15.0

-- 출력순서에 따른 전체 목록
SELECT diecateno, title, seqno, visible, cnt, rdate
FROM diecate
ORDER BY seqno ASC;

 DIECATENO TITLE SEQNO VISIBLE CNT RDATE
 --------- ----- ----- ------- --- ---------------------
         1 귀걸이       1 Y         0 2019-05-24 13:12:13.0
         2 목걸이       2 Y         0 2019-05-24 13:12:14.0
         3 팔찌        3 Y         0 2019-05-24 13:12:15.0

         
4. 조회
SELECT diecateno, title, seqno, visible, cnt, rdate
FROM diecate
WHERE diecateno = 1;

 DIECATENO TITLE SEQNO VISIBLE CNT RDATE
 --------- ----- ----- ------- --- ---------------------
         1 귀걸이       1 Y         0 2019-05-24 13:12:13.0
         

5. 수정
UPDATE diecate
SET title='목걸이/초커', seqno = 2, visible='Y'
WHERE diecateno = 2;

SELECT diecateno, title, seqno, visible, cnt, rdate
FROM diecate
ORDER BY seqno ASC;

 DIECATENO TITLE  SEQNO VISIBLE CNT RDATE
 --------- ------ ----- ------- --- ---------------------
         1 귀걸이        1 Y         0 2019-05-24 13:12:13.0
         2 목걸이/초커     2 Y         0 2019-05-24 13:12:14.0
         3 팔찌         3 Y         0 2019-05-24 13:12:15.0


6. 삭제
-- 모든 레코드 삭제
DELETE FROM diecate;

DELETE FROM diecate
WHERE diecateno = 3;


7. 출력순서
-- 출력 순서 상향, 10 -> 1
UPDATE diecate
SET seqno = seqno - 1
WHERE diecateno=1;

-- 출력순서 하향, 1 -> 10
UPDATE diecate
SET seqno = seqno + 1
WHERE diecateno=1;

-- 출력 순서에 따른 전체 목록
SELECT diecateno, title, seqno
FROM diecate
ORDER BY seqno ASC;


8. 등록된 글 수
-- 컨텐츠 추가에 따른 등록된 글 수의 증가
UPDATE diecate 
SET cnt = cnt + 1 
WHERE diecateno = 1;

-- 컨텐츠 삭제에 따른 등록된 글 수의 감소
UPDATE diecate 
SET cnt = cnt - 1 
WHERE diecateno = 1;

-- 글 수의 초기화
UPDATE diecate 
SET cnt = 0;


/**********************************/
/* Table Name: 상품 컨텐츠 */
/**********************************/
DROP TABLE goods

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
            
-----------------------------------------------------------------------------------------------------------------

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

-----------------------------------------------------------------------------------------------------------------

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
/* Table Name: 주문 */
/**********************************/
drop table ordered

CREATE TABLE ordered(
		orderno                       		VARCHAR2(50)		 NOT NULL		 PRIMARY KEY,
		goodsno                       		NUMBER(10)		 NOT NULL,
		memno                         		NUMBER(10)		 NOT NULL,
		orderRec                      		VARCHAR2(50)		 NOT NULL,
		orderAddr1                    		VARCHAR2(20)		 NOT NULL,
		orderAddr2                    		VARCHAR2(50)		 NOT NULL,
		orderAddr3                    		VARCHAR2(50)		 NULL ,
		orderDate                     		DATE		 NOT NULL,
  FOREIGN KEY (memno) REFERENCES mem (memno),
  FOREIGN KEY (goodsno) REFERENCES goods (goodsno)
);

COMMENT ON TABLE ordered is '주문';
COMMENT ON COLUMN ordered.orderno is '주문 번호';
COMMENT ON COLUMN ordered.goodsno is '상품 번호';
COMMENT ON COLUMN ordered.memno is '회원 번호';
COMMENT ON COLUMN ordered.orderRec is '받는사람';
COMMENT ON COLUMN ordered.orderAddr1 is '우편번호';
COMMENT ON COLUMN ordered.orderAddr2 is '주소';
COMMENT ON COLUMN ordered.orderAddr3 is '상세주소';
COMMENT ON COLUMN ordered.orderDate is '주문 날짜';


/**********************************/
/* Table Name: 장바구니 */
/**********************************/
CREATE TABLE cart(
		cartno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		goodsno                       		NUMBER(10)		 NOT NULL,
		memno                         		NUMBER(10)		 NOT NULL,
		goodsqty                      		NUMBER(10)		 NOT NULL,
		addDate                       		DATE		 NOT NULL,
  FOREIGN KEY (goodsno) REFERENCES goods (goodsno),
  FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE cart is '장바구니';
COMMENT ON COLUMN cart.cartno is '장바구니 번호';
COMMENT ON COLUMN cart.goodsno is '상품 번호';
COMMENT ON COLUMN cart.memno is '회원 번호';
COMMENT ON COLUMN cart.goodsqty is '상품 수량';
COMMENT ON COLUMN cart.addDate is '날짜';


/**********************************/
/* Table Name: 고객문의 */
/**********************************/
DROP TABLE custo_qus

CREATE TABLE custo_qus(
		custoqusno                    		NUMBER(10)		       NOT NULL		 PRIMARY KEY,
		diecateno                       NUMBER(10)           NOT NULL,
		name                          		VARCHAR2(10)		       NOT NULL,
		title                             		VARCHAR2(50)		       NOT NULL,
		askcont                       		VARCHAR2(2000)		     NOT NULL,
		thumbs                         VARCHAR2(1000)       NULL ,
		files                         		VARCHAR2(1000)		      NULL ,
		sizes                             VARCHAR2(1000)        NULL ,
		rdate                         	  	DATE		                    NOT NULL,
		answerno                      		NUMBER(10)		      NOT NULL,
		memno                             NUMBER(10)     NOT NULL,
    FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE custo_qus is '고객문의';
COMMENT ON COLUMN custo_qus.custoqusno is '고객문의번호';
COMMENT ON COLUMN custo_qus.diecateno is '카테고리번호';
COMMENT ON COLUMN custo_qus.name is '회원이름';
COMMENT ON COLUMN custo_qus.title is '제목';
COMMENT ON COLUMN custo_qus.askcont is '문의내용';
COMMENT ON COLUMN custo_qus.thumbs is 'Thumb 파일';
COMMENT ON COLUMN custo_qus.files is '파일';
COMMENT ON COLUMN custo_qus.sizes is '파일크기';
COMMENT ON COLUMN custo_qus.rdate is '날짜';
COMMENT ON COLUMN custo_qus.answerno is '답변번호';
COMMENT ON COLUMN custo_qus.memno is '회원번호';

-- 등록
INSERT INTO custo_qus(custoqusno, 
                                diecateno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno, memno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, '회원1', '문의사항', '배송지를 바꿔주세요', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                diecateno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            2, '회원2', '상품문의', '귀걸이3 재입고가 언제인가요', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                diecateno, name, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            3, '회원3', '반품문의', '목걸이를 반품하고 싶어요', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
-- 목록
SELECT custoqusno, diecateno, name, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
ORDER BY custoqusno ASC  

 CUSTOQUSNO NAME TITLE ASKCONT         THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ---- ----- --------------- ---------- -------- ----- --------------------- --------
          1 회원1  문의사항  배송지를 바꿔주세요      file_t.jpg file.jpg 0     2019-06-17 16:06:49.0        1
          2 회원2  상품문의  귀걸이3 재입고가 언제인가요 file_t.jpg file.jpg 0     2019-06-17 16:06:50.0        1
          3 회원3  반품문의  목걸이를 반품하고 싶어요   file_t.jpg file.jpg 0     2019-06-17 16:06:51.0        1
          
         16         1 회원1  문의사항     배송지를 바꿔주세요      file_t.jpg file.jpg 0     2019-06-18 16:53:53.0        1
         17         2 회원2  상품문의     귀걸이3 재입고가 언제인가요 file_t.jpg file.jpg 0     2019-06-18 16:53:54.0        1
         18         3 회원3  반품문의     목걸이를 반품하고 싶어요   file_t.jpg file.jpg 0     2019-06-18 16:53:55.0        1
      
-- 조회
SELECT custoqusno, diecateno, name, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
WHERE custoqusno=16; 

 CUSTOQUSNO NAME TITLE ASKCONT    THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ---- ----- ---------- ---------- -------- ----- --------------------- --------
          1 회원1  문의사항  배송지를 바꿔주세요 file_t.jpg file.jpg 0     2019-06-17 16:06:49.0        1

-- 수정
UPDATE custo_qus
SET name='회원11', title='ㅇ', askcont='dd'
WHERE custoqusno=16;

-- 수정 확인
SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
WHERE custoqusno=16; 

 CUSTOQUSNO GOODSNO MEMNO NAME TITLE ASKCONT    THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ------- ----- ---- ----- ---------- ---------- -------- ----- --------------------- --------
          1       1     1 회원11 문의사항  배송지를 바꿔주세요 file_t.jpg file.jpg 0     2019-06-04 17:24:22.0        1

-- 삭제
DELETE FROM custo_qus
WHERE custoqusno=16;

-- 페이징
SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
WHERE custoqusno=6
ORDER BY custoqusno ASC;
 
-- step 2         
SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno, rownum as r
FROM(
         SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno
         FROM custo_qus
         WHERE custoqusno=6
         ORDER BY custoqusno ASC
);
 
-- step 3         
SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno, r
FROM(
         SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno, rownum as r
         FROM(
                  SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno
                           FROM custo_qus
                           WHERE custoqusno=6
                           ORDER BY custoqusno ASC
         )
)
WHERE r >=6 AND r <= 9;

SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno, r
FROM(
         SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno, rownum as r
         FROM(
                  SELECT custoqusno, name, title, askcont, thumbs, files, sizes, rdate, answerno
                  FROM custo_qus
                  WHERE custoqusno=6 AND askcont LIKE '%문의%'
                  ORDER BY custoqusno DESC
         )
)
WHERE r >=1 AND r <= 3;


/**********************************/
/* Table Name: 고객문의 답변 */
/**********************************/
DROP TABLE ctsanswer

CREATE TABLE ctsanswer(
		answerno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		custoqusno                    		NUMBER(10)		 NOT NULL,
		answer                        		VARCHAR2(50)		 NOT NULL,
  FOREIGN KEY (custoqusno) REFERENCES custo_qus (custoqusno)
);

COMMENT ON TABLE ctsanswer is '고객문의 답변';
COMMENT ON COLUMN ctsanswer.answerno is '답변번호';
COMMENT ON COLUMN ctsanswer.custoqusno is '고객문의번호';
COMMENT ON COLUMN ctsanswer.answer is '답변';

-- 등록
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            1, '배송지 변경해드렸습니다.');
            
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            1, '일주일 후 재입고 예정입니다.');
 
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            1, '집 주소를 적어 주시기 바랍니다.');
            
            
-- 목록
SELECT answerno, custoqusno, answer
FROM ctsanswer
ORDER BY answerno ASC  

 ANSWERNO CUSTOQUSNO ANSWER
 -------- ---------- ------------------
        1          1 배송지 변경해드렸습니다.
        2          1 일주일 후 재입고 예정입니다.
        3          1 집 주소를 적어 주시기 바랍니다.

          
-- 조회
SELECT answerno, custoqusno, answer
FROM ctsanswer
WHERE answerno=1; 

 ANSWERNO CUSTOQUSNO ANSWER
 -------- ---------- -------------
        1          1 배송지 변경해드렸습니다.


-- 수정
UPDATE ctsanswer
SET answer='배송지를 변경했습니다.'
WHERE answerno=1;

-- 수정 확인
SELECT answerno, custoqusno, answer
FROM ctsanswer
WHERE answerno=1; 

 ANSWERNO CUSTOQUSNO ANSWER
 -------- ---------- ------------
        1          1 배송지를 변경했습니다.


-- 삭제
DELETE FROM ctsanswer
WHERE answerno=1;


/**********************************/
/* Table Name: 리뷰 */
/**********************************/
DROP TABLE review

CREATE TABLE review(
		reviewno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		goodsno                       		NUMBER(10)		 NULL ,
		thumbs                         		VARCHAR2(1000)		 NULL ,
		files                             VARCHAR2(1000)     NULL ,
		sizes                             VARCHAR2(1000)     NULL ,
		writing                       		VARCHAR2(50)		 NOT NULL,
		grade                         		VARCHAR2(10)		 NOT NULL,
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

-- 등록
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, grade)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            1, 'review_t.jpg', 'review.jpg', 0, '배송이 빠르고 좋아요', '4.7');
            
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, grade)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            1, 'review2_t.jpg', 'review2.jpg', 0, '귀걸이가 무겁지 않아요', '4.5');
 
INSERT INTO review(reviewno, 
                                goodsno, thumbs, files, sizes, writing, grade)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
            1, 'review3_t.jpg', 'review3.jpg', 0, '목걸이가 예뻐요', '4.0');
            
            
-- 목록
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade
FROM review
ORDER BY reviewno ASC  

 REVIEWNO GOODSNO THUMBS        FILES       SIZES WRITING      GRADE
 -------- ------- ------------- ----------- ----- ------------ -----
        1       1 review_t.jpg  review.jpg  0     배송이 빠르고 좋아요  4.7
        2       1 review2_t.jpg review2.jpg 0     귀걸이가 무겁지 않아요 4.5
        3       1 review3_t.jpg review3.jpg 0     목걸이가 예뻐요     4.0

          
-- 조회
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade
FROM review
WHERE reviewno=1; 

 REVIEWNO GOODSNO PHOTO      WRITING     GRADE
 -------- ------- ---------- ----------- -----
        1       1 review.jpg 배송이 빠르고 좋아요 4.7


-- 수정
UPDATE review
SET grade='4.2'
WHERE reviewno=1;

-- 수정 확인
SELECT reviewno, goodsno, thumbs, files, sizes, writing, grade
FROM review
WHERE reviewno=1; 

 REVIEWNO GOODSNO PHOTO      WRITING     GRADE
 -------- ------- ---------- ----------- -----
        1       1 review.jpg 배송이 빠르고 좋아요 4.2


-- 삭제
DELETE FROM review
WHERE reviewno=1;


/**********************************/
/* Table Name: 공지사항 */
/**********************************/
drop table notice

CREATE TABLE notice(
		noticeno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		diecateno                     		NUMBER(10)		 NOT NULL,
		title                         		VARCHAR2(50)		 NOT NULL,
		content                       		CLOB(4000)		 NOT NULL,
		passwd                        		VARCHAR2(20)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		file                          		VARCHAR2(1000)		 NULL ,
		map                           		VARCHAR2(1024)		 NULL ,
		visit                         		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (diecateno) REFERENCES diecate (diecateno)
);

COMMENT ON TABLE notice is '공지사항';
COMMENT ON COLUMN notice.noticeno is '공지사항 번호';
COMMENT ON COLUMN notice.diecateno is '카테고리 번호';
COMMENT ON COLUMN notice.title is '공지사항 제목';
COMMENT ON COLUMN notice.content is '공지사항 내용';
COMMENT ON COLUMN notice.passwd is '비밀번호';
COMMENT ON COLUMN notice.rdate is '등록일';
COMMENT ON COLUMN notice.file is '이미지 파일';
COMMENT ON COLUMN notice.map is '지도';
COMMENT ON COLUMN notice.visit is '조회수';


/**********************************/
/* Table Name: 회원 로그인 내역 */
/**********************************/
CREATE TABLE login(
		logno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memno                         		NUMBER(10)		 NOT NULL,
		id                            		VARCHAR2(50)		 NOT NULL,
		logdate                       		DATE		 NOT NULL,
  FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE login is '회원 로그인 내역';
COMMENT ON COLUMN login.logno is '회원 로그인 내역 번호';
COMMENT ON COLUMN login.memno is '회원 번호';
COMMENT ON COLUMN login.id is '아이디';
COMMENT ON COLUMN login.logdate is '회원 로그인 날짜';


