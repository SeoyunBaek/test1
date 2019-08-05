package dev.mvc.mem;

public class MemVO {
  
  /*memno             NUMBER(10)     NOT NULL, -- 회원 번호 
  id                    VARCHAR(50)   NOT NULL, -- 아이디
  passwd            NUMBER(10)     NOT NULL, -- 비밀번호   
  name               VARCHAR(50)   NOT NULL, -- 이름 
  zipcode            VARCHAR(50)     NOT NULL, -- 우편번호
  address1          VARCHAR(50)    NOT NULL, -- 기본 주소
  address2          VARCHAR(50)    NOT NULL, -- 상세 주소
  phone              VARCHAR(50)     NOT NULL, -- 휴대 전화
  email               VARCHAR(50)    UNIQUE NOT NULL, -- 이메일
  act                   CHAR(1)            DEFAULT 'N' NOT NULL, -- M: 마스터, Y: 로그인 가능, N: 로그인 불가, H: 인증 대기, G: 손님, C: 탈퇴
  PRIMARY KEY (memno) */

  /** 회원 번호 */
  private int memno;
  /** 아이디 */
  private String id = "";
  /** 비밀번호 */
  private String passwd = "";
  /** 이름 */
  private String name = "";
  /** 우편 번호 */
  private String zipcode = "";
  /** 기본 주소 */
  private String address1 = "";
  /** 상세 주소 */
  private String address2 = "";
  /** 휴대 전화 */
  private String phone = "";
  /** 이메일 */
  private String email = "";
  /** 등급 */
  private String act = "";
  
  /** 등록된 패스워드 */
  private String old_passwd = "";
  /** id 저장 여부 */
  private String id_save = "";
  /** passwd 저장 여부 */
  private String passwd_save = "";
  /** 이동할 주소 저장 */
  private String url_address = "";
  
  
  public int getMemno() {
    return memno;
  }
  public void setMemno(int memno) {
    this.memno = memno;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getPasswd() {
    return passwd;
  }
  public void setPasswd(String passwd) {
    this.passwd = passwd;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getZipcode() {
    return zipcode;
  }
  public void setZipcode(String zipcode) {
    this.zipcode = zipcode;
  }
  public String getAddress1() {
    return address1;
  }
  public void setAddress1(String address1) {
    this.address1 = address1;
  }
  public String getAddress2() {
    return address2;
  }
  public void setAddress2(String address2) {
    this.address2 = address2;
  }
  public String getPhone() {
    return phone;
  }
  public void setPhone(String phone) {
    this.phone = phone;
  }
  public String getEmail() {
    return email;
  }
  public void setEmail(String email) {
    this.email = email;
  }
  public String getAct() {
    return act;
  }
  public void setAct(String act) {
    this.act = act;
  }
  public String getOld_passwd() {
    return old_passwd;
  }
  public void setOld_passwd(String old_passwd) {
    this.old_passwd = old_passwd;
  }
  public String getId_save() {
    return id_save;
  }
  public void setId_save(String id_save) {
    this.id_save = id_save;
  }
  public String getPasswd_save() {
    return passwd_save;
  }
  public void setPasswd_save(String passwd_save) {
    this.passwd_save = passwd_save;
  }
  public String getUrl_address() {
    return url_address;
  }
  public void setUrl_address(String url_address) {
    this.url_address = url_address;
  }
  
  
}
