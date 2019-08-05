<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>디에스타(Diesta)</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

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
<c:import url="/menu/top.jsp" />
<DIV class='content' style='width: 90%;'>

<DIV class='title_line'>MESSAGE</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.count == 0}">
          <li class='li_none'>『${title }』 수정에 실패했습니다.</li>
          <li class='li_none'>다시 한 번 시도해주세요.</li>
          <li class='li_none'>
            <br>
            <button type='button' onclick='history.back()'>수정</button>
            <button type='button' onclick="location.href='./list_by_diecate_search_paging.do?diecateno=${param.diecateno}&nowPage=${param.nowPage }'">목록</button>
          </li>
                     
        </c:when>
        <c:when test="${param.count == 1}">
          <li class='li_none'>『${param.title }』 수정에 성공했습니다.</li>
          <li class='li_none'>
            <br>
            <button type='button' onclick="location.href='./read.do?diecateno=${param.diecateno}&goodsno=${param.goodsno}&nowPage=${param.nowPage }'">확인</button>
            <button type='button' onclick="location.href='./list_by_diecate_search_paging.do?diecateno=${param.diecateno}&nowPage=${param.nowPage }'">목록</button>
          </li>          
        </c:when>
      </c:choose>    

    </UL>
  </fieldset>

</DIV>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 

  
  