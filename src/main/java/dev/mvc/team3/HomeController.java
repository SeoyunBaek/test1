package dev.mvc.team3;
 
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
 
@Controller
public class HomeController {
  @RequestMapping(value = "/", method = RequestMethod.GET)
  public ModelAndView home1() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("redirect:/index.jsp"); // 파일 확장자 포함
    
    return mav;
  }
  
  @RequestMapping(value = "/home.do", method = RequestMethod.GET)
  public ModelAndView home2() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("redirect:/index.jsp"); // 파일 확장자 포함
    
    return mav;
  }
  
  // http://localhost:9090/ojt/index.do
  /**
   * 시작 페이지
   * @param mno
   * @return
   */
  @RequestMapping(value = "/index.do", 
                            method = RequestMethod.GET)
  public ModelAndView home3() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/index"); // /webapp/index.jsp
 
    return mav;
  } 
  
}
 


/*package dev.mvc.ojt;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

*//**
 * Handles requests for the application home page.
 *//*
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	*//**
	 * Simply selects the home view to render by returning its name.
	 *//*
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
}*/
