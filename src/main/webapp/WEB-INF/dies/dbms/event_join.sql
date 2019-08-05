/**********************************/
/* Table Name: 이벤트 */
/**********************************/
DROP TABLE event

CREATE TABLE event(
    eventno                           NUMBER(10)     NOT NULL    PRIMARY KEY,
    diecateno                           NUMBER(10)     NOT NULL,
    title                             VARCHAR2(50)     NOT NULL,
    contents                          VARCHAR2(2000)     NOT NULL,
    thumbs                            VARCHAR2(1000)     NULL ,
    files                             VARCHAR2(1000)     NULL ,
    sizes                             VARCHAR2(1000)     NULL ,
    rdate                             DATE     NOT NULL,
    word                              VARCHAR2(100)    NULL,
    seqno                             NUMBER(5)    DEFAULT 0     NOT NULL,
    visible                           CHAR(1)    DEFAULT 'Y'     NOT NULL,
    id                                VARCHAR2(100)    NOT NULL,
    cnt                               NUMBER(10)     DEFAULT 0     NOT NULL
    --FOREIGN KEY (diecateno) REFERENCES diecate (diecateno)
);

COMMENT ON TABLE event is '이벤트';
COMMENT ON COLUMN event.eventno is '이벤트번호';
COMMENT ON COLUMN event.diecateno is '카테고리번호';
COMMENT ON COLUMN event.title is '글제목';
COMMENT ON COLUMN event.contents is '글내용';
COMMENT ON COLUMN event.thumbs is '썸네일';
COMMENT ON COLUMN event.files is '파일';
COMMENT ON COLUMN event.sizes is '파일사이즈';
COMMENT ON COLUMN event.rdate is '날짜';
COMMENT ON COLUMN event.word is '검색어';
COMMENT ON COLUMN event.seqno is '출력순서';
COMMENT ON COLUMN event.visible is '출력모드';
COMMENT ON COLUMN event.id is '접근계정';
COMMENT ON COLUMN event.cnt is '등록된 자료수';

-- 등록
INSERT INTO event(eventno,
                          diecateno, 
                          title, contents, 
                          thumbs, files, sizes, rdate, word,
                          seqno, visible, id, cnt)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event),
           (SELECT NVL(MAX(diecateno), 0)+1 as diecateno FROM event),
            '할인 이벤트를 시작합니다', '귀걸이1 할인 시작', 
            'file_t.jpg', 'file.jpg', 0, sysdate, '이벤트,할인',
            2, 'Y', 'master',0);

INSERT INTO event(eventno,
                          diecateno, 
                          title, contents, 
                          thumbs, files, sizes, rdate, word,
                          seqno, visible, id, cnt)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event),
           (SELECT NVL(MAX(diecateno), 0)+1 as diecateno FROM event),
            '배송비 무료 이벤트 안내', '일주일간 목걸이1을 구매하시면 배송비가 무료입니다', 
            'file_t.jpg', 'file.jpg', 0, sysdate, '이벤트,배송비,무료',
            2, 'Y', 'master', 0);

INSERT INTO event(eventno,
                          diecateno, 
                          title, contents, 
                          thumbs, files, sizes, rdate, word,
                          seqno, visible, id, cnt)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event),
           (SELECT NVL(MAX(diecateno), 0)+1 as diecateno FROM event),
            'SNS 이벤트', 'SNS에 후기를 올리면 추첨을 통해 반지를 드립니다', 
            'file_t.jpg', 'file.jpg', 0, sysdate, '이벤트,SNS,후기',
            2, 'Y', 'master',0);

-- 목록
SELECT eventno, diecateno, title, contents, thumbs, files, sizes, rdate, word, seqno, visible, id, cnt
FROM event
ORDER BY eventno ASC  

 EVENTNO DIECATENO TITLE         CONTENTS                     THUMBS     FILES    SIZES RDATE                 WORD       SEQNO VISIBLE ID     CNT
 ------- --------- ------------- ---------------------------- ---------- -------- ----- --------------------- ---------- ----- ------- ------ ---
       1         1 할인 이벤트를 시작합니다 귀걸이1 할인 시작                   file_t.jpg file.jpg 0     2019-07-30 18:06:30.0 이벤트,할인         2 Y       master   0
       2         2 배송비 무료 이벤트 안내 일주일간 목걸이1을 구매하시면 배송비가 무료입니다  file_t.jpg file.jpg 0     2019-07-30 18:06:31.0 이벤트,배송비,무료     2 Y       master   0
       3         3 SNS 이벤트       SNS에 후기를 올리면 추첨을 통해 반지를 드립니다 file_t.jpg file.jpg 0     2019-07-30 18:06:32.0 이벤트,SNS,후기     2 Y       master   0

-- 조회
SELECT eventno, diecateno, title, contents, thumbs, files, sizes, rdate, word, seqno, visible, id, cnt
FROM event
WHERE eventno=1; 

 EVENTNO DIECATENO TITLE         CONTENTS   THUMBS     FILES    SIZES RDATE                 WORD   SEQNO VISIBLE ID     CNT
 ------- --------- ------------- ---------- ---------- -------- ----- --------------------- ------ ----- ------- ------ ---
       1         1 할인 이벤트를 시작합니다 귀걸이1 할인 시작 file_t.jpg file.jpg 0     2019-07-30 18:06:30.0 이벤트,할인     2 Y       master   0

