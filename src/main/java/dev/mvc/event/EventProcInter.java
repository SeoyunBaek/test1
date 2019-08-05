package dev.mvc.event;

import java.util.ArrayList;
import java.util.HashMap;

import dev.mvc.goods.FileVO;

public interface EventProcInter {
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
   * 등록된 전체 글수
   * <select id="total_count" resultType="int" > 
   */
  public int total_count();
  
  /**
   * 파일명의 갯수만큼 FileVO 객체를 만들어 리턴
   * @param eventVO
   * @return
   */
  public ArrayList<FileVO> getThumbs(EventVO eventVO);
  
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
   * 검색 목록
   * <select id="list_by_event_search" resultType="EventVO" parameterType="HashMap">
   * @param 
   * @return
   */
  public ArrayList<EventVO> list_by_event_search(HashMap map);
  
  /**
   * 검색된 레코드 갯수
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(HashMap map);
  
  /**
   * 페이지 목록 문자열 생성
   * @param listFile 목록 파일명 
   * @param cateno 카테고리번호
   * @param search_count 검색 갯수
   * @param nowPage 현재 페이지, nowPage는 1부터 시작
   * @param askcont 검색어
   * @return
   */
  public String pagingBox(String listFile, int diecateno, int search_count, int nowPage, String askcont);
  
  /**
   * <xmp>
   * 검색 + 페이징 목록
   * <select id="list_by_event_search_paging" resultType="EventVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<EventVO> list_by_event_search_paging(HashMap<String, Object> map);
}
