package dev.mvc.diecategrp;

import java.util.ArrayList;

public interface DiecategrpProcInter {
  /**
   * <Xmp>
   * 카테고리 그룹 등록
   * <insert id="create" parameterType="DiecategrpVO"> 
   * </Xmp>
   * @param diecategrpVO
   * @return 처리된 레코드 갯수
   */
  public int create(DiecategrpVO diecategrpVO);
  
  /**
   * <xmp>
   * seqno 오름차순 목록
   * <select id="list" resultType="DiecategrpVO" >
   * </xmp>
   * @return ArrayList<DiecategrpVO>
   */
  public ArrayList<DiecategrpVO> list();  

  /**
   * 조회
   * <xmp>
   *   <select id="read" resultType="DiecategrpVO" parameterType="int">
   * </xmp>  
   * @param grpno
   * @return
   */
  public DiecategrpVO read(int grpno);
 
  /**
   * 수정 처리
   * <xmp>
   *   <update id="update" parameterType="DiecategrpVO"> 
   * </xmp>
   * @param diecategrpVO
   * @return 처리된 레코드 갯수
   */
  public int update(DiecategrpVO diecategrpVO);

  /**
   * 삭제 처리
   * <xmp>
   *   <delete id="delete" parameterType="int">
   * </xmp> 
   * @param grpno
   * @return 처리된 레코드 갯수
   */
  public int delete(int grpno);

  /**
   * 출력 순서 상향
   * <xmp>
   * <update id="update_seqno_up" parameterType="int">
   * </xmp>
   * @param grpno
   * @return 처리된 레코드 갯수
   */
    public int update_seqno_up(int grpno);
 
  /**
   * 출력 순서 하향
   * <xmp>
   * <update id="update_seqno_down" parameterType="int">
   * </xmp>
   * @param grpno
   * @return 처리된 레코드 갯수
   */
    public int update_seqno_down(int grpno);

}
