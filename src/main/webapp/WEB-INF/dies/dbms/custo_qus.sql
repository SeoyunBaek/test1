/**********************************/
/* Table Name: 고객문의 */
/**********************************/
DROP TABLE custo_qus
DROP TABLE ctsanswer

CREATE TABLE custo_qus(
    custoqusno                    NUMBER(10)              NOT NULL    PRIMARY KEY,
    diecateno                       NUMBER(10)              NOT NULL,
    title                               VARCHAR2(50)          NOT NULL,
    askcont                          VARCHAR2(2000)       NOT NULL,
    thumbs                          VARCHAR2(1000)       NULL,
    files                              VARCHAR2(1000)        NULL,
    sizes                             VARCHAR2(1000)        NULL,
    replycnt                         NUMBER(7)               DEFAULT 0       NOT NULL,  
    rdate                             DATE                       NOT NULL,
    grpno                           NUMBER(7)               NOT NULL,
    indent                           NUMBER(2)              DEFAULT 0       NOT NULL,
    ansnum                         NUMBER(5)              DEFAULT 0       NOT NULL,
    word                            VARCHAR2(100)         NULL,
    answerno                       NUMBER(10)             NOT NULL,
    memno                         NUMBER(10)             NOT NULL,
    FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE custo_qus is '고객문의';
COMMENT ON COLUMN custo_qus.custoqusno is '고객문의번호';
COMMENT ON COLUMN custo_qus.diecateno is '카테고리번호';
COMMENT ON COLUMN custo_qus.title is '제목';
COMMENT ON COLUMN custo_qus.askcont is '문의내용';
COMMENT ON COLUMN custo_qus.thumbs is 'Thumb 파일';
COMMENT ON COLUMN custo_qus.files is '파일';
COMMENT ON COLUMN custo_qus.sizes is '파일크기';
COMMENT ON COLUMN custo_qus.replycnt is '답변수';
COMMENT ON COLUMN custo_qus.rdate is '날짜';
COMMENT ON COLUMN custo_qus.grpno is '그룹번호';
COMMENT ON COLUMN custo_qus.indent is '답변차수';
COMMENT ON COLUMN custo_qus.ansnum is '답변순서';
COMMENT ON COLUMN custo_qus.word is '검색어';
COMMENT ON COLUMN custo_qus.answerno is '답변번호';
COMMENT ON COLUMN custo_qus.memno is '회원번호';

-- 등록
INSERT INTO custo_qus(custoqusno, 
                                diecateno, title, askcont, thumbs, files, 
                                sizes, replycnt, rdate, grpno, 
                                indent, ansnum, word, answerno, memno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            1, '문의사항', '배송지를 바꿔주세요', 
            'file_t.jpg', 'file.jpg', 0, 0, sysdate, (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM custo_qus),
            0, 0, '문의사항,배송지,재입고', 1, 1);

INSERT INTO custo_qus(custoqusno, 
                                diecateno, title, askcont, thumbs, files, 
                                sizes, replycnt, rdate, grpno, 
                                indent, ansnum, word, answerno, memno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            2, '상품문의', '귀걸이3 재입고가 언제인가요', 
            'file_t.jpg', 'file.jpg', 0, 0, sysdate, (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM custo_qus),
            0, 0, '문의사항,배송지,재입고', 2, 2);
            
INSERT INTO custo_qus(custoqusno, 
                                diecateno, title, askcont, thumbs, files, 
                                sizes, replycnt, rdate, grpno, 
                                indent, ansnum, word, answerno, memno)
VALUES((SELECT NVL(MAX(custoqusno), 0)+1 as custoqusno FROM custo_qus),
            3, '반품문의', '목걸이를 반품하고 싶어요', 
            'file_t.jpg', 'file.jpg', 0, 0, sysdate, (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM custo_qus),
            0, 0, '문의사항,배송지,재입고', 3, 3);
 
-- 1) 컬럼 추가
ALTER TABLE custo_qus
ADD (ansnum NUMBER(5));     
 
-- 목록
SELECT custoqusno, diecateno, title, askcont, thumbs, files, sizes, replycnt, rdate, 
          grpno, indent, ansnum, word, answerno, memno
