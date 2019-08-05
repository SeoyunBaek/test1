package dev.mvc.diecate;

import java.util.ArrayList;

public interface DiecateProcInter {
  /**
   * <xmp>
   * ī�װ� ���
   * <insert id="create" parameterType="DiecateVO">
   * </xmp>
   * @param diecateVO
   * @return ��ϵ� ���ڵ� ����
   */
  public int create(DiecateVO diecateVO);

  /**
   * <xmp>
   * ��� ī�װ� join(����) ���
   * <select id="list" resultType="Diecategrp_cateVO" >
   * </xmp> 
   * @return
   */
  public ArrayList<Diecategrp_cateVO> list();
  
  /**
   * <xmp>
   * ī�װ� �׷� ��ȣ�� ���� ī�װ� ���
   * <select id="list_by_grpno" resultType="Diecategrp_cateVO"  parameterType="int">
   * </xmp>
   * @return
   */
  public ArrayList<Diecategrp_cateVO> list_by_grpno(int grpno);
  
  /**
   * <xmp>
   * ��ȸ
   * <select id="read" resultType="DiecateVO" parameterType="int">
   * </xmp>
   * @param diecateno
   * @return 
   */
  public DiecateVO read(int diecateno);
  
  /**
   * <select id="read_by_join" resultType="Goods_ReviewVO" parameterType="int">
   * @param memno
   * @return
   */
  public Diecate_EventVO read_by_join_e(int diecateno);
  
  /**
   * <xmp> 
   * ��ȸ
   * <select id="read_by_join" resultType="Diecategrp_cateVO" parameterType="int">
   * </xmp>
   * @param diecateno
   * @return �Ѱ��� ī�װ�
   */
  public Diecategrp_cateVO read_by_join(int diecateno);
  
  /**
   * <xmp>
   * ���� ó��
   * <update id="update" parameterType="DiecateVO">
   * </xmp>
   * @param diecateVO
   * @return ó���� ���ڵ� ����
   */
  public int update(DiecateVO diecateVO);
  
  /**
   * <xmp>
   * ���� ó��
   * <delete id="delete" parameterType="int">
   * </xmp>
   * @param diecateno
   * @return ó���� ���ڵ� ����
   */
  public int delete(int diecateno);
  
  /**
   * <xmp>
   * ��� ���� ���� 10 -> 1  
   * <update id="update_seqno_up" parameterType="int">
   * </xmp>
   * @param diecateno
   * @return ó���� ���ڵ� ����
   */
  public int update_seqno_up(int diecateno);
  
  /**
   * <xmp>
   * ��� ���� ���� 1 -> 10
   * <update id="update_seqno_down" parameterType="int">
   * </xmp>
   * @param diecateno
   * @return ó���� ���ڵ� ����
   */
  public int update_seqno_down(int diecateno);
  
  /**
   * �� �� ����
   * <update id="increaseCnt" parameterType="int">
   * @param diecateno
   * @return
   */
  public int increaseCnt(int diecateno);
  
  /**
   * �� �� ����
   * <update id="decreaseCnt" parameterType="int">
   * @param diecateno
   * @return
   */
  public int decreaseCnt(int diecateno);
  
}
