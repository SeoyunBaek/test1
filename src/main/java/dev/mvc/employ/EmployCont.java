package dev.mvc.employ;

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
import dev.mvc.diecate.DiecateVO;
import dev.mvc.diecate.Diecategrp_cateVO;
import dev.mvc.diecategrp.DiecategrpVO;
import dev.mvc.event.EventVO;
import dev.mvc.goods.FileVO;
import dev.mvc.review.ReviewVO;
import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class EmployCont {
  @Autowired
  @Qualifier("dev.mvc.employ.EmployProc")
  private EmployProcInter employProc=null;
  
  @Autowired
  @Qualifier("dev.mvc.diecate.DiecateProc")
  private DiecateProcInter diecateProc;
  
  /**
   * 등록 폼 http://localhost:9090/diesta/employ/create.do?diecateno=1
   * 
   * @return
   */  
  @RequestMapping(value="/employ/create.do", method=RequestMethod.GET)
  public ModelAndView create(int diecateno) {
    ModelAndView mav = new ModelAndView();
 
   Diecategrp_cateVO diecategrp_cateVO=diecateProc.read_by_join(diecateno);
    mav.addObject("diecategrp_cateVO", diecategrp_cateVO);
   
    mav.setViewName("/employ/create");
    
    return mav;
  }
  
  /**
   * 등록 처리
   * @param request
   * @param eventVO
   * @return
   */  
  @RequestMapping(value="/employ/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, EmployVO employVO) {
    
    ModelAndView mav = new ModelAndView();
    
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/employ/storage");
    // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
    List<MultipartFile> filesMF = employVO.getFilesMF(); 
 
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
    employVO.setFiles(files);
    employVO.setSizes(sizes);
    employVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------

     
    count = employProc.create(employVO);
    if (count==1) {
      diecateProc.increaseCnt(employVO.getDiecateno()); // 글 수 증가
    }
    mav.setViewName("redirect:/employ/create_msg.jsp?count=" + count + "&diecateno=" + employVO.getDiecateno());
   
    return mav;
  }
  
  /**
   * 전체 목록
   * http://localhost:9090/diesta/employ/list_all_employ.do
   * @return
   */
  @RequestMapping(value="/employ/list_all_employ.do", method=RequestMethod.GET)
  public ModelAndView list_all_employ() {
    ModelAndView mav = new ModelAndView();

    ArrayList<EmployVO> list = employProc.list_all_employ();
    mav.addObject("list", list);
    
    int total_count=employProc.total_count();
    mav.addObject("total_count", total_count);
    
    mav.setViewName("/employ/list_all_employ"); // /webapp/diecate/list_all_custo.jsp
    
    return mav;
  }
  
  /**
   * 조회
   * 
   * @param eventno
   * @return
   */
  @RequestMapping(value = "/employ/read.do", method = RequestMethod.GET)
  public ModelAndView read(int employno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/employ/read"); // /webapp/contents/read.jsp

    EmployVO employVO = employProc.read(employno);
    mav.addObject("employVO", employVO);

    // 카테고리 정보 저장 
    Diecategrp_cateVO diecategrp_cateVO=diecateProc.read_by_join(employVO.getDiecateno());
    mav.addObject("diecategrp_cateVO", diecategrp_cateVO);
    
    ArrayList<FileVO> file_list = employProc.getThumbs(employVO);

    mav.addObject("file_list", file_list);

    return mav;
  }
  
  /**
   * 수정 폼 http://localhost:9090/diesta/employ/update.do?eventno=1
   * 
   * @return
   */
  @RequestMapping(value = "/employ/update.do", method = RequestMethod.GET)
  public ModelAndView update(int diecateno, int employno) {  //int diecateno, int custoqusno CustoVO custoVO
    ModelAndView mav = new ModelAndView();

    Diecategrp_cateVO diecategrp_cateVO=diecateProc.read_by_join(diecateno);
    mav.addObject("diecategrp_cateVO", diecategrp_cateVO);

    EmployVO employVO=employProc.read(employno);
    mav.addObject("employVO", employVO);
    
    ArrayList<FileVO> file_list = employProc.getThumbs(employVO);
    mav.addObject("file_list", file_list);
    
    mav.setViewName("/employ/update"); // /webapp/contents/update.jsp
 
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
  @RequestMapping(value = "/employ/update.do", method = RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         EmployVO employVO) {
    ModelAndView mav = new ModelAndView();    
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/employ/storage");
    // Spring이 File 객체를 저장해둠.
    List<MultipartFile> filesMF = employVO.getFilesMF(); 
 
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
    EmployVO employVO_old = employProc.read(employVO.getEmployno());
    
    if (filesMF.get(0).getSize() > 0) { // 새로운 파일을 등록함으로 기존에 등록된 파일 목록 삭제
      // thumbs 파일 삭제
      String thumbs_old = employVO_old.getThumbs();
      StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
      while (thumbs_st.hasMoreTokens()) {
        String fname = upDir + thumbs_st.nextToken();
        Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
      }
 
      // 원본 파일 삭제
      String files_old = employVO_old.getFiles();
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
      files = employVO_old.getFiles();
      sizes = employVO_old.getSizes();
      thumbs = employVO_old.getThumbs();
    }
    employVO.setFiles(files);
    employVO.setSizes(sizes);
    employVO.setThumbs(thumbs);
 
    // eventVO.setDiecateno(1); // 회원 개발후 session으로 변경
 
    count = employProc.update(employVO);
 
    // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
    
    redirectAttributes.addAttribute("count", count); // redirect parameter 적용
 
    // redirect시에는 request가 전달이안됨으로 아래의 방법을 이용하여 데이터 전달
    redirectAttributes.addAttribute("diecateno", employVO.getDiecateno());
    redirectAttributes.addAttribute("employno", employVO.getEmployno());
    redirectAttributes.addAttribute("title", employVO.getTitle());
 
    mav.setViewName("redirect:/employ/update_msg.jsp");
     
    return mav; 
  }
  
  /**
   * 삭제 폼 
   * http://localhost:9090/diesta/employ/delete.do?eventno=1
   * 
   * @return
   */
  @RequestMapping(value = "/employ/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int diecateno, int employno) {
    ModelAndView mav = new ModelAndView();
    
    Diecategrp_cateVO diecategrp_cateVO=diecateProc.read_by_join(diecateno);
    mav.addObject("diecategrp_cateVO", diecategrp_cateVO);

    EmployVO employVO=employProc.read(employno);
    mav.addObject("employVO", employVO);
    
    // ArrayList<FileVO> file_list = contentsProc.getThumbs(contentsVO);
    // mav.addObject("file_list", file_list);
    
    mav.setViewName("/employ/delete"); // /webapp/contents/delete.jsp
 
    return mav;
  }
  
  /**
   * 삭제
   * @param request
   * @param employVO
   * @return
   */
  @RequestMapping(value = "/employ/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         int employno,
                                         @RequestParam(value="diecateno", defaultValue="1") int diecateno) {
    ModelAndView mav = new ModelAndView();
 
    String upDir = Tool.getRealPath(request, "/employ/storage");

    // 기존의 등록 정보 조회
    EmployVO employVO_old = employProc.read(employno);
    
    String thumbs_old = employVO_old.getThumbs();
    StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
    while (thumbs_st.hasMoreTokens()) {
      String fname = upDir + thumbs_st.nextToken();
      Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
    }
    
    // 원본 파일 삭제
    String files_old = employVO_old.getFiles();
    StringTokenizer files_st = new StringTokenizer(files_old, "/");
    while (files_st.hasMoreTokens()) {
      String fname = upDir + files_st.nextToken();
      Tool.deleteFile(fname);  // 기존에 등록된 원본 파일 삭제
    }
    
    int count = employProc.delete(employno);
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
    redirectAttributes.addAttribute("employno", employno);
    redirectAttributes.addAttribute("diecateno", diecateno);
    redirectAttributes.addAttribute("title", employVO_old.getTitle());
    
    mav.setViewName("redirect:/employ/delete_msg.jsp");
 
    return mav; 
  }

}
