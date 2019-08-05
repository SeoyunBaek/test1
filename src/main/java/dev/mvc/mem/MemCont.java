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
   * ���̵� �ߺ� üũ (JSON)
   * http://localhost:9090/ojt/mem/checkId.do?id=use1
   * 
   * @param id
   * @return �ߺ��� ���ڵ� ����
   */
  @ResponseBody
  @RequestMapping(value="/mem/checkId.do", 
                           method=RequestMethod.GET,
                           produces="text/plain;charset=UTF-8")
  public String checkId(String id) {
    //1��
    try {
      Thread.sleep(1000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    int count=memProc.checkId(id);
    
    JSONObject json = new JSONObject();
    json.put("count", count);
    
    return json.toString(); // ���ڿ��� �ٲ��� ����
  }

  /**
   * ȸ������ ��
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
  * ȸ�� ���� ó��
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
 * ��ȸ
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
   *  ����
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
    
    int count = memProc.update(memVO); // ����
 
    redirectAttributes.addAttribute("count", count); // 1 or 0
    redirectAttributes.addAttribute("memno", memVO.getMemno()); // ȸ�� ��ȣ
    redirectAttributes.addAttribute("name", memVO.getName());
    
    mav.setViewName("redirect:/mem/update_msg.jsp");
   
    return mav;
  }
  
  /**
   * �н����� ������
   * @return
   */
  @RequestMapping(value="/mem/passwd_update.do", method=RequestMethod.GET)
  public ModelAndView passwd_update(){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/mem/passwd_update"); // webapp/mem/passwd_update.jsp
    
    return mav;
  }  
  
  /**
   * ������ ����
   * @param memVO
   * @return
   */
  
  /**
   * �н����带 ���� ó��
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
    
    // �α��� ���� �߰� ����
    // int count = memProc.login(id, passwd); // ���� �н����� �˻�
    int count = 1;
    System.out.println("--> count: " + count);
    if (count == 1) { // �α����� ȸ���� �н����� �˻�
      int count_update = memProc.passwd_update(memno, new_passwd);
      //System.out.println("--> count_update: " + count_update);
      mav.setViewName("redirect:/mem/passwd_update_msg.jsp?count=" + count_update + "&memno=" + memno);
    } else {
      mav.setViewName("redirect:/mem/login.do");      
    }
    
    return mav;
  } 
  
  /**
   * ���� ��
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
 * ���� ó��
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
 * �α��� ��
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

  String ck_id = ""; // id ���� ����
  String ck_id_save = ""; // id ���� ���θ� üũ�ϴ� ����
  String ck_passwd = ""; // passwd ���� ����
  String ck_passwd_save = ""; // passwd ���� ���θ� üũ�ϴ� ����

  if (cookies != null) {
    for (int i=0; i < cookies.length; i++){
      cookie = cookies[i]; // ��Ű ��ü ����
      
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
 * �α��� ó��
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
  
  if (memProc.login(id, passwd) != 1) { // �α��� ���н�
    mav.setViewName("redirect:/mem/login_msg.jsp");
    
  } else { // �н����� ��ġ�ϴ� ���
    MemVO memVO = memProc.readById(id);

    session.setAttribute("memno",  memVO.getMemno()); // session ���� ��ü
    session.setAttribute("id", id);
    session.setAttribute("passwd", passwd);
    session.setAttribute("name", memVO.getName());
    
    // -------------------------------------------------------------------
    // id ���� ��� ����
    // -------------------------------------------------------------------
    if (id_save.equals("Y")) { // id�� ������ ���
      Cookie ck_id = new Cookie("ck_id", id);
      ck_id.setMaxAge(60 * 60 * 72 * 10); // 30 day, �ʴ���
      response.addCookie(ck_id);
    } else { // N, id�� �������� �ʴ� ���
      Cookie ck_id = new Cookie("ck_id", "");
      ck_id.setMaxAge(0);
      response.addCookie(ck_id);
    }
    // id�� �������� �����ϴ�  CheckBox üũ ����
    Cookie ck_id_save = new Cookie("ck_id_save", id_save);
    ck_id_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
    response.addCookie(ck_id_save);
    // -------------------------------------------------------------------

    // -------------------------------------------------------------------
    // Password ���� ��� ����
    // -------------------------------------------------------------------
    if (passwd_save.equals("Y")) { // �н����� ������ ���
      Cookie ck_passwd = new Cookie("ck_passwd", passwd);
      ck_passwd.setMaxAge(60 * 60 * 72 * 10); // 30 day
      response.addCookie(ck_passwd);
    } else { // N, �н����带 �������� ���� ���
      Cookie ck_passwd = new Cookie("ck_passwd", "");
      ck_passwd.setMaxAge(0);
      response.addCookie(ck_passwd);
    }
    // passwd�� �������� �����ϴ�  CheckBox üũ ����
    Cookie ck_passwd_save = new Cookie("ck_passwd_save", passwd_save);
    ck_passwd_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
    response.addCookie(ck_passwd_save);
    // -------------------------------------------------------------------
    
    // �α��� ���� �߰�
    // VO
    // LoginProc.java create method execute
    // LoginVO loginVO = new LoginVO();
    // loginProc.create(loginVO);
    
    mav.setViewName("redirect:/index.do"); // Ȯ���� ��� 
    
  }
  
  return mav;
}


/**
 * �α׾ƿ� ó��
 * @param request
 * @param session
 * @return
 */
@RequestMapping(value="/mem/logout.do", method=RequestMethod.GET)
public ModelAndView logout(HttpServletRequest request, 
                                       HttpSession session){
  // System.out.println("--> logout() GET called.");
  ModelAndView mav = new ModelAndView();

  session.invalidate(); // session ���� ��ü�� ��ϵ� ��� session ���� ����
  
  // webapp/member/message_logout.jsp
  mav.setViewName("redirect:/mem/logout_msg.jsp"); 
  
  return mav;
}
  
  
}
