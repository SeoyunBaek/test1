package dev.mvc.mem;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

public interface MemProcInter {
  
  /**
   * 아이디 중복 체크
   * @param id
   * @return
   */
  public int checkId(String id);
  
  /**
   * 회원 가입
   * @param memVO
   * @return
   */
  public int create(MemVO memVO);
  
  /**
   * 회원 전체 목록
   * @return
   */
  public ArrayList<MemVO>list();
  
  /**
   * 조회
   * @param memno
   * @return
   */
  public MemVO read(int memno);
  
  /**
   * id로 조회
   * @param id
   * @return
   */
  public MemVO readById(String id);
  
  /**
   * 수정
   * @param memVO
   * @return
   */
  public int update(MemVO memVO);
  
  /**
   * 권한의 변경
   * @param memVO
   * @return
   */
  public int act_update(MemVO memVO);
  
/**
 * 패스워드 변경
 * @param memno
 * @param new_passwd
 * @return
 */
  public int passwd_update(int memno, String new_passwd);
 
  /**
  * 삭제
  * @param memno
  * @return
  */
  public int delete(int memno);
  
 /**
  * 로그인
  * @param id
  * @param passwd
  * @return
  */
  public int login(String id, String passwd);
  
  /**
   * 로그인된 회원 계정인지 검사합니다.
   * @param request
   * @return true: 관리자
   */
  public boolean isMember(HttpSession session);
  
  /**
   * <select id="read_by_join" resultType="Mem_CustoVO" parameterType="int">
   * @param memno
   * @return
   */
  public Mem_CustoVO read_by_join_m(int memno);
  
  /**
   * 글 수 증가
   * <update id="increaseCnt" parameterType="int">
   * @param memno
   * @return
   */
  public int increaseCnt(int memno);
  
  /**
   * 글 수 감소
   * <update id="decreaseCnt" parameterType="int">
   * @param memno
   * @return
   */
  public int decreaseCnt(int memno);
  
}
