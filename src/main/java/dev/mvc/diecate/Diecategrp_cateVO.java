package dev.mvc.diecate;

public class Diecategrp_cateVO {
  // diecategrp table
  /** 카테고리 번호 */
  private int grpno;
  /**  카테고리 이름 */
  private String name;
  /** 출력순서 */
  private int seqno;
 
  // diecate table
  /** 게시판 번호 */
  private int diecateno;
  /** 게시판 이름 */
  private String title;
  /** 출력순서 */
  private int diecate_seqno;
  /** 출력모드 */
  private String visible;
  /** 접근계정 */
  private String id;
  /** 등록된 자료수 */
  private int cnt;
  /** 게시판 생성일 */
  private String rdate;
  
  
  public int getGrpno() {
    return grpno;
  }
  public void setGrpno(int grpno) {
    this.grpno = grpno;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public int getSeqno() {
    return seqno;
  }
  public void setSeqno(int seqno) {
    this.seqno = seqno;
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
  public int getDiecate_seqno() {
    return diecate_seqno;
  }
  public void setDiecate_seqno(int diecate_seqno) {
    this.diecate_seqno = diecate_seqno;
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