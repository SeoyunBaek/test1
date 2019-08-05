DELETE FROM goods;

DELETE FROM custo_qus;

--PK 테이블 데이터 추가

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
            
            
SELECT * FROM mem ORDER BY memno ASC;            


INSERT INTO custo_qus(custoqusno, 
                                diecateno, title, askcont, 
                                thumbs, files, sizes, rdate, answerno, memno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, '문의사항', '배송지를 바꿔주세요', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                diecateno, title, askcont, 
                                thumbs, files, sizes, rdate, answerno, memno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            2, '상품문의', '귀걸이3 재입고가 언제인가요', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1, 2);
            
INSERT INTO custo_qus(custoqusno, 
                                diecateno, title, askcont, 
                                thumbs, files, sizes, rdate, answerno, memno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            3, '반품문의', '목걸이를 반품하고 싶어요', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1, 3);



/**********************************/
/* Table Name: 고객문의 */
/**********************************/
DROP TABLE custo_qus

CREATE TABLE custo_qus(
    custoqusno                        NUMBER(10)           NOT NULL    PRIMARY KEY,
    goodsno                           NUMBER(10)           NULL ,
    memno                             NUMBER(10)           NOT NULL,
    title                                 VARCHAR2(50)           NOT NULL,
    askcont                           VARCHAR2(100)        NOT NULL,
    thumbs                         VARCHAR2(1000)       NULL ,
    files                             VARCHAR2(1000)         NULL ,
    sizes                             VARCHAR2(1000)        NULL ,
    rdate                               DATE                        NOT NULL,
    answerno                          NUMBER(10)          NOT NULL,
  FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE custo_qus is '고객문의';
COMMENT ON COLUMN custo_qus.custoqusno is '고객문의번호';
COMMENT ON COLUMN custo_qus.goodsno is '상품 번호';
COMMENT ON COLUMN custo_qus.memno is '회원번호';
COMMENT ON COLUMN custo_qus.title is '제목';
COMMENT ON COLUMN custo_qus.askcont is '문의내용';
COMMENT ON COLUMN custo_qus.thumbs is 'Thumb 파일';
COMMENT ON COLUMN custo_qus.files is '파일';
COMMENT ON COLUMN custo_qus.sizes is '파일크기';
COMMENT ON COLUMN custo_qus.rdate is '날짜';
COMMENT ON COLUMN custo_qus.answerno is '답변번호';

-- 등록
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, '문의사항', '배송지를 바꿔주세요', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, '상품문의', '귀걸이3 재입고가 언제인가요', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
INSERT INTO custo_qus(custoqusno, 
                                goodsno, memno, title, askcont, 
                                thumbs, files, sizes, rdate, answerno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, 1, '반품문의', '목걸이를 반품하고 싶어요', 
            'file_t.jpg', 'file.jpg', 0, sysdate, 1);
            
-- 목록
SELECT custoqusno, goodsno, memno, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
ORDER BY custoqusno ASC  

 CUSTOQUSNO GOODSNO MEMNO NAME TITLE ASKCONT         THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ------- ----- ---- ----- --------------- ---------- -------- ----- --------------------- --------
          1       1     1 회원1  문의사항  배송지를 바꿔주세요      file_t.jpg file.jpg 0     2019-06-04 17:24:22.0        1
          2       1     1 회원2  상품문의  귀걸이3 재입고가 언제인가요 file_t.jpg file.jpg 0     2019-06-04 17:24:23.0        1
          3       1     1 회원3  반품문의  목걸이를 반품하고 싶어요   file_t.jpg file.jpg 0     2019-06-04 17:24:24.0        1
         
-- 조회
SELECT custoqusno, goodsno, memno, title, askcont, thumbs, files, sizes, rdate, answerno
FROM custo_qus
WHERE custoqusno=1; 

 CUSTOQUSNO GOODSNO MEMNO NAME TITLE ASKCONT    THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ------- ----- ---- ----- ---------- ---------- -------- ----- --------------------- --------
          1       1     1 회원1  문의사항  배송지를 바꿔주세요 file_t.jpg file.jpg 0     2019-06-04 17:24:22.0        1

-- 수정
UPDATE custo_qus
SET title='문의'
WHERE custoqusno=1;

-- 수정 확인
SELECT custoqusno, goodsno, memno, title, askcont, thumbs, files, sizes, rdate, answerno
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
    


SELECT c.memno, c.name,
          t.askcont
FROM mem c, custo_qus t  
WHERE c.memno = t.memno
ORDER BY c.memno ASC, t.custoqusno ASC;

 MEMNO NAME ASKCONT
 ----- ---- ---------------
     1 박지영  배송지를 바꿔주세요
     2 최지원  귀걸이3 재입고가 언제인가요
     3 박수영  목걸이를 반품하고 싶어요





