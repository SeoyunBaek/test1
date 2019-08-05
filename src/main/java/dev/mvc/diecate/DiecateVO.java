package dev.mvc.diecate;

/*
    diecateno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    grpno                             NUMBER(10)     NULL ,
    title                             VARCHAR2(50)     NOT NULL,
    seqno                             NUMBER(5)    NOT NULL,
    visible                           CHAR(1)    DEFAULT 'Y'     NOT NULL,
    id                                VARCHAR2(100)    NOT NULL,
    cnt                               NUMBER(10)     DEFAULT 0     NOT NULL,
    rdate                             DATE     NOT NULL,
 */

public class DiecateVO {
  /** �Խ��� ��ȣ */
  private int diecateno;
  /** ī�װ� �׷� ��ȣ */
  private int grpno;
  /** �Խ��� �̸� */
  private String title;
  /** ��¼��� */
  private int seqno;
  /** ��¸�� */
  private String visible;
  /** ���ٰ��� */
  private String id;
  /** ��ϵ� �ڷ�� */
  private int cnt;
  /** �Խ��� ������ */
  private String rdate;
  
  
  public int getDiecateno() {
    return diecateno;
  }
  public void setDiecateno(int diecateno) {
    this.diecateno = diecateno;
  }
  public int getGrpno() {
    return grpno;
  }
  public void setGrpno(int grpno) {
    this.grpno = grpno;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public int getSeqno() {
    return seqno;
  }
  public void setSeqno(int seqno) {
    this.seqno = seqno;
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
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  
   
    
}
