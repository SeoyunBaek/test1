DELETE FROM custo_qus;

DELETE FROM ctsanswer;

--PK 테이블 데이터 추가

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
            
SELECT * FROM custo_qus ORDER BY custoqusno ASC;

 CUSTOQUSNO DIECATENO TITLE     ASKCONT         THUMBS     FILES    SIZES RDATE                 ANSWERNO MEMNO
 ---------- --------- --------- --------------- ---------- -------- ----- --------------------- -------- -----
          3         3 반품문의      목걸이를 반품하고 싶어요   file_t.jpg file.jpg 0     2019-06-25 16:23:16.0        1     3
          4         0 문의 사항     주소를 바꿔주세요.      NULL       NULL     NULL  2019-06-25 18:24:48.0        0     1
          5         0 문의 사항2323 주소를 바꿔주세요.      NULL       NULL     NULL  2019-06-25 18:24:54.0        0     1
          6         1 문의사항      배송지를 바꿔주세요      file_t.jpg file.jpg 0     2019-06-25 18:38:11.0        1     1
          7         2 상품문의      귀걸이3 재입고가 언제인가요 file_t.jpg file.jpg 0     2019-06-25 18:38:12.0        1     2
          8         3 반품문의      목걸이를 반품하고 싶어요   file_t.jpg file.jpg 0     2019-06-25 18:38:13.0        1     3


CREATE TABLE ctsanswer(
    answerno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    custoqusno                        NUMBER(10)     NOT NULL,
    answer                            VARCHAR2(50)     NOT NULL,
  FOREIGN KEY (custoqusno) REFERENCES custo_qus (custoqusno)
);

COMMENT ON TABLE ctsanswer is '고객문의 답변';
COMMENT ON COLUMN ctsanswer.answerno is '답변번호';
COMMENT ON COLUMN ctsanswer.custoqusno is '고객문의번호';
COMMENT ON COLUMN ctsanswer.answer is '답변';

-- 등록
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer, rdate)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            1, '배송지 변경해드렸습니다.', sysdate);
         
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer, rdate)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            2, '일주일 후 재입고 예정입니다.', sysdate);
 
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer, rdate)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            3, '집 주소를 적어 주시기 바랍니다.', sysdate);
            
            
-- 목록
SELECT answerno, custoqusno, answer, rdate
FROM ctsanswer
ORDER BY answerno ASC  

 ANSWERNO CUSTOQUSNO ANSWER             RDATE
 -------- ---------- ------------------ ---------------------
        1          1 배송지 변경해드렸습니다.      2019-07-03 13:00:46.0
        2          2 일주일 후 재입고 예정입니다.   2019-07-03 13:01:26.0
        3          3 집 주소를 적어 주시기 바랍니다. 2019-07-03 13:01:27.0
       
-- 조회
SELECT answerno, custoqusno, answer, rdate
FROM ctsanswer
WHERE answerno=1; 

 ANSWERNO CUSTOQUSNO ANSWER        RDATE
 -------- ---------- ------------- ---------------------
        1          1 배송지 변경해드렸습니다. 2019-07-03 13:00:46.0
    
-- 수정
UPDATE ctsanswer
SET answer='배송지를 변경했습니다.'
WHERE answerno=1;

-- 수정 확인
SELECT answerno, custoqusno, answer, rdate
FROM ctsanswer
WHERE answerno=1; 

 ANSWERNO CUSTOQUSNO ANSWER       RDATE
 -------- ---------- ------------ ---------------------
        1          1 배송지를 변경했습니다. 2019-07-03 13:00:46.0

-- 삭제
DELETE FROM ctsanswer
WHERE answerno=1;



 CUSTOQUSNO GOODSNO MEMNO NAME TITLE ASKCONT         THUMBS     FILES    SIZES RDATE                 ANSWERNO
 ---------- ------- ----- ---- ----- --------------- ---------- -------- ----- --------------------- --------
          1       1     1 회원11 문의사항  배송지를 바꿔주세요      file_t.jpg file.jpg 0     2019-06-04 17:35:46.0        1
          2       1     1 회원2  상품문의  귀걸이3 재입고가 언제인가요 file_t.jpg file.jpg 0     2019-06-04 17:35:47.0        1
          3       1     1 회원3  반품문의  목걸이를 반품하고 싶어요   file_t.jpg file.jpg 0     2019-06-04 17:35:48.0        1
          4       1     1 회원1  문의사항  배송지를 바꿔주세요      file_t.jpg file.jpg 0     2019-06-12 17:43:22.0        1
          5       1     1 회원2  상품문의  귀걸이3 재입고가 언제인가요 file_t.jpg file.jpg 0     2019-06-12 17:43:23.0        1
          6       1     1 회원3  반품문의  목걸이를 반품하고 싶어요   file_t.jpg file.jpg 0     2019-06-12 17:43:24.0        1

          
SELECT c.custoqusno, c.askcont,
          t.answer
FROM custo_qus c, ctsanswer t  
ORDER BY c.custoqusno ASC, t.answerno ASC;

 CUSTOQUSNO ASKCONT         ANSWER
 ---------- --------------- ------------------
          1 배송지를 바꿔주세요      배송지 변경해드렸습니다.
          1 배송지를 바꿔주세요      일주일 후 재입고 예정입니다.
          1 배송지를 바꿔주세요      집 주소를 적어 주시기 바랍니다.
          2 귀걸이3 재입고가 언제인가요 배송지 변경해드렸습니다.
          2 귀걸이3 재입고가 언제인가요 일주일 후 재입고 예정입니다.
          2 귀걸이3 재입고가 언제인가요 집 주소를 적어 주시기 바랍니다.
          3 목걸이를 반품하고 싶어요   배송지 변경해드렸습니다.
          3 목걸이를 반품하고 싶어요   일주일 후 재입고 예정입니다.
          3 목걸이를 반품하고 싶어요   집 주소를 적어 주시기 바랍니다.

--!!!!!맞는 코드
SELECT c.custoqusno, c.askcont,
          t.answer
FROM custo_qus c, ctsanswer t  
WHERE c.custoqusno = t.custoqusno
ORDER BY c.custoqusno ASC, t.answerno ASC;

 CUSTOQUSNO ASKCONT         ANSWER
 ---------- --------------- ------------------
          1 배송지를 바꿔주세요      배송지를 변경했습니다.
          2 귀걸이3 재입고가 언제인가요 일주일 후 재입고 예정입니다.
          3 목걸이를 반품하고 싶어요   집 주소를 적어 주시기 바랍니다.







