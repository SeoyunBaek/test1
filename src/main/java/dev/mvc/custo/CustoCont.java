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
   * ��� �� http://localhost:9090/diesta/custo_qus/create.do?memno=1
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
   * ��� ó��
   * 
   * ���� �±��� ����
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ��
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/custo_qus/storage");
    // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
    List<MultipartFile> filesMF = custoVO.getFilesMF(); 
 
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
    custoVO.setFiles(files);
    custoVO.setSizes(sizes);
    custoVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    
    count = custoProc.create(custoVO);
    if (count==1) {
      memProc.increaseCnt(custoVO.getMemno()); // �� �� ����
    }
           
    mav.setViewName("redirect:/custo_qus/create_msg.jsp?count=" + count+"&memno="+custoVO.getMemno());
   
    return mav;
  }
  
  /**
   * ��ü ���
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
   * ��ȸ
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

    // ī�װ� ���� ����
    Mem_CustoVO mem_CustoVO=memProc.read_by_join_m(custoVO.getMemno());
    mav.addObject("mem_CustoVO", mem_CustoVO);
    
    ArrayList<FileVO> file_list = custoProc.getThumbs(custoVO);

    mav.addObject("file_list", file_list);

    return mav;
  }
  
  /**
   * ���� �� http://localhost:9090/diesta/custo_qus/update.do?custoqusno=1
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
   * - �۸� �����ϴ� ����� ���� 
   * - ���ϸ� �����ϴ� ����� ���� 
   * - �۰� ������ ���ÿ� �����ϴ� ����� ����
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/custo_qus/storage");
    // Spring�� File ��ü�� �����ص�.
    List<MultipartFile> filesMF = custoVO.getFilesMF(); 
 
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
    CustoVO custoVO_old = custoProc.read(custoVO.getCustoqusno());
    
    if (filesMF.get(0).getSize() > 0) { // ���ο� ������ ��������� ������ ��ϵ� ���� ��� ����
      // thumbs ���� ����
      String thumbs_old = custoVO_old.getThumbs();
      StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
      while (thumbs_st.hasMoreTokens()) {
        String fname = upDir + thumbs_st.nextToken();
        Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
      }
 
      // ���� ���� ����
      String files_old = custoVO_old.getFiles();
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
      files = custoVO_old.getFiles();
      sizes = custoVO_old.getSizes();
      thumbs = custoVO_old.getThumbs();
    }
    custoVO.setFiles(files);
    custoVO.setSizes(sizes);
    custoVO.setThumbs(thumbs);
 
    custoVO.setMemno(1); // ȸ�� ������ session���� ����
 
    count = custoProc.update(custoVO);
 
    // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
    
    redirectAttributes.addAttribute("count", count); // redirect parameter ����
 
    // redirect�ÿ��� request�� �����̾ȵ����� �Ʒ��� ����� �̿��Ͽ� ������ ����
    redirectAttributes.addAttribute("custoqusno", custoVO.getCustoqusno());
    redirectAttributes.addAttribute("memno", custoVO.getMemno());
    redirectAttributes.addAttribute("title", custoVO.getTitle());
    redirectAttributes.addAttribute("nowPage", nowPage);
 
    mav.setViewName("redirect:/custo_qus/update_msg.jsp");
     
    return mav; 
  }
    
  /**
   * ���� �� 
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
   * ����
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

    // ������ ��� ���� ��ȸ
    CustoVO custoVO_old = custoProc.read(custoqusno);
    
    String thumbs_old = custoVO_old.getThumbs();
    StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
    while (thumbs_st.hasMoreTokens()) {
      String fname = upDir + thumbs_st.nextToken();
      Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
    }
    
    // ���� ���� ����
    String files_old = custoVO_old.getFiles();
    StringTokenizer files_st = new StringTokenizer(files_old, "/");
    while (files_st.hasMoreTokens()) {
      String fname = upDir + files_st.nextToken();
      Tool.deleteFile(fname);  // ������ ��ϵ� ���� ���� ����
    }
    
    int count = custoProc.delete(custoqusno);
    if (count > 0) {
      memProc.decreaseCnt(memno);  // �۰��� ����
      
    // -------------------------------------------------------------------------------------
    // ������ �������� ���ڵ� �������� ������ ��ȣ -1 ó��
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
    redirectAttributes.addAttribute("count", count); // redirect parameter ����
    redirectAttributes.addAttribute("custoqusno", custoqusno);
    redirectAttributes.addAttribute("memno", memno);
    redirectAttributes.addAttribute("title", custoVO_old.getTitle());
    redirectAttributes.addAttribute("nowPage", nowPage);    
    
    mav.setViewName("redirect:/custo_qus/delete_msg.jsp");
 
    return mav; 
  }
  
  /**
   * ī�װ��� �˻� ���
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
    
    // �˻��� ���ڵ� ���
    List<CustoVO> list = custoProc.list_by_custo_search(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = custoProc.search_count(map);
    mav.addObject("search_count", search_count);
 
    mav.setViewName("/custo_qus/list_by_custo_search"); // /webapp/contents/list_by_cateno_search.jsp
 
    return mav;
  }
  
  /**
   * ��� + �˻� + ����¡ ����
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
    
    // �˻� ��� �߰�,  /webapp/custo_qus/list_by_custo_search_paging.jsp
    mav.setViewName("/custo_qus/list_by_custo_search_paging");   
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("memno", memno); // #{memno}
    map.put("word", word);     // #{word}
    map.put("nowPage", nowPage);       
    
    // �˻� ���
    List<CustoVO> list = custoProc.list_by_custo_search_paging(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = custoProc.search_count(map);
    mav.addObject("search_count", search_count);
  
    Mem_CustoVO mem_CustoVO=memProc.read_by_join_m(memno);
    mav.addObject("mem_CustoVO", mem_CustoVO);
    
    // mav.addObject("word", word);
  
    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     * 
     * @param listFile ��� ���ϸ� 
     * @param categoryno ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param word �˻���
     * @return ����¡ ���� ���ڿ�
     */ 
    String paging = custoProc.pagingBox("list_by_custo_search_paging.do", memno, search_count, nowPage, word);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }
  
  /**
   * �亯 �� http://localhost:9090/diesta/custo_qus/reply.do?memno=1
   * 
   * @return
   */
  @RequestMapping(value = "/custo_qus/reply.do", method = RequestMethod.GET)
  public ModelAndView reply(int memno, int custoqusno) {
    ModelAndView mav = new ModelAndView();
    
    System.out.println("�亯 ���: " + custoqusno);

    Mem_CustoVO mem_CustoVO = memProc.read_by_join_m(memno);
    mav.addObject("mem_CustoVO", mem_CustoVO);
    
    mav.setViewName("/custo_qus/reply"); // /webapp/contents/reply.jsp
 
    return mav;
  }

  /**
   * �亯 ó��
   * 
   * ���� �±��� ����
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ��
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/custo_qus/storage");
    // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
    List<MultipartFile> filesMF = custoVO.getFilesMF(); 
 
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
    custoVO.setFiles(files);
    custoVO.setSizes(sizes);
    custoVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    
    // ȸ�� ���� �� session ���κ���
    // int mno = (Integer)session.getAttribute("mno");
    custoVO.setMemno(1);
    
    // --------------------------- �亯 ���� �ڵ� ���� --------------------------
    CustoVO parentVO = custoProc.read(custoVO.getCustoqusno()); // �θ�� ���� ����
    
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("grpno", parentVO.getGrpno());
    map.put("ansnum",  parentVO.getAnsnum());
    custoProc.increaseAnsnum(map); // ���� ��ϵ� �亯 �ڷ� +1 ó����.

    custoVO.setGrpno(parentVO.getGrpno()); // �θ��� �׷��ȣ �Ҵ�
    custoVO.setIndent(parentVO.getIndent() + 1); // �亯 ���� ����
    custoVO.setAnsnum(parentVO.getAnsnum() + 1); // �θ� �ٷ� �Ʒ� ���
    // --------------------------- �亯 ���� �ڵ� ���� --------------------------

    count = custoProc.reply(custoVO);
    if (count == 1) {
      memProc.increaseCnt(custoVO.getMemno()); // �ۼ� ����
    }
 
    mav.setViewName(
        "redirect:/custo_qus/reply_msg.jsp?count=" + count + "&memno=" + custoVO.getMemno()+ "&nowPage=" + nowPage); // /webapp/contents/reply_msg.jsp
 
    // mav.setViewName("redirect:/contents/list_by_cateno_search_paging.do?cateno=" + contentsVO.getCateno());
    // mav.setViewName("redirect:/contents/list_all_cateno.do");
 
    return mav;
  }
  
}
