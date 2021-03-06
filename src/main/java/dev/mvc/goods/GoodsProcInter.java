package dev.mvc.goods;

import java.util.ArrayList;
import java.util.HashMap;

public interface GoodsProcInter {
  /**
   * <xmp>
   * 등록
   * <insert id="create" parameterType="GoodsVO">
   * </xmp>
   * @param goodsVO
   * @return 등록된 레코드 개수
   */
  public int create(GoodsVO goodsVO);
  
  /**
   * <xmp>
   * 전체 글 목록
   * <select id="list_all_diecate" resultType="GoodsVO">
   * </xmp>
   * @return
   */  
  public ArrayList<GoodsVO> list_all_diecate();
  
  /**
   * <xmp>
   * 등록된 전체 자료수
   * <select id="total_count" resultType="int">
   * </xmp> 
   */
  public int total_count();
  
  /**
   * <xmp>
   * 카테고리별 목록
   * <select id="list_by_diecate" resultType="GoodsVO" parameterType="int">
   * </xmp> 
   * @return 
   */
  public ArrayList<GoodsVO> list_by_diecate(int diecateno);
  
  /**
   * 파일명의 갯수만큼 FileVO 객체를 만들어 리턴
   * @param goodsVO
   * @return
   */  
  public ArrayList<FileVO> getThumbs(GoodsVO goodsVO);
    
  /**
   * <xmp> 
   * 조회
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
   * 조회수 증가
   * <update id="increaseVisit" parameterType="int">
   * </xmp>
   * @param goodsno
   * @return
   */
  public int increaseVisit(int goodsno);

  /**
   * 글 수 감소
   * <update id="decreaseCnt" parameterType="int">
   * @param goodsno
   * @return
   */
  public int decreaseVisit(int goodsno);
  
  /**
   * <xmp> 
   * 글 수정 
   * <update id="update" parameterType="GoodsVO">
   * </xmp>
   * @param goodsVO
   * @return 처리된 레코드 개수
   */
  public int update(GoodsVO goodsVO);
  
  /**
   * <xmp>
   * 삭제
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param goodsno
   * @return 처리된 레코드 개수
   */
  public int delete(int goodsno);
  
  /**
   * <xmp>
   * 검색 목록
   * <select id="list_by_diecate_search" resultType="GoodsVO" parameterType="HashMap">
   * </xmp>
   * @param diecateno
   * @return
   */  
  public ArrayList<GoodsVO> list_by_diecate_search(HashMap map);
  
  /**
   * <xmp>
   * 카테고리별 검색된 레코드 개수
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * </xmp>
   * @return
   */  
  public int search_count(HashMap map);
    
  /**
   * 페이지 목록 문자열 생성
   * @param listFile 목록 파일명 
   * @param diecateno 카테고리번호
   * @param search_count 검색 갯수
   * @param nowPage 현재 페이지, nowPage는 1부터 시작
   * @param word 검색어
   * @return
   */  
  public String pagingBox(String listFile, int diecateno, int search_count, int nowPage, String word);
    
  /**
   * <xmp>
   * 검색 + 페이징 목록
   * <select id="list_by_diecate_search_paging" resultType="GoodsVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */  
  public ArrayList<GoodsVO> list_by_diecate_search_paging(HashMap<String, Object> map);
  
  
}
