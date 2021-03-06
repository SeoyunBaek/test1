package dev.mvc.employ;

import java.util.ArrayList;
import dev.mvc.goods.FileVO;

public interface EmployProcInter {
  /**
   * <insert id="create" parameterType="EmployVO">
   */
  public int create(EmployVO employVO);
  
  /**
   * <select id="list_all_employ" resultType="EmployVO">
   * @return
   */
  public ArrayList<EmployVO> list_all_employ();
  
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
  public ArrayList<FileVO> getThumbs(EmployVO employVO);
    
  /**
   * <select id="read" resultType="EmployVO" parameterType="int">
   * @param eventno
   * @return
   */
  public EmployVO read(int employno);
  
  /**
   * <update id="update" parameterType="EmployVO">
   * @param eventVO
   * @return
   */
  public int update(EmployVO employVO);
  
  /**
   * <delete id="delete" parameterType="int">
   * @param eventno
   * @return
   */
  public int delete(int eventno);
}
