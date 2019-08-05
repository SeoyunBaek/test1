package dev.mvc.mem;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

public interface MemProcInter {
  
  /**
   * ���̵� �ߺ� üũ
   * @param id
   * @return
   */
  public int checkId(String id);
  
  /**
   * ȸ�� ����
   * @param memVO
   * @return
   */
  public int create(MemVO memVO);
  
  /**
   * ȸ�� ��ü ���
   * @return
   */
  public ArrayList<MemVO>list();
  
  /**
   * ��ȸ
   * @param memno
   * @return
   */
  public MemVO read(int memno);
  
  /**
   * id�� ��ȸ
   * @param id
   * @return
   */
  public MemVO readById(String id);
  
  /**
   * ����
   * @param memVO
   * @return
   */
  public int update(MemVO memVO);
  
  /**
   * ������ ����
   * @param memVO
   * @return
   */
  public int act_update(MemVO memVO);
  
/**
 * �н����� ����
 * @param memno
 * @param new_passwd
 * @return
 */
  public int passwd_update(int memno, String new_passwd);
 
  /**
  * ����
  * @param memno
  * @return
  */
  public int delete(int memno);
  
 /**
  * �α���
  * @param id
  * @param passwd
  * @return
  */
  public int login(String id, String passwd);
  
  /**
   * �α��ε� ȸ�� �������� �˻��մϴ�.
   * @param request
   * @return true: ������
   */
  public boolean isMember(HttpSession session);
  
  /**
   * <select id="read_by_join" resultType="Mem_CustoVO" parameterType="int">
   * @param memno
   * @return
   */
  public Mem_CustoVO read_by_join_m(int memno);
  
  /**
   * �� �� ����
   * <update id="increaseCnt" parameterType="int">
   * @param memno
   * @return
   */
  public int increaseCnt(int memno);
  
  /**
   * �� �� ����
   * <update id="decreaseCnt" parameterType="int">
   * @param memno
   * @return
   */
  public int decreaseCnt(int memno);
  
}
