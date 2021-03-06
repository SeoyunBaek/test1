package dev.mvc.event;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.goods.FileVO;
import dev.mvc.review.ReviewVO;
import nation.web.tool.Tool;

@Component("dev.mvc.event.EventProc")
public class EventProc implements EventProcInter{  
  @Autowired
  private EventDAOInter eventDAO;

  public EventProc() {
    System.out.println("--> EventProc created.");
  }

  @Override
  public int create(EventVO eventVO) {
    int count=eventDAO.create(eventVO);
    return count;
  }
  
  @Override
  public ArrayList<EventVO> list_all_event() {
    ArrayList<EventVO> list=eventDAO.list_all_event();
    return list;
  }
  
  /**
   * 이미지 목록중에 첫번째 이미지 파일명을 추출하여 리턴
   * @param eventVO
   * @return
   */
  public String getThumb(EventVO eventVO) {
    String thumbs = eventVO.getThumbs();
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
  public ArrayList<FileVO> getThumbs(EventVO eventVO) {
    ArrayList<FileVO> file_list = new ArrayList<FileVO>();
    
    String thumbs = eventVO.getThumbs(); // xmas01_2_t.jpg/xmas02_2_t.jpg...
    String files = eventVO.getFiles();          // xmas01_2.jpg/xmas02_2.jpg...
    String sizes = eventVO.getSizes();        // 272558/404087... 
    
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
    int count=eventDAO.total_count();
    return count;
  }

  @Override
  public EventVO read(int eventno) {
    return eventDAO.read(eventno);
  }
  
  @Override
  public int update(EventVO eventVO) {
    int count = eventDAO.update(eventVO);
    return count;
  }
  
  @Override
  public int delete(int eventno) {
    int count = eventDAO.delete(eventno);
    return count;
  }
  
  @Override
  public ArrayList<EventVO> list_by_event_search(HashMap map) {
    ArrayList<EventVO> list = eventDAO.list_by_event_search(map);
    
    int count = list.size();
    for (int i=0; i < count; i++) {
      EventVO eventVO = list.get(i);
      String thumb = getThumb(eventVO);
      eventVO.setThumb(thumb);
    }
    
    return list;
  }
  
  @Override
  public int search_count(HashMap map) {
    int count = eventDAO.search_count(map);
    return count;
  }
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param listFile 목록 파일명 
   * @param cateno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  @Override
  public String pagingBox(String listFile, int diecateno, int search_count, int nowPage, String word){ 
    int totalPage = (int)(Math.ceil((double)search_count/Event.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Event.PAGE_PER_BLOCK)); // 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Event.PAGE_PER_BLOCK)); // 현재 그룹 
    int startPage = ((nowGrp - 1) * Event.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Event.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료
    
    
   StringBuffer str = new StringBuffer(); 
    
   str.append("<style type='text/css'>"); 
   str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
   str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
   str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
   str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
   str.append("  .span_box_1{"); 
   str.append("    text-align: center;");    
   str.append("    font-size: 1em;"); 
   str.append("    border: 1px;"); 
   str.append("    border-style: solid;"); 
   str.append("    border-color: #cccccc;"); 
   str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
   str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
   str.append("  }"); 
   str.append("  .span_box_2{"); 
   str.append("    text-align: center;");    
   str.append("    background-color: #668db4;"); 
   str.append("    color: #FFFFFF;"); 
   str.append("    font-size: 1em;"); 
   str.append("    border: 1px;"); 
   str.append("    border-style: solid;"); 
   str.append("    border-color: #cccccc;"); 
   str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
   str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
   str.append("  }"); 
   str.append("</style>"); 
   str.append("<DIV id='paging'>"); 
//   str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 

   // 이전 10개 페이지로 이동
   // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
   // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 10
   // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 20
   
   int _nowPage = (nowGrp-1) * Event.PAGE_PER_BLOCK;
   if (nowGrp >= 2){ 
     str.append("<span class='span_box_1'><A href='./"+listFile+"?&word="+word+"&nowPage="+_nowPage+"&diecateno="+diecateno+"'>이전</A></span>"); 
   } 
   
   for(int i=startPage; i<=endPage; i++){ 
     if (i > totalPage){ 
       break; 
     } 
 
     if (nowPage == i){ 
       str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
     }else{
       // 현재 페이지가 아닌 페이지
       str.append("<span class='span_box_1'><A href='./"+listFile+"?word="+word+"&nowPage="+i+"&diecateno="+diecateno+"'>"+i+"</A></span>");   
     } 
   }

   // 10개 다음 페이지로 이동
   // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
   // 현재 1그룹일 경우: (1 * 10) + 1 = 2그룹의 11
   // 현재 2그룹일 경우: (2 * 10) + 1 = 3그룹의 21
   _nowPage = (nowGrp * Event.PAGE_PER_BLOCK)+1;
   if (nowGrp < totalGrp){ 
     str.append("<span class='span_box_1'><A href='./"+listFile+"?&word="+word+"&nowPage="+_nowPage+"&diecateno="+diecateno+"'>다음</A></span>"); 
   } 
   str.append("</DIV>"); 
    
   return str.toString();    
  }
  
  @Override
  public ArrayList<EventVO> list_by_event_search_paging(HashMap<String, Object> map) {
    /* 
    페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
    2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
    3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * Event.RECORD_PER_PAGE;
   
    // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
   int startNum = beginOfPage + 1; 
   //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
   int endNum = beginOfPage + Event.RECORD_PER_PAGE;   
   /*
    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30
    */
   map.put("startNum", startNum);
   map.put("endNum", endNum);
   
    ArrayList<EventVO> list = eventDAO.list_by_event_search_paging(map);
    
    int count = list.size();
    for (int i=0; i < count; i++) {
      EventVO eventVO = list.get(i);
      String thumb = getThumb(eventVO); // 대표 이미지 추출
      eventVO.setThumb(thumb); 
    }
    
    return list;
  }
   
}
