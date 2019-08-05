/**********************************/
/* Table Name: 이벤트 */
/**********************************/
CREATE TABLE event(
    eventno                           NUMBER(10)     NOT NULL    PRIMARY KEY,
    title                             VARCHAR2(50)     NOT NULL,
    contents                          VARCHAR2(2000)     NOT NULL,
    thumbs                            VARCHAR2(1000)     NULL ,
    files                             VARCHAR2(1000)     NULL ,
    sizes                             VARCHAR2(1000)     NULL ,
    rdate                             DATE     NOT NULL,
    word                              VARCHAR2(100)    NULL,
    diecateno                         NUMBER(10)             NOT NULL,
    FOREIGN KEY (diecateno) REFERENCES diecate (diecateno)
);

COMMENT ON TABLE event is '이벤트';
COMMENT ON COLUMN event.eventno is '이벤트번호';
COMMENT ON COLUMN event.title is '글제목';
COMMENT ON COLUMN event.contents is '글내용';
COMMENT ON COLUMN event.thumbs is '썸네일';
COMMENT ON COLUMN event.files is '파일';
COMMENT ON COLUMN event.sizes is '파일사이즈';
COMMENT ON COLUMN event.rdate is '날짜';
COMMENT ON COLUMN event.word is '검색어';

-- 등록
INSERT INTO event(eventno, 
                          title, contents, 
                          thumbs, files, sizes, rdate, word)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event),
            '할인 이벤트를 시작합니다', '귀걸이1 할인 시작', 
            'file_t.jpg', 'file.jpg', 0, sysdate, '이벤트,할인');

INSERT INTO event(eventno, 
                          title, contents, 
                          thumbs, files, sizes, rdate, word)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event),
            '배송비 무료 이벤트 안내', '일주일간 목걸이1을 구매하시면 배송비가 무료입니다', 
            'file_t.jpg', 'file.jpg', 0, sysdate, '이벤트,배송비,무료');
            
INSERT INTO event(eventno, 
                          title, contents, 
                          thumbs, files, sizes, rdate, word)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event),
            'SNS 이벤트', 'SNS에 후기를 올리면 추첨을 통해 반지를 드립니다', 
            'file_t.jpg', 'file.jpg', 0, sysdate, '이벤트,SNS,후기');
 
-- 목록
SELECT eventno, title, contents, thumbs, files, sizes, rdate, word
FROM event
ORDER BY eventno ASC  

 EVENTNO TITLE         CONTENTS                     THUMBS     FILES    SIZES RDATE                 WORD
 ------- ------------- ---------------------------- ---------- -------- ----- --------------------- ----------
       1 할인 이벤트를 시작합니다 귀걸이1 할인 시작                   file_t.jpg file.jpg 0     2019-07-26 15:46:32.0 이벤트,할인
       2 배송비 무료 이벤트 안내 일주일간 목걸이1을 구매하시면 배송비가 무료입니다  file_t.jpg file.jpg 0     2019-07-26 15:46:33.0 이벤트,배송비,무료
       3 SNS 이벤트       SNS에 후기를 올리면 추첨을 통해 반지를 드립니다 file_t.jpg file.jpg 0     2019-07-26 15:46:34.0 이벤트,SNS,후기
  
-- 조회
SELECT eventno, title, contents, thumbs, files, sizes, rdate, word
FROM event
WHERE eventno=1; 

 EVENTNO TITLE         CONTENTS   THUMBS     FILES    SIZES RDATE                 WORD
 ------- ------------- ---------- ---------- -------- ----- --------------------- ------
       1 할인 이벤트를 시작합니다 귀걸이1 할인 시작 file_t.jpg file.jpg 0     2019-07-26 15:46:32.0 이벤트,할인

-- 수정
UPDATE event
SET title='할인 이벤트 시작', contents='일주일간 귀걸이1을 구매하시면 10%할인해드립니다.'
WHERE eventno=1;

-- 수정 확인
SELECT eventno, title, contents, thumbs, files, sizes, rdate, word
FROM event
WHERE eventno=1; 

 EVENTNO TITLE     CONTENTS                     THUMBS     FILES    SIZES RDATE                 WORD
 ------- --------- ---------------------------- ---------- -------- ----- --------------------- ------
       1 할인 이벤트 시작 일주일간 귀걸이1을 구매하시면 10%할인해드립니다. file_t.jpg file.jpg 0     2019-07-26 15:46:32.0 이벤트,할인

-- 삭제
DELETE FROM event
WHERE eventno=1;

-- 검색+페이징
SELECT eventno, title, contents, thumbs, files, sizes, rdate, word, r
FROM(
         SELECT eventno, title, contents, thumbs, files, sizes, rdate, word, rownum as r
         FROM(
                  SELECT eventno, title, contents, thumbs, files, sizes, rdate, word
                  FROM event
                  WHERE eventno=1 AND word LIKE '%이벤트%'
                  ORDER BY eventno DESC
         )
)
WHERE r >=1 AND r <= 3;

 EVENTNO TITLE     CONTENTS                     THUMBS     FILES    SIZES RDATE                 WORD   R
 ------- --------- ---------------------------- ---------- -------- ----- --------------------- ------ -
       1 할인 이벤트 시작 일주일간 귀걸이1을 구매하시면 10%할인해드립니다. file_t.jpg file.jpg 0     2019-07-26 15:46:32.0 이벤트,할인 1

SELECT c.diecateno, c.title,
          t.title
FROM diecate c, event t
WHERE c.diecateno = t.diecateno
ORDER BY c.diecateno ASC, t.eventno




