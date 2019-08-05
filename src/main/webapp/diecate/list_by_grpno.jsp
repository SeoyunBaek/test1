<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>디에스타(Diesta)</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  //우선순위 up 10 -> 1
  function seqnoUp(diecateno) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_up.do');
    $('#diecateno', frm_seqno).val(diecateno);
    frm_seqno.submit();
  }

  // 우선순위 down 1 -> 10
  function seqnoDown(diecateno) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_down.do');
    $('#diecateno', frm_seqno).val(diecateno);
    frm_seqno.submit();
  }

  
</script>

</head> 

<body>
<DIV class='container' style='width: 100%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 90%;'>

<!-- 우선 순위 증가 감소 폼, GET -> POST -->
<FORM name='frm_seqno' id='frm_seqno' method='post' action=''>
  <input type='hidden' name='diecateno' id='diecateno' value=''>
</FORM>
  
<DIV class='title_line'>${diecategrpVO.name } 카테고리 목록</DIV>

<DIV class='aside_menu'>
  <ASIDE style='float: left; margin-top: 10px;'>
    <A href='../diecategrp/list.do'>카테고리 그룹</A> >
    <A href='./list_by_grpno.do?grpno=${param.grpno }'>${diecategrpVO.name }</A> 
  </ASIDE> 
  
  <ASIDE style='float: right; margin-top: 10px;'>
    <A href='./create.do?grpno=${param.grpno }'>등록</A>
    <span class='menu_divide'> |</span>
    <A href="javascript:location.reload();">새로고침</A> 
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV>

<TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 15%;'/>
    <col style='width: 25%;'/>
    <col style='width: 15%;'/>
    <col style='width: 10%;'/>
    <col style='width: 15%;'/>
  </colgroup>
  <thead>  
  <TR>
    <TH style='text-align: center ;'>순서</TH>
    <TH style='text-align: center ;'>카테고리</TH>
    <TH style='text-align: center ;'>구분</TH>
    <TH style='text-align: center ;'>등록계정</TH>
    <TH style='text-align: center ;'>공개여부</TH>
    <TH style='text-align: center ;'>날짜</TH>
    <TH style='text-align: center ;'>기타</TH>
    
  </TR>
  </thead>

  <tbody id='tbody_panel' data-nowPage='0' data-endPage='0'>
    <c:forEach var="diecategrp_cateVO" items="${list }">  <!-- varStatus="info" -->
  <TR>
    <TD style='text-align: center ;'>${diecategrp_cateVO.seqno }</TD>
    <TD style='text-align: center ;'>${diecategrp_cateVO.name }</TD>
    <TD><A href='../goods/list_by_diecate_search_paging.do?diecateno=${diecategrp_cateVO.diecateno }'>${diecategrp_cateVO.title }</A></TD>
    <TD>${diecategrp_cateVO.id }</TD>
    <TD style='text-align: center ;'>${diecategrp_cateVO.rdate.substring(0, 10) }</TD>
    <TD style='text-align: center ;'>
      <c:choose>
        <c:when test="${diecategrp_cateVO.visible == 'Y'}">
          <IMG src='./images/show.png'>
        </c:when>
        <c:when test="${diecategrp_cateVO.visible == 'N'}">
          <IMG src='./images/hide.png'>
        </c:when>
      </c:choose>
    </TD>
    <TD style='text-align: center ;'>
      <A href="../goods/create.do?diecateno=${diecategrp_cateVO.diecateno }&grpno=${diecategrp_cateVO.grpno }"><IMG src='./images/create.png' title='등록'></A>
    
      <A href="javascript:seqnoUp(${diecateVO.diecateno })"><IMG src='./images/up.png' title='우선순위 높임' style='width: 16px;'></A>
      <A href="javascript:seqnoDown(${diecateVO.diecateno })"><IMG src='./images/down.png' title='우선순위 높임' style='width: 16px;'></A>
     
      <A href="./update.do?diecateno=${diecategrp_cateVO.diecateno }&grpno=${diecategrp_cateVO.grpno }"><IMG src='./images/update.png' title='수정'></A>
      <A href="./delete.do?diecateno=${diecategrp_cateVO.diecateno }&grpno=${diecategrp_cateVO.grpno }"><IMG src='./images/delete.png' title='삭제'></A>
    </TD>
  </TR>
  </c:forEach> 
  </tbody>
  
</TABLE>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 

 