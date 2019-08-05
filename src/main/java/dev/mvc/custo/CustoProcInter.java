package dev.mvc.custo;

import java.util.ArrayList;
import java.util.HashMap;

import dev.mvc.goods.FileVO;

public interface CustoProcInter {
  /**
   * <insert id="create" parameterType="CustoVO">
   * @param diesVO
   * @return
   */
  public int create(CustoVO custoVO);
  
  /**
   * <select id="list_all_custo" resultType="CustoVO">    
   * @return
   */
  public ArrayList<CustoVO> list_all_custo();
  
  /**
   * 등록된 전체 글수
   * <select id="total_count" resultType="int" > 
   */
  public int total_count();
  
  /**
   * 파일명의 갯수만큼 FileVO 객체를 만들어 리턴
   * @param custoVO
   * @return
   */
  public ArrayList<FileVO> getThumbs(CustoVO custoVO);
  
  /**
   * <select id="read" resultType="CustoVO" parameterType="int">
   * @param diecateno
   * @return
   */
  public CustoVO read(int custoqusno);
  
  /**
   * <select id="read_by_join" resultType="Mem_CustoVO" parameterType="int">
   * @param memno
   * @return
   */
  public CustoVO read_by_join_m(int memno);
  
  /**
   * <select id="read_by_join" resultType="Mem_CustoVO" parameterType="int">
   * @param memno
   * @return
   */
  // public Custo_CtsansVO read_by_join_c(int custoqusno);
  
  /**
   * <update id="update" parameterType="CustoVO">
   * @param custoVO
   * @return
   */
  public int update(CustoVO custoVO);
  
  /**
   * <delete id="delete" parameterType="int">
   * @param custoqusno
   * @return
   */
  public int delete(int custoqusno);
  
  /**
   * 검색 목록
   * <select id="list_by_custo_search" resultType="CustoVO" parameterType="HashMap">
   * @param cateno
   * @return
   */
  public ArrayList<CustoVO> list_by_custo_search(HashMap map);
  
  /**
   * cate별 검색된 레코드 갯수
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
   * <select id="list_by_custo_search_paging" resultType="CustoVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<CustoVO> list_by_custo_search_paging(HashMap<String, Object> map);
  
  /**
   * 답변 순서 증가
   * <update id="increaseAnsnum" parameterType="HashMap"> 
   * @param map
   * @return
   */
  public int increaseAnsnum(HashMap<String, Object> map);
  
  /**
   * <xmp>
   * 답변
   * <insert id="reply" parameterType="CustoVO">
   * </xmp>
   * @param custoVO
   * @return
   */
  public int reply(CustoVO custoVO);
  
}
