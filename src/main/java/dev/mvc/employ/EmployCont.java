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
   * ��� �� http://localhost:9090/diesta/employ/create.do?diecateno=1
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
   * ��� ó��
   * @param request
   * @param eventVO
   * @return
   */  
  @RequestMapping(value="/employ/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, EmployVO employVO) {
    
    ModelAndView mav = new ModelAndView();
    
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/employ/storage");
    // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
    List<MultipartFile> filesMF = employVO.getFilesMF(); 
 
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
    employVO.setFiles(files);
    employVO.setSizes(sizes);
    employVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------

     
    count = employProc.create(employVO);
    if (count==1) {
      diecateProc.increaseCnt(employVO.getDiecateno()); // �� �� ����
    }
    mav.setViewName("redirect:/employ/create_msg.jsp?count=" + count + "&diecateno=" + employVO.getDiecateno());
   
    return mav;
  }
  
  /**
   * ��ü ���
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
   * ��ȸ
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

    // ī�װ� ���� ���� 
    Diecategrp_cateVO diecategrp_cateVO=diecateProc.read_by_join(employVO.getDiecateno());
    mav.addObject("diecategrp_cateVO", diecategrp_cateVO);
    
    ArrayList<FileVO> file_list = employProc.getThumbs(employVO);

    mav.addObject("file_list", file_list);

    return mav;
  }
  
  /**
   * ���� �� http://localhost:9090/diesta/employ/update.do?eventno=1
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
   * - �۸� �����ϴ� ����� ���� 
   * - ���ϸ� �����ϴ� ����� ���� 
   * - �۰� ������ ���ÿ� �����ϴ� ����� ����
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/employ/storage");
    // Spring�� File ��ü�� �����ص�.
    List<MultipartFile> filesMF = employVO.getFilesMF(); 
 
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
    EmployVO employVO_old = employProc.read(employVO.getEmployno());
    
    if (filesMF.get(0).getSize() > 0) { // ���ο� ������ ��������� ������ ��ϵ� ���� ��� ����
      // thumbs ���� ����
      String thumbs_old = employVO_old.getThumbs();
      StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
      while (thumbs_st.hasMoreTokens()) {
        String fname = upDir + thumbs_st.nextToken();
        Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
      }
 
      // ���� ���� ����
      String files_old = employVO_old.getFiles();
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
      files = employVO_old.getFiles();
      sizes = employVO_old.getSizes();
      thumbs = employVO_old.getThumbs();
    }
    employVO.setFiles(files);
    employVO.setSizes(sizes);
    employVO.setThumbs(thumbs);
 
    // eventVO.setDiecateno(1); // ȸ�� ������ session���� ����
 
    count = employProc.update(employVO);
 
    // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
    
    redirectAttributes.addAttribute("count", count); // redirect parameter ����
 
    // redirect�ÿ��� request�� �����̾ȵ����� �Ʒ��� ����� �̿��Ͽ� ������ ����
    redirectAttributes.addAttribute("diecateno", employVO.getDiecateno());
    redirectAttributes.addAttribute("employno", employVO.getEmployno());
    redirectAttributes.addAttribute("title", employVO.getTitle());
 
    mav.setViewName("redirect:/employ/update_msg.jsp");
     
    return mav; 
  }
  
  /**
   * ���� �� 
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
   * ����
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

    // ������ ��� ���� ��ȸ
    EmployVO employVO_old = employProc.read(employno);
    
    String thumbs_old = employVO_old.getThumbs();
    StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
    while (thumbs_st.hasMoreTokens()) {
      String fname = upDir + thumbs_st.nextToken();
      Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
    }
    
    // ���� ���� ����
    String files_old = employVO_old.getFiles();
    StringTokenizer files_st = new StringTokenizer(files_old, "/");
    while (files_st.hasMoreTokens()) {
      String fname = upDir + files_st.nextToken();
      Tool.deleteFile(fname);  // ������ ��ϵ� ���� ���� ����
    }
    
    int count = employProc.delete(employno);
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
    redirectAttributes.addAttribute("employno", employno);
    redirectAttributes.addAttribute("diecateno", diecateno);
    redirectAttributes.addAttribute("title", employVO_old.getTitle());
    
    mav.setViewName("redirect:/employ/delete_msg.jsp");
 
    return mav; 
  }

}
