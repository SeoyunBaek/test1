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
   * ��� ��
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
   * ��� ó��
   * 
   * ���� �±��� ����
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ��
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/goods/storage");
    // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
    List<MultipartFile> filesMF = goodsVO.getFilesMF(); 
 
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
    goodsVO.setFiles(files);
    goodsVO.setSizes(sizes);
    goodsVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------

    count = goodsProc.create(goodsVO);
    if (count == 1) {
      diecateProc.increaseCnt(goodsVO.getDiecateno()); // �ۼ� ����
    }
 
    mav.setViewName(
        "redirect:/goods/create_msg.jsp?count=" + count + "&diecateno=" + goodsVO.getDiecateno());
    return mav;
  }
  
  /**
   * ��ü ���
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
   * ī�װ��� ���
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
   * ��ȸ
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

    // ī�װ� ���� ����
    DiecateVO diecateVO = diecateProc.read(goodsVO.getDiecateno()); 
    mav.addObject("diecateVO", diecateVO);

    ArrayList<FileVO> file_list = goodsProc.getThumbs(goodsVO);

    mav.addObject("file_list", file_list);
    
    int count = goodsProc.increaseVisit(goodsno);
    mav.addObject("count", count);
    
    return mav;
  }
  
  //ZIP ���� �� ���� �ٿ�ε� 
  @RequestMapping(value = "/goods/download.do", method = RequestMethod.GET)
  public ModelAndView download(HttpServletRequest request, int goodsno) {
    ModelAndView mav = new ModelAndView();

    GoodsVO goodsVO = goodsProc.read(goodsno);
   
    String files = goodsVO.getFiles();
    String[] files_array = files.split("/");
   
    String dir = "/goods/storage";
    String upDir = Tool.getRealPath(request, dir); // ���� ��� ����
   
    // �ٿ�ε�Ǵ� ����, ���ϸ��� �����ϰų� ��¥ ����
    String zip = Tool.getDateRand() + ".zip";  // 20190522102114933.zip
    String zip_filename = upDir + zip; // ���������� ������ ���� ����
   
    String[] zip_src = new String[files_array.length]; // ���� ������ŭ �迭 ����
   
    for (int i=0; i < files_array.length; i++) {
      zip_src[i] = upDir + "/" + files_array[i]; // ���� ��ΰ� ���յ� ���� ����      
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
        // 4 KB�� �о buffer �迭�� ������ ���� ����Ʈ���� length�� ����
        while((length = in.read(buffer)) > 0) {
          zipOutputStream.write(buffer, 0, length); // ����� ����, ���뿡���� ���� ��ġ, ����� ����
         
        }
        zipOutputStream.closeEntry();
        in.close();
      }
      zipOutputStream.close();
     
      File file = new File(zip_filename);
     
      if (file.exists() && file.length() > 0) {
        System.out.println(zip_filename + " ���� ���� ����.");
      }
     
//     if (file.delete() == true) {
//       System.out.println(zip_filename + " ������ �����߽��ϴ�.");
//     }

    } catch (FileNotFoundException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    }

    // download ���� ����
    mav.setViewName("redirect:/download?dir=" + dir + "&filename=" + zip);    
   
    return mav;
  }
  
  /**
   * ���� ��
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
   * - �۸� �����ϴ� ����� ���� 
   * - ���ϸ� �����ϴ� ����� ���� 
   * - �۰� ������ ���ÿ� �����ϴ� ����� ����
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/goods/storage");
    // Spring�� File ��ü�� �����ص�.
    List<MultipartFile> filesMF = goodsVO.getFilesMF(); 
 
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
    GoodsVO goodsVO_old = goodsProc.read(goodsVO.getGoodsno());
    
    if (filesMF.get(0).getSize() > 0) { // ���ο� ������ ��������� ������ ��ϵ� ���� ��� ����
      // thumbs ���� ����
      String thumbs_old = goodsVO_old.getThumbs();
      StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
      while (thumbs_st.hasMoreTokens()) {
        String fname = upDir + thumbs_st.nextToken();
        Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
      }
 
      // ���� ���� ����
      String files_old = goodsVO_old.getFiles();
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
            thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb �̹���
                                                                    // ����
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
      files = goodsVO_old.getFiles();
      sizes = goodsVO_old.getSizes();
      thumbs = goodsVO_old.getThumbs();
    }
    goodsVO.setFiles(files);
    goodsVO.setSizes(sizes);
    goodsVO.setThumbs(thumbs);
 
    // goodsVO.setMemno(1); // ȸ�� ������ session���� ����
 
    count = goodsProc.update(goodsVO);  // DBMS ����
 
    // mav.setViewName("redirect:/goods/update_msg.jsp?count=" + count + "&...);
    
    redirectAttributes.addAttribute("count", count); // redirect parameter ����
 
    // redirect�ÿ��� request�� �����̾ȵ����� �Ʒ��� ����� �̿��Ͽ� ������ ����
    redirectAttributes.addAttribute("goodsno", goodsVO.getGoodsno());
    redirectAttributes.addAttribute("diecateno", goodsVO.getDiecateno());
    redirectAttributes.addAttribute("title", goodsVO.getTitle());
    redirectAttributes.addAttribute("nowPage", nowPage);
 
    mav.setViewName("redirect:/goods/update_msg.jsp");
     
    return mav; 
  }
  
  /**
   * ���� �� 
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
   * ����
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

    // ������ ��� ���� ��ȸ
    GoodsVO goodsVO_old = goodsProc.read(goodsno);
    
    String thumbs_old = goodsVO_old.getThumbs();
    StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
    while (thumbs_st.hasMoreTokens()) {
      String fname = upDir + thumbs_st.nextToken();
      Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
    }
 
    // ���� ���� ����
    String files_old = goodsVO_old.getFiles();
    StringTokenizer files_st = new StringTokenizer(files_old, "/");
    while (files_st.hasMoreTokens()) {
      String fname = upDir + files_st.nextToken();
      Tool.deleteFile(fname);  // ������ ��ϵ� ���� ���� ����
    }
 
    int count = goodsProc.delete(goodsno);
    if (count > 0) {
      diecateProc.decreaseCnt(diecateno);  // �۰��� ����
      
      // -------------------------------------------------------------------------------------
      // ������ �������� ���ڵ� �������� ������ ��ȣ -1 ó��
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
    redirectAttributes.addAttribute("count", count); // redirect parameter ����
    redirectAttributes.addAttribute("goodsno", goodsno);
    redirectAttributes.addAttribute("diecateno", diecateno);
    redirectAttributes.addAttribute("title", goodsVO_old.getTitle());
    redirectAttributes.addAttribute("nowPage", nowPage);
    
    mav.setViewName("redirect:/goods/delete_msg.jsp");
 
    return mav; 
  
  }
  
  /**
   * ī�װ��� �˻� ���
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
    
    // �˻��� ���ڵ� ���
    List<GoodsVO> list = goodsProc.list_by_diecate_search(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = goodsProc.search_count(map);
    mav.addObject("search_count", search_count);

 
    mav.setViewName("/goods/list_by_diecate_search"); // /webapp/contents/list_by_cateno_search.jsp
 
    return mav;
  }
  
  /**
   * ��� + �˻� + ����¡ ����
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
    
    // �˻� ��� �߰�,  /webapp/contents/list_by_category_search_paging.jsp
    mav.setViewName("/goods/list_by_diecate_search_paging");   
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("diecateno", diecateno); // #{cateno}
    map.put("word", word);     // #{word}
    map.put("nowPage", nowPage);       
    
    // �˻� ���
    List<GoodsVO> list = goodsProc.list_by_diecate_search_paging(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = goodsProc.search_count(map);
    mav.addObject("search_count", search_count);
  
    DiecateVO diecateVO = diecateProc.read(diecateno);
    mav.addObject("diecateVO", diecateVO);
    
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
    String paging = goodsProc.pagingBox("list_by_diecate_search_paging.do", diecateno, search_count, nowPage, word);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }    
  
  
  
}
