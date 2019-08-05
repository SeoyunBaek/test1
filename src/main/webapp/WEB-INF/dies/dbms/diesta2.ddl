/**********************************/
/* Table Name: 회원 */
/**********************************/
DROP TABLE mem;

CREATE TABLE mem(
		memno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		id                            		VARCHAR2(50)		 NOT NULL,
		passwd                        		NUMBER(10)		 NOT NULL,
		name                          		VARCHAR2(50)		 NOT NULL,
		zipcode                       		VARCHAR2(50)		 NOT NULL,
		address1                      		VARCHAR2(50)		 NOT NULL,
		address2                      		VARCHAR2(50)		 NULL ,
		phone                         		VARCHAR2(20)		 NOT NULL,
		email                         		VARCHAR2(50)		 NOT NULL
);

COMMENT ON TABLE mem is '회원';
COMMENT ON COLUMN mem.memno is '회원 번호';
COMMENT ON COLUMN mem.id is '아이디';
COMMENT ON COLUMN mem.passwd is '비밀번호';
COMMENT ON COLUMN mem.name is '이름';
COMMENT ON COLUMN mem.zipcode is '우편번호';
COMMENT ON COLUMN mem.address1 is '기본주소';
COMMENT ON COLUMN mem.address2 is '상세주소';
COMMENT ON COLUMN mem.phone is '휴대전화';
COMMENT ON COLUMN mem.email is '이메일';


/**********************************/
/* Table Name: 카테고리 */
/**********************************/
DROP TABLE diecate;

CREATE TABLE diecate(
		diecateno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		title                         		VARCHAR2(50)		 NOT NULL,
		seqno                         		NUMBER(5)		 NOT NULL,
		visible                       		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		cnt                           		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		rdate                         		DATE		 NOT NULL
);

COMMENT ON TABLE diecate is '카테고리';
COMMENT ON COLUMN diecate.diecateno is '카테고리 번호';
COMMENT ON COLUMN diecate.title is '카테고리 제목';
COMMENT ON COLUMN diecate.seqno is '출력순서';
COMMENT ON COLUMN diecate.visible is '출력모드';
COMMENT ON COLUMN diecate.cnt is '등록된 자료수';
COMMENT ON COLUMN diecate.rdate is '카테고리 생성일';


/**********************************/
/* Table Name: 상품 컨텐츠 */
/**********************************/
DROP TABLE goods;

CREATE TABLE goods(
		goodsno                       		NUMBER(10)	     	 NOT NULL		 PRIMARY KEY,
		diecateno                     		NUMBER(10)		        NULL,
		memno                         		NUMBER(10)	     	 NULL ,
		title                         		VARCHAR2(50)		         NOT NULL,
  	content                       		CLOB(4000)		         NOT NULL,
		price                         		NUMBER(10)		         NOT NULL,
		dcprice                       		NUMBER(10)          NOT NULL,
		totprice                      		NUMBER(10)		         NOT NULL,
		good                          		NUMBER(10)		       DEFAULT 0		 NOT NULL,
		passwd                        		VARCHAR2(20)		     NOT NULL,
		thumb                         		VARCHAR2(1000)		 NOT NULL,
		file                          		VARCHAR2(1000)		     NOT NULL,
		visit                         		NUMBER(10)		         DEFAULT 0		 NOT NULL,
		visible                       		CHAR(1)		               DEFAULT 'Y'		 NOT NULL,
		rdate                         		DATE		                   NOT NULL,
  FOREIGN KEY (diecateno) REFERENCES diecate (diecateno),
  FOREIGN KEY (memno) REFERENCES mem (memno)
);

CREATE TABLE goods(
    goodsno                           NUMBER(10)         NOT NULL    PRIMARY KEY,
    diecateno                         NUMBER(10)            NULL,
    memno                             NUMBER(10)         NULL ,
    title                             VARCHAR2(50)             NOT NULL,
    price                             NUMBER(10)             NOT NULL,
    dcprice                           NUMBER(10)          NOT NULL,
    totprice                          NUMBER(10)             NOT NULL,
    passwd                            VARCHAR2(20)         NOT NULL,
  FOREIGN KEY (diecateno) REFERENCES diecate (diecateno),
  FOREIGN KEY (memno) REFERENCES mem (memno)
);

