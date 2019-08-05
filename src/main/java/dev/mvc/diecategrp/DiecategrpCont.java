package dev.mvc.diecategrp;

import java.util.ArrayList;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DiecategrpCont {
  @Autowired
  @Qualifier("dev.mvc.diecategrp.DiecategrpProc")
  private DiecategrpProcInter diecategrpProc;
  
  public DiecategrpCont() {
    System.out.println("--> DiecategrpCont created.");
  }
  
  /**
   * 등록 폼
   * @return
   */
  @RequestMapping(value="/diecategrp/create.do", method=RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/diecategrp/create"); 
    
    return mav;
  }
  
  /**
   * 등록 처리
   * @param diecategrpVO
   * @return
   */
  @RequestMapping(value="/diecategrp/create.do", method=RequestMethod.POST)
  public ModelAndView create(DiecategrpVO diecategrpVO) {
    ModelAndView mav = new ModelAndView();
        
    int count = diecategrpProc.create(diecategrpVO);
    // mav.addObject("count", count);
    mav.setViewName("redirect:/diecategrp/create_msg.jsp?count=" + count);
    
    return mav;
  }
  
  /**
   * 전체 목록
   * http://localhost:9090/diesta/diecategrp/list.do
   * @return
   */
  @RequestMapping(value="/diecategrp/list.do", method=RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/diecategrp/list"); 
    
    ArrayList<DiecategrpVO> list = diecategrpProc.list();
    mav.addObject("list", list);
    
    return mav;
  }  
  
  /**
   * 조회
   * JSON
   * @param grpno
   * @return
   */
  @ResponseBody
  @RequestMapping(value="/diecategrp/read.do", method=RequestMethod.GET,
                           produces="text/plain;charset=UTF-8")
  public String read(int grpno) {
    try {
      Thread.sleep(1000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    DiecategrpVO diecategrpVO = diecategrpProc.read(grpno);
    JSONObject json = new JSONObject(diecategrpVO);
    
    return json.toString();
  }
  
  /**
   * 수정
   * @param diecategrpVO
   * @return
   */
  @RequestMapping(value="/diecategrp/update.do", method=RequestMethod.POST)
  public ModelAndView update(DiecategrpVO diecategrpVO) {
    ModelAndView mav = new ModelAndView();
   
    int count = diecategrpProc.update(diecategrpVO);
    mav.setViewName("redirect:/diecategrp/update_msg.jsp?count=" + count);
    
    return mav;
  }
  
  /**
   * 한건의 그룹 삭제
   * @param grpno
   * @return
   */    
  @RequestMapping(value="/diecategrp/delete.do", method=RequestMethod.POST)
  public ModelAndView delete(int grpno) {
    ModelAndView mav = new ModelAndView();
   
    int count = diecategrpProc.delete(grpno);
    mav.setViewName("redirect:/diecategrp/list.do");  // 목록으로 바로 이동
    
    return mav;
  }

  // http://localhost:9090/diesta/diecategrp/update_seqno_up.do?grpno=29
  @RequestMapping(value="/diecategrp/update_seqno_up.do", method=RequestMethod.POST)
  public ModelAndView update_seqno_up(int grpno) {
    ModelAndView mav = new ModelAndView();
   
    int count = diecategrpProc.update_seqno_up(grpno);
    mav.setViewName("redirect:/diecategrp/list.do");
    
    return mav;
  }
  
  // http://localhost:9090/diesta/diecategrp/update_seqno_down.do
  @RequestMapping(value="/diecategrp/update_seqno_down.do", method=RequestMethod.POST)
  public ModelAndView update_seqno_down(int grpno) {
    ModelAndView mav = new ModelAndView();
   
    int count = diecategrpProc.update_seqno_down(grpno);
    mav.setViewName("redirect:/diecategrp/list.do");
    
    return mav;
  }
  
}
