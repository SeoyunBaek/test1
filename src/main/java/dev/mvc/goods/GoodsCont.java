package dev.mvc.goods;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

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
import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class GoodsCont {
  @Autowired
  @Qualifier("dev.mvc.diecate.DiecateProc")
  private DiecateProcInter diecateProc;
  
  @Autowired
  @Qualifier("dev.mvc.goods.GoodsProc")
  private GoodsProcInter goodsProc = null;
  
  /**
   * 등록 폼
   * 
   * @return
   */
  @RequestMapping(value = "/goods/create.do", method = RequestMethod.GET)
  public ModelAndView create(int diecateno) {
    ModelAndView mav = new ModelAndView();
    
    DiecateVO diecateVO = diecateProc.read(diecateno);
    mav.addObject("diecateVO", diecateVO);
    
    mav.setViewName("/goods/create"); 
 
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
   * @param goodsVO
   * @return
   */
  @RequestMapping(value = "/goods/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, 
                                        GoodsVO goodsVO) {
    // System.out.println("--> create() POST executed");
    ModelAndView mav = new ModelAndView();
 
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/goods/storage");
    // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
    List<MultipartFile> filesMF = goodsVO.getFilesMF(); 
 
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
    goodsVO.setFiles(files);
    goodsVO.setSizes(sizes);
    goodsVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------

    count = goodsProc.create(goodsVO);
    if (count == 1) {
      diecateProc.increaseCnt(goodsVO.getDiecateno()); // 글수 증가
    }
 
    mav.setViewName(
        "redirect:/goods/create_msg.jsp?count=" + count + "&diecateno=" + goodsVO.getDiecateno());
    return mav;
  }
  
  /**
   * 전체 목록
   * http://localhost:9090/diesta/goods/list_all_diecate.do
   * @return
   */
  
  @RequestMapping(value = "/goods/list_all_diecate.do", method = RequestMethod.GET)
  public ModelAndView list_all_diecate() {
    ModelAndView mav = new ModelAndView();
 
    ArrayList<GoodsVO> list = goodsProc.list_all_diecate();
    mav.addObject("list", list);
    
    int total_count = goodsProc.total_count();
    mav.addObject("total_count", total_count);
 
    mav.setViewName("/goods/list_all_diecate"); 
 
    return mav;
  }
  
  /**
   * 카테고리별 목록
   * // http://localhost:9090/diesta/goods/list_by_diecate.do?cateno=1
   * @return
   */
  
  @RequestMapping(value = "/goods/list_by_diecate.do", method = RequestMethod.GET)
  public ModelAndView list_by_diecate(int diecateno) {
    ModelAndView mav = new ModelAndView();
 
    DiecateVO diecateVO = diecateProc.read(diecateno);
    mav.addObject("diecateVO", diecateVO);
 
    List<GoodsVO> list = goodsProc.list_by_diecate(diecateno);
    mav.addObject("list", list);
 
    mav.setViewName("/goods/list_by_diecate"); 
 
    return mav;
  }
  
  /**
   * 조회
   * 
   * @param goodsno
   * @return
   */
  @RequestMapping(value = "/goods/read.do", method = RequestMethod.GET)
  public ModelAndView read(int goodsno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/goods/read"); // /webapp/contents/read.jsp

    GoodsVO goodsVO = goodsProc.read(goodsno);
    mav.addObject("goodsVO", goodsVO);

    // 카테고리 정보 저장
    DiecateVO diecateVO = diecateProc.read(goodsVO.getDiecateno()); 
    mav.addObject("diecateVO", diecateVO);

    ArrayList<FileVO> file_list = goodsProc.getThumbs(goodsVO);

    mav.addObject("file_list", file_list);
    
    int count = goodsProc.increaseVisit(goodsno);
    mav.addObject("count", count);
    
    return mav;
  }
  
  //ZIP 압축 후 파일 다운로드 
  @RequestMapping(value = "/goods/download.do", method = RequestMethod.GET)
  public ModelAndView download(HttpServletRequest request, int goodsno) {
    ModelAndView mav = new ModelAndView();

    GoodsVO goodsVO = goodsProc.read(goodsno);
   
    String files = goodsVO.getFiles();
    String[] files_array = files.split("/");
   
    String dir = "/goods/storage";
    String upDir = Tool.getRealPath(request, dir); // 절대 경로 산출
   
    // 다운로드되는 파일, 파일명을 지정하거나 날짜 조합
    String zip = Tool.getDateRand() + ".zip";  // 20190522102114933.zip
    String zip_filename = upDir + zip; // 압축파일이 생성될 폴더 지정
   
    String[] zip_src = new String[files_array.length]; // 파일 갯수만큼 배열 선언
   
    for (int i=0; i < files_array.length; i++) {
      zip_src[i] = upDir + "/" + files_array[i]; // 절대 경로가 조합된 파일 저장      
    }

    byte[] buffer = new byte[4096]; // 4 KB
   
    try {
      ZipOutputStream zipOutputStream = new ZipOutputStream(new FileOutputStream(zip_filename));
     
      for(int index=0; index < zip_src.length; index++) {
        FileInputStream in = new FileInputStream(zip_src[index]);
       
        Path path = Paths.get(zip_src[index]);
        String zip_src_file = path.getFileName().toString();
        // System.out.println("zip_src_file: " + zip_src_file);
       
        ZipEntry zipEntry = new ZipEntry(zip_src_file);
        zipOutputStream.putNextEntry(zipEntry);
       
        int length = 0;
        // 4 KB씩 읽어서 buffer 배열에 저장후 읽은 바이트수를 length에 저장
        while((length = in.read(buffer)) > 0) {
          zipOutputStream.write(buffer, 0, length); // 기록할 내용, 내용에서의 시작 위치, 기록할 길이
         
        }
        zipOutputStream.closeEntry();
        in.close();
      }
      zipOutputStream.close();
     
      File file = new File(zip_filename);
     
      if (file.exists() && file.length() > 0) {
        System.out.println(zip_filename + " 압축 파일 생성.");
      }
     
//     if (file.delete() == true) {
//       System.out.println(zip_filename + " 파일을 삭제했습니다.");
//     }

    } catch (FileNotFoundException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    }

    // download 서블릿 연결
    mav.setViewName("redirect:/download?dir=" + dir + "&filename=" + zip);    
   
    return mav;
  }
  
  /**
   * 수정 폼
   * 
   * @return
   */
  @RequestMapping(value = "/goods/update.do", method = RequestMethod.GET)
  public ModelAndView update(int diecateno, int goodsno) {
    ModelAndView mav = new ModelAndView();
    
    DiecateVO diecateVO = diecateProc.read(diecateno);
    mav.addObject("diecateVO", diecateVO);
    
    GoodsVO goodsVO = goodsProc.read(goodsno);
    mav.addObject("goodsVO", goodsVO);
    
    ArrayList<FileVO> file_list = goodsProc.getThumbs(goodsVO);
    mav.addObject("file_list", file_list);
    
    mav.setViewName("/goods/update"); 
 
    return mav;
  }
  
  /**
   * - 글만 수정하는 경우의 구현 
   * - 파일만 수정하는 경우의 구현 
   * - 글과 파일을 동시에 수정하는 경우의 구현
   * 
   * @param request
   * @param goodsVO
   * @return
   */
  @RequestMapping(value = "/goods/update.do", method = RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         GoodsVO goodsVO,
                                         @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
 
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/goods/storage");
    // Spring이 File 객체를 저장해둠.
    List<MultipartFile> filesMF = goodsVO.getFilesMF(); 
 
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
    GoodsVO goodsVO_old = goodsProc.read(goodsVO.getGoodsno());
    
    if (filesMF.get(0).getSize() > 0) { // 새로운 파일을 등록함으로 기존에 등록된 파일 목록 삭제
      // thumbs 파일 삭제
      String thumbs_old = goodsVO_old.getThumbs();
      StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
      while (thumbs_st.hasMoreTokens()) {
        String fname = upDir + thumbs_st.nextToken();
        Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
      }
 
      // 원본 파일 삭제
      String files_old = goodsVO_old.getFiles();
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
            thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb 이미지
                                                                    // 생성
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
      files = goodsVO_old.getFiles();
      sizes = goodsVO_old.getSizes();
      thumbs = goodsVO_old.getThumbs();
    }
    goodsVO.setFiles(files);
    goodsVO.setSizes(sizes);
    goodsVO.setThumbs(thumbs);
 
    // goodsVO.setMemno(1); // 회원 개발후 session으로 변경
 
    count = goodsProc.update(goodsVO);  // DBMS 수정
 
    // mav.setViewName("redirect:/goods/update_msg.jsp?count=" + count + "&...);
    
    redirectAttributes.addAttribute("count", count); // redirect parameter 적용
 
    // redirect시에는 request가 전달이안됨으로 아래의 방법을 이용하여 데이터 전달
    redirectAttributes.addAttribute("goodsno", goodsVO.getGoodsno());
    redirectAttributes.addAttribute("diecateno", goodsVO.getDiecateno());
    redirectAttributes.addAttribute("title", goodsVO.getTitle());
    redirectAttributes.addAttribute("nowPage", nowPage);
 
    mav.setViewName("redirect:/goods/update_msg.jsp");
     
    return mav; 
  }
  
  /**
   * 삭제 폼 
   * 
   * @return
   */
  @RequestMapping(value = "/goods/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int diecateno, int goodsno) {
    ModelAndView mav = new ModelAndView();
    
    DiecateVO diecateVO = diecateProc.read(diecateno);
    mav.addObject("diecateVO", diecateVO);
    
    GoodsVO goodsVO = goodsProc.read(goodsno);
    mav.addObject("goodsVO", goodsVO);

    ArrayList<FileVO> file_list = goodsProc.getThumbs(goodsVO);
    mav.addObject("file_list", file_list);
    
    mav.setViewName("/goods/delete"); // /webapp/contents/delete.jsp
 
    return mav;
  }
  
  /**
   * 삭제
   * @param request
   * @param goodsVO
   * @return
   */
  @RequestMapping(value = "/goods/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         int goodsno,
                                         @RequestParam(value="diecateno", defaultValue="1") int diecateno,
                                         @RequestParam(value="word", defaultValue="") String word,
                                         @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
 
    String upDir = Tool.getRealPath(request, "/goods/storage");

    // 기존의 등록 정보 조회
    GoodsVO goodsVO_old = goodsProc.read(goodsno);
    
    String thumbs_old = goodsVO_old.getThumbs();
    StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
    while (thumbs_st.hasMoreTokens()) {
      String fname = upDir + thumbs_st.nextToken();
      Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
    }
 
    // 원본 파일 삭제
    String files_old = goodsVO_old.getFiles();
    StringTokenizer files_st = new StringTokenizer(files_old, "/");
    while (files_st.hasMoreTokens()) {
      String fname = upDir + files_st.nextToken();
      Tool.deleteFile(fname);  // 기존에 등록된 원본 파일 삭제
    }
 
    int count = goodsProc.delete(goodsno);
    if (count > 0) {
      diecateProc.decreaseCnt(diecateno);  // 글갯수 감소
      
      // -------------------------------------------------------------------------------------
      // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
      HashMap<String, Object> map = new HashMap();
      map.put("diecateno", diecateno);
      map.put("word", word);
      if (goodsProc.search_count(map) % Goods.RECORD_PER_PAGE == 0) {
        nowPage = nowPage - 1;
        if (nowPage < 1) {
          nowPage = 1;
        }
      }
      // -------------------------------------------------------------------------------------

    }
 
    // mav.setViewName("redirect:/goods/update_msg.jsp?count=" + count + "&...);
    redirectAttributes.addAttribute("count", count); // redirect parameter 적용
    redirectAttributes.addAttribute("goodsno", goodsno);
    redirectAttributes.addAttribute("diecateno", diecateno);
    redirectAttributes.addAttribute("title", goodsVO_old.getTitle());
    redirectAttributes.addAttribute("nowPage", nowPage);
    
    mav.setViewName("redirect:/goods/delete_msg.jsp");
 
    return mav; 
  
  }
  
  /**
   * 카테고리별 검색 목록
   * 
   * @return
   */
  @RequestMapping(value = "/goods/list_by_cateno_search.do", method = RequestMethod.GET)
  public ModelAndView list_by_cateno_search(int diecateno, String word) {
    ModelAndView mav = new ModelAndView();
 
    DiecateVO diecateVO = diecateProc.read(diecateno);
    mav.addObject("diecateVO", diecateVO);
 
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("diecateno", diecateno);
    map.put("word", word);
    
    // 검색된 레코드 목록
    List<GoodsVO> list = goodsProc.list_by_diecate_search(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = goodsProc.search_count(map);
    mav.addObject("search_count", search_count);

 
    mav.setViewName("/goods/list_by_diecate_search"); // /webapp/contents/list_by_cateno_search.jsp
 
    return mav;
  }
  
  /**
   * 목록 + 검색 + 페이징 지원
   * 
   * @param diecateno
   * @param word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/goods/list_by_diecate_search_paging.do", 
                                       method = RequestMethod.GET)
  public ModelAndView list_by_category_search_paging(
      @RequestParam(value="diecateno", defaultValue="1") int diecateno,
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) { 
    // System.out.println("--> list_by_category() GET called.");
    System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
    
    // 검색 기능 추가,  /webapp/contents/list_by_category_search_paging.jsp
    mav.setViewName("/goods/list_by_diecate_search_paging");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("diecateno", diecateno); // #{cateno}
    map.put("word", word);     // #{word}
    map.put("nowPage", nowPage);       
    
    // 검색 목록
    List<GoodsVO> list = goodsProc.list_by_diecate_search_paging(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = goodsProc.search_count(map);
    mav.addObject("search_count", search_count);
  
    DiecateVO diecateVO = diecateProc.read(diecateno);
    mav.addObject("diecateVO", diecateVO);
    
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
    String paging = goodsProc.pagingBox("list_by_diecate_search_paging.do", diecateno, search_count, nowPage, word);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }    
  
  
  
}
