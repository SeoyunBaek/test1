package dev.mvc.diecate;

public class Diecate_EventVO {
  // diecate table
  /** ī�װ� ��ȣ */
  private int diecateno;
  /**  ī�װ� �̸� */
  private String title;
  
  // event table
  /** �Խ��� ��ȣ */
  private int eventno;
  /** ���� */
  private String contents;
  /** ���ٰ��� */
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
