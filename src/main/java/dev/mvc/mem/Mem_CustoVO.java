package dev.mvc.mem;

public class Mem_CustoVO {
  // mem table
  private String name;
  private int memno;
  
  // custo_qus table
  private int custoqusno;
  private String title;
  private String askcont;
  private int answerno;

  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public int getMemno() {
    return memno;
  }
  public void setMemno(int memno) {
    this.memno = memno;
  }
  public int getCustoqusno() {
    return custoqusno;
  }
  public void setCustoqusno(int custoqusno) {
    this.custoqusno = custoqusno;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getAskcont() {
    return askcont;
  }
  public void setAskcont(String askcont) {
    this.askcont = askcont;
  }
  
  public int getAnswerno() {
    return answerno;
  }
  public void setAnswerno(int answerno) {
    this.answerno = answerno;
  }
  
}
