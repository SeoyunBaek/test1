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
  /** 상품 번호 */
  private int goodsno;
  /** 카테고리 번호 */
  private int diecateno;
  /** 회원 번호 */
  private int memno;
  /** 컨텐츠 제목 */
  private String title;
  /** 컨텐츠 내용 */
  private String content;
  /** 판매가 */
  private int price;
  /** 할인가 */
  private int dcprice;
  /** 결제 금액 */
  private int totprice;    
  /** preview 이미지 (200 X 150), 자동 생성 */
  private String thumbs = "";
  
  /** 여러 이미지중에 첫번째 Preview 이미지 (200 X 150) 저장 */
  private String thumb = "";
  
  /** 파일명 */
  private String files = "";
  /** 파일 크기 */
  private String sizes = "";  
  /** 검색어 */
  private String word;
  /** 조회수 */
  private int visit = 0;
  /** 출력모드 */
  private String visible;
  /** 등록일 */
  private String rdate;
  
  /** 
  Spring Framework에서 자동 주입되는 업로드 파일 객체,
  DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
  여러개의 파일 업로드
  */  
  private List<MultipartFile> filesMF;

  /** size1의 컴마 저장 출력용 변수, 실제 컬럼은 존재하지 않음. */
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
