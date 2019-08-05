package dev.mvc.employ;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.diecate.DiecateVO;
import dev.mvc.event.EventVO;
import dev.mvc.goods.FileVO;
import nation.web.tool.Tool;


@Component("dev.mvc.employ.EmployProc")
public class EmployProc implements EmployProcInter {
  @Autowired
  private EmployDAOInter employDAO;
  
  public EmployProc() {
    System.out.println("--> EventProc created.");
  }
  
  @Override
  public int create(EmployVO employVO) {
    int count=employDAO.create(employVO);
    return count;
  }

  @Override
  public ArrayList<EmployVO> list_all_employ() {
    ArrayList<EmployVO> list=employDAO.list_all_employ();
    return list;
  }
  
  /**
   * 이미지 목록중에 첫번째 이미지 파일명을 추출하여 리턴
   * @param eventVO
   * @return
   */
  public String getThumb(EmployVO employVO) {
    String thumbs = employVO.getThumbs();
    String thumb = "";
    
    if (thumbs != null) {
      String[] thumbs_array = thumbs.split("/");
      int count = thumbs_array.length;
      
      if (count > 0) {
        thumb = thumbs_array[0];    
      }
    }
    // System.out.println("thumb: " + thumb);
    return thumb;
  }
  
  /**
   * 파일명의 갯수만큼 FileVO 객체를 만들어 리턴
   * @param eventVO
   * @return
   */
  public ArrayList<FileVO> getThumbs(EmployVO employVO) {
    ArrayList<FileVO> file_list = new ArrayList<FileVO>();
    
    String thumbs = employVO.getThumbs(); // xmas01_2_t.jpg/xmas02_2_t.jpg...
    String files = employVO.getFiles();          // xmas01_2.jpg/xmas02_2.jpg...
    String sizes = employVO.getSizes();        // 272558/404087... 
    
    String[] thumbs_array = thumbs.split("/");  // Thumbs
    String[] files_array = files.split("/");   // 파일명 추출
    String[] sizes_array = sizes.split("/"); // 파일 사이즈

    int count = sizes_array.length;
    // System.out.println("sizes_array.length: " + sizes_array.length);
    // System.out.println("sizes: " + sizes);
    // System.out.println("files: " + files);

    if (files.length() > 0) {
      for (int index = 0; index < count; index++) {
        sizes_array[index] = Tool.unit(new Integer(sizes_array[index]));  // 1024 -> 1KB
      
        FileVO fileVO = new FileVO(thumbs_array[index], 
                                            files_array[index], 
                                            sizes_array[index]);
        file_list.add(fileVO);
      }
    } 

    return file_list;
  }

  @Override
  public int total_count() {
    int count=employDAO.total_count();
    return count;
  }
  
  @Override
  public EmployVO read(int employno) {
    return employDAO.read(employno);
  }

  @Override
  public int update(EmployVO employVO) {
    int count = employDAO.update(employVO);
    return count;
  }
  
  @Override
  public int delete(int eventno) {
    int count = employDAO.delete(eventno);
    return count;
  }
  
}
