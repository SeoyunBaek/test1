package dev.mvc.custo;

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
import dev.mvc.goods.FileVO;
import dev.mvc.mem.MemProcInter;
import dev.mvc.mem.MemVO;
import dev.mvc.mem.Mem_CustoVO;
import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class CustoCont {
  @Autowired
  @Qualifier("dev.mvc.mem.MemProc")
  private MemProcInter memProc=null;

  @Autowired
  @Qualifier("dev.mvc.custo.CustoProc")
  private CustoProcInter custoProc=null;
  
/*  @Autowired
  @Qualifier("dev.mvc.ctsans.CtsansProc")
  private CustoProcInter ctsansProc=null;*/
  
  /**
   * 등록 폼 http://localhost:9090/diesta/custo_qus/create.do?memno=1
   * 
   * @return
   */  
  @RequestMapping(value="/custo_qus/create.do", method=RequestMethod.GET)
  public ModelAndView create(int memno) {
    ModelAndView mav = new ModelAndView();

    Mem_CustoVO mem_CustoVO=memProc.read_by_join_m(memno);
    mav.addObject("mem_CustoVO", mem_CustoVO);
    
    mav.setViewName("/custo_qus/create");
    
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
   * @param custoVO
   * @return
   */  
  @RequestMapping(value="/custo_qus/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, CustoVO custoVO) {
    
    ModelAndView mav = new ModelAndView();
        
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/custo_qus/storage");
    // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
    List<MultipartFile> filesMF = custoVO.getFilesMF(); 
 
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
    custoVO.setFiles(files);
    custoVO.setSizes(sizes);
    custoVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    
    count = custoProc.create(custoVO);
    if (count==1) {
      memProc.increaseCnt(custoVO.getMemno()); // 글 수 증가
    }
           
    mav.setViewName("redirect:/custo_qus/create_msg.jsp?count=" + count+"&memno="+custoVO.getMemno());
   
    return mav;
  }
  
  /**
   * 전체 목록
   * http://localhost:9090/diesta/custo_qus/list_all_custo.do
   * @return
   */
  @RequestMapping(value="/custo_qus/list_all_custo.do", method=RequestMethod.GET)
  public ModelAndView list_all_custo() {
    ModelAndView mav = new ModelAndView();

    ArrayList<CustoVO> list = custoProc.list_all_custo();
    mav.addObject("list", list);
    
    int total_count=custoProc.total_count();
    mav.addObject("total_count", total_count);
    
    mav.setViewName("/custo_qus/list_all_custo"); // /webapp/diecate/list_all_custo.jsp
    
    return mav;
  }  
  
  /**
   * 조회
   * 
   * @param custoqusno
   * @return
   */
  @RequestMapping(value = "/custo_qus/read.do", method = RequestMethod.GET)
  public ModelAndView read(int custoqusno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/custo_qus/read"); // /webapp/contents/read.jsp

    CustoVO custoVO = custoProc.read(custoqusno);
    mav.addObject("custoVO", custoVO);

    // 카테고리 정보 저장
    Mem_CustoVO mem_CustoVO=memProc.read_by_join_m(custoVO.getMemno());
    mav.addObject("mem_CustoVO", mem_CustoVO);
    
    ArrayList<FileVO> file_list = custoProc.getThumbs(custoVO);

    mav.addObject("file_list", file_list);

    return mav;
  }
  
  /**
   * 수정 폼 http://localhost:9090/diesta/custo_qus/update.do?custoqusno=1
   * 
   * @return
   */
  @RequestMapping(value = "/custo_qus/update.do", method = RequestMethod.GET)
  public ModelAndView update(int memno, int custoqusno) {  //int diecateno, int custoqusno CustoVO custoVO
    ModelAndView mav = new ModelAndView();
    
    Mem_CustoVO mem_CustoVO=memProc.read_by_join_m(memno);
    mav.addObject("mem_CustoVO", mem_CustoVO);

    CustoVO custoVO=custoProc.read(custoqusno);
    mav.addObject("custoVO", custoVO);
    
    ArrayList<FileVO> file_list = custoProc.getThumbs(custoVO);
    mav.addObject("file_list", file_list);
    
    mav.setViewName("/custo_qus/update"); // /webapp/contents/update.jsp
 
    return mav;    
  }
  
  /**
   * - 글만 수정하는 경우의 구현 
   * - 파일만 수정하는 경우의 구현 
   * - 글과 파일을 동시에 수정하는 경우의 구현
   * 
   * @param request
   * @param custoVO
   * @return
   */
  @RequestMapping(value = "/custo_qus/update.do", method = RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         CustoVO custoVO,
                                         @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();    
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/custo_qus/storage");
    // Spring이 File 객체를 저장해둠.
    List<MultipartFile> filesMF = custoVO.getFilesMF(); 
 
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
    CustoVO custoVO_old = custoProc.read(custoVO.getCustoqusno());
    
    if (filesMF.get(0).getSize() > 0) { // 새로운 파일을 등록함으로 기존에 등록된 파일 목록 삭제
      // thumbs 파일 삭제
      String thumbs_old = custoVO_old.getThumbs();
      StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
      while (thumbs_st.hasMoreTokens()) {
        String fname = upDir + thumbs_st.nextToken();
        Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
      }
 
      // 원본 파일 삭제
      String files_old = custoVO_old.getFiles();
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
      files = custoVO_old.getFiles();
      sizes = custoVO_old.getSizes();
      thumbs = custoVO_old.getThumbs();
    }
    custoVO.setFiles(files);
    custoVO.setSizes(sizes);
    custoVO.setThumbs(thumbs);
 
    custoVO.setMemno(1); // 회원 개발후 session으로 변경
 
    count = custoProc.update(custoVO);
 
    // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
    
    redirectAttributes.addAttribute("count", count); // redirect parameter 적용
 
    // redirect시에는 request가 전달이안됨으로 아래의 방법을 이용하여 데이터 전달
    redirectAttributes.addAttribute("custoqusno", custoVO.getCustoqusno());
    redirectAttributes.addAttribute("memno", custoVO.getMemno());
    redirectAttributes.addAttribute("title", custoVO.getTitle());
    redirectAttributes.addAttribute("nowPage", nowPage);
 
    mav.setViewName("redirect:/custo_qus/update_msg.jsp");
     
    return mav; 
  }
    
  /**
   * 삭제 폼 
   * http://localhost:9090/diesta/custo_qus/delete.do?cateno=1
   * 
   * @return
   */
  @RequestMapping(value = "/custo_qus/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int memno, int custoqusno) {
    ModelAndView mav = new ModelAndView();
    
    Mem_CustoVO mem_CustoVO=memProc.read_by_join_m(memno);
    mav.addObject("mem_CustoVO", mem_CustoVO);

    CustoVO custoVO=custoProc.read(custoqusno);
    mav.addObject("custoVO", custoVO);
    
    // ArrayList<FileVO> file_list = contentsProc.getThumbs(contentsVO);
    // mav.addObject("file_list", file_list);
    
    mav.setViewName("/custo_qus/delete"); // /webapp/contents/delete.jsp
 
    return mav;
  }
  
  /**
   * 삭제
   * @param request
   * @param custoVO
   * @return
   */
  @RequestMapping(value = "/custo_qus/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         int custoqusno,
                                         @RequestParam(value="memno", defaultValue="1") int memno,
                                         @RequestParam(value="word", defaultValue="") String word,
                                         @RequestParam(value="nowPage", defaultValue="1") int nowPage) { 
    ModelAndView mav = new ModelAndView();
 
    String upDir = Tool.getRealPath(request, "/custo_qus/storage");

    // 기존의 등록 정보 조회
    CustoVO custoVO_old = custoProc.read(custoqusno);
    
    String thumbs_old = custoVO_old.getThumbs();
    StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
    while (thumbs_st.hasMoreTokens()) {
      String fname = upDir + thumbs_st.nextToken();
      Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
    }
    
    // 원본 파일 삭제
    String files_old = custoVO_old.getFiles();
    StringTokenizer files_st = new StringTokenizer(files_old, "/");
    while (files_st.hasMoreTokens()) {
      String fname = upDir + files_st.nextToken();
      Tool.deleteFile(fname);  // 기존에 등록된 원본 파일 삭제
    }
    
    int count = custoProc.delete(custoqusno);
    if (count > 0) {
      memProc.decreaseCnt(memno);  // 글갯수 감소
      
    // -------------------------------------------------------------------------------------
    // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
    HashMap<String, Object> map = new HashMap();
    map.put("memno", memno);
    map.put("word", word);
    if (custoProc.search_count(map) % Custo.RECORD_PER_PAGE == 0) {
      nowPage = nowPage - 1;
      if (nowPage < 1) {
        nowPage = 1;
      }
    }
    // -------------------------------------------------------------------------------------
    
  }
   
    // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
    redirectAttributes.addAttribute("count", count); // redirect parameter 적용
    redirectAttributes.addAttribute("custoqusno", custoqusno);
    redirectAttributes.addAttribute("memno", memno);
    redirectAttributes.addAttribute("title", custoVO_old.getTitle());
    redirectAttributes.addAttribute("nowPage", nowPage);    
    
    mav.setViewName("redirect:/custo_qus/delete_msg.jsp");
 
    return mav; 
  }
  
  /**
   * 카테고리별 검색 목록
   * 
   * @return
   */
  // http://localhost:9090/diesta/custo_qus/list_by_custo_search.do?diecateno=1
  @RequestMapping(value = "/custo_qus/list_by_custo_search.do", method = RequestMethod.GET)
  public ModelAndView list_by_custo_search(int memno, String word) {
    ModelAndView mav = new ModelAndView();
 
    Mem_CustoVO mem_CustoVO=memProc.read_by_join_m(memno);
    mav.addObject("mem_CustoVO", mem_CustoVO);
 
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("memno", memno);
    map.put("word", word);
    
    // 검색된 레코드 목록
    List<CustoVO> list = custoProc.list_by_custo_search(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = custoProc.search_count(map);
    mav.addObject("search_count", search_count);
 
    mav.setViewName("/custo_qus/list_by_custo_search"); // /webapp/contents/list_by_cateno_search.jsp
 
    return mav;
  }
  
  /**
   * 목록 + 검색 + 페이징 지원
   * http://localhost:9090/diesta/custo_qus/list_by_custo_search_paging.do
   * @param categoryno
   * @param word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/custo_qus/list_by_custo_search_paging.do", 
                                       method = RequestMethod.GET)
  public ModelAndView list_by_custo_search_paging(
      @RequestParam(value="memno", defaultValue="1") int memno,
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage) { 
    // System.out.println("--> list_by_category() GET called.");
    System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
    
    // 검색 기능 추가,  /webapp/custo_qus/list_by_custo_search_paging.jsp
    mav.setViewName("/custo_qus/list_by_custo_search_paging");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("memno", memno); // #{memno}
    map.put("word", word);     // #{word}
    map.put("nowPage", nowPage);       
    
    // 검색 목록
    List<CustoVO> list = custoProc.list_by_custo_search_paging(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = custoProc.search_count(map);
    mav.addObject("search_count", search_count);
  
    Mem_CustoVO mem_CustoVO=memProc.read_by_join_m(memno);
    mav.addObject("mem_CustoVO", mem_CustoVO);
    
    // mav.addObject("word", word);
  
    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     * 
     * @param listFile 목록 파일명 
     * @param categoryno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = custoProc.pagingBox("list_by_custo_search_paging.do", memno, search_count, nowPage, word);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }
  
  /**
   * 답변 폼 http://localhost:9090/diesta/custo_qus/reply.do?memno=1
   * 
   * @return
   */
  @RequestMapping(value = "/custo_qus/reply.do", method = RequestMethod.GET)
  public ModelAndView reply(int memno, int custoqusno) {
    ModelAndView mav = new ModelAndView();
    
    System.out.println("답변 대상: " + custoqusno);

    Mem_CustoVO mem_CustoVO = memProc.read_by_join_m(memno);
    mav.addObject("mem_CustoVO", mem_CustoVO);
    
    mav.setViewName("/custo_qus/reply"); // /webapp/contents/reply.jsp
 
    return mav;
  }

  /**
   * 답변 처리
   * 
   * 파일 태그의 연결
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ↓
   * private List<MultipartFile> filesMF;
   * 
   * @param request
   * @param contentsVO
   * @return
   */
  @RequestMapping(value = "/custo_qus/reply.do", method = RequestMethod.POST)
  public ModelAndView reply(HttpServletRequest request, 
                                        CustoVO custoVO,
                                        @RequestParam(value="word", defaultValue="") String word,
                                        @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    // System.out.println("--> create() POST executed");
    ModelAndView mav = new ModelAndView();
 
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/custo_qus/storage");
    // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
    List<MultipartFile> filesMF = custoVO.getFilesMF(); 
 
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
    custoVO.setFiles(files);
    custoVO.setSizes(sizes);
    custoVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    
    // 회원 개발 후 session 으로변경
    // int mno = (Integer)session.getAttribute("mno");
    custoVO.setMemno(1);
    
    // --------------------------- 답변 관련 코드 시작 --------------------------
    CustoVO parentVO = custoProc.read(custoVO.getCustoqusno()); // 부모글 정보 추출
    
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("grpno", parentVO.getGrpno());
    map.put("ansnum",  parentVO.getAnsnum());
    custoProc.increaseAnsnum(map); // 현재 등록된 답변 뒤로 +1 처리함.

    custoVO.setGrpno(parentVO.getGrpno()); // 부모의 그룹번호 할당
    custoVO.setIndent(parentVO.getIndent() + 1); // 답변 차수 증가
    custoVO.setAnsnum(parentVO.getAnsnum() + 1); // 부모 바로 아래 등록
    // --------------------------- 답변 관련 코드 종료 --------------------------

    count = custoProc.reply(custoVO);
    if (count == 1) {
      memProc.increaseCnt(custoVO.getMemno()); // 글수 증가
    }
 
    mav.setViewName(
        "redirect:/custo_qus/reply_msg.jsp?count=" + count + "&memno=" + custoVO.getMemno()+ "&nowPage=" + nowPage); // /webapp/contents/reply_msg.jsp
 
    // mav.setViewName("redirect:/contents/list_by_cateno_search_paging.do?cateno=" + contentsVO.getCateno());
    // mav.setViewName("redirect:/contents/list_all_cateno.do");
 
    return mav;
  }
  
}
