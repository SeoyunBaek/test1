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
   * ��� �� http://localhost:9090/diesta/review/create.do?goodsno=1
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
   * ��� ó��
   * 
   * ���� �±��� ����
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ��
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
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/review/storage");
   // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
   List<MultipartFile> filesMF = reviewVO.getFilesMF(); 

   // System.out.println("--> filesMF.get(0).getSize(): " +
   // filesMF.get(0).getSize());

   String files = "";        // DBMS �÷��� ������ ���ϸ�
   String files_item = ""; // �ϳ��� ���ϸ�
   String sizes = "";       // DBMS �÷��� ������ ���� ũ��
   long sizes_item = 0;   // �ϳ��� ���� ������
   String thumbs = "";    // DBMS �÷��� ������ Thumb ���ϵ�
   String thumbs_item = ""; // �ϳ��� Thumb ���ϸ�

   int count = filesMF.size(); // ���ε�� ���� ����

   // Spring�� ���� ������ ���ص� 1���� MultipartFile ��ü�� ������.
   // System.out.println("--> ���ε�� ���� ���� count: " + count);

   if (count > 0) { // ���� ������ �����Ѵٸ�
     // for (MultipartFile multipartFile: filesMF) {
     for (int i = 0; i < count; i++) {
       MultipartFile multipartFile = filesMF.get(i); // 0: ù��° ����, 1:�ι�° ���� ~
       // System.out.println("multipartFile.getName(): " + multipartFile.getName());

       if (multipartFile.getSize() > 0) { // ���������� �ִ��� üũ
         // System.out.println("���� ������ �ֽ��ϴ�.");
         files_item = Upload.saveFileSpring(multipartFile, upDir); // ������ ���� ����
         sizes_item = multipartFile.getSize(); // ������ ����� ���� ũ��

         if (Tool.isImage(files_item)) { // �̹������� �˻�
           thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb �̹��� ����
         }

         // 1�� �̻��� ���� ���� ó��
         if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
           // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
           files = files + "/" + files_item;
           // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
           sizes = sizes + "/" + sizes_item;
           // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
           thumbs = thumbs + "/" + thumbs_item;
           
         // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ, ������ 1���ΰ��  
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
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   
   count = reviewProc.create(reviewVO);
   if (count == 1) {
     goodsProc.increaseVisit(reviewVO.getGoodsno()); // �ۼ� ����
   }
   
   mav.setViewName("redirect:/review/create_msg.jsp?count=" + count + "&goodsno=" + reviewVO.getGoodsno()); // /webapp/contents/create_msg.jsp

   return mav;   
 }
 
 /**
  * ��ü ���
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
  * ��ȸ
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
  * ���� �� http://localhost:9090/diesta/review/update.do?goodsno=1
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
  * - �۸� �����ϴ� ����� ���� 
  * - ���ϸ� �����ϴ� ����� ���� 
  * - �۰� ������ ���ÿ� �����ϴ� ����� ����
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
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/review/storage");
   // Spring�� File ��ü�� �����ص�.
   List<MultipartFile> filesMF = reviewVO.getFilesMF(); 

   // System.out.println("--> filesMF.get(0).getSize(): " +
   // filesMF.get(0).getSize());

   String files = ""; // �÷��� ������ ���ϸ�
   String files_item = ""; // �ϳ��� ���ϸ�
   String sizes = "";
   long sizes_item = 0; // �ϳ��� ���� ������
   String thumbs = ""; // Thumb ���ϵ�
   String thumbs_item = ""; // �ϳ��� Thumb ���ϸ�

   int count = filesMF.size(); // ���ε�� ���� ����

   // ������ ��� ���� ��ȸ
   ReviewVO reviewVO_old = reviewProc.read(reviewVO.getReviewno());
   
   if (filesMF.get(0).getSize() > 0) { // ���ο� ������ ��������� ������ ��ϵ� ���� ��� ����
     // thumbs ���� ����
     String thumbs_old = reviewVO_old.getThumbs();
     StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
     while (thumbs_st.hasMoreTokens()) {
       String fname = upDir + thumbs_st.nextToken();
       Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
     }

     // ���� ���� ����
     String files_old = reviewVO_old.getFiles();
     StringTokenizer files_st = new StringTokenizer(files_old, "/");
     while (files_st.hasMoreTokens()) {
       String fname = upDir + files_st.nextToken();
       Tool.deleteFile(fname);  // ������ ��ϵ� ���� ���� ����
     }

     // --------------------------------------------
     // ���ο� ������ ��� ����
     // --------------------------------------------
     // for (MultipartFile multipartFile: filesMF) {
     for (int i = 0; i < count; i++) {
       MultipartFile multipartFile = filesMF.get(i); // 0 ~
       System.out.println("multipartFile.getName(): " + multipartFile.getName());

       // if (multipartFile.getName().length() > 0) { // ���������� �ִ��� üũ, filesMF
       if (multipartFile.getSize() > 0) { // ���������� �ִ��� üũ
         // System.out.println("���� ������ �ֽ��ϴ�.");
         files_item = Upload.saveFileSpring(multipartFile, upDir);
         sizes_item = multipartFile.getSize();

         if (Tool.isImage(files_item)) {
           thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb �̹��� ����
         }

         if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
           // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
           files = files + "/" + files_item;
           // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
           sizes = sizes + "/" + sizes_item;
           // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
           thumbs = thumbs + "/" + thumbs_item;
         } else if (multipartFile.getSize() > 0) { // ������ ��� ���� ��ü�� 1�� ����������
                                                   // ũ�� üũ
           files = files_item; // file1.jpg
           sizes = "" + sizes_item; // 123456
           thumbs = thumbs_item; // file1_t.jpg
         }

       }
     } // for END
     // --------------------------------------------
     // ���ο� ������ ��� ����
     // --------------------------------------------

   } else { // �۸� �����ϴ� ���, ������ ���� ���� ����
     files = reviewVO_old.getFiles();
     sizes = reviewVO_old.getSizes();
     thumbs = reviewVO_old.getThumbs();
   }
   reviewVO.setFiles(files);
   reviewVO.setSizes(sizes);
   reviewVO.setThumbs(thumbs);

   // reviewVO.setMemno(1); // ȸ�� ������ session���� ����

   count = reviewProc.update(reviewVO);

   // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
   
   redirectAttributes.addAttribute("count", count); // redirect parameter ����

   // redirect�ÿ��� request�� �����̾ȵ����� �Ʒ��� ����� �̿��Ͽ� ������ ����
   redirectAttributes.addAttribute("reviewno", reviewVO.getReviewno());
   redirectAttributes.addAttribute("goodsno", reviewVO.getGoodsno());
   redirectAttributes.addAttribute("writing", reviewVO.getWriting());
   redirectAttributes.addAttribute("nowPage", nowPage);

   mav.setViewName("redirect:/review/update_msg.jsp");
    
   return mav; 
 }
 
 /**
  * ���� �� 
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
  * ����
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

   // ������ ��� ���� ��ȸ
   ReviewVO reviewVO_old = reviewProc.read(reviewno);
   
   String thumbs_old = reviewVO_old.getThumbs();
   StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
   while (thumbs_st.hasMoreTokens()) {
     String fname = upDir + thumbs_st.nextToken();
     Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
   }
   
   // ���� ���� ����
   String files_old = reviewVO_old.getFiles();
   StringTokenizer files_st = new StringTokenizer(files_old, "/");
   while (files_st.hasMoreTokens()) {
     String fname = upDir + files_st.nextToken();
     Tool.deleteFile(fname);  // ������ ��ϵ� ���� ���� ����
   }
   
   int count = reviewProc.delete(reviewno);
   if (count > 0) {
     goodsProc.decreaseVisit(goodsno);  // �۰��� ����
     
   // -------------------------------------------------------------------------------------
   // ������ �������� ���ڵ� �������� ������ ��ȣ -1 ó��
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
   redirectAttributes.addAttribute("count", count); // redirect parameter ����
   redirectAttributes.addAttribute("reviewno", reviewno);
   redirectAttributes.addAttribute("goodsno", goodsno);
   redirectAttributes.addAttribute("writing", reviewVO_old.getWriting());
   // redirectAttributes.addAttribute("askcont", custoVO_old.getAskcont());
   redirectAttributes.addAttribute("nowPage", nowPage);    
   
   mav.setViewName("redirect:/review/delete_msg.jsp");

   return mav; 
 }
 
 /**
  * ī�װ��� �˻� ���
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
   
   // �˻��� ���ڵ� ���
   List<ReviewVO> list = reviewProc.list_by_review_search(map);
   mav.addObject("list", list);
   
   // �˻��� ���ڵ� ����
   int search_count = reviewProc.search_count(map);
   mav.addObject("search_count", search_count);

   mav.setViewName("/review/list_by_review_search"); // /webapp/contents/list_by_cateno_search.jsp

   return mav;
 }
 
 /**
  * ��� + �˻� + ����¡ ����
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
   
   // �˻� ��� �߰�,  /webapp/review/list_by_review_search_paging.jsp
   mav.setViewName("/review/list_by_review_search_paging");   
   
   // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
   HashMap<String, Object> map = new HashMap<String, Object>();
   map.put("goodsno", goodsno); // #{goodsno}
   map.put("word", word);     // #{word}
   map.put("nowPage", nowPage);       
   
   // �˻� ���
   List<ReviewVO> list = reviewProc.list_by_review_search_paging(map);
   mav.addObject("list", list);
   
   // �˻��� ���ڵ� ����
   int search_count = reviewProc.search_count(map);
   mav.addObject("search_count", search_count);
 
   Goods_ReviewVO goods_ReviewVO=goodsProc.read_by_join(goodsno);
   mav.addObject("goods_ReviewVO", goods_ReviewVO);
   
   // mav.addObject("word", word);
 
   /*
    * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
    * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
    * 
    * @param listFile ��� ���ϸ� 
    * @param goodsno ī�װ���ȣ 
    * @param search_count �˻�(��ü) ���ڵ�� 
    * @param nowPage     ���� ������
    * @param word �˻���
    * @return ����¡ ���� ���ڿ�
    */ 
   String paging = reviewProc.pagingBox("list_by_review_search_paging.do", goodsno, search_count, nowPage, word);
   mav.addObject("paging", paging);
 
   mav.addObject("nowPage", nowPage);
   
   return mav;
 }
 
}
