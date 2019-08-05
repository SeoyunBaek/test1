package dev.mvc.diecate;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.diecategrp.DiecategrpProcInter;
import dev.mvc.diecategrp.DiecategrpVO;
import dev.mvc.goods.GoodsProcInter;
import nation.web.tool.Tool;

@Controller
public class DiecateCont {
  @Autowired
  @Qualifier("dev.mvc.diecategrp.DiecategrpProc")
  private DiecategrpProcInter diecategrpProc;
  
  @Autowired
  @Qualifier("dev.mvc.diecate.DiecateProc")
  private DiecateProcInter diecateProc;
  
  @Autowired
  @Qualifier("dev.mvc.goods.GoodsProc")
  private GoodsProcInter goodsProc = null;
  
  public DiecateCont () {
    System.out.println("--> DiecateCont created.");    
  }
  
  /**
   * <xmp>
   * 등록 폼
   * http://localhost:9090/diesta/diecate/create.do
   * </xmp>
   * @return
   */
  @RequestMapping(value="/diecate/create.do", method=RequestMethod.GET)
  public ModelAndView create(int grpno) {
    ModelAndView mav = new ModelAndView();
    
    DiecategrpVO diecategrpVO = diecategrpProc.read(grpno);
    mav.addObject("diecategrpVO", diecategrpVO);
    
    mav.setViewName("/diecate/create"); // /webapp/diecate/create.jsp
   
    return mav;
  }
 
  /**
   * <xmp>
   * 등록 처리 
   * diecateVO는 Form 태그의 값으로 자동 저장
   * http://localhost:9090/diesta/diecate/create.do
   * </xmp>
   * @param diecateVO
   * @return
   */
  @RequestMapping(value="/diecate/create.do", method=RequestMethod.POST)
  public ModelAndView create(DiecateVO diecateVO) {
    ModelAndView mav = new ModelAndView();
   
    int count = diecateProc.create(diecateVO);
    mav.setViewName("redirect:/diecate/create_msg.jsp?count=" + count + "&grpno=" + diecateVO.getGrpno());
   
    return mav;
  }
  
  /**
   * <xmp>
   * 전체 목록
   * http://localhost:9090/diesta/diecate/list.do
   * </xmp>
   * @return
   */
  @RequestMapping(value="/diecate/list.do", method=RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/diecate/list"); // /webapp/diecate/list.jsp
   
    ArrayList<Diecategrp_cateVO> list = diecateProc.list();
    mav.addObject("list", list);
   
    return mav;
  }  
  
  /**
   * <xmp>
   * 목록 (seqno 오름차순 정렬)
   * http://localhost:9090/diesta/diecate/list_by_grpno.do
   * </xmp>
   * @return
   */  
  @RequestMapping(value="/diecate/list_by_grpno.do", method=RequestMethod.GET)
  public ModelAndView list_by_grpno(int grpno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/diecate/list_by_grpno");
    
    ArrayList<Diecategrp_cateVO> list = diecateProc.list_by_grpno(grpno);
    mav.addObject("list", list);
    
    DiecategrpVO diecategrpVO = diecategrpProc.read(grpno);
    mav.addObject("diecategrpVO", diecategrpVO);
    
    return mav;
  }

  /**
   * <xmp>
   * 수정 처리
   * http://localhost:9090/diesta/diecate/update.do?diecateno=1
   * </xmp>
   * @param diecategrp_cateVO
   * @return 처리된 레코드 개수
   */
  @RequestMapping(value="/diecate/update.do", method=RequestMethod.GET)
  public ModelAndView update(int diecateno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/diecate/update");
   
    Diecategrp_cateVO diecategrp_cateVO = diecateProc.read_by_join(diecateno);
    mav.addObject("diecategrp_cateVO", diecategrp_cateVO);
   
    return mav;
  }
 
  /**
   * <xmp>
   * 수정
   * http://localhost:9090/diesta/diecate/update.do
   * </xmp>
   * @param diecateVO
   * @return
   */
  @RequestMapping(value="/diecate/update.do", method=RequestMethod.POST)
  public ModelAndView update(DiecateVO diecateVO) {
    ModelAndView mav = new ModelAndView();
  
    int count = diecateProc.update(diecateVO);
   
    // Spring controller > JSP View EL
    String title = Tool.spring_param_encoding(diecateVO.getTitle());

    mav.setViewName("redirect:/diecate/update_msg.jsp?count=" + count +"&title=" + title + "&grpno="+diecateVO.getGrpno());
   
    return mav;
  }  
 
  /**
   * <xmp>
   * 삭제
   * http://localhost:9090/diesta/diecate/delete.do?diecateno=1
   * </xmp>
   * @param diecateno
   * @return
   */
  @RequestMapping(value="/diecate/delete.do", method=RequestMethod.GET)
  public ModelAndView delete(int diecateno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/diecate/delete"); 
   
    Diecategrp_cateVO diecategrp_cateVO = diecateProc.read_by_join(diecateno);
    mav.addObject("diecategrp_cateVO", diecategrp_cateVO);
   
    return mav;
  }
  
  /**
   * <xmp>
   * 삭제 처리
   * http://localhost:9090/diesta/diecate/delete.do
   * </xmp>
   * @param diecateno
   * @return
   */
  @RequestMapping(value="/diecate/delete.do", method=RequestMethod.POST)
  public ModelAndView delete_proc(int diecateno) {
    ModelAndView mav = new ModelAndView();
  
    Diecategrp_cateVO diecategrp_cateVO = diecateProc.read_by_join(diecateno);
   
    // Spring controller > JSP View EL
    String name = Tool.spring_param_encoding(diecategrp_cateVO.getName());
    String title = Tool.spring_param_encoding(diecategrp_cateVO.getTitle());
   
    int count = diecateProc.delete(diecateno);

    mav.setViewName("redirect:/diecate/delete_msg.jsp?count=" + count+"&name=" + name + "&title=" + title + "&grpno="+diecategrp_cateVO.getGrpno());
   
    return mav;
  }

  // localhost:9090/diesta/diecate/update_seqno_up.do?diecateno=1
  @RequestMapping(value="/diecate/update_seqno_up.do", method=RequestMethod.POST)
  public ModelAndView update_seqno_up(int diecateno) {
    ModelAndView mav = new ModelAndView();
   
    int count = diecateProc.update_seqno_up(diecateno);
    mav.setViewName("redirect:/diecate/list.do");
    
    return mav;
  }
  
  // http://localhost:9090/diesta/diecate/update_seqno_down.do
  @RequestMapping(value="/diecate/update_seqno_down.do", method=RequestMethod.POST)
  public ModelAndView update_seqno_down(int diecateno) {
    ModelAndView mav = new ModelAndView();
   
    int count = diecateProc.update_seqno_down(diecateno);
    mav.setViewName("redirect:/diecate/list.do");
    
    return mav;
  }
}
