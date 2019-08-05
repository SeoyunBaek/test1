package dev.mvc.review;

import java.util.ArrayList;
import java.util.HashMap;

import dev.mvc.custo.CustoVO;
import dev.mvc.goods.FileVO;

public interface ReviewProcInter {
  /**
   * 등록
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
   * 등록된 전체 글수
   * <select id="total_count" resultType="int" > 
   */
  public int total_count();
  
  /**
   * 파일명의 갯수만큼 FileVO 객체를 만들어 리턴
   * @param reviewVO
   * @return
   */
  public ArrayList<FileVO> getThumbs(ReviewVO reviewVO);
  
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
   * 검색 목록
   * <select id="list_by_review_search" resultType="ReviewVO" parameterType="HashMap">
   * @param cateno
   * @return
   */
  public ArrayList<ReviewVO> list_by_review_search(HashMap map);
  
  /**
   * 검색된 레코드 갯수
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(HashMap map);
  
  /**
   * 페이지 목록 문자열 생성
   * @param listFile 목록 파일명 
   * @param goodsno 상품번호
   * @param search_count 검색 갯수
   * @param nowPage 현재 페이지, nowPage는 1부터 시작
   * @param word 검색어
   * @return
   */
  public String pagingBox(String listFile, int goodsno, int search_count, int nowPage, String word);
  
  /**
   * <xmp>
   * 검색 + 페이징 목록
   * <select id="list_by_review_search_paging" resultType="ReviewVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<ReviewVO> list_by_review_search_paging(HashMap<String, Object> map);
  
  /**
   * 답변 순서 증가
   * <update id="increaseAnsnum" parameterType="HashMap"> 
   * @param map
   * @return
   */
  public int increaseAnsnum(HashMap<String, Object> map);

}
