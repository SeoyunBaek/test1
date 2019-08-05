/**********************************/
/* Table Name: ȸ�� */
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

COMMENT ON TABLE mem is 'ȸ��';
COMMENT ON COLUMN mem.memno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN mem.id is '���̵�';
COMMENT ON COLUMN mem.passwd is '��й�ȣ';
COMMENT ON COLUMN mem.name is '�̸�';
COMMENT ON COLUMN mem.zipcode is '�����ȣ';
COMMENT ON COLUMN mem.address1 is '�⺻�ּ�';
COMMENT ON COLUMN mem.address2 is '���ּ�';
COMMENT ON COLUMN mem.phone is '�޴���ȭ';
COMMENT ON COLUMN mem.email is '�̸���';


/**********************************/
/* Table Name: ī�װ� */
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

COMMENT ON TABLE diecate is 'ī�װ�';
COMMENT ON COLUMN diecate.diecateno is 'ī�װ� ��ȣ';
COMMENT ON COLUMN diecate.title is 'ī�װ� ����';
COMMENT ON COLUMN diecate.seqno is '��¼���';
COMMENT ON COLUMN diecate.visible is '��¸��';
COMMENT ON COLUMN diecate.cnt is '��ϵ� �ڷ��';
COMMENT ON COLUMN diecate.rdate is 'ī�װ� ������';


/**********************************/
/* Table Name: ��ǰ ������ */
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

COMMENT ON TABLE goods is '��ǰ ������';
COMMENT ON COLUMN goods.goodsno is '��ǰ ��ȣ';
COMMENT ON COLUMN goods.diecateno is 'ī�װ� ��ȣ';
COMMENT ON COLUMN goods.memno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN goods.title is '����';
COMMENT ON COLUMN goods.content is '����';
COMMENT ON COLUMN goods.price is '�ǸŰ���';
COMMENT ON COLUMN goods.dcprice is '���ΰ���';
COMMENT ON COLUMN goods.totprice is '�����ݾ�';
COMMENT ON COLUMN goods.good is '��õ��';
COMMENT ON COLUMN goods.passwd is '��й�ȣ';
COMMENT ON COLUMN goods.thumb is 'preview �̹���';
COMMENT ON COLUMN goods.file is '���ϸ�';
COMMENT ON COLUMN goods.visit is '��ȸ��';
COMMENT ON COLUMN goods.visible is '��¸��';
COMMENT ON COLUMN goods.rdate is '�����';


/**********************************/
/* Table Name: �ֹ� */
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

COMMENT ON TABLE order is '�ֹ�';
COMMENT ON COLUMN order.orderno is '�ֹ� ��ȣ';
COMMENT ON COLUMN order.goodsno is '��ǰ ��ȣ';
COMMENT ON COLUMN order.memno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN order.orderRec is '�޴»��';
COMMENT ON COLUMN order.orderAddr1 is '�����ȣ';
COMMENT ON COLUMN order.orderAddr2 is '�ּ�';
COMMENT ON COLUMN order.orderAddr3 is '���ּ�';
COMMENT ON COLUMN order.orderDate is '�ֹ� ��¥';


/**********************************/
/* Table Name: ��ٱ��� */
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

COMMENT ON TABLE cart is '��ٱ���';
COMMENT ON COLUMN cart.cartno is '��ٱ��� ��ȣ';
COMMENT ON COLUMN cart.goodsno is '��ǰ ��ȣ';
COMMENT ON COLUMN cart.memno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN cart.goodsqty is '��ǰ ����';
COMMENT ON COLUMN cart.addDate is '��¥';


/**********************************/
/* Table Name: ������ */
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

COMMENT ON TABLE custo_qus is '������';
COMMENT ON COLUMN custo_qus.custoqusno is '�����ǹ�ȣ';
COMMENT ON COLUMN custo_qus.goodsno is '��ǰ ��ȣ';
COMMENT ON COLUMN custo_qus.memno is 'ȸ����ȣ';
COMMENT ON COLUMN custo_qus.name is 'ȸ���̸�';
COMMENT ON COLUMN custo_qus.title is '����';
COMMENT ON COLUMN custo_qus.askcont is '���ǳ���';
COMMENT ON COLUMN custo_qus.photo is '����';
COMMENT ON COLUMN custo_qus.rdate is '��¥';
COMMENT ON COLUMN custo_qus.answerno is '�亯��ȣ';


/**********************************/
/* Table Name: ������ �亯 */
/**********************************/
DROP TABLE ctsanswer;
CREATE TABLE ctsanswer(
		answerno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		custoqusno                    		NUMBER(10)		 NOT NULL,
		answer                        		VARCHAR2(50)		 NOT NULL,
  FOREIGN KEY (custoqusno) REFERENCES custo_qus (custoqusno)
);

COMMENT ON TABLE ctsanswer is '������ �亯';
COMMENT ON COLUMN ctsanswer.answerno is '�亯��ȣ';
COMMENT ON COLUMN ctsanswer.custoqusno is '�����ǹ�ȣ';
COMMENT ON COLUMN ctsanswer.answer is '�亯';


/**********************************/
/* Table Name: ���� */
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

COMMENT ON TABLE review is '����';
COMMENT ON COLUMN review.reviewno is '�����ȣ';
COMMENT ON COLUMN review.goodsno is '��ǰ ��ȣ';
COMMENT ON COLUMN review.photo is '��������';
COMMENT ON COLUMN review.writing is '�۸���';
COMMENT ON COLUMN review.grade is '����';


/**********************************/
/* Table Name: �������� */
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

COMMENT ON TABLE notice is '��������';
COMMENT ON COLUMN notice.noticeno is '�������� ��ȣ';
COMMENT ON COLUMN notice.diecateno is 'ī�װ� ��ȣ';
COMMENT ON COLUMN notice.title is '�������� ����';
COMMENT ON COLUMN notice.content is '�������� ����';
COMMENT ON COLUMN notice.passwd is '��й�ȣ';
COMMENT ON COLUMN notice.rdate is '�����';
COMMENT ON COLUMN notice.file is '�̹��� ����';
COMMENT ON COLUMN notice.map is '����';
COMMENT ON COLUMN notice.visit is '��ȸ��';


/**********************************/
/* Table Name: ȸ�� �α��� ���� */
/**********************************/
DROP TABLE login;
CREATE TABLE login(
		logno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memno                         		NUMBER(10)		 NOT NULL,
		id                            		VARCHAR2(50)		 NOT NULL,
		logdate                       		DATE		 NOT NULL,
  FOREIGN KEY (memno) REFERENCES mem (memno)
);

COMMENT ON TABLE login is 'ȸ�� �α��� ����';
COMMENT ON COLUMN login.logno is 'ȸ�� �α��� ���� ��ȣ';
COMMENT ON COLUMN login.memno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN login.id is '���̵�';
COMMENT ON COLUMN login.logdate is 'ȸ�� �α��� ��¥';


