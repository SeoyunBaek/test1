package dev.mvc.diecate;

import java.util.ArrayList;

public interface DiecateProcInter {
  /**
   * <xmp>
   * 카테고리 등록
   * <insert id="create" parameterType="DiecateVO">
   * </xmp>
   * @param diecateVO
   * @return 등록된 레코드 개수
   */
  public int create(DiecateVO diecateVO);

  /**
   * <xmp>
   * 모든 카테고리 join(결합) 목록
   * <select id="list" resultType="Diecategrp_cateVO" >
   * </xmp> 
   * @return
   */
  public ArrayList<Diecategrp_cateVO> list();
  
  /**
   * <xmp>
   * 카테고리 그룹 번호에 의한 카테고리 목록
   * <select id="list_by_grpno" resultType="Diecategrp_cateVO"  parameterType="int">
   * </xmp>
   * @return
   */
  public ArrayList<Diecategrp_cateVO> list_by_grpno(int grpno);
  
  /**
   * <xmp>
   * 조회
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
   * 조회
   * <select id="read_by_join" resultType="Diecategrp_cateVO" parameterType="int">
   * </xmp>
   * @param diecateno
   * @return 한건의 카테고리
   */
  public Diecategrp_cateVO read_by_join(int diecateno);
  
  /**
   * <xmp>
   * 수정 처리
   * <update id="update" parameterType="DiecateVO">
   * </xmp>
   * @param diecateVO
   * @return 처리된 레코드 개수
   */
  public int update(DiecateVO diecateVO);
  
  /**
   * <xmp>
   * 삭제 처리
   * <delete id="delete" parameterType="int">
   * </xmp>
   * @param diecateno
   * @return 처리된 레코드 개수
   */
  public int delete(int diecateno);
  
  /**
   * <xmp>
   * 출력 순서 상향 10 -> 1  
   * <update id="update_seqno_up" parameterType="int">
   * </xmp>
   * @param diecateno
   * @return 처리된 레코드 개수
   */
  public int update_seqno_up(int diecateno);
  
  /**
   * <xmp>
   * 출력 순서 하향 1 -> 10
   * <update id="update_seqno_down" parameterType="int">
   * </xmp>
   * @param diecateno
   * @return 처리된 레코드 개수
   */
  public int update_seqno_down(int diecateno);
  
  /**
   * 글 수 증가
   * <update id="increaseCnt" parameterType="int">
   * @param diecateno
   * @return
   */
  public int increaseCnt(int diecateno);
  
  /**
   * 글 수 감소
   * <update id="decreaseCnt" parameterType="int">
   * @param diecateno
   * @return
   */
  public int decreaseCnt(int diecateno);
  
}