FROM custo_qus
ORDER BY custoqusno ASC  

  CUSTOQUSNO DIECATENO TITLE ASKCONT         THUMBS     FILES    SIZES REPLYCNT RDATE                 GRPNO INDENT WORD ANSWERNO MEMNO
 ---------- --------- ----- --------------- ---------- -------- ----- -------- --------------------- ----- ------ ---- -------- -----
          1         1 문의사항  배송지를 바꿔주세요      file_t.jpg file.jpg 0            0 2019-07-03 12:22:30.0     1      0 0           1     1
          2         2 상품문의  귀걸이3 재입고가 언제인가요 file_t.jpg file.jpg 0            0 2019-07-03 12:23:18.0     2      0 0           2     2
          3         3 반품문의  목걸이를 반품하고 싶어요   file_t.jpg file.jpg 0            0 2019-07-03 12:23:19.0     3      0 0           3     3

  
-- 조회
SELECT custoqusno, diecateno, title, askcont, thumbs, files, sizes, replycnt, rdate, 
          grpno, indent, ansnum, word, answerno, memno
FROM custo_qus
WHERE custoqusno=1; 

 CUSTOQUSNO DIECATENO TITLE ASKCONT    THUMBS     FILES    SIZES REPLYCNT RDATE                 GRPNO INDENT WORD ANSWERNO MEMNO
 ---------- --------- ----- ---------- ---------- -------- ----- -------- --------------------- ----- ------ ---- -------- -----
          1         1 문의사항  배송지를 바꿔주세요 file_t.jpg file.jpg 0            0 2019-07-03 12:22:30.0     1      0 0           1     1

-- 수정
UPDATE custo_qus
SET title='문의 사항', askcont='배송지를 변경해주세요'
WHERE custoqusno=1;

-- 수정 확인
SELECT custoqusno, diecateno, title, askcont, thumbs, files, sizes, replycnt, rdate, 
          grpno, indent, ansnum, word, answerno, memno
FROM custo_qus
WHERE custoqusno=1; 

 CUSTOQUSNO DIECATENO TITLE ASKCONT     THUMBS     FILES    SIZES REPLYCNT RDATE                 GRPNO INDENT WORD ANSWERNO MEMNO
 ---------- --------- ----- ----------- ---------- -------- ----- -------- --------------------- ----- ------ ---- -------- -----
          1         1 문의 사항 배송지를 변경해주세요 file_t.jpg file.jpg 0            0 2019-07-03 12:22:30.0     1      0 0           1     1

-- 삭제
DELETE FROM custo_qus
WHERE custoqusno=1;

-- 검색+페이징
SELECT custoqusno, title, askcont, thumbs, files, sizes, replycnt, rdate, answerno, memno, word, r
FROM(
         SELECT custoqusno, title, askcont, thumbs, files, sizes, replycnt, rdate, answerno, memno, word, rownum as r
         FROM(
                  SELECT custoqusno, title, askcont, thumbs, files, sizes, replycnt, rdate, answerno, memno, word
                  FROM custo_qus
                  WHERE memno=1 AND word LIKE '%문의%'
                  ORDER BY custoqusno DESC
         )
)
WHERE r >=1 AND r <= 3;

 CUSTOQUSNO TITLE    ASKCONT    THUMBS     FILES    SIZES  RDATE                 ANSWERNO MEMNO WORD        R
 ---------- -------- ---------- ---------- -------- ------ --------------------- -------- ----- ----------- -
         14 문의 사항    주소를 바꿔주세요. NULL       NULL     NULL   2019-07-01 16:38:37.0        0     1 문의,주소,배송,입고 1
         13 문의 사항ㅁㅇㄴ 주소를 바꿔주세요. sw21_t.jpg sw21.jpg 100669 2019-07-01 16:27:20.0        0     1 문의,주소,배송,입고 2
         12 문의 사항    주소를 바꿔주세요. sw09_t.jpg sw09.jpg 278237 2019-07-01 16:26:42.0        0     1 문의,주소,배송,입고 3

         
-- 답변         
    INSERT INTO custo_qus(custoqusno, 
                                    diecateno, title, askcont, thumbs, files, 
                                    sizes, replycnt, rdate, 
                                    word, grpno, 
                                    indent, ansnum, answerno, memno) 
VALUES((SELECT NVL(MAX(custoqusno), 0) + 1 as custoqusno FROM custo_qus),
            2, 're: 상품문의', '귀걸이3는 일주일 후에 재입고 됩니다', 'file_t.jpg', 'file.jpg', 
            0, 0, sysdate, 
            '', (SELECT NVL(MAX(diecateno), 0) + 1 as diecateno FROM custo_qus), 
            1, 1, 2, 2);



SELECT custoqusno, diecateno, title, askcont, thumbs, files, sizes, rdate, answerno, memno, word
FROM custo_qus
WHERE memno=6 AND word LIKE '%문의%'
ORDER BY custoqusno DESC;

