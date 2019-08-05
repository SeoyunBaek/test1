<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

<script type="text/javascript">
</script>
</head>

<body>
<DIV class='container' style='width: 100%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 90%;'>     
  <form name='frm' id='frm' method="get" action="./list_by_diecate_search_paging.do">
  
  <ASIDE style='float: left; margin-top: 10px;'>
    <A href='../diecate/list.do'>카테고리 목록</A> >
    <A href='./list_by_diecate.do?diecateno=${diecateVO.diecateno }'>${diecateVO.title }</A>
    
    <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>
    
  </ASIDE>
  
  <ASIDE style='float: right; margin-top: 10px;'>
    <span class='menu_divide' >│</span> 
    <A href="javascript:location.reload();">새로고침</A>
    
    <span class='menu_divide' >│</span> 
    <A href='./create.do?diecateno=${diecateVO.diecateno }'>등록</A>
 
    <%-- <c:if test="${sessionScope.id ne null }">
      <span class='menu_divide' >│</span> 
      <A href='./create.do?diecateno=${diecateVO.diecateno }'>등록</A>
    </c:if> --%>
    
    <input type='hidden' name='diecateno' id='diecateno' value='${diecateVO.diecateno }'>
    <span class='menu_divide' >│</span> 
    <c:choose>
      <c:when test="${param.word != '' }">
        <input type='text' name='word' id='word' value='${param.word }' style='width: 35%;'>
      </c:when>
      <c:otherwise>
        <input type='text' name='word_find' id='word_find' value='' style='width: 35%;'>
      </c:otherwise>
    </c:choose>
    <button type='submit'>검색</button>
    <button type='button' 
                 onclick="location.href='./list_by_diecate_search_paging.do?diecateno=${diecateVO.diecateno }'">ALL</button>
  </ASIDE>
  </form>
    
  <div class='menu_line' style='clear: both;'></div>       

  <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 10%;"></col>     
        <col style="width: 40%;"></col>
        <col style="width: 15%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 15%;"></col>      
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th style='text-align: center;'>파일</th>     
          <th style='text-align: center;'>제목</th>
          <th style='text-align: center;'>등록일</th>
          <th style='text-align: center;'>조회수</th>
          <th style='text-align: center;'>공개여부</th>
          <th style='text-align: center;'>기타</th>
        </tr>
      
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="goodsVO" items="${list }">
          <tr>
            <td style='vertical-align: middle;' >
            <c:choose>
              <c:when test="${goodsVO.thumb != ''}">
                <IMG id='thumb' src='./storage/${goodsVO.thumb}' > <!-- 이미지 파일명 출력 -->
              </c:when>
              <c:otherwise>
                <IMG id='thumb' src='./images/none1.png' style='width: 120px; height: 80px;'> <!-- 파일이 존재하지 않는 경우 -->
              </c:otherwise>
            </c:choose>
            </td>
            
            <td style='vertical-align: middle;'>
              <a href="./read.do?goodsno=${goodsVO.goodsno}&diecateno=${goodsVO.diecateno}&word=${param.word}&nowPage=${param.nowPage}">${goodsVO.title}</a> 
            </td>

            <td style='vertical-align: middle; text-align: center;'>${goodsVO.rdate.substring(0, 16)}</td>
            <td style='vertical-align: middle; text-align: center;'>${goodsVO.visit}</td>
            <td style='vertical-align: middle; text-align: center;'>
              <c:choose>
                <c:when test="${goodsVO.visible == 'Y'}">
                  <IMG src='./images/show.png'>
                </c:when>
                <c:when test="${goodsVO.visible == 'N'}">
                  <IMG src='./images/hide.png'>
                </c:when>
              </c:choose>    
            </td>
            <td style='vertical-align: middle; text-align: center;'>
              <a href="./update.do?goodsno=${goodsVO.goodsno}&diecateno=${goodsVO.diecateno}&nowPage=${param.nowPage}&word=${param.word}"><img src="./images/update.png" title="수정" border='0'/></a>
              <a href="./delete.do?goodsno=${goodsVO.goodsno}&diecateno=${goodsVO.diecateno}&nowPage=${param.nowPage}&word=${param.word}"><img src="./images/delete.png" title="삭제"  border='0'/></a>
              <%-- G${contentsVO.grpno}/A${contentsVO.ansnum} --%>
            </td>
          </tr>
        </c:forEach>
        
      </tbody>
  </table>
  <DIV class='bottom_menu'>${paging }</DIV>
  <br><br>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>