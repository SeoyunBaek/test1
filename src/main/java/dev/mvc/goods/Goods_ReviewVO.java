package dev.mvc.goods;

public class Goods_ReviewVO {
  // goods table
  private int goodsno;
  private String title;
  
  // review table
  private int reviewno;
  private String writing;
  private String grade;
  
  public int getGoodsno() {
    return goodsno;
  }
  public void setGoodsno(int goodsno) {
    this.goodsno = goodsno;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public int getReviewno() {
    return reviewno;
  }
  public void setReviewno(int reviewno) {
    this.reviewno = reviewno;
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
    
}
