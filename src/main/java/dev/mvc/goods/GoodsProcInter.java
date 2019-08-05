package dev.mvc.goods;

import java.util.ArrayList;
import java.util.HashMap;

public interface GoodsProcInter {
  /**
   * <xmp>
   * ���
   * <insert id="create" parameterType="GoodsVO">
   * </xmp>
   * @param goodsVO
   * @return ��ϵ� ���ڵ� ����
   */
  public int create(GoodsVO goodsVO);
  
  /**
   * <xmp>
   * ��ü �� ���
   * <select id="list_all_diecate" resultType="GoodsVO">
   * </xmp>
   * @return
   */  
  public ArrayList<GoodsVO> list_all_diecate();
  
  /**
   * <xmp>
   * ��ϵ� ��ü �ڷ��
   * <select id="total_count" resultType="int">
   * </xmp> 
   */
  public int total_count();
  
  /**
   * <xmp>
   * ī�װ��� ���
   * <select id="list_by_diecate" resultType="GoodsVO" parameterType="int">
   * </xmp> 
   * @return 
   */
  public ArrayList<GoodsVO> list_by_diecate(int diecateno);
  
  /**
   * ���ϸ��� ������ŭ FileVO ��ü�� ����� ����
   * @param goodsVO
   * @return
   */  
  public ArrayList<FileVO> getThumbs(GoodsVO goodsVO);
    
  /**
   * <xmp> 
   * ��ȸ
   * <select id="read" resultType="GoodsVO" parameterType="int">
   * </xmp> 
   * @param goodsno
   * @return
   */
  public GoodsVO read(int goodsno);
  
  /**
   * <select id="read_by_join" resultType="Goods_ReviewVO" parameterType="int">
   * @param memno
   * @return
   */
  public Goods_ReviewVO read_by_join(int goodsno);
 
  /**
   * <xmp>
   * ��ȸ�� ����
   * <update id="increaseVisit" parameterType="int">
   * </xmp>
   * @param goodsno
   * @return
   */
  public int increaseVisit(int goodsno);

  /**
   * �� �� ����
   * <update id="decreaseCnt" parameterType="int">
   * @param goodsno
   * @return
   */
  public int decreaseVisit(int goodsno);
  
  /**
   * <xmp> 
   * �� ���� 
   * <update id="update" parameterType="GoodsVO">
   * </xmp>
   * @param goodsVO
   * @return ó���� ���ڵ� ����
   */
  public int update(GoodsVO goodsVO);
  
  /**
   * <xmp>
   * ����
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param goodsno
   * @return ó���� ���ڵ� ����
   */
  public int delete(int goodsno);
  
  /**
   * <xmp>
   * �˻� ���
   * <select id="list_by_diecate_search" resultType="GoodsVO" parameterType="HashMap">
   * </xmp>
   * @param diecateno
   * @return
   */  
  public ArrayList<GoodsVO> list_by_diecate_search(HashMap map);
  
  /**
   * <xmp>
   * ī�װ��� �˻��� ���ڵ� ����
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * </xmp>
   * @return
   */  
  public int search_count(HashMap map);
    
  /**
   * ������ ��� ���ڿ� ����
   * @param listFile ��� ���ϸ� 
   * @param diecateno ī�װ���ȣ
   * @param search_count �˻� ����
   * @param nowPage ���� ������, nowPage�� 1���� ����
   * @param word �˻���
   * @return
   */  
  public String pagingBox(String listFile, int diecateno, int search_count, int nowPage, String word);
    
  /**
   * <xmp>
   * �˻� + ����¡ ���
   * <select id="list_by_diecate_search_paging" resultType="GoodsVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */  
  public ArrayList<GoodsVO> list_by_diecate_search_paging(HashMap<String, Object> map);
  
  
}
