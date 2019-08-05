package dev.mvc.event;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.diecate.DiecateProcInter;
import dev.mvc.diecate.Diecategrp_cateVO;
import dev.mvc.goods.FileVO;
import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class EventCont {
  @Autowired
  @Qualifier("dev.mvc.event.EventProc")
  private EventProcInter eventProc=null;
  
  @Autowired
  @Qualifier("dev.mvc.diecate.DiecateProc")
  private DiecateProcInter diecateProc;
  
/*  @Autowired
  @Qualifier("dev.mvc.diecate.DiecateProc")
  private DiecategrpProcInter diecateProc;
  */
  /**http://localhost:9090/diesta/event/create.do?diecateno=1
   * 등록 폼 
   * 
   * @return
   */  
  @RequestMapping(value="/event/create.do", method=RequestMethod.GET)
  public ModelAndView create(int diecateno) {
    ModelAndView mav = new ModelAndView();
 
    Diecategrp_cateVO diecategrp_cateVO=diecateProc.read_by_join(diecateno);
    mav.addObject("diecategrp_cateVO", diecategrp_cateVO);
   
    mav.setViewName("/event/create");
    
    return mav;
  }
  
  /**
   * 등록 처리
   * 
   * 파일 태그의 연결
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ↓
   * private List<MultipartFile> filesMF;
   * 
   * @param request
   * @param eventVO
   * @return
   */  
  @RequestMapping(value="/event/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, EventVO eventVO) {
    
    ModelAndView mav = new ModelAndView();
        
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/event/storage");
    // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
    List<MultipartFile> filesMF = eventVO.getFilesMF(); 
 
    // System.out.println("--> filesMF.get(0).getSize(): " +
    // filesMF.get(0).getSize());
 
    String files = "";        // DBMS 컬럼에 저장할 파일명
    String files_item = ""; // 하나의 파일명
    String sizes = "";       // DBMS 컬럼에 저장할 파일 크기
    long sizes_item = 0;   // 하나의 파일 사이즈
    String thumbs = "";    // DBMS 컬럼에 저장할 Thumb 파일들
    String thumbs_item = ""; // 하나의 Thumb 파일명
 
    int count = filesMF.size(); // 업로드된 파일 갯수
 
    // Spring은 파일 선택을 안해도 1개의 MultipartFile 객체가 생성됨.
    // System.out.println("--> 업로드된 파일 갯수 count: " + count);
 
    if (count > 0) { // 전송 파일이 존재한다면
      // for (MultipartFile multipartFile: filesMF) {
      for (int i = 0; i < count; i++) {
        MultipartFile multipartFile = filesMF.get(i); // 0: 첫번째 파일, 1:두번째 파일 ~
        // System.out.println("multipartFile.getName(): " + multipartFile.getName());
 
        if (multipartFile.getSize() > 0) { // 전송파일이 있는지 체크
          // System.out.println("전송 파일이 있습니다.");
          files_item = Upload.saveFileSpring(multipartFile, upDir); // 서버에 파일 저장
          sizes_item = multipartFile.getSize(); // 서버에 저장된 파일 크기
 
          if (Tool.isImage(files_item)) { // 이미지인지 검사
            thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb 이미지 생성
          }
 
          // 1개 이상의 다중 파일 처리
          if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
            // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
            files = files + "/" + files_item;
            // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
            sizes = sizes + "/" + sizes_item;
            // 미니 이미지를 조합하여 하나의 컬럼에 저장
            thumbs = thumbs + "/" + thumbs_item;
            
          // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크, 파일이 1개인경우  
          } else if (multipartFile.getSize() > 0) { 
            files = files_item; // file1.jpg
            sizes = "" + sizes_item; // 123456
            thumbs = thumbs_item; // file1_t.jpg
          }
        } // if (multipartFile.getSize() > 0) {  END
      } // END for
    }
    eventVO.setFiles(files);
    eventVO.setSizes(sizes);
    eventVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    
    count = eventProc.create(eventVO);
    if (count==1) {
      diecateProc.increaseCnt(eventVO.getDiecateno()); // 글 수 증가
    }
           
    mav.setViewName("redirect:/event/create_msg.jsp?count=" + count+"&diecateno="+eventVO.getDiecateno());
   
    return mav;
  }
  
  /**
   * 전체 목록
   * http://localhost:9090/diesta/event/list_all_event.do
   * @return
   */
  @RequestMapping(value="/event/list_all_event.do", method=RequestMethod.GET)
  public ModelAndView list_all_event() {
    ModelAndView mav = new ModelAndView();

    ArrayList<EventVO> list = eventProc.list_all_event();
    mav.addObject("list", list);
    
    int total_count=eventProc.total_count();
    mav.addObject("total_count", total_count);
    
    mav.setViewName("/event/list_all_event"); // /webapp/diecate/list_all_custo.jsp
    
    return mav;
  }
  
  /**
   * 조회
   * 
   * @param eventno
   * @return
   */
  @RequestMapping(value = "/event/read.do", method = RequestMethod.GET)
  public ModelAndView read(int eventno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/event/read"); // /webapp/contents/read.jsp

    EventVO eventVO = eventProc.read(eventno);
    mav.addObject("eventVO", eventVO);

    // 카테고리 정보 저장 
    Diecategrp_cateVO diecategrp_cateVO=diecateProc.read_by_join(eventVO.getDiecateno());
    mav.addObject("diecategrp_cateVO", diecategrp_cateVO);
    
    ArrayList<FileVO> file_list = eventProc.getThumbs(eventVO);

    mav.addObject("file_list", file_list);

    return mav;
  }
  
  /**
   * 수정 폼 http://localhost:9090/diesta/event/update.do?eventno=1
   * 
   * @return
   */
  @RequestMapping(value = "/event/update.do", method = RequestMethod.GET)
  public ModelAndView update(int diecateno, int eventno) {  //int diecateno, int custoqusno CustoVO custoVO
    ModelAndView mav = new ModelAndView();

    Diecategrp_cateVO diecategrp_cateVO=diecateProc.read_by_join(diecateno);
    mav.addObject("diecategrp_cateVO", diecategrp_cateVO);

    EventVO eventVO=eventProc.read(eventno);
    mav.addObject("eventVO", eventVO);
    
    ArrayList<FileVO> file_list = eventProc.getThumbs(eventVO);
    mav.addObject("file_list", file_list);
    
    mav.setViewName("/event/update"); // /webapp/contents/update.jsp
 
    return mav;    
  }
  
  /**
   * - 글만 수정하는 경우의 구현 
   * - 파일만 수정하는 경우의 구현 
   * - 글과 파일을 동시에 수정하는 경우의 구현
   * 
   * @param request
   * @param eventVO
   * @return
   */
  @RequestMapping(value = "/event/update.do", method = RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         EventVO eventVO) {
    ModelAndView mav = new ModelAndView();    
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/event/storage");
    // Spring이 File 객체를 저장해둠.
    List<MultipartFile> filesMF = eventVO.getFilesMF(); 
 
    // System.out.println("--> filesMF.get(0).getSize(): " +
    // filesMF.get(0).getSize());
 
    String files = ""; // 컬럼에 저장할 파일명
    String files_item = ""; // 하나의 파일명
    String sizes = "";
    long sizes_item = 0; // 하나의 파일 사이즈
    String thumbs = ""; // Thumb 파일들
    String thumbs_item = ""; // 하나의 Thumb 파일명
 
    int count = filesMF.size(); // 업로드된 파일 갯수
 
    // 기존의 등록 정보 조회
    EventVO eventVO_old = eventProc.read(eventVO.getEventno());
    
    if (filesMF.get(0).getSize() > 0) { // 새로운 파일을 등록함으로 기존에 등록된 파일 목록 삭제
      // thumbs 파일 삭제
      String thumbs_old = eventVO_old.getThumbs();
      StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
      while (thumbs_st.hasMoreTokens()) {
        String fname = upDir + thumbs_st.nextToken();
        Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
      }
 
      // 원본 파일 삭제
      String files_old = eventVO_old.getFiles();
      StringTokenizer files_st = new StringTokenizer(files_old, "/");
      while (files_st.hasMoreTokens()) {
        String fname = upDir + files_st.nextToken();
        Tool.deleteFile(fname);  // 기존에 등록된 원본 파일 삭제
      }
 
      // --------------------------------------------
      // 새로운 파일의 등록 시작
      // --------------------------------------------
      // for (MultipartFile multipartFile: filesMF) {
      for (int i = 0; i < count; i++) {
        MultipartFile multipartFile = filesMF.get(i); // 0 ~
        System.out.println("multipartFile.getName(): " + multipartFile.getName());
 
        // if (multipartFile.getName().length() > 0) { // 전송파일이 있는지 체크, filesMF
        if (multipartFile.getSize() > 0) { // 전송파일이 있는지 체크
          // System.out.println("전송 파일이 있습니다.");
          files_item = Upload.saveFileSpring(multipartFile, upDir);
          sizes_item = multipartFile.getSize();
 
          if (Tool.isImage(files_item)) {
            thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb 이미지 생성
          }
 
          if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
            // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
            files = files + "/" + files_item;
            // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
            sizes = sizes + "/" + sizes_item;
            // 미니 이미지를 조합하여 하나의 컬럼에 저장
            thumbs = thumbs + "/" + thumbs_item;
          } else if (multipartFile.getSize() > 0) { // 파일이 없어도 파일 객체가 1개 생성됨으로
                                                    // 크기 체크
            files = files_item; // file1.jpg
            sizes = "" + sizes_item; // 123456
            thumbs = thumbs_item; // file1_t.jpg
          }
 
        }
      } // for END
      // --------------------------------------------
      // 새로운 파일의 등록 종료
      // --------------------------------------------
 
    } else { // 글만 수정하는 경우, 기존의 파일 정보 재사용
      files = eventVO_old.getFiles();
      sizes = eventVO_old.getSizes();
      thumbs = eventVO_old.getThumbs();
    }
    eventVO.setFiles(files);
    eventVO.setSizes(sizes);
    eventVO.setThumbs(thumbs);
 
    // eventVO.setDiecateno(1); // 회원 개발후 session으로 변경
 
    count = eventProc.update(eventVO);
 
    // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
    
    redirectAttributes.addAttribute("count", count); // redirect parameter 적용
 
    // redirect시에는 request가 전달이안됨으로 아래의 방법을 이용하여 데이터 전달
    redirectAttributes.addAttribute("diecateno", eventVO.getDiecateno());
    redirectAttributes.addAttribute("eventno", eventVO.getEventno());
    redirectAttributes.addAttribute("title", eventVO.getTitle());
 
    mav.setViewName("redirect:/event/update_msg.jsp");
     
    return mav; 
  }
  
  /**
   * 삭제 폼 
   * http://localhost:9090/diesta/event/delete.do?eventno=1
   * 
   * @return
   */
  @RequestMapping(value = "/event/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int diecateno, int eventno) {
    ModelAndView mav = new ModelAndView();
    
    Diecategrp_cateVO diecategrp_cateVO=diecateProc.read_by_join(diecateno);
    mav.addObject("diecategrp_cateVO", diecategrp_cateVO);

    EventVO eventVO=eventProc.read(eventno);
    mav.addObject("eventVO", eventVO);
    
    // ArrayList<FileVO> file_list = contentsProc.getThumbs(contentsVO);
    // mav.addObject("file_list", file_list);
    
    mav.setViewName("/event/delete"); // /webapp/contents/delete.jsp
 
    return mav;
  }
  
  /**
   * 삭제
   * @param request
   * @param eventVO
   * @return
   */
  @RequestMapping(value = "/event/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         int eventno,
                                         @RequestParam(value="diecateno", defaultValue="1") int diecateno) {
    ModelAndView mav = new ModelAndView();
 
    String upDir = Tool.getRealPath(request, "/event/storage");

    // 기존의 등록 정보 조회
    EventVO eventVO_old = eventProc.read(eventno);
    
    String thumbs_old = eventVO_old.getThumbs();
    StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
    while (thumbs_st.hasMoreTokens()) {
      String fname = upDir + thumbs_st.nextToken();
      Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
    }
    
    // 원본 파일 삭제
    String files_old = eventVO_old.getFiles();
    StringTokenizer files_st = new StringTokenizer(files_old, "/");
    while (files_st.hasMoreTokens()) {
      String fname = upDir + files_st.nextToken();
      Tool.deleteFile(fname);  // 기존에 등록된 원본 파일 삭제
    }
    
    int count = eventProc.delete(eventno);
    if (count > 0) {
      diecateProc.decreaseCnt(diecateno);  // 글갯수 감소
      
    // -------------------------------------------------------------------------------------
    // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
    HashMap<String, Object> map = new HashMap();
    map.put("diecateno", diecateno);
    // -------------------------------------------------------------------------------------
    
  }
   
    // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
    redirectAttributes.addAttribute("count", count); // redirect parameter 적용
    redirectAttributes.addAttribute("eventno", eventno);
    redirectAttributes.addAttribute("diecateno", diecateno);
    redirectAttributes.addAttribute("title", eventVO_old.getTitle());
    
    mav.setViewName("redirect:/event/delete_msg.jsp");
 
    return mav; 
  }
  
  /**
   * 카테고리별 검색 목록
   * 
   * @return
   */
  // http://localhost:9090/diesta/event/list_by_event_search.do?diecateno=1
  @RequestMapping(value = "/event/list_by_event_search.do", method = RequestMethod.GET)
  public ModelAndView list_by_event_search(int diecateno, String word) {
    ModelAndView mav = new ModelAndView();
    
    Diecategrp_cateVO diecategrp_cateVO=diecateProc.read_by_join(diecateno);
    mav.addObject("diecategrp_cateVO", diecategrp_cateVO);
 
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("diecateno", diecateno);
    map.put("word", word);
    
    // 검색된 레코드 목록
    List<EventVO> list = eventProc.list_by_event_search(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = eventProc.search_count(map);
    mav.addObject("search_count", search_count);
 
    mav.setViewName("/event/list_by_event_search"); // /webapp/contents/list_by_cateno_search.jsp
 
    return mav;
  }
  
  /**
   * 목록 + 검색 + 페이징 지원
   * http://localhost:9090/diesta/event/list_by_event_search_paging.do
   * @param categoryno
   * @param word
   * @param nowPage
   * @return
   */
/*  @RequestMapping(value = "/event/list_by_event_search_paging.do", 
                                       method = RequestMethod.GET)
  public ModelAndView list_by_event_search_paging(
      @RequestParam(value="diecateno", defaultValue="1") int diecateno,
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage) { 
    // System.out.println("--> list_by_category() GET called.");
    System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
    
    // 검색 기능 추가,  /webapp/custo_qus/list_by_custo_search_paging.jsp
    mav.setViewName("/event/list_by_event_search_paging");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("diecateno", diecateno); // #{diecateno}
    map.put("word", word);     // #{word}
    map.put("nowPage", nowPage);       
    
    // 검색 목록
    List<EventVO> list = eventProc.list_by_event_search_paging(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = eventProc.search_count(map);
    mav.addObject("search_count", search_count);

    Diecategrp_cateVO diecategrp_cateVO=diecateProc.read_by_join(diecateno);
    mav.addObject("diecategrp_cateVO", diecategrp_cateVO);
    
    // mav.addObject("word", word);
  
    
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     * 
     * @param listFile 목록 파일명 
     * @param categoryno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
      
    String paging = eventProc.pagingBox("list_by_event_search_paging.do", diecateno, search_count, nowPage, word);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }*/
  
}


