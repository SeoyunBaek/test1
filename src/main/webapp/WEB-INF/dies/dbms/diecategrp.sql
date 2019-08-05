1. 테이블 생성
/**********************************/
/* Table Name: 카테고리 그룹 */
/**********************************/
DROP TABLE diecategrp;
DROP TABLE diecategrp CASCADE CONSTRAINTS;

CREATE TABLE diecategrp(
    grpno                             NUMBER(10)     NOT NULL    PRIMARY KEY,
    name                              VARCHAR2(50)     NOT NULL,
    seqno                             NUMBER(5)    DEFAULT 0     NOT NULL,
    visible                           CHAR(1)    DEFAULT 'Y'     NOT NULL,
    rdate                             DATE     NOT NULL
);

COMMENT ON TABLE diecategrp is '카테고리 그룹';
COMMENT ON COLUMN diecategrp.grpno is '카테고리그룹 번호';
COMMENT ON COLUMN diecategrp.name is '카테고리그룹 이름';
COMMENT ON COLUMN diecategrp.seqno is '출력순서';
COMMENT ON COLUMN diecategrp.visible is '출력모드';
COMMENT ON COLUMN diecategrp.rdate is '그룹 생성일';


2. 등록
- classification: 1-notice, 2-goods, 3-Q&A
- visible: Y, N

INSERT INTO diecategrp(grpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM diecategrp),
            '공지사항', 1, 'Y', sysdate);

INSERT INTO diecategrp(grpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM diecategrp),
            '상품', 2, 'Y', sysdate);

INSERT INTO diecategrp(grpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM diecategrp),
            'Q&A', 3, 'Y', sysdate);
            
INSERT INTO diecategrp(grpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM diecategrp),
            '회원', 4, 'N', sysdate);
            
 
3. 목록
-- grpno 정렬
SELECT grpno, name, seqno, visible, TO_CHAR(rdate, 'YYYY-MM-DD hh:mi:ss') as rdate
FROM diecategrp
ORDER BY grpno ASC;

 GRPNO NAME SEQNO VISIBLE RDATE
 ----- ---- ----- ------- -------------------
     1 공지사항     1 Y       2019-07-17 05:52:48
     2 상품       2 Y       2019-07-17 05:52:49
     3 Q&A      3 Y       2019-07-17 05:52:50
     4 회원       4 N       2019-07-17 05:52:51


-- 출력 순서에따른 전체 목록
SELECT grpno, name, seqno, visible, rdate
FROM diecategrp
ORDER BY seqno ASC;


4. 조회
SELECT grpno, name, seqno, visible, rdate 
FROM diecategrp
WHERE grpno = 1;

 GRPNO NAME SEQNO VISIBLE RDATE
 ----- ---- ----- ------- ---------------------
     1 공지사항     1 Y       2019-07-17 17:52:48.0

         
5.  수정
UPDATE diecategrp
SET name='이벤트', seqno = 4, visible='Y'
WHERE grpno = 1;

SELECT grpno, name, seqno, visible, rdate 
FROM diecategrp
ORDER BY grpno ASC;

 GRPNO NAME SEQNO VISIBLE RDATE
 ----- ---- ----- ------- ---------------------
     1 이벤트      4 Y       2019-07-17 17:52:48.0
     2 상품       2 Y       2019-07-17 17:52:49.0
     3 Q&A      3 Y       2019-07-17 17:52:50.0
     4 회원       4 N       2019-07-17 17:52:51.0


6. 삭제
-- 모든 레코드 삭제
DELETE FROM diecategrp;

DELETE FROM diecategrp
WHERE grpno = 1;

SELECT grpno, name, seqno, visible, rdate 
FROM diecategrp
ORDER BY grpno ASC;

 GRPNO NAME SEQNO VISIBLE RDATE
 ----- ---- ----- ------- ---------------------
     2 상품       2 Y       2019-07-17 17:52:49.0
     3 Q&A      3 Y       2019-07-17 17:52:50.0
     4 회원       4 N       2019-07-17 17:52:51.0

-- 출력 순서 상향, 10 -> 1
UPDATE diecategrp
SET seqno = seqno - 1
WHERE grpno=1;

-- 출력순서 하향, 1 -> 10
UPDATE diecategrp
SET seqno = seqno + 1
WHERE grpno=1;

-- 출력 순서에따른 전체 목록
SELECT grpno, name, seqno
FROM diecategrp
ORDER BY seqno ASC;
 
 GRPNO NAME SEQNO
 ----- ---- -----
     2 상품       2
     3 Q&A      3
     4 회원       4

          
8) 검색

         
9) 페이징