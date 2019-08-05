package dev.mvc.review;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ReviewVO {
/*  CREATE TABLE review(
    reviewno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    goodsno                           NUMBER(10)     NOT NULL ,
    thumbs                            VARCHAR2(1000)     NULL ,
    files                             VARCHAR2(1000)     NULL ,
    sizes                             VARCHAR2(1000)     NULL ,
    writing                          VARCHAR2(50)     NOT NULL,
    grade                            VARCHAR2(10)     NOT NULL,    
    grpno                           NUMBER(7)               NOT NULL,
    indent                           NUMBER(2)              DEFAULT 0       NOT NULL,
    ansnum                         NUMBER(5)              DEFAULT 0       NOT NULL,
    word                             VARCHAR2(100)           NULL,
    rdate                             DATE                  NOT NULL,
  );*/
  /** ���� ��ȣ */
  private int reviewno;
  
  /** ��ǰ ��ȣ */
  private int goodsno;
  
  /** Thumb ���� */
  private String thumbs="";
  
  /** ���� �̹����߿� ù��° Preview �̹��� ����, 200 X 150 */
  private String thumb = "";
  
  /** ���� */
  private String files="";
  
  /** ���� ũ�� */
  private String sizes="";
  
  /** �� ���� */
  private String writing;
  
  /** ���� */
  private String grade;
  
  /** �׷��ȣ */
  private int grpno;
  
  /** �亯���� */
  private int indent;
  
  /** �亯���� */
  private int ansnum;
  
  /** �˻��� */
  private String word;

  /** ��¥ */
  private String rdate;
    
  /** 
  Spring Framework���� �ڵ� ���ԵǴ� ���ε� ���� ��ü,
  DBMS �� ���� �÷��� �������� �ʰ� ���� �ӽ� ���� ����.
  �ϳ��� ���� ���ε�
*/  
// private MultipartFile filesMF;

public String getRdate() {
    return rdate;
  }

  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

/** 
Spring Framework���� �ڵ� ���ԵǴ� ���ε� ���� ��ü,
DBMS �� ���� �÷��� �������� �ʰ� ���� �ӽ� ���� ����.
�������� ���� ���ε�
*/  
private List<MultipartFile> filesMF;

/** size1�� �ĸ� ���� ��¿� ����, ���� �÷��� �������� ����. */
private String sizesLabel;

public ReviewVO() {
  
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
  this.files=files;
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

public int getReviewno() {
  return reviewno;
}

public void setReviewno(int reviewno) {
  this.reviewno = reviewno;
}

public int getGoodsno() {
  return goodsno;
}

public void setGoodsno(int goodsno) {
  this.goodsno = goodsno;
}

public String getWriting() {
  return writing;
}

public void setWriting(String writing) {
  this.writing = writing;
}

public String getGrade() {
  return grade;
}

public void setGrade(String grade) {
  this.grade = grade;
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

public String getWord() {
  return word;
}

public void setWord(String word) {
  this.word = word;
}

  
}
