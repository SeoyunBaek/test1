package dev.mvc.custo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class CustoVO {
/*
    custoqusno                    NUMBER(10)              NOT NULL    PRIMARY KEY,
    diecateno                       NUMBER(10)              NOT NULL,
    title                               VARCHAR2(50)          NOT NULL,
    askcont                          VARCHAR2(2000)       NOT NULL,
    thumbs                          VARCHAR2(1000)       NULL,
    files                              VARCHAR2(1000)        NULL,
    sizes                             VARCHAR2(1000)        NULL,
    replycnt                         NUMBER(7)               DEFAULT 0       NOT NULL,  
    rdate                             DATE                       NOT NULL,
    grpno                           NUMBER(7)               NOT NULL,
    indent                           NUMBER(2)              DEFAULT 0       NOT NULL,
    ansnum                         NUMBER(5)              DEFAULT 0       NOT NULL,
    answerno                       NUMBER(10)             NOT NULL,
    memno                         NUMBER(10)             NOT NULL,
    word                            VARCHAR2(100)         NULL,
    FOREIGN KEY (memno) REFERENCES mem (memno)
*/
  
  /** 고객문의 번호 */
  private int custoqusno;
  /** 카테고리 번호 */
  private int diecateno;
  /** 제목 */
  private String title;
  /** 문의내용 */
  private String askcont;
  /** Preview 소형 이미지 200 X 150, 자동 생성됨 */
  private String thumbs = "";
  
  /** 여러 이미지중에 첫번째 Preview 이미지 저장, 200 X 150 */
  private String thumb = "";  
  
  /** 업로드 파일 */
  private String files = "";
  
  /** 업로드된 파일 크기 */
  private String sizes = "";
  
  /** 답변 수 */
  private int replycnt;
  
  /** 등록일 */
  private String rdate;
  
  /** 그룹 번호 */
  private int grpno;
  
  /** 답변 차수 */
  private int indent;
  
  /** 답변 순서 */
  private int ansnum;
  
  /** 답변 번호 */ 
  private int answerno;
  /** 회원 번호 */
  private int memno;
  /** 검색어 */
  private String word;  

  /** 
    Spring Framework에서 자동 주입되는 업로드 파일 객체,
    DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
    하나의 파일 업로드
  */  
  // private MultipartFile filesMF;
  
  public int getCustoqusno() {
    return custoqusno;
  }

  public void setCustoqusno(int custoqusno) {
    this.custoqusno = custoqusno;
  }  

  public int getDiecateno() {
    return diecateno;
  }

  public void setDiecateno(int diecateno) {
    this.diecateno = diecateno;
  }

  /**
   * @return the title
   */
  public String getTitle() {
    return title;
  }

  /**
   * @param title the title to set
   */
  public void setTitle(String title) {
    this.title = title;
  }

  public String getAskcont() {
    return askcont;
  }

  public void setAskcont(String askcont) {
    this.askcont = askcont;
  }

  /** 
  Spring Framework에서 자동 주입되는 업로드 파일 객체,
  DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
  여러개의 파일 업로드
  */  
  private List<MultipartFile> filesMF;

  /** size1의 컴마 저장 출력용 변수, 실제 컬럼은 존재하지 않음. */
  private String sizesLabel;
  
  public CustoVO() {
    
  }
  
  public int getAnswerno() {
    return answerno;
  }

  public void setAnswerno(int answerno) {
    this.answerno = answerno;
  }
  
  public int getMemno() {
    return memno;
  }

  public void setMemno(int memno) {
    this.memno = memno;
  }
  
  public String getWord() {
    return word;
  }

  public void setWord(String word) {
    this.word = word;
  }
  

  public int getReplycnt() {
    return replycnt;
  }

  public void setReplycnt(int replycnt) {
    this.replycnt = replycnt;
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
   * @return the rdate
   */
  public String getRdate() {
    return rdate;
  }

  /**
   * @param rdate the rdate to set
   */
  public void setRdate(String rdate) {
    this.rdate = rdate;
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
  
}

  