-- 수정
UPDATE event
SET title='할인 이벤트 시작', contents='일주일간 귀걸이1을 구매하시면 10%할인해드립니다.'
WHERE eventno=1;

-- 수정 확인
SELECT eventno, diecateno, title, contents, thumbs, files, sizes, rdate, word, seqno, visible, id, cnt
FROM event
WHERE eventno=1; 

 EVENTNO DIECATENO TITLE     CONTENTS                     THUMBS     FILES    SIZES RDATE                 WORD   SEQNO VISIBLE ID     CNT
 ------- --------- --------- ---------------------------- ---------- -------- ----- --------------------- ------ ----- ------- ------ ---
       1         1 할인 이벤트 시작 일주일간 귀걸이1을 구매하시면 10%할인해드립니다. file_t.jpg file.jpg 0     2019-07-30 18:06:30.0 이벤트,할인     2 Y       master   0

-- 삭제
DELETE FROM event
WHERE eventno=1;
DELETE FROM event
WHERE eventno=2;
DELETE FROM event
WHERE eventno=3;

-- 검색+페이징
SELECT eventno, diecateno, title, contents, thumbs, files, sizes, rdate, word, seqno, visible, id, cnt, r
FROM(
         SELECT eventno, diecateno, title, contents, thumbs, files, sizes, rdate, word, seqno, visible, id, cnt, rownum as r
         FROM(
                  SELECT eventno, diecateno, title, contents, thumbs, files, sizes, rdate, word, seqno, visible, id, cnt
                  FROM event
                  WHERE diecateno=1 AND word LIKE '%이벤트%'
                  ORDER BY eventno DESC
         )
)
WHERE r >=1 AND r <= 3;

 EVENTNO DIECATENO TITLE     CONTENTS                     THUMBS     FILES    SIZES RDATE                 WORD   SEQNO VISIBLE ID     CNT R
 ------- --------- --------- ---------------------------- ---------- -------- ----- --------------------- ------ ----- ------- ------ --- -
       1         1 할인 이벤트 시작 일주일간 귀걸이1을 구매하시면 10%할인해드립니다. file_t.jpg file.jpg 0     2019-07-30 18:06:30.0 이벤트,할인     2 Y       master   0 1


       
SELECT c.diecateno, c.title,
          t.contents
FROM diecate c, event t
WHERE c.diecateno = t.diecateno
ORDER BY c.diecateno ASC, t.eventno
       
 DIECATENO TITLE  CONTENTS
 --------- ------ ----------------------------
         1 귀걸이    일주일간 귀걸이1을 구매하시면 10%할인해드립니다.
         2 목걸이/초커 일주일간 목걸이1을 구매하시면 배송비가 무료입니다
         3 팔찌     SNS에 후기를 올리면 추첨을 통해 반지를 드립니다


       
       
       

-- Equal(INNER) JOIN
SELECT c.grpno, c.name, c.seqno,
          t.eventno, t.grpno, t.title, t.seqno as diecate_seqno, t.visible, t.id, t.cnt, t.rdate
FROM diecategrp c, event t
WHERE c.grpno = t.grpno
ORDER BY c.grpno ASC, t.seqno ASC;
-- 추가 할 변수 : grpno, seqno, visible, id, cnt
SELECT c.grpno, c.name, c.seqno,
          t.diecateno, t.grpno, t.title, t.seqno as diecate_seqno, t.visible, t.id, t.cnt, t.rdate

 GRPNO NAME SEQNO EVENTNO GRPNO TITLE         DIECATE_SEQNO VISIBLE ID     CNT RDATE
 ----- ---- ----- ------- ----- ------------- ------------- ------- ------ --- ---------------------
     1 이벤트      4       3     1 SNS 이벤트                   2 Y       master   0 2019-07-29 17:54:40.0
     1 이벤트      4       1     1 할인 이벤트 시작                 2 Y       master   0 2019-07-29 17:54:38.0
     1 이벤트      4       2     1 배송비 무료 이벤트 안내             2 Y       master   0 2019-07-29 17:54:39.0


-- LEFT Outer JOIN
SELECT c.grpno, c.name, c.seqno,
          t.eventno, t.grpno, t.title, t.seqno as diecate_seqno, t.visible, t.id, t.cnt, t.rdate
FROM diecategrp c, event t
WHERE c.grpno = t.grpno(+)
ORDER BY c.grpno ASC, t.seqno ASC;

 GRPNO NAME SEQNO EVENTNO GRPNO TITLE         DIECATE_SEQNO VISIBLE ID     CNT  RDATE
 ----- ---- ----- ------- ----- ------------- ------------- ------- ------ ---- ---------------------
     1 이벤트      4       1     1 할인 이벤트 시작                 2 Y       master    0 2019-07-29 17:54:38.0
     1 이벤트      4       2     1 배송비 무료 이벤트 안내             2 Y       master    0 2019-07-29 17:54:39.0
     1 이벤트      4       3     1 SNS 이벤트                   2 Y       master    0 2019-07-29 17:54:40.0
     2 상품       2    NULL  NULL NULL                   NULL NULL    NULL   NULL NULL
     3 Q&A      3    NULL  NULL NULL                   NULL NULL    NULL   NULL NULL
     4 회원       4    NULL  NULL NULL                   NULL NULL    NULL   NULL NULL



