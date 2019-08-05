1. 테이블 구조
/**********************************/
/* Table Name: 카테고리 */
/**********************************/
-- 테이블 삭제
DROP TABLE diecate;
DROP TABLE diecate CASCADE CONSTRAINTS;

CREATE TABLE diecate(
    diecateno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    grpno                             NUMBER(10)     NULL ,
    title                             VARCHAR2(50)     NOT NULL,
    seqno                             NUMBER(5)    NOT NULL,
    visible                           CHAR(1)    DEFAULT 'Y'     NOT NULL,
    id                                VARCHAR2(100)    NOT NULL,
    cnt                               NUMBER(10)     DEFAULT 0     NOT NULL,
    rdate                             DATE     NOT NULL,
  FOREIGN KEY (grpno) REFERENCES diecategrp (grpno)
);

COMMENT ON TABLE diecate is '카테고리';
COMMENT ON COLUMN diecate.diecateno is '게시판 번호';
COMMENT ON COLUMN diecate.grpno is '카테고리그룹 번호';
COMMENT ON COLUMN diecate.title is '게시판 이름';
COMMENT ON COLUMN diecate.seqno is '출력순서';
COMMENT ON COLUMN diecate.visible is '출력모드';
COMMENT ON COLUMN diecate.id is '접근계정';
COMMENT ON COLUMN diecate.cnt is '등록된 자료수';
COMMENT ON COLUMN diecate.rdate is '게시판 생성일';


2. 등록
INSERT INTO diecate(diecateno, grpno, title, seqno, visible, id, cnt, rdate)
VALUES((SELECT NVL(MAX(diecateno), 0) + 1 as diecateno FROM diecate),
            2, '귀걸이', 1, 'Y', 'master', 0, sysdate);
            
INSERT INTO diecate(diecateno, grpno, title, seqno, visible, id, cnt, rdate)
VALUES((SELECT NVL(MAX(diecateno), 0) + 1 as diecateno FROM diecate),
            2, '목걸이', 2, 'Y', 'master', 0, sysdate);
            
INSERT INTO diecate(diecateno, grpno, title, seqno, visible, id, cnt, rdate)
VALUES((SELECT NVL(MAX(diecateno), 0) + 1 as diecateno FROM diecate),
            2, '팔찌', 3, 'Y', 'master', 0, sysdate);
            
            
3. 목록
-- 출력순서에 따른 전체 목록
SELECT diecateno, grpno, title, seqno, visible, id, cnt, rdate
FROM diecate
ORDER BY seqno ASC;

 DIECATENO GRPNO TITLE SEQNO VISIBLE ID     CNT RDATE
 --------- ----- ----- ----- ------- ------ --- ---------------------
         1     2 귀걸이       1 Y       master   0 2019-07-17 18:15:55.0
         2     2 목걸이       2 Y       master   0 2019-07-17 18:15:56.0
         3     2 팔찌        3 Y       master   0 2019-07-17 18:15:57.0
         
-- Equal(INNER) JOIN
SELECT c.grpno, c.name, c.seqno,
          t.diecateno, t.grpno, t.title, t.seqno as diecate_seqno, t.visible, t.id, t.cnt, t.rdate
FROM diecategrp c, diecate t
WHERE c.grpno = t.grpno
ORDER BY c.grpno ASC, t.seqno ASC;

 GRPNO NAME SEQNO DIECATENO GRPNO TITLE DIECATE_SEQNO VISIBLE ID     CNT RDATE
 ----- ---- ----- --------- ----- ----- ------------- ------- ------ --- ---------------------
     2 상품       2         1     2 귀걸이               1 Y       master   0 2019-07-17 18:15:55.0
     2 상품       2         2     2 목걸이               2 Y       master   0 2019-07-17 18:15:56.0
     2 상품       2         3     2 팔찌                3 Y       master   0 2019-07-17 18:15:57.0

-- LEFT Outer JOIN
SELECT c.grpno, c.name, c.seqno,
          t.diecateno, t.grpno, t.title, t.seqno as diecate_seqno, t.visible, t.id, t.cnt, t.rdate
FROM diecategrp c, diecate t
WHERE c.grpno = t.grpno(+)
ORDER BY c.grpno ASC, t.seqno ASC;

 GRPNO NAME SEQNO DIECATENO GRPNO TITLE DIECATE_SEQNO VISIBLE ID     CNT  RDATE
 ----- ---- ----- --------- ----- ----- ------------- ------- ------ ---- ---------------------
     1 공지사항     1      NULL  NULL NULL           NULL NULL    NULL   NULL NULL
     2 상품       2         1     2 귀걸이               1 Y       master    0 2019-07-17 18:15:55.0
     2 상품       2         2     2 목걸이               2 Y       master    0 2019-07-17 18:15:56.0
     2 상품       2         3     2 팔찌                3 Y       master    0 2019-07-17 18:15:57.0
     3 Q&A      3      NULL  NULL NULL           NULL NULL    NULL   NULL NULL
     4 회원       4      NULL  NULL NULL           NULL NULL    NULL   NULL NULL

         
4. 조회
SELECT diecateno, grpno, title, seqno, visible, cnt, rdate
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


9. 검색



10. 페이징
            
            