<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>문의사항 목록</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!--===============================================================================================-->  
  <link rel="icon" type="image/png" href="../images/icons/favicon.png"/>
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../fonts/linearicons-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../vendor/animate/animate.css">
<!--===============================================================================================-->  
  <link rel="stylesheet" type="text/css" href="../vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../vendor/select2/select2.min.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../vendor/perfect-scrollbar/perfect-scrollbar.css">
<!--===============================================================================================-->
  <link rel="stylesheet" type="text/css" href="../css/util.css">
  <link rel="stylesheet" type="text/css" href="../css/main.css">
<!--===============================================================================================-->
<script type="text/javascript">

</script>

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

  <DIV class='title_line'>전체 보기</DIV>

  <ASIDE style='float: left;'>
    전체 보기 <span style='font-size: 0.8em; color: #CCCCCC;'>(${total_count })</span> 
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href='./create.do?memno=1'>등록</A>
        <input type='hidden' name='memno' id='memno' value='${custo_CtsansVO.memno }'>
    <span class='menu_divide' >│</span> 
    <c:choose>
      <c:when test="${param.word != '' }">
        <input type='text' name='word' id='word' value='${param.word }' style='width: 35%;'>
      </c:when>
      <c:otherwise>
        <input type='text' name='word' id='word' value='' style='width: 35%;'>
      </c:otherwise>
    </c:choose>
    <button type='submit'>검색</button>
    <button type='button' 
                 onclick="location.href='./list_by_custo_search_paging.do?memno=${custo_CtsansVO.memno }'">전체 보기</button>
        
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
  
  <div style='width: 100%;'>
    <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 20%;"></col>
        <col style="width: 55%;"></col>
        <col style="width: 15%;"></col>        
        <col style="width: 25%;"></col>
        
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th style='text-align: center;'>등록일</th>
          <th style='text-align: center;'>제목</th>
          <th style='text-align: center;'>회원번호</th>
          <th style='text-align: center;'>기타</th>
        </tr>
      
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="custoVO" items="${list }">
          <tr> 
            <td style='text-align: center;'>${custoVO.rdate.substring(0, 10)}</td>
            <td>
              <a href="./read.do?custoqusno=${custoVO.custoqusno}">${custoVO.title}</a> 
            </td> 
            <td style='text-align: center;'>${custoVO.memno}</td>
             <td style='text-align: center;'>
             <a href="./update.do?memno=${custoVO.memno }&custoqusno=${custoVO.custoqusno}&word=${param.word}&nowPage=${param.nowPage}"><img src="./images/update.png" title="수정" border='0'/></a>
             <%-- diecateno=${custoVO.diecateno }&custoqusno=${custoVO.custoqusno} --%>
             <a href="./delete.do?memno=${custoVO.memno }&custoqusno=${custoVO.custoqusno}&word=${param.word}&nowPage=${param.nowPage}"><img src="./images/delete.png" title="삭제"  border='0'/></a>
 <%--              ${custoVO.cateno} / ${custoVO.mno }
            </td> --%>
          </tr>
        </c:forEach>
        
      </tbody>
    </table>
    <br><br>
  </div>


</DIV> <!-- content END -->
</DIV> <!-- container END -->

<jsp:include page="/menu/bottom.jsp" flush='false' />

<!--===============================================================================================-->  
  <script src="../vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
  <script src="../vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
  <script src="../vendor/bootstrap/js/popper.js"></script>
  <script src="../vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
  <script src="../vendor/select2/select2.min.js"></script>
  <script>
    $(".js-select2").each(function(){
      $(this).select2({
        minimumResultsForSearch: 20,
        dropdownParent: $(this).next('.dropDownSelect2')
      });
    })
  </script>
<!--===============================================================================================-->
  <script src="../vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
<!--===============================================================================================-->
  <script src="../vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
  <script>
    $('.js-pscroll').each(function(){
      $(this).css('position','relative');
      $(this).css('overflow','hidden');
      var ps = new PerfectScrollbar(this, {
        wheelSpeed: 1,
        scrollingThreshold: 1000,
        wheelPropagation: false,
      });

      $(window).on('resize', function(){
        ps.update();
      })
    }); 
  </script>
<!--===============================================================================================-->
  <script src="../js/main.js"></script>



</body>

</html>
    