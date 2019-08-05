package dev.mvc.mem;

import java.util.ArrayList;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import nation.web.tool.Tool;

@Controller
public class MemCont {
  @Autowired
  @Qualifier("dev.mvc.mem.MemProc")
  private MemProcInter memProc = null;
  
  public MemCont(){
  //System.out.println("--> MemCont created.");
  }
  
  /**
   * 아이디 중복 체크 (JSON)
   * http://localhost:9090/ojt/mem/checkId.do?id=use1
   * 
   * @param id
   * @return 중복된 레코드 갯수
   */
  @ResponseBody
  @RequestMapping(value="/mem/checkId.do", 
                           method=RequestMethod.GET,
                           produces="text/plain;charset=UTF-8")
  public String checkId(String id) {
    //1초
    try {
      Thread.sleep(1000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    int count=memProc.checkId(id);
    
    JSONObject json = new JSONObject();
    json.put("count", count);
    
    return json.toString(); // 문자열로 바껴서 리턴
  }

  /**
   * 회원가입 폼
   * http://localhost:9090/diesta/mem/create.do
   * 
   * @return
   */
  @RequestMapping(value="/mem/create.do", method=RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/mem/create");
    
    return mav;
  }
  
 /**
  * 회원 가입 처리
  * @param memVO
  * @return
  */
  @RequestMapping(value="/mem/create.do", 
                               method=RequestMethod.POST)
  public ModelAndView create(MemVO memVO){
    ModelAndView mav = new ModelAndView();
    
    int count = memProc.create(memVO);
    mav.setViewName("redirect:/mem/create_msg.jsp?count=" + count);
     
    return mav;
  }
  
 /**
  * list
  * @param session
  * @return
  */
  @RequestMapping(value="/mem/list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session){
    // System.out.println("--> create() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/mem/list"); // webapp/mem/list.jsp
    
    if (memProc.isMember(session) == false) {
      mav.setViewName("redirect:/mem/login_need.jsp"); 
    } else {
      mav.setViewName("/mem/list"); // webapp/mem/list.jsp
      
      ArrayList<MemVO> list = memProc.list();
      mav.addObject("list", list);
    }
    
    return mav;
  }   
  
/**
 * 조회
 * @param memno
 * @return
 */
  @RequestMapping(value="/mem/read.do", method=RequestMethod.GET)
  public ModelAndView read(int memno){
    // System.out.println("--> read(int memno) GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/mem/read"); // webapp/mem/read.jsp
    
    MemVO memVO = memProc.read(memno);
    mav.addObject("memVO", memVO);
    
    return mav;
  }  
  
  /**
   *  수정
   * @param redirectAttributes
   * @param request
   * @param memVO
   * @return
   */
  @RequestMapping(value="/mem/update.do", method=RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes,
                                              HttpServletRequest request, MemVO memVO){
    // System.out.println("--> update() POST called.");
    ModelAndView mav = new ModelAndView();
    
    int count = memProc.update(memVO); // 수정
 
    redirectAttributes.addAttribute("count", count); // 1 or 0
    redirectAttributes.addAttribute("memno", memVO.getMemno()); // 회원 번호
    redirectAttributes.addAttribute("name", memVO.getName());
    
    mav.setViewName("redirect:/mem/update_msg.jsp");
   
    return mav;
  }
  
  /**
   * 패스워드 변경폼
   * @return
   */
  @RequestMapping(value="/mem/passwd_update.do", method=RequestMethod.GET)
  public ModelAndView passwd_update(){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/mem/passwd_update"); // webapp/mem/passwd_update.jsp
    
    return mav;
  }  
  
  /**
   * 권한의 변경
   * @param memVO
   * @return
   */
  
  /**
   * 패스워드를 변경 처리
   * @param request
   * @param passwd
   * @param new_passwd
   * @return
   */
  @RequestMapping(value="/mem/passwd_update.do", method=RequestMethod.POST)
  public ModelAndView passwd_update(HttpServletRequest request,
                                                    HttpSession session,
                                                    String passwd,
                                                    String new_passwd){
    // System.out.println("--> passwd_update() POST called.");
    ModelAndView mav = new ModelAndView();
    
    String id = "mem1";
    // String id = (String)session.getAttribute("id"); // session
    int memno = 1;
    // int memno = (Integer)session.getAttribute("memno"); // session
    
    // 로그인 관련 추가 영역
    // int count = memProc.login(id, passwd); // 현재 패스워드 검사
    int count = 1;
    System.out.println("--> count: " + count);
    if (count == 1) { // 로그인한 회원의 패스워드 검사
      int count_update = memProc.passwd_update(memno, new_passwd);
      //System.out.println("--> count_update: " + count_update);
      mav.setViewName("redirect:/mem/passwd_update_msg.jsp?count=" + count_update + "&memno=" + memno);
    } else {
      mav.setViewName("redirect:/mem/login.do");      
    }
    
    return mav;
  } 
  
  /**
   * 삭제 폼
   * @param mno
   * @return
   */
@RequestMapping(value="/mem/delete.do",method=RequestMethod.GET)
public ModelAndView delete(int memno){
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/mem/delete");
  
  MemVO memVO = memProc.read(memno);
  mav.addObject("memVO", memVO);
  
  return mav;
}

/**
 * 삭제 처리
 * @param memno
 * @return
 */
@RequestMapping(value="/mem/delete.do", method=RequestMethod.POST)
public ModelAndView delete_proc(int memno){
  ModelAndView mav = new ModelAndView();
  
  MemVO memVO = memProc.read(memno);
  
  String name=Tool.spring_param_encoding(memVO.getName());
  String id=Tool.spring_param_encoding(memVO.getId());
  
  int count = memProc.delete(memno);
  
  mav.setViewName("redirect:/mem/delete_msg.jsp?count="+count+"&memno=" + memno);
   
  return mav;
}

/**
 * 로그인 폼
 * @return
 */
// http://localhost:9090/mem/mem/login.do 
@RequestMapping(value = "/mem/login.do", 
                           method = RequestMethod.GET)
public ModelAndView login(HttpServletRequest request) {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/mem/login_ck_form"); // /webapp/mem/login_ck_form.jsp
  
  Cookie[] cookies = request.getCookies();
  Cookie cookie = null;

  String ck_id = ""; // id 저장 변수
  String ck_id_save = ""; // id 저장 여부를 체크하는 변수
  String ck_passwd = ""; // passwd 저장 변수
  String ck_passwd_save = ""; // passwd 저장 여부를 체크하는 변수

  if (cookies != null) {
    for (int i=0; i < cookies.length; i++){
      cookie = cookies[i]; // 쿠키 객체 추출
      
      if (cookie.getName().equals("ck_id")){
        ck_id = cookie.getValue(); 
      }else if(cookie.getName().equals("ck_id_save")){
        ck_id_save = cookie.getValue();  // Y, N
      }else if (cookie.getName().equals("ck_passwd")){
        ck_passwd = cookie.getValue();         // 1234
      }else if(cookie.getName().equals("ck_passwd_save")){
        ck_passwd_save = cookie.getValue();  // Y, N
      }
    }
  }
  
  mav.addObject("ck_id", ck_id);
  mav.addObject("ck_id_save", ck_id_save);
  mav.addObject("ck_passwd", ck_passwd);
  mav.addObject("ck_passwd_save", ck_passwd_save);
  
  return mav;
}

/**
 * 로그인 처리
 * @param request
 * @param response
 * @param session
 * @param id
 * @param id_save
 * @param passwd
 * @param passwd_save
 * @return
 */
@RequestMapping(value="/mem/login.do", method=RequestMethod.POST)
public ModelAndView login(HttpServletRequest request, 
                                     HttpServletResponse response,
                                     HttpSession session,
                                     String id, 
                                     @RequestParam(value="id_save", defaultValue="") String id_save,
                                     String passwd,
                                     @RequestParam(value="passwd_save", defaultValue="") String passwd_save){
  // System.out.println("--> login() POST called.");
  ModelAndView mav = new ModelAndView();
  
  if (memProc.login(id, passwd) != 1) { // 로그인 실패시
    mav.setViewName("redirect:/mem/login_msg.jsp");
    
  } else { // 패스워드 일치하는 경우
    MemVO memVO = memProc.readById(id);

    session.setAttribute("memno",  memVO.getMemno()); // session 내부 객체
    session.setAttribute("id", id);
    session.setAttribute("passwd", passwd);
    session.setAttribute("name", memVO.getName());
    
    // -------------------------------------------------------------------
    // id 관련 쿠기 저장
    // -------------------------------------------------------------------
    if (id_save.equals("Y")) { // id를 저장할 경우
      Cookie ck_id = new Cookie("ck_id", id);
      ck_id.setMaxAge(60 * 60 * 72 * 10); // 30 day, 초단위
      response.addCookie(ck_id);
    } else { // N, id를 저장하지 않는 경우
      Cookie ck_id = new Cookie("ck_id", "");
      ck_id.setMaxAge(0);
      response.addCookie(ck_id);
    }
    // id를 저장할지 선택하는  CheckBox 체크 여부
    Cookie ck_id_save = new Cookie("ck_id_save", id_save);
    ck_id_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
    response.addCookie(ck_id_save);
    // -------------------------------------------------------------------

    // -------------------------------------------------------------------
    // Password 관련 쿠기 저장
    // -------------------------------------------------------------------
    if (passwd_save.equals("Y")) { // 패스워드 저장할 경우
      Cookie ck_passwd = new Cookie("ck_passwd", passwd);
      ck_passwd.setMaxAge(60 * 60 * 72 * 10); // 30 day
      response.addCookie(ck_passwd);
    } else { // N, 패스워드를 저장하지 않을 경우
      Cookie ck_passwd = new Cookie("ck_passwd", "");
      ck_passwd.setMaxAge(0);
      response.addCookie(ck_passwd);
    }
    // passwd를 저장할지 선택하는  CheckBox 체크 여부
    Cookie ck_passwd_save = new Cookie("ck_passwd_save", passwd_save);
    ck_passwd_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
    response.addCookie(ck_passwd_save);
    // -------------------------------------------------------------------
    
    // 로그인 내역 추가
    // VO
    // LoginProc.java create method execute
    // LoginVO loginVO = new LoginVO();
    // loginProc.create(loginVO);
    
    mav.setViewName("redirect:/index.do"); // 확장자 명시 
    
  }
  
  return mav;
}


/**
 * 로그아웃 처리
 * @param request
 * @param session
 * @return
 */
@RequestMapping(value="/mem/logout.do", method=RequestMethod.GET)
public ModelAndView logout(HttpServletRequest request, 
                                       HttpSession session){
  // System.out.println("--> logout() GET called.");
  ModelAndView mav = new ModelAndView();

  session.invalidate(); // session 내부 객체의 등록된 모든 session 변수 삭제
  
  // webapp/member/message_logout.jsp
  mav.setViewName("redirect:/mem/logout_msg.jsp"); 
  
  return mav;
}
  
  
}
