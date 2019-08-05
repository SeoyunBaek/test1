/**********************************/
/* Table Name: 고객문의 답변 */
/**********************************/
DROP TABLE ctsanswer;
DELETE FROM ctsanswer

CREATE TABLE ctsanswer(
    answerno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    custoqusno                        NUMBER(10)     NOT NULL,
    answer                            VARCHAR2(50)     NOT NULL,
    ansnum                         NUMBER(5)              DEFAULT 0       NOT NULL,
    rdate                             DATE                       NOT NULL,
  FOREIGN KEY (custoqusno) REFERENCES custo_qus (custoqusno)
);

COMMENT ON TABLE ctsanswer is '고객문의 답변';
COMMENT ON COLUMN ctsanswer.answerno is '답변번호';
COMMENT ON COLUMN ctsanswer.custoqusno is '고객문의번호';
COMMENT ON COLUMN ctsanswer.answer is '답변';
COMMENT ON COLUMN ctsanswer.ansnum is '답변순서';
COMMENT ON COLUMN ctsanswer.rdate is '날짜';

-- 참고
1) 컬럼 추가
ALTER TABLE ctsanswer
ADD (rdate DATE);
COMMENT ON COLUMN ctsanswer.grpno is '그룹번호';
COMMENT ON COLUMN ctsanswer.indent is '답변차수';
ALTER TABLE ctsanswer
DROP COLUMN indent;

-- 등록
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer, grpno, 
                                indent, ansnum, rdate)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            1, '배송지 변경해드렸습니다.', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM ctsanswer),
            0, 0, sysdate);
         
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer, grpno, 
                                indent, ansnum, rdate)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            2, '일주일 후 재입고 예정입니다.', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM ctsanswer),
            0, 0, sysdate);
 
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer, grpno, 
                                indent, ansnum, rdate)
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            3, '집 주소를 적어 주시기 바랍니다.', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM ctsanswer),
            0, 0, sysdate);
            
            
-- 목록
SELECT answerno, custoqusno, answer, grpno, indent, ansnum, rdate
FROM ctsanswer
ORDER BY answerno ASC  

 ANSWERNO CUSTOQUSNO ANSWER             RDATE
 -------- ---------- ------------------ ---------------------
        1          1 배송지를 변경했습니다.       2019-07-03 13:00:46.0
        2          2 일주일 후 재입고 예정입니다.   2019-07-03 13:01:26.0
        3          3 집 주소를 적어 주시기 바랍니다. 2019-07-03 13:01:27.0

          
-- 조회
SELECT answerno, custoqusno, answer, rdate
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
SELECT answerno, custoqusno, answer, rdate
FROM ctsanswer
WHERE answerno=1; 

 ANSWERNO CUSTOQUSNO ANSWER
 -------- ---------- ------------
        1          1 배송지를 변경했습니다.


-- 삭제
DELETE FROM ctsanswer
WHERE answerno=1;

-- 답변
INSERT INTO ctsanswer(answerno, 
                                custoqusno, answer, rdate)  
VALUES((SELECT NVL(MAX(answerno), 0)+1 as answerno FROM ctsanswer),
            1, '집 주소를 적어 주시기 바랍니다.', sysdate);
            
            
            