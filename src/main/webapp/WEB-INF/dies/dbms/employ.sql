/**********************************/
/* Table Name: 채용공고 */
/**********************************/
DROP TABLE employ

CREATE TABLE employ(
		employno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		diecateno                         NUMBER(10)     NOT NULL,
		title                         		VARCHAR2(50)		 NOT NULL,
		contents                      		VARCHAR2(2000)		 NOT NULL,
		thumbs                            VARCHAR2(1000)     NULL ,
    files                             VARCHAR2(1000)     NULL ,
    sizes                             VARCHAR2(1000)     NULL ,
		id                                VARCHAR2(100)    NOT NULL,
		rdate                         		DATE		 NOT NULL
);

COMMENT ON TABLE employ is '채용공고';
COMMENT ON COLUMN employ.employno is '공고번호';
COMMENT ON COLUMN employ.diecateno is '카테고리번호';
COMMENT ON COLUMN employ.title is '글제목';
COMMENT ON COLUMN employ.contents is '글내용';
COMMENT ON COLUMN employ.thumbs is '썸네일';
COMMENT ON COLUMN employ.files is '파일';
COMMENT ON COLUMN employ.sizes is '파일사이즈';
COMMENT ON COLUMN employ.id is '접근계정';
COMMENT ON COLUMN employ.rdate is '날짜';

-- 등록
INSERT INTO employ(employno, 
                            diecateno, 
                            title, contents, thumbs, files, sizes, id, rdate)
VALUES((SELECT NVL(MAX(employno), 0)+1 as employno FROM employ),
           (SELECT NVL(MAX(diecateno), 0)+1 as diecateno FROM employ),
           '채용 공고1', '자격 요건: 포토샵 가능한 사람', 'file_t.jpg', 'file.jpg', 0, 'master', sysdate);

INSERT INTO employ(employno, 
                            diecateno, 
                            title, contents, thumbs, files, sizes, id, rdate)
VALUES((SELECT NVL(MAX(employno), 0)+1 as employno FROM employ),
           (SELECT NVL(MAX(diecateno), 0)+1 as diecateno FROM employ),
           '채용 공고2', '자격 요건: 엑셀 가능한 사람', 'file_t.jpg', 'file.jpg', 0, 'master', sysdate);
            
INSERT INTO employ(employno, 
                            diecateno, 
                            title, contents, thumbs, files, sizes, id, rdate)
VALUES((SELECT NVL(MAX(employno), 0)+1 as employno FROM employ),
           (SELECT NVL(MAX(diecateno), 0)+1 as diecateno FROM employ),
           '채용 공고3', '자격 요건: 일러스트 가능한 사람', 'file_t.jpg', 'file.jpg', 0, 'master', sysdate);

-- 목록
SELECT employno, diecateno, title, contents, thumbs, files, sizes, id, rdate
FROM employ
ORDER BY employno ASC  

 EMPLOYNO TITLE  CONTENTS           ID     RDATE
 -------- ------ ------------------ ------ ---------------------
        1 채용 공고1 자격 요건: 포토샵 가능한 사람  master 2019-08-01 15:13:59.0
        2 채용 공고2 자격 요건: 엑셀 가능한 사람   master 2019-08-01 15:14:00.0
        3 채용 공고3 자격 요건: 일러스트 가능한 사람 master 2019-08-01 15:14:01.0

-- 조회
SELECT employno, diecateno, title, contents, thumbs, files, sizes, id, rdate
FROM employ
WHERE employno=1; 

 EMPLOYNO TITLE  CONTENTS          ID     RDATE
 -------- ------ ----------------- ------ ---------------------
        1 채용 공고1 자격 요건: 포토샵 가능한 사람 master 2019-08-01 15:13:59.0

-- 수정
UPDATE employ
SET title='직원 모집', contents='포토샵 자격증 소지시 가산점'
WHERE employno=1;

-- 수정 확인
SELECT employno, diecateno, title, contents, thumbs, files, sizes, id, rdate
FROM employ
WHERE employno=1;

 EMPLOYNO DIECATENO TITLE CONTENTS        ID      RDATE
 -------- --------- ----- --------------- ------- ---------------------
        1         1 직원 모집 포토샵 자격증 소지시 가산점 master1 2019-08-01 15:53:07.0

-- 삭제
DELETE FROM employ
WHERE employno=1;


