package dev.mvc.mem;

public class MemVO {
  
  /*memno             NUMBER(10)     NOT NULL, -- ȸ�� ��ȣ 
  id                    VARCHAR(50)   NOT NULL, -- ���̵�
  passwd            NUMBER(10)     NOT NULL, -- ��й�ȣ   
  name               VARCHAR(50)   NOT NULL, -- �̸� 
  zipcode            VARCHAR(50)     NOT NULL, -- �����ȣ
  address1          VARCHAR(50)    NOT NULL, -- �⺻ �ּ�
  address2          VARCHAR(50)    NOT NULL, -- �� �ּ�
  phone              VARCHAR(50)     NOT NULL, -- �޴� ��ȭ
  email               VARCHAR(50)    UNIQUE NOT NULL, -- �̸���
  act                   CHAR(1)            DEFAULT 'N' NOT NULL, -- M: ������, Y: �α��� ����, N: �α��� �Ұ�, H: ���� ���, G: �մ�, C: Ż��
  PRIMARY KEY (memno) */

  /** ȸ�� ��ȣ */
  private int memno;
  /** ���̵� */
  private String id = "";
  /** ��й�ȣ */
  private String passwd = "";
  /** �̸� */
  private String name = "";
  /** ���� ��ȣ */
  private String zipcode = "";
  /** �⺻ �ּ� */
  private String address1 = "";
  /** �� �ּ� */
  private String address2 = "";
  /** �޴� ��ȭ */
  private String phone = "";
  /** �̸��� */
  private String email = "";
  /** ��� */
  private String act = "";
  
  /** ��ϵ� �н����� */
  private String old_passwd = "";
  /** id ���� ���� */
  private String id_save = "";
  /** passwd ���� ���� */
  private String passwd_save = "";
  /** �̵��� �ּ� ���� */
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