CREATE TABLE goods(
    goodsno                           NUMBER(10)     NOT NULL    PRIMARY KEY,
    diecateno                         NUMBER(10)     NULL ,
    memno                             NUMBER(10)     NULL ,
    title                             VARCHAR2(50)     NOT NULL,
    content                           CLOB(4000)     NOT NULL,
    price                             NUMBER(10)     NOT NULL,
    dcprice                           NUMBER(10)     NOT NULL,
    totprice                          NUMBER(10)     NOT NULL,
    good                              NUMBER(10)     DEFAULT 0     NOT NULL,
    passwd                            VARCHAR2(20)     NOT NULL,
    thumb                             VARCHAR2(1000)     NOT NULL,
    file                              VARCHAR2(1000)     NOT NULL,
    visit                             NUMBER(10)     DEFAULT 0     NOT NULL,
    visible                           CHAR(1)    DEFAULT 'Y'     NOT NULL,
    rdate                             DATE     NOT NULL,
  FOREIGN KEY (diecateno) REFERENCES diecate (diecateno),
  FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE goods is '상품 컨텐츠';
COMMENT ON COLUMN goods.goodsno is '상품 번호';
COMMENT ON COLUMN goods.diecateno is '카테고리 번호';
COMMENT ON COLUMN goods.memno is '회원 번호';
COMMENT ON COLUMN goods.title is '제목';
COMMENT ON COLUMN goods.content is '내용';
COMMENT ON COLUMN goods.price is '판매가격';
COMMENT ON COLUMN goods.dcprice is '할인가격';
COMMENT ON COLUMN goods.totprice is '결제금액';
COMMENT ON COLUMN goods.good is '추천수';
COMMENT ON COLUMN goods.passwd is '비밀번호';
COMMENT ON COLUMN goods.thumb is 'preview 이미지';
COMMENT ON COLUMN goods.file is '파일명';
COMMENT ON COLUMN goods.visit is '조회수';
COMMENT ON COLUMN goods.visible is '출력모드';
COMMENT ON COLUMN goods.rdate is '등록일';


/**********************************/
/* Table Name: 주문 */
/**********************************/
DROP TABLE order;
CREATE TABLE order(
		orderno                       		VARCHAR2(50)		 NOT NULL		 PRIMARY KEY,
		goodsno                       		NUMBER(10)		 NOT NULL,
		memno                         		NUMBER(10)		 NOT NULL,
		orderRec                      		VARCHAR2(50)		 NOT NULL,
		orderAddr1                    		VARCHAR2(20)		 NOT NULL,
		orderAddr2                    		VARCHAR2(50)		 NOT NULL,
		orderAddr3                    		VARCHAR2(50)		 NULL ,
		orderDate                     		DATE		 NOT NULL,
  FOREIGN KEY (memno) REFERENCES mem (memno),
  FOREIGN KEY (goodsno) REFERENCES goods (goodsno)
);

COMMENT ON TABLE order is '주문';
COMMENT ON COLUMN order.orderno is '주문 번호';
COMMENT ON COLUMN order.goodsno is '상품 번호';
COMMENT ON COLUMN order.memno is '회원 번호';
COMMENT ON COLUMN order.orderRec is '받는사람';
COMMENT ON COLUMN order.orderAddr1 is '우편번호';
COMMENT ON COLUMN order.orderAddr2 is '주소';
COMMENT ON COLUMN order.orderAddr3 is '상세주소';
COMMENT ON COLUMN order.orderDate is '주문 날짜';


/**********************************/
/* Table Name: 장바구니 */
/**********************************/
DROP TABLE cart;
CREATE TABLE cart(
		cartno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		goodsno                       		NUMBER(10)		 NOT NULL,
		memno                         		NUMBER(10)		 NOT NULL,
		goodsqty                      		NUMBER(10)		 NOT NULL,
		addDate                       		DATE		 NOT NULL,
  FOREIGN KEY (goodsno) REFERENCES goods (goodsno),
  FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE cart is '장바구니';
COMMENT ON COLUMN cart.cartno is '장바구니 번호';
COMMENT ON COLUMN cart.goodsno is '상품 번호';
COMMENT ON COLUMN cart.memno is '회원 번호';
COMMENT ON COLUMN cart.goodsqty is '상품 수량';
COMMENT ON COLUMN cart.addDate is '날짜';


/**********************************/
/* Table Name: 고객문의 */
/**********************************/
DROP TABLE custo_qus;
CREATE TABLE custo_qus(
		custoqusno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		goodsno                       		NUMBER(10)		 NULL ,
		memno                         		NUMBER(10)		 NOT NULL,
		name                          		VARCHAR2(10)		 NOT NULL,
		title                         		VARCHAR2(50)		 NOT NULL,
		askcont                       		VARCHAR2(100)		 NOT NULL,
		photo                         		VARCHAR2(100)		 NULL ,
		rdate                         		DATE		 NOT NULL,
		answerno                      		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (memno) REFERENCES mem (memno),
  FOREIGN KEY (goodsno) REFERENCES goods (goodsno)
);

COMMENT ON TABLE custo_qus is '고객문의';
COMMENT ON COLUMN custo_qus.custoqusno is '고객문의번호';
COMMENT ON COLUMN custo_qus.goodsno is '상품 번호';
COMMENT ON COLUMN custo_qus.memno is '회원번호';
COMMENT ON COLUMN custo_qus.name is '회원이름';
COMMENT ON COLUMN custo_qus.title is '제목';
COMMENT ON COLUMN custo_qus.askcont is '문의내용';
COMMENT ON COLUMN custo_qus.photo is '사진';
COMMENT ON COLUMN custo_qus.rdate is '날짜';
COMMENT ON COLUMN custo_qus.answerno is '답변번호';


/**********************************/
/* Table Name: 고객문의 답변 */
/**********************************/
DROP TABLE ctsanswer;
CREATE TABLE ctsanswer(
		answerno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		custoqusno                    		NUMBER(10)		 NOT NULL,
		answer                        		VARCHAR2(50)		 NOT NULL,
  FOREIGN KEY (custoqusno) REFERENCES custo_qus (custoqusno)
);

COMMENT ON TABLE ctsanswer is '고객문의 답변';
COMMENT ON COLUMN ctsanswer.answerno is '답변번호';
COMMENT ON COLUMN ctsanswer.custoqusno is '고객문의번호';
COMMENT ON COLUMN ctsanswer.answer is '답변';


/**********************************/
/* Table Name: 리뷰 */
/**********************************/
DROP TABLE review;
CREATE TABLE review(
		reviewno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		goodsno                       		NUMBER(10)		 NULL ,
		photo                         		VARCHAR2(50)		 NULL ,
		writing                       		VARCHAR2(50)		 NOT NULL,
		grade                         		VARCHAR2(10)		 NOT NULL,
  FOREIGN KEY (goodsno) REFERENCES goods (goodsno)
);

COMMENT ON TABLE review is '리뷰';
COMMENT ON COLUMN review.reviewno is '리뷰번호';
COMMENT ON COLUMN review.goodsno is '상품 번호';
COMMENT ON COLUMN review.photo is '사진리뷰';
COMMENT ON COLUMN review.writing is '글리뷰';
COMMENT ON COLUMN review.grade is '평점';


/**********************************/
/* Table Name: 공지사항 */
/**********************************/
DROP TABLE notice;
CREATE TABLE notice(
		noticeno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		diecateno                     		NUMBER(10)		 NOT NULL,
		title                         		VARCHAR2(50)		 NOT NULL,
		content                       		CLOB(4000)		 NOT NULL,
		passwd                        		VARCHAR2(20)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		file                          		VARCHAR2(1000)		 NULL ,
		map                           		VARCHAR2(1024)		 NULL ,
		visit                         		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (diecateno) REFERENCES diecate (diecateno)
);

COMMENT ON TABLE notice is '공지사항';
COMMENT ON COLUMN notice.noticeno is '공지사항 번호';
COMMENT ON COLUMN notice.diecateno is '카테고리 번호';
COMMENT ON COLUMN notice.title is '공지사항 제목';
COMMENT ON COLUMN notice.content is '공지사항 내용';
COMMENT ON COLUMN notice.passwd is '비밀번호';
COMMENT ON COLUMN notice.rdate is '등록일';
COMMENT ON COLUMN notice.file is '이미지 파일';
COMMENT ON COLUMN notice.map is '지도';
COMMENT ON COLUMN notice.visit is '조회수';


/**********************************/
/* Table Name: 회원 로그인 내역 */
/**********************************/
DROP TABLE login;
CREATE TABLE login(
		logno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memno                         		NUMBER(10)		 NOT NULL,
		id                            		VARCHAR2(50)		 NOT NULL,
		logdate                       		DATE		 NOT NULL,
  FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE login is '회원 로그인 내역';
COMMENT ON COLUMN login.logno is '회원 로그인 내역 번호';
COMMENT ON COLUMN login.memno is '회원 번호';
COMMENT ON COLUMN login.id is '아이디';
COMMENT ON COLUMN login.logdate is '회원 로그인 날짜';


