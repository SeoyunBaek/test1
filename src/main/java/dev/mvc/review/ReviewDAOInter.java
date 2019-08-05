package dev.mvc.review;

import java.util.ArrayList;
import java.util.HashMap;

public interface ReviewDAOInter {
  /**
   * ���
   * @param reviewVO
   * @return
   */
  public int create(ReviewVO reviewVO);

  /**
   * <select id="list_all_review" resultType="ReviewVO">
   * @return
   */
  public ArrayList<ReviewVO> list_all_review();
  
  /**
   * ��ϵ� ��ü �ۼ�
   * <select id="total_count" resultType="int" > 
   */
  public int total_count();
  
  /**
   * <select id="read" resultType="ReviewVO" parameterType="int">
   * @param reviewno
   * @return
   */
  public ReviewVO read(int reviewno);
  
  /**
   * <select id="read_by_join" resultType="Goods_ReviewVO" parameterType="int">
   * @param memno
   * @return
   */
  public ReviewVO read_by_join(int goodsno);
  
  /**
   * <update id="update" parameterType="ReviewVO">
   * 
   * @param reviewVO
   * @return
   */
  public int update(ReviewVO reviewVO);
  
  /**
   * <delete id="delete" parameterType="int">
   * @param reviewno
   * @return
   */
  public int delete(int reviewno);
  
  /**
   * �˻� ���
   * <select id="list_by_review_search" resultType="ReviewVO" parameterType="HashMap">
   * @param cateno
   * @return
   */
  public ArrayList<ReviewVO> list_by_review_search(HashMap map);
  
  /**
   * �˻��� ���ڵ� ����
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(HashMap map);
  
  /**
   * <xmp>
   * �˻� + ����¡ ���
   * <select id="list_by_review_search_paging" resultType="ReviewVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<ReviewVO> list_by_review_search_paging(HashMap<String, Object> map);
  
  /**
   * �亯 ���� ����
   * <update id="increaseAnsnum" parameterType="HashMap"> 
   * @param map
   * @return
   */
  public int increaseAnsnum(HashMap<String, Object> map);

  
}
