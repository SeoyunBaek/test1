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

<DIV class='title_line' style='width: 50%;'>『${diecategrpVO.name }』 카테고리 등록</DIV>

<FORM name='frm' method='POST' action='./create.do'>  
  <input type='hidden' name='grpno' id='grpno' value='${param.grpno }'>
  
  <fieldset class='fieldset_basic'>
    <ul>
      <li class='li_none'>
        <label>카테고리 그룹 '${diecategrpVO.name }'에 새로운 카테고리를 등록합니다.</label>
      </li>
    
      <li class='li_none'>
        <label for='title'>카테고리 이름</label>
        <input type='text' name='title' id='title' value='' required="required" autofocus="autofocus">
      </li>
      <li class='li_none'>
        <label for='seqno'>출력 순서</label>
        <input type='number' name='seqno' id='seqno' value='1' required="required" placeholder="${seqno }" min="1" max="1000" style='width: 70%;'>
      </li>
      <li class='li_none'>
        <label for='visible'>출력 형식</label>
        <select name='visible'>
          <option value='Y' selected="selected">Y</option>
          <option value='N'>N</option>
        </select>
      </li>
      <li class='li_none'>
        <label for='id'>접근 계정</label>
        <input type='text' name='id' id='id' value='master1' required="required">
      </li>

      <li class='li_right'>
        <button type="submit">등록</button>
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
 
 
 