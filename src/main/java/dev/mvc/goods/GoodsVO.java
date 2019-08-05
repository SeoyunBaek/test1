package dev.mvc.goods;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

/*
goodsno                           NUMBER(10)                      NOT NULL    PRIMARY KEY,
diecateno                          NUMBER(10)                      NOT NULL,
memno                            NUMBER(10)                       NOT NULL,
title                                 VARCHAR2(100)                   NOT NULL,
content                            CLOB                                 NOT NULL,
price                                NUMBER(10)     DEFAULT 0    NOT NULL,
dcprice                             NUMBER(10)     DEFAULT 0           NULL ,
totprice                            NUMBER(10)     DEFAULT 0     NOT NULL,
thumbs                            VARCHAR2(1000)                         NULL ,
files                                 VARCHAR2(1000)                         NULL ,
sizes                                VARCHAR2(1000)                         NULL ,
word                               VARCHAR2(100)                           NULL,
visit                                 NUMBER(10)     DEFAULT 0     NOT NULL,
visible                              CHAR(1)           DEFAULT 'Y'   NOT NULL,
rdate                               DATE                                  NOT NULL, 
 */

public class GoodsVO {
  /** ��ǰ ��ȣ */
  private int goodsno;
  /** ī�װ� ��ȣ */
  private int diecateno;
  /** ȸ�� ��ȣ */
  private int memno;
  /** ������ ���� */
  private String title;
  /** ������ ���� */
  private String content;
  /** �ǸŰ� */
  private int price;
  /** ���ΰ� */
  private int dcprice;
  /** ���� �ݾ� */
  private int totprice;    
  /** preview �̹��� (200 X 150), �ڵ� ���� */
  private String thumbs = "";
  
  /** ���� �̹����߿� ù��° Preview �̹��� (200 X 150) ���� */
  private String thumb = "";
  
  /** ���ϸ� */
  private String files = "";
  /** ���� ũ�� */
  private String sizes = "";  
  /** �˻��� */
  private String word;
  /** ��ȸ�� */
  private int visit = 0;
  /** ��¸�� */
  private String visible;
  /** ����� */
  private String rdate;
  
  /** 
  Spring Framework���� �ڵ� ���ԵǴ� ���ε� ���� ��ü,
  DBMS �� ���� �÷��� �������� �ʰ� ���� �ӽ� ���� ����.
  �������� ���� ���ε�
  */  
  private List<MultipartFile> filesMF;

  /** size1�� �ĸ� ���� ��¿� ����, ���� �÷��� �������� ����. */
  private String sizesLabel;
  
  public GoodsVO() {

  }
  
  public int getGoodsno() {
    return goodsno;
  }
  public void setGoodsno(int goodsno) {
    // System.out.println("goodsno: " + goodsno);
    this.goodsno = goodsno;
  }
  public int getDiecateno() {
    return diecateno;
  }
  public void setDiecateno(int diecateno) {
    // System.out.println("diecateno: " + diecateno);
    this.diecateno = diecateno;
  }
  public int getMemno() {
    return memno;
  }
  public void setMemno(int memno) {
    // System.out.println("memno: " + memno);
    this.memno = memno;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  public int getPrice() {
    return price;
  }
  public void setPrice(int price) {
    // System.out.println("price: " + price);
    this.price = price;
  }
  public int getDcprice() {
    return dcprice;
  }
  public void setDcprice(int dcprice) {
    // System.out.println("dcprice: " + dcprice);
    this.dcprice = dcprice;
  }
  public int getTotprice() {
    return totprice;
  }
  public void setTotprice(int totprice) {
    // System.out.println("totprice: " + totprice);
    this.totprice = totprice;
  }
  public String getThumbs() {
    return thumbs;
  }
  public void setThumbs(String thumbs) {
    this.thumbs = thumbs;
  }
  public String getFiles() {
    if (this.files == null) {
      return "";
    } else{
      return files;
    }
  }
  public void setFiles(String files) {
    this.files = files;
  }
  public String getSizes() {
    return sizes;
  }
  public void setSizes(String sizes) {
    this.sizes = sizes;
  }
  public String getWord() {
    return word;
  }
  public void setWord(String word) {
    this.word = word;
  }
  public int getVisit() {
    return visit;
  }
  public void setVisit(int visit) {
    // System.out.println("visit: " + visit);
    this.visit = visit;
  }
  public String getVisible() {
    return visible;
  }
  public void setVisible(String visible) {
    this.visible = visible;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  } 
  
  public String getSizesLabel() {
    return sizesLabel;
  }
  public void setSizesLabel(String sizesLabel) {
    this.sizesLabel = sizesLabel;
  }
  public List<MultipartFile> getFilesMF() {
    return filesMF;
  }
  public void setFilesMF(List<MultipartFile> filesMF) {
    this.filesMF = filesMF;
  }
  public String getThumb() {
    return thumb;
  }
  public void setThumb(String thumb) {
    this.thumb = thumb;
  }
  

}
