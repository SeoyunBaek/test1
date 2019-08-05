package dev.mvc.review;

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

import dev.mvc.custo.Custo;
import dev.mvc.custo.CustoVO;
import dev.mvc.goods.FileVO;
import dev.mvc.goods.GoodsProcInter;
import dev.mvc.goods.GoodsVO;
import dev.mvc.goods.Goods_ReviewVO;
import dev.mvc.mem.Mem_CustoVO;
import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class ReviewCont {  
  @Autowired
  @Qualifier("dev.mvc.goods.GoodsProc")
  private GoodsProcInter goodsProc=null;
  
  @Autowired
  @Qualifier("dev.mvc.review.ReviewProc")
  private ReviewProcInter reviewProc=null;
  
  /**
   * 등록 폼 http://localhost:9090/diesta/review/create.do?goodsno=1
   * 
   * @return
   */  
  @RequestMapping(value="/review/create.do", method=RequestMethod.GET)
  public ModelAndView create(int goodsno) {     //int diecateno
    ModelAndView mav = new ModelAndView();

    Goods_ReviewVO goods_ReviewVO=goodsProc.read_by_join(goodsno);
    mav.addObject("goods_ReviewVO", goods_ReviewVO);
    
    mav.setViewName("/review/create");
    
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
   * @param diesVO
   * @return
   */  
 @RequestMapping(value = "/review/create.do", method = RequestMethod.POST)
 public  ModelAndView create(HttpServletRequest request, ReviewVO reviewVO) {
   
   ModelAndView mav = new ModelAndView();
   
   // -------------------------------------------------------------------
   // 파일 전송 코드 시작
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/review/storage");
   // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
   List<MultipartFile> filesMF = reviewVO.getFilesMF(); 

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
   reviewVO.setFiles(files);
   reviewVO.setSizes(sizes);
   reviewVO.setThumbs(thumbs);
   // -------------------------------------------------------------------
   // 파일 전송 코드 종료
   // -------------------------------------------------------------------
   
   count = reviewProc.create(reviewVO);
   if (count == 1) {
     goodsProc.increaseVisit(reviewVO.getGoodsno()); // 글수 증가
   }
   
   mav.setViewName("redirect:/review/create_msg.jsp?count=" + count + "&goodsno=" + reviewVO.getGoodsno()); // /webapp/contents/create_msg.jsp

   return mav;   
 }
 
 /**
  * 전체 목록
  * http://localhost:9090/diesta/review/list_all_review.do
  * @return
  */
 @RequestMapping(value="/review/list_all_review.do", method=RequestMethod.GET)
 public ModelAndView list_all_review() {
   ModelAndView mav = new ModelAndView();

   ArrayList<ReviewVO> list = reviewProc.list_all_review();
   mav.addObject("list", list);
   
   int total_count=reviewProc.total_count();
   mav.addObject("total_count", total_count);
   
   mav.setViewName("/review/list_all_review");
   
   return mav;
 }
 
 /**
  * 조회
  * 
  * @param reviewno
  * @return
  */
 @RequestMapping(value = "/review/read.do", method = RequestMethod.GET)
 public ModelAndView read(int reviewno) {
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/review/read"); // /webapp/contents/read.jsp
   
   ReviewVO reviewVO=reviewProc.read(reviewno);
   mav.addObject("reviewVO", reviewVO);

   Goods_ReviewVO goods_ReviewVO=goodsProc.read_by_join(reviewVO.getGoodsno());
   mav.addObject("goods_ReviewVO", goods_ReviewVO);
   
   ArrayList<FileVO> file_list = reviewProc.getThumbs(reviewVO);

   mav.addObject("file_list", file_list);

   return mav;
 }
 
 /**
  * 수정 폼 http://localhost:9090/diesta/review/update.do?goodsno=1
  * 
  * @return
  */
 @RequestMapping(value = "/review/update.do", method = RequestMethod.GET)
 public ModelAndView update(int goodsno, int reviewno) {  //int diecateno, int custoqusno CustoVO custoVO
   ModelAndView mav = new ModelAndView();

   Goods_ReviewVO goods_ReviewVO=goodsProc.read_by_join(goodsno);
   mav.addObject("goods_ReviewVO", goods_ReviewVO);

   ReviewVO reviewVO=reviewProc.read(reviewno);
   mav.addObject("reviewVO", reviewVO);
   
   ArrayList<FileVO> file_list = reviewProc.getThumbs(reviewVO);
   mav.addObject("file_list", file_list);
   
   mav.setViewName("/review/update"); // /webapp/contents/update.jsp

   return mav;    
 }
 
 /**
  * - 글만 수정하는 경우의 구현 
  * - 파일만 수정하는 경우의 구현 
  * - 글과 파일을 동시에 수정하는 경우의 구현
  * 
  * @param request
  * @param reviewVO
  * @return
  */
 @RequestMapping(value = "/review/update.do", method = RequestMethod.POST)
 public ModelAndView update(RedirectAttributes redirectAttributes, 
                                        HttpServletRequest request,
                                        ReviewVO reviewVO,
                                        @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
   ModelAndView mav = new ModelAndView();
   // -------------------------------------------------------------------
   // 파일 전송 코드 시작
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/review/storage");
   // Spring이 File 객체를 저장해둠.
   List<MultipartFile> filesMF = reviewVO.getFilesMF(); 

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
   ReviewVO reviewVO_old = reviewProc.read(reviewVO.getReviewno());
   
   if (filesMF.get(0).getSize() > 0) { // 새로운 파일을 등록함으로 기존에 등록된 파일 목록 삭제
     // thumbs 파일 삭제
     String thumbs_old = reviewVO_old.getThumbs();
     StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
     while (thumbs_st.hasMoreTokens()) {
       String fname = upDir + thumbs_st.nextToken();
       Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
     }

     // 원본 파일 삭제
     String files_old = reviewVO_old.getFiles();
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
     files = reviewVO_old.getFiles();
     sizes = reviewVO_old.getSizes();
     thumbs = reviewVO_old.getThumbs();
   }
   reviewVO.setFiles(files);
   reviewVO.setSizes(sizes);
   reviewVO.setThumbs(thumbs);

   // reviewVO.setMemno(1); // 회원 개발후 session으로 변경

   count = reviewProc.update(reviewVO);

   // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
   
   redirectAttributes.addAttribute("count", count); // redirect parameter 적용

   // redirect시에는 request가 전달이안됨으로 아래의 방법을 이용하여 데이터 전달
   redirectAttributes.addAttribute("reviewno", reviewVO.getReviewno());
   redirectAttributes.addAttribute("goodsno", reviewVO.getGoodsno());
   redirectAttributes.addAttribute("writing", reviewVO.getWriting());
   redirectAttributes.addAttribute("nowPage", nowPage);

   mav.setViewName("redirect:/review/update_msg.jsp");
    
   return mav; 
 }
 
 /**
  * 삭제 폼 
  * http://localhost:9090/diesta/review/delete.do?goodsno=1
  * 
  * @return
  */
 @RequestMapping(value = "/review/delete.do", method = RequestMethod.GET)
 public ModelAndView delete(int goodsno, int reviewno) {
   ModelAndView mav = new ModelAndView();

   Goods_ReviewVO goods_ReviewVO=goodsProc.read_by_join(goodsno);
   mav.addObject("goods_ReviewVO", goods_ReviewVO);

   ReviewVO reviewVO=reviewProc.read(reviewno);
   mav.addObject("reviewVO", reviewVO);
   
   // ArrayList<FileVO> file_list = contentsProc.getThumbs(contentsVO);
   // mav.addObject("file_list", file_list);
   
   mav.setViewName("/review/delete"); // /webapp/contents/delete.jsp

   return mav;
 }
 
 /**
  * 삭제
  * @param request
  * @param reviewVO
  * @return
  */
 @RequestMapping(value = "/review/delete.do", method = RequestMethod.POST)
 public ModelAndView delete(RedirectAttributes redirectAttributes, 
                                        HttpServletRequest request, 
                                        int reviewno,
                                        @RequestParam(value="goodsno", defaultValue="1") int goodsno,
                                        @RequestParam(value="word", defaultValue="") String word,
                                        @RequestParam(value="nowPage", defaultValue="1") int nowPage) { 
   ModelAndView mav = new ModelAndView();

   String upDir = Tool.getRealPath(request, "/review/storage");

   // 기존의 등록 정보 조회
   ReviewVO reviewVO_old = reviewProc.read(reviewno);
   
   String thumbs_old = reviewVO_old.getThumbs();
   StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
   while (thumbs_st.hasMoreTokens()) {
     String fname = upDir + thumbs_st.nextToken();
     Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
   }
   
   // 원본 파일 삭제
   String files_old = reviewVO_old.getFiles();
   StringTokenizer files_st = new StringTokenizer(files_old, "/");
   while (files_st.hasMoreTokens()) {
     String fname = upDir + files_st.nextToken();
     Tool.deleteFile(fname);  // 기존에 등록된 원본 파일 삭제
   }
   
   int count = reviewProc.delete(reviewno);
   if (count > 0) {
     goodsProc.decreaseVisit(goodsno);  // 글갯수 감소
     
   // -------------------------------------------------------------------------------------
   // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
   HashMap<String, Object> map = new HashMap();
   map.put("goodsno", goodsno);
   map.put("word", word);
   if (reviewProc.search_count(map) % Review.RECORD_PER_PAGE == 0) {
     nowPage = nowPage - 1;
     if (nowPage < 1) {
       nowPage = 1;
     }
   }
   // -------------------------------------------------------------------------------------
   
 }
  
   // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
   redirectAttributes.addAttribute("count", count); // redirect parameter 적용
   redirectAttributes.addAttribute("reviewno", reviewno);
   redirectAttributes.addAttribute("goodsno", goodsno);
   redirectAttributes.addAttribute("writing", reviewVO_old.getWriting());
   // redirectAttributes.addAttribute("askcont", custoVO_old.getAskcont());
   redirectAttributes.addAttribute("nowPage", nowPage);    
   
   mav.setViewName("redirect:/review/delete_msg.jsp");

   return mav; 
 }
 
 /**
  * 카테고리별 검색 목록
  * 
  * @return
  */
 // http://localhost:9090/diesta/review/list_by_review_search.do?diecateno=1
 @RequestMapping(value = "/review/list_by_review_search.do", method = RequestMethod.GET)
 public ModelAndView list_by_review_search(int goodsno, String word) {
   ModelAndView mav = new ModelAndView();

   Goods_ReviewVO goods_ReviewVO=goodsProc.read_by_join(goodsno);
   mav.addObject("goods_ReviewVO", goods_ReviewVO);

   HashMap<String, Object> map = new HashMap<String, Object>();
   map.put("goodsno", goodsno);
   map.put("word", word);
   
   // 검색된 레코드 목록
   List<ReviewVO> list = reviewProc.list_by_review_search(map);
   mav.addObject("list", list);
   
   // 검색된 레코드 갯수
   int search_count = reviewProc.search_count(map);
   mav.addObject("search_count", search_count);

   mav.setViewName("/review/list_by_review_search"); // /webapp/contents/list_by_cateno_search.jsp

   return mav;
 }
 
 /**
  * 목록 + 검색 + 페이징 지원
  * http://localhost:9090/diesta/review/list_by_review_search_paging.do
  * @param goodsno
  * @param word
  * @param nowPage
  * @return
  */
 @RequestMapping(value = "/review/list_by_review_search_paging.do", 
                                      method = RequestMethod.GET)
 public ModelAndView list_by_review_search_paging(
     @RequestParam(value="goodsno", defaultValue="1") int goodsno,
     @RequestParam(value="word", defaultValue="") String word,
     @RequestParam(value="nowPage", defaultValue="1") int nowPage) { 
   // System.out.println("--> list_by_category() GET called.");
   System.out.println("--> nowPage: " + nowPage);
   
   ModelAndView mav = new ModelAndView();
   
   // 검색 기능 추가,  /webapp/review/list_by_review_search_paging.jsp
   mav.setViewName("/review/list_by_review_search_paging");   
   
   // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
   HashMap<String, Object> map = new HashMap<String, Object>();
   map.put("goodsno", goodsno); // #{goodsno}
   map.put("word", word);     // #{word}
   map.put("nowPage", nowPage);       
   
   // 검색 목록
   List<ReviewVO> list = reviewProc.list_by_review_search_paging(map);
   mav.addObject("list", list);
   
   // 검색된 레코드 갯수
   int search_count = reviewProc.search_count(map);
   mav.addObject("search_count", search_count);
 
   Goods_ReviewVO goods_ReviewVO=goodsProc.read_by_join(goodsno);
   mav.addObject("goods_ReviewVO", goods_ReviewVO);
   
   // mav.addObject("word", word);
 
   /*
    * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
    * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
    * 
    * @param listFile 목록 파일명 
    * @param goodsno 카테고리번호 
    * @param search_count 검색(전체) 레코드수 
    * @param nowPage     현재 페이지
    * @param word 검색어
    * @return 페이징 생성 문자열
    */ 
   String paging = reviewProc.pagingBox("list_by_review_search_paging.do", goodsno, search_count, nowPage, word);
   mav.addObject("paging", paging);
 
   mav.addObject("nowPage", nowPage);
   
   return mav;
 }
 
}
