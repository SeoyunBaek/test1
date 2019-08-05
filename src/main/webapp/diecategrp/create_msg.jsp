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

<!-- store Bootstrap -->
<!--===============================================================================================-->  
  <link rel="icon" type="image/png" href="./images/icons/favicon.png"/>
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="./vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="./fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="./fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="./fonts/linearicons-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="./vendor/animate/animate.css">
<!--===============================================================================================-->  
  <link rel="stylesheet" type="text/css" href="./vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="./vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="./vendor/select2/select2.min.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="./vendor/perfect-scrollbar/perfect-scrollbar.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="./css/util.css">
  <link rel="stylesheet" type="text/css" href="./css/main.css">
<!--===============================================================================================-->     
 
</head> 
<body>
<DIV class='container' style='width: 100%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 90%;'>

<DIV class='title_line'>MESSAGE</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.count == 1 }">
          <LI class='li_none'>새로운 카테고리 그룹을 등록했습니다.</LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none'>새로운 카테고리 그룹 등록에 실패했습니다.</LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <button type='button' onclick="location.href='./create.do'">새로 등록</button>
        <button type='button' onclick="location.href='./list.do'">목록</button>
      </LI>
 
    </UL>
  </fieldset>

</DIV>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 

   
  