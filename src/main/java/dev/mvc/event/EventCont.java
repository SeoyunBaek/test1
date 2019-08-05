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
   * ��� �� 
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
   * ��� ó��
   * 
   * ���� �±��� ����
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ��
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/event/storage");
    // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
    List<MultipartFile> filesMF = eventVO.getFilesMF(); 
 
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
    eventVO.setFiles(files);
    eventVO.setSizes(sizes);
    eventVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    
    count = eventProc.create(eventVO);
    if (count==1) {
      diecateProc.increaseCnt(eventVO.getDiecateno()); // �� �� ����
    }
           
    mav.setViewName("redirect:/event/create_msg.jsp?count=" + count+"&diecateno="+eventVO.getDiecateno());
   
    return mav;
  }
  
  /**
   * ��ü ���
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
   * ��ȸ
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

    // ī�װ� ���� ���� 
    Diecategrp_cateVO diecategrp_cateVO=diecateProc.read_by_join(eventVO.getDiecateno());
    mav.addObject("diecategrp_cateVO", diecategrp_cateVO);
    
    ArrayList<FileVO> file_list = eventProc.getThumbs(eventVO);

    mav.addObject("file_list", file_list);

    return mav;
  }
  
  /**
   * ���� �� http://localhost:9090/diesta/event/update.do?eventno=1
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
   * - �۸� �����ϴ� ����� ���� 
   * - ���ϸ� �����ϴ� ����� ���� 
   * - �۰� ������ ���ÿ� �����ϴ� ����� ����
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/event/storage");
    // Spring�� File ��ü�� �����ص�.
    List<MultipartFile> filesMF = eventVO.getFilesMF(); 
 
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
    EventVO eventVO_old = eventProc.read(eventVO.getEventno());
    
    if (filesMF.get(0).getSize() > 0) { // ���ο� ������ ��������� ������ ��ϵ� ���� ��� ����
      // thumbs ���� ����
      String thumbs_old = eventVO_old.getThumbs();
      StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
      while (thumbs_st.hasMoreTokens()) {
        String fname = upDir + thumbs_st.nextToken();
        Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
      }
 
      // ���� ���� ����
      String files_old = eventVO_old.getFiles();
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
      files = eventVO_old.getFiles();
      sizes = eventVO_old.getSizes();
      thumbs = eventVO_old.getThumbs();
    }
    eventVO.setFiles(files);
    eventVO.setSizes(sizes);
    eventVO.setThumbs(thumbs);
 
    // eventVO.setDiecateno(1); // ȸ�� ������ session���� ����
 
    count = eventProc.update(eventVO);
 
    // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
    
    redirectAttributes.addAttribute("count", count); // redirect parameter ����
 
    // redirect�ÿ��� request�� �����̾ȵ����� �Ʒ��� ����� �̿��Ͽ� ������ ����
    redirectAttributes.addAttribute("diecateno", eventVO.getDiecateno());
    redirectAttributes.addAttribute("eventno", eventVO.getEventno());
    redirectAttributes.addAttribute("title", eventVO.getTitle());
 
    mav.setViewName("redirect:/event/update_msg.jsp");
     
    return mav; 
  }
  
  /**
   * ���� �� 
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
   * ����
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

    // ������ ��� ���� ��ȸ
    EventVO eventVO_old = eventProc.read(eventno);
    
    String thumbs_old = eventVO_old.getThumbs();
    StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
    while (thumbs_st.hasMoreTokens()) {
      String fname = upDir + thumbs_st.nextToken();
      Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
    }
    
    // ���� ���� ����
    String files_old = eventVO_old.getFiles();
    StringTokenizer files_st = new StringTokenizer(files_old, "/");
    while (files_st.hasMoreTokens()) {
      String fname = upDir + files_st.nextToken();
      Tool.deleteFile(fname);  // ������ ��ϵ� ���� ���� ����
    }
    
    int count = eventProc.delete(eventno);
    if (count > 0) {
      diecateProc.decreaseCnt(diecateno);  // �۰��� ����
      
    // -------------------------------------------------------------------------------------
    // ������ �������� ���ڵ� �������� ������ ��ȣ -1 ó��
    HashMap<String, Object> map = new HashMap();
    map.put("diecateno", diecateno);
    // -------------------------------------------------------------------------------------
    
  }
   
    // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
    redirectAttributes.addAttribute("count", count); // redirect parameter ����
    redirectAttributes.addAttribute("eventno", eventno);
    redirectAttributes.addAttribute("diecateno", diecateno);
    redirectAttributes.addAttribute("title", eventVO_old.getTitle());
    
    mav.setViewName("redirect:/event/delete_msg.jsp");
 
    return mav; 
  }
  
  /**
   * ī�װ��� �˻� ���
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
    
    // �˻��� ���ڵ� ���
    List<EventVO> list = eventProc.list_by_event_search(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = eventProc.search_count(map);
    mav.addObject("search_count", search_count);
 
    mav.setViewName("/event/list_by_event_search"); // /webapp/contents/list_by_cateno_search.jsp
 
    return mav;
  }
  
  /**
   * ��� + �˻� + ����¡ ����
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
    
    // �˻� ��� �߰�,  /webapp/custo_qus/list_by_custo_search_paging.jsp
    mav.setViewName("/event/list_by_event_search_paging");   
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("diecateno", diecateno); // #{diecateno}
    map.put("word", word);     // #{word}
    map.put("nowPage", nowPage);       
    
    // �˻� ���
    List<EventVO> list = eventProc.list_by_event_search_paging(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = eventProc.search_count(map);
    mav.addObject("search_count", search_count);

    Diecategrp_cateVO diecategrp_cateVO=diecateProc.read_by_join(diecateno);
    mav.addObject("diecategrp_cateVO", diecategrp_cateVO);
    
    // mav.addObject("word", word);
  
    
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     * 
     * @param listFile ��� ���ϸ� 
     * @param categoryno ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param word �˻���
     * @return ����¡ ���� ���ڿ�
      
    String paging = eventProc.pagingBox("list_by_event_search_paging.do", diecateno, search_count, nowPage, word);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }*/
  
}


