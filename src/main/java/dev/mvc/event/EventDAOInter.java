package dev.mvc.event;

import java.util.ArrayList;
import java.util.HashMap;

import dev.mvc.review.ReviewVO;

public interface EventDAOInter {  
  /**
   * <insert id="create" parameterType="EventVO">
   */
  public int create(EventVO eventVO);
  
  /**
   * <select id="list_all_event" resultType="EventVO">    
   * @return
   */
  public ArrayList<EventVO> list_all_event();
  
  /**
   * ��ϵ� ��ü �ۼ�
   * <select id="total_count" resultType="int" > 
   */
  public int total_count();
  
  /**
   * <select id="read" resultType="EventVO" parameterType="int">
   * @param eventno
   * @return
   */
  public EventVO read(int eventno);

  /**
   * <update id="update" parameterType="EventVO">
   * @param eventVO
   * @return
   */
  public int update(EventVO eventVO);
  
  /**
   * <delete id="delete" parameterType="int">
   * @param eventno
   * @return
   */
  public int delete(int eventno);
  
  /**
   * �˻� ���
   * <select id="list_by_event_search" resultType="EventVO" parameterType="HashMap">
   * @param 
   * @return
   */
  public ArrayList<EventVO> list_by_event_search(HashMap map);
  
  /**
   * �˻��� ���ڵ� ����
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(HashMap map);
  
  /**
   * <xmp>
   * �˻� + ����¡ ���
   * <select id="list_by_event_search_paging" resultType="EventVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<EventVO> list_by_event_search_paging(HashMap<String, Object> map);

}
