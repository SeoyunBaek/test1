<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
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
 
 
<script type="text/javascript">
  $(function(){
 
  });
  
</script>
</head> 
 
<body>
<DIV class='container' style='width: 100%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 100%; margin: 20px auto; text-align: center;'>
 
  <ASIDE style='float: left;'>
      <A href='./mem/list.do'>회원 목록</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>목록</A>
  </ASIDE> 
 
  <div class='menu_line'></div>
  
 
  <table class="table table-striped" style='width: 100%;'>
  <caption>관리자만 접근가능합니다.</caption>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 15%;'/>
    <col style='width: 25%;'/>
    <col style='width: 15%;'/>
     <col style='width: 5%;'/>
    <col style='width: 10%;'/>
  </colgroup>
  <TR style= 'text-align: center;'>
    <TH class='th'>회원 번호</TH>
    <TH class='th'>ID</TH>
    <TH class='th'>성명</TH>
    <TH class='th'>휴대 전화</TH>
    <TH class='th'>주소</TH>
    <TH class='th'>이메일</TH>
     <TH class='th'>등급</TH>
      <TH class='th'>기타</TH>
  </TR>
 
  <c:forEach var="memVO" items="${list }">
    <c:set var="memno" value ="${memVO.memno }" />  
  <TR>
    <TD class='td'>${memno}</TD>
    <TD class='td'><A href="./read.do?memno=${memno}">${memVO.id}</A></TD>
    <TD class='td'><A href="./read.do?memno=${memno}">${memVO.name}</A></TD>
    <TD class='td'>${memVO.phone}</TD>
    <TD class='td'>
      <c:choose>
        <c:when test="${memVO.address1.length() > 15 }">
          ${memVO.address1.substring(0, 15) }...
        </c:when>
        <c:otherwise>
          ${memVO.address1}
        </c:otherwise>
      </c:choose>
    </TD>
    <TD class='td'>
      <c:choose>
        <c:when test="${memVO.email.length() > 15 }">
          ${memVO.email.substring(0, 15) }...
        </c:when>
        <c:otherwise>
          ${memVO.email}
        </c:otherwise>
      </c:choose>
      </TD>
      <TD class='td'>
      <c:choose>
        <c:when test="${memVO.act.length() > 15 }">
          ${memVO.act.substring(0, 15) }...
        </c:when>
        <c:otherwise>
          ${memVO.act}
        </c:otherwise>
      </c:choose>
      </TD>
  
    
    <TD class='td'>
      <A href="./passwd_update.do?memno=${memno}"><IMG src='./images/passwd.png' title='패스워드 변경'></A>
      <A href="./read.do?memno=${memno}"><IMG src='./images/update.png' title='수정'></A>
      <A href="./delete.do?memno=${memno}"><IMG src='./images/delete.png' title='삭제'></A>
    </TD>
    
  </TR>
  </c:forEach>
  
</TABLE>
 
<DIV class='bottom_menu'>
  <button type='button' onclick="location.href='./create.do'">등록</button>
  <button type='button' onclick="location.reload();">새로 고침</button>
</DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>