package dev.mvc.employ;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class EmployVO {
  /*employno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    diecateno                         NUMBER(10)     NOT NULL,
    title                             VARCHAR2(50)     NOT NULL,
    contents                          VARCHAR2(2000)     NOT NULL,
    thumbs                            VARCHAR2(1000)     NULL ,
    files                             VARCHAR2(1000)     NULL ,
    sizes                             VARCHAR2(1000)     NULL ,
    id                                VARCHAR2(100)    NOT NULL,
    rdate                             DATE     NOT NULL*/
  /** �����ȣ */
  private int employno;
  
  /** ī�װ���ȣ */
  private int diecateno;
  
  /** ������ */
  private String title;
  
  /** �۳��� */
  private String contents;
  
  /** Preview ���� �̹��� 200 X 150, �ڵ� ������ */
  private String thumbs = "";
  
  /** ���� �̹����߿� ù��° Preview �̹��� ����, 200 X 150 */
  private String thumb = "";
  
  /** ���ε� ���� */
  private String files = "";
  
  /** ���ε�� ���� ũ�� */
  private String sizes = "";
  
  /** ���ٰ��� */
  private String id;
  
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
  
  public EmployVO() {
    
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

  public int getEmployno() {
    return employno;
  }

  public void setEmployno(int employno) {
    this.employno = employno;
  }

  public int getDiecateno() {
    return diecateno;
  }

  public void setDiecateno(int diecateno) {
    this.diecateno = diecateno;
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
  
  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getRdate() {
    return rdate;
  }

  public void setRdate(String rdate) {
    this.rdate = rdate;
  }  
}
