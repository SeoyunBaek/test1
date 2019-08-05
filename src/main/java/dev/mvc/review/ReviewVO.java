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
  /** 리뷰 번호 */
  private int reviewno;
  
  /** 상품 번호 */
  private int goodsno;
  
  /** Thumb 파일 */
  private String thumbs="";
  
  /** 여러 이미지중에 첫번째 Preview 이미지 저장, 200 X 150 */
  private String thumb = "";
  
  /** 파일 */
  private String files="";
  
  /** 파일 크기 */
  private String sizes="";
  
  /** 글 리뷰 */
  private String writing;
  
  /** 평점 */
  private String grade;
  
  /** 그룹번호 */
  private int grpno;
  
  /** 답변차수 */
  private int indent;
  
  /** 답변순서 */
  private int ansnum;
  
  /** 검색어 */
  private String word;

  /** 날짜 */
  private String rdate;
    
  /** 
  Spring Framework에서 자동 주입되는 업로드 파일 객체,
  DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
  하나의 파일 업로드
*/  
// private MultipartFile filesMF;

public String getRdate() {
    return rdate;
  }

  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

/** 
Spring Framework에서 자동 주입되는 업로드 파일 객체,
DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
여러개의 파일 업로드
*/  
private List<MultipartFile> filesMF;

/** size1의 컴마 저장 출력용 변수, 실제 컬럼은 존재하지 않음. */
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
