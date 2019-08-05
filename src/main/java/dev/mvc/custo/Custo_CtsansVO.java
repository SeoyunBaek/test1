package dev.mvc.custo;

public class Custo_CtsansVO {
  // custo_qus table
  private int custoqusno;
  private String title;
  private String askcont;
  
  // ctsans table
  private int answerno;
  private String answer;
  
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
  public String getAnswer() {
    return answer;
  }
  public void setAnswer(String answer) {
    this.answer = answer;
  }  
  
}
