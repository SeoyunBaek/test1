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
   
ALTER TABLE mem
ADD (cnt NUMBER(6));     
   
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
SET passwd='1234'
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
   
               