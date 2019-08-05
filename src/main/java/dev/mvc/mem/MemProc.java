package dev.mvc.mem;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.mem.MemProc")
public class MemProc implements MemProcInter{
 @Autowired
  private MemDAOInter memDAO;

 public MemProc(){
 //System.out.println("--> MemProc created.");
 }

@Override
public int checkId(String id) {
  int count = memDAO.checkId(id);
  return count;
}

@Override
public int create(MemVO memVO) {
  int count = memDAO.create(memVO);
  return count;
}

@Override
public ArrayList<MemVO> list() {
  ArrayList<MemVO>list = memDAO.list();
  return list;
}

@Override
public MemVO read(int memno) {
 MemVO memVO = memDAO.read(memno);
  return memVO;
}

@Override
public MemVO readById(String id) {
  MemVO memVO = memDAO.readById(id);
  return memVO;
}

@Override
public int update(MemVO memVO) {
  int count = memDAO.update(memVO);
  return count;
}

@Override
public int act_update(MemVO memVO) {
  int count = memDAO.act_update(memVO);
  return count;
}

@Override
public int passwd_update(int memno, String new_passwd) {
  HashMap<String, Object> map =new HashMap<String, Object>();
  map.put("memno", memno);
  map.put("passwd", new_passwd);
  
  int count = memDAO.passwd_update(map);
  return count;
}

@Override
public int delete(int memno) {
  int count = memDAO.delete(memno);
  return count;
}

@Override
public int login(String id, String passwd) {
  HashMap<String, Object> map =new HashMap<String, Object>();
  map.put("id", id);
  map.put("passwd", passwd);
  
  int count = memDAO.login(map);
  System.out.println("id:" + id);
  System.out.println("passwd:" + passwd);
  System.out.println("count:" + count);
 
  return count;
}

/**
 * 로그인된 회원 계정인지 검사합니다.
 * @param request
 * @return true: 관리자
 */
@Override
public boolean isMember(HttpSession session) {
  boolean sw = false;
  
  String id = (String)session.getAttribute("id");
  
  if (id != null){
    sw = true;
  }
  return sw;
}

@Override
public Mem_CustoVO read_by_join_m(int memno) {
  Mem_CustoVO mem_CustoVO=memDAO.read_by_join_m(memno);
  return mem_CustoVO;
}

@Override
public int increaseCnt(int memno) {
  int cnt=memDAO.increaseCnt(memno);
  return cnt;
}

@Override
public int decreaseCnt(int memno) {
  int cnt=memDAO.decreaseCnt(memno);
  return cnt;
}
 
}
