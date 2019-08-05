package dev.mvc.event;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class EventVO {
/*  eventno                           NUMBER(10)     NOT NULL    PRIMARY KEY,
  diecateno                           NUMBER(10)     NOT NULL,
  title                             VARCHAR2(50)     NOT NULL,
  contents                          VARCHAR2(2000)     NOT NULL,
  thumbs                            VARCHAR2(1000)     NULL ,
  files                             VARCHAR2(1000)     NULL ,
  sizes                             VARCHAR2(1000)     NULL ,
  rdate                             DATE     NOT NULL,
  word                              VARCHAR2(100)    NULL,
  seqno                             NUMBER(5)    DEFAULT 0     NOT NULL,
  grpno                           NUMBER(7)               NOT NULL,
  indent                           NUMBER(2)              DEFAULT 0       NOT NULL,
  ansnum                         NUMBER(5)              DEFAULT 0       NOT NULL,    
  visible                           CHAR(1)    DEFAULT 'Y'     NOT NULL,
  id                                VARCHAR2(100)    NOT NULL,
  cnt                               NUMBER(10)     DEFAULT 0     NOT NULL,
  FOREIGN KEY (diecateno) REFERENCES diecate (diecateno) */
  /** 이벤트번호 */
  private int eventno;
  
  /** 카테고리번호 */
  private int diecateno;
  
  /** 글제목 */
  private String title;
  
  /** 글내용 */
  private String contents;
  
  /** Preview 소형 이미지 200 X 150, 자동 생성됨 */
  private String thumbs = "";
  
  /** 여러 이미지중에 첫번째 Preview 이미지 저장, 200 X 150 */
  private String thumb = "";
  
  /** 업로드 파일 */
  private String files = "";
  
  /** 업로드된 파일 크기 */
  private String sizes = "";
  
  /** 등록일 */
  private String rdate;
  
  /** 검색어 */
  private String word;

  /** 출력순서 */
  private int seqno;
  
  /** 그룹번호 */
  private int grpno;
  
  /** 답변차수 */
  private int indent;
  
  /** 답변순서 */
  private int ansnum;
  
  /** 출력모드 */
  private String visible;
  
  /** 접근계정 */
  private String id;
  
  /** 등록된 자료수 */
  private int cnt;
    
  /** 
  Spring Framework에서 자동 주입되는 업로드 파일 객체,
  DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
  여러개의 파일 업로드
  */  
  private List<MultipartFile> filesMF;

  /** size1의 컴마 저장 출력용 변수, 실제 컬럼은 존재하지 않음. */
  private String sizesLabel;
  
  public EventVO() {
    
  }
  
  /**
   * @return the thumbs
   */
  public String getThumbs() {
    return thumbs;
  }

  /**
   * @param thumbs the thumbs to set
   */
  public void setThumbs(String thumbs) {
    this.thumbs = thumbs;
  }

  /**
   * @return the files
   */
  public String getFiles() {
    if (this.files == null) {
      return "";
    } else{
      return files;
    }
  }

  /**
   * @param files the files to set
   */
  public void setFiles(String files) {
    this.files = files;
  }

  /**
   * @return the sizes
   */
  public String getSizes() {
    return sizes;
  }

  /**
   * @param sizes the sizes to set
   */
  public void setSizes(String sizes) {
    this.sizes = sizes;
  }
  
  /**
   * @return the sizesLabel
   */
  public String getSizesLabel() {
    return sizesLabel;
  }

  /**
   * @param sizesLabel the sizesLabel to set
   */
  public void setSizesLabel(String sizesLabel) {
    this.sizesLabel = sizesLabel;
  }

  /**
   * @return the filesMF
   */
  public List<MultipartFile> getFilesMF() {
    return filesMF;
  }

  /**
   * @param filesMF the filesMF to set
   */
  public void setFilesMF(List<MultipartFile> filesMF) {
    this.filesMF = filesMF;
  }
  
  /**
   * @return the thumb
   */
  public String getThumb() {
    return thumb;
  }

  /**
   * @param thumb the thumb to set
   */
  public void setThumb(String thumb) {
    this.thumb = thumb;
  }

  public int getEventno() {
    return eventno;
  }

  public void setEventno(int eventno) {
    this.eventno = eventno;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getContents() {
    return contents;
  }

  public void setContents(String contents) {
    this.contents = contents;
  }

  public String getRdate() {
    return rdate;
  }

  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

  public String getWord() {
    return word;
  }

  public void setWord(String word) {
    this.word = word;
  }  

  public int getSeqno() {
    return seqno;
  }

  public void setSeqno(int seqno) {
    this.seqno = seqno;
  }  

  public int getGrpno() {
    return grpno;
  }

  public void setGrpno(int grpno) {
    this.grpno = grpno;
  }

  public int getIndent() {
    return indent;
  }

  public void setIndent(int indent) {
    this.indent = indent;
  }

  public int getAnsnum() {
    return ansnum;
  }

  public void setAnsnum(int ansnum) {
    this.ansnum = ansnum;
  }

  public String getVisible() {
    return visible;
  }

  public void setVisible(String visible) {
    this.visible = visible;
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public int getCnt() {
    return cnt;
  }

  public void setCnt(int cnt) {
    this.cnt = cnt;
  }

  public int getDiecateno() {
    return diecateno;
  }

  public void setDiecateno(int diecateno) {
    this.diecateno = diecateno;
  }
  
}
