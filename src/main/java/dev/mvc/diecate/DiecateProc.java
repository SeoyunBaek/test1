package dev.mvc.diecate;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.diecate.DiecateProc")
public class DiecateProc implements DiecateProcInter {
  @Autowired
  private DiecateDAOInter diecateDAO;
  
  public DiecateProc () {
    System.out.println("--> DiecateProc created.");
  }

  @Override
  public int create(DiecateVO diecateVO) {
    int count = diecateDAO.create(diecateVO);
    return count;
  }

  @Override
  public ArrayList<Diecategrp_cateVO> list() {
    ArrayList<Diecategrp_cateVO> list = diecateDAO.list();
    return list;
  }
  
  @Override
  public ArrayList<Diecategrp_cateVO> list_by_grpno(int grpno) {
    ArrayList<Diecategrp_cateVO> list = diecateDAO.list_by_grpno(grpno);
    return list;
  }

  @Override
  public DiecateVO read(int diecateno) {
    DiecateVO diecateVO = diecateDAO.read(diecateno);
    return diecateVO;
  }
  
  @Override
  public Diecategrp_cateVO read_by_join(int diecateno) {
    Diecategrp_cateVO diecategrp_cateVO = diecateDAO.read_by_join(diecateno);
    return diecategrp_cateVO;
  }
  
  @Override
  public Diecate_EventVO read_by_join_e(int diecateno) {
    Diecate_EventVO diecate_EventVO = diecateDAO.read_by_join_e(diecateno);
    return diecate_EventVO;
  }

  @Override
  public int update(DiecateVO diecateVO) {
    int count = diecateDAO.update(diecateVO);
    return count;
  }

  @Override
  public int delete(int diecateno) {
    int count = diecateDAO.delete(diecateno);
    return count;
  }

  @Override
  public int update_seqno_up(int diecateno) {
    int count = diecateDAO.update_seqno_up(diecateno);
    return count;
  }

  @Override
  public int update_seqno_down(int diecateno) {
    int count = diecateDAO.update_seqno_down(diecateno);
    return count;
  }

  @Override
  public int increaseCnt(int diecateno) {
    int cnt = diecateDAO.increaseCnt(diecateno);
    return cnt;
  }

  @Override
  public int decreaseCnt(int diecateno) {
    int cnt = diecateDAO.decreaseCnt(diecateno);
    return cnt;
  }

}
