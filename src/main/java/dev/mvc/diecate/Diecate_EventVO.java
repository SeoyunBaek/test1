package dev.mvc.diecate;

public class Diecate_EventVO {
  // diecate table
  /** 카테고리 번호 */
  private int diecateno;
  /**  카테고리 이름 */
  private String title;
  
  // event table
  /** 게시판 번호 */
  private int eventno;
  /** 내용 */
  private String contents;
  /** 접근계정 */
  private String id;
  
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
  public int getEventno() {
    return eventno;
  }
  public void setEventno(int eventno) {
    this.eventno = eventno;
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
}
