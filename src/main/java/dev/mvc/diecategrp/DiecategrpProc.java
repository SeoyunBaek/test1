package dev.mvc.diecategrp;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.diecategrp.DiecategrpProc")
public class DiecategrpProc implements DiecategrpProcInter {
  @Autowired
  private DiecategrpDAOInter diecategrpDAO;
  
  public DiecategrpProc() {
    System.out.println("--> DiecategrpProc created.");
  }

  @Override
  public int create(DiecategrpVO diecategrpVO) {
    int count = diecategrpDAO.create(diecategrpVO);
    return count;
  }

  @Override
  public ArrayList<DiecategrpVO> list() {
    ArrayList<DiecategrpVO> list = diecategrpDAO.list();
    return list;
  }

  @Override
  public DiecategrpVO read(int grpno) {
    DiecategrpVO diecategrpVO = diecategrpDAO.read(grpno);
    return diecategrpVO;
  }

  @Override
  public int update(DiecategrpVO diecategrpVO) {
    int count = diecategrpDAO.update(diecategrpVO);
    return count;
  }

  @Override
  public int delete(int grpno) {
    int count = diecategrpDAO.delete(grpno);
    return count;
  }

  @Override
  public int update_seqno_up(int grpno) {
    int count = diecategrpDAO.update_seqno_up(grpno);
    return count;
  }

  @Override
  public int update_seqno_down(int grpno) {
    int count = diecategrpDAO.update_seqno_down(grpno);
    return count;
  }

}
