<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
          
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>         
  
</head> 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
<DIV class='title_line'>알림</DIV>
 
<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.count == 1 }">
          <LI class='li_none'>새로운 컨텐츠를 등록했습니다.</LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none'>새로운 컨텐츠 등록에 실패했습니다.</LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <button type='button' onclick="location.href='./create.do?'">회원 등록</button>
        <button type='button' onclick="location.href='./list.do?'">목록</button>
      </LI>
     </UL>
  </fieldset>
 
</DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 