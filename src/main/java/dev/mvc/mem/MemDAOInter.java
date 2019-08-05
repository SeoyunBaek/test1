package dev.mvc.mem;

import java.util.ArrayList;
import java.util.HashMap;

import dev.mvc.mem.MemVO;

public interface MemDAOInter {
 
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
   * �н������� ����
   * @param map
   * @return
   */
  public int passwd_update(HashMap <String, Object> map);
 
  /**
  * ����
  * @param memno
  * @return
  */
  public int delete(int memno);
  
  /**
   * �α���
   * @param map
   * @return
   */
  public int login(HashMap<String, Object> map);
    
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
