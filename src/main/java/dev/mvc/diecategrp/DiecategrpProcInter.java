package dev.mvc.diecategrp;

import java.util.ArrayList;

public interface DiecategrpProcInter {
  /**
   * <Xmp>
   * ī�װ� �׷� ���
   * <insert id="create" parameterType="DiecategrpVO"> 
   * </Xmp>
   * @param diecategrpVO
   * @return ó���� ���ڵ� ����
   */
  public int create(DiecategrpVO diecategrpVO);
  
  /**
   * <xmp>
   * seqno �������� ���
   * <select id="list" resultType="DiecategrpVO" >
   * </xmp>
   * @return ArrayList<DiecategrpVO>
   */
  public ArrayList<DiecategrpVO> list();  

  /**
   * ��ȸ
   * <xmp>
   *   <select id="read" resultType="DiecategrpVO" parameterType="int">
   * </xmp>  
   * @param grpno
   * @return
   */
  public DiecategrpVO read(int grpno);
 
  /**
   * ���� ó��
   * <xmp>
   *   <update id="update" parameterType="DiecategrpVO"> 
   * </xmp>
   * @param diecategrpVO
   * @return ó���� ���ڵ� ����
   */
  public int update(DiecategrpVO diecategrpVO);

  /**
   * ���� ó��
   * <xmp>
   *   <delete id="delete" parameterType="int">
   * </xmp> 
   * @param grpno
   * @return ó���� ���ڵ� ����
   */
  public int delete(int grpno);

  /**
   * ��� ���� ����
   * <xmp>
   * <update id="update_seqno_up" parameterType="int">
   * </xmp>
   * @param grpno
   * @return ó���� ���ڵ� ����
   */
    public int update_seqno_up(int grpno);
 
  /**
   * ��� ���� ����
   * <xmp>
   * <update id="update_seqno_down" parameterType="int">
   * </xmp>
   * @param grpno
   * @return ó���� ���ڵ� ����
   */
    public int update_seqno_down(int grpno);

}
