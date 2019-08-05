<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
  $(function(){

  });
</script>

</head> 

<body>
<DIV class='container' style='width: 100%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 90%;'>

<DIV class='title_line' style='width: 70%;'>
  『${diecategrp_cateVO.name} > ${diecategrp_cateVO.title}』 카테고리 삭제
</DIV>

<FORM name='frm' method='POST' action='./delete.do'>

  <input type='hidden' name='grpno' id='grpno' value='${diecategrp_cateVO.grpno }'>
  <input type='hidden' name='diecateno' id='diecateno' value='${diecategrp_cateVO.diecateno }'>
  
  <fieldset class='fieldset_basic'>
    <ul>
      <li class='li_none'>
        <label>카테고리를 삭제합니다.</label>
      </li>
    
      <li class='li_none'>
        <label for='title'>카테고리명: </label>
        ${diecategrp_cateVO.title }
      </li>
      <li class='li_none'>
        <label for='seqno'>출력순서: </label>
        ${diecategrp_cateVO.seqno }
      </li>
      <li class='li_none'>
        <label for='visible'>공개여부: </label>
        ${diecategrp_cateVO.visible }
      </li>
      <li class='li_none'>
        <label for='id'>접근계정: </label>
        ${diecategrp_cateVO.id }
      </li>

      <li class='li_right'>
        <button type="submit">삭제</button>
        <button type="button" onclick="location.href='./list_by_grpno.do?grpno=${param.grpno}'">목록</button>
      </li>         
    </ul>
  </fieldset>
</FORM>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
 
 
 