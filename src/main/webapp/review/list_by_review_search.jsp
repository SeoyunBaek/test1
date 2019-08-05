<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>검색 목록</title>
 
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
 
  <form name='frm' id='frm' method="get" action="./list_by_custo_search.do">
  
  <ASIDE style='float: left;'>
    <!-- 카테고리 그룹 > 해외 여행 > 스위스 -->
<%--     <A href='../categrp/list.do'>카테고리 그룹</A> >
    <A href='../cate/list_by_categrpno.do?categrpno=${categrp_CateVO.categrpno }'>${categrp_CateVO.name }</A> > 
    <A href='./list_by_cateno_search.do?cateno=${categrp_CateVO.cateno }'>${categrp_CateVO.title }</A>  
  --%>
    <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>
 
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A> 
    <span class='menu_divide' >│</span> 
       <A href='./create.do?goodsno=${goods_ReviewVO.goodsno }'>등록</A>
    
    <input type='hidden' name='goodsno' id='goodsno' value='${goods_ReviewVO.goodsno }'>
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
                 onclick="location.href='./list_all_review.do?goodsno=${goods_ReviewVO.goodsno }'">전체 보기</button>
  </ASIDE>
  </form>

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
          <th style='text-align: center;'>리뷰</th>
          <th style='text-align: center;'>평점</th>
          <th style='text-align: center;'>기타</th>
        </tr>
      
      </thead>
      
      <%-- table 내용 --%>
     <tbody>
        <c:forEach var="reviewVO" items="${list }">
          <tr> 
            <td style='vertical-align: middle;'>
              <c:choose>
                <c:when test="${reviewVO.thumb != ''}">
                  <IMG id='thumb' src='./storage/${reviewVO.thumb }'> <!-- 이미지 파일명 출력 -->
                </c:when>
                <c:otherwise>
                  <!-- 파일이 존재하지 않는 경우 -->
                  <IMG src='./images/none1.png' style='width: 120px; height: 80px;'>
                </c:otherwise>
              </c:choose>
            </td>

            <td style='text-align: center; vertical-align: middle;'><a
              href="./read.do?goodsno=${reviewVO.goodsno}&reviewno=${reviewVO.reviewno}&word=${param.word}">${reviewVO.writing}</a>
            </td>
            
            <td style='text-align: center; vertical-align: middle;'>${reviewVO.rdate.substring(0, 10)}</td>
            <%-- <td style='vertical-align: middle;'>${contentsVO.good}</td> --%>
            <td style='text-align: center; vertical-align: middle;'>${reviewVO.reviewno}</td>
            <td style='text-align: center; vertical-align: middle;'>
              <a href="./update.do?goodsno=${reviewVO.goodsno }&reviewno=${reviewVO.reviewno}&word=${param.word}&nowPage=${param.nowPage}"><img src="./images/update.png" title="수정" border='0'/></a>
              <a href="./delete.do?goodsno=${reviewVO.goodsno }&reviewno=${reviewVO.reviewno}&word=${param.word}&nowPage=${param.nowPage}"><img src="./images/delete.png" title="삭제"  border='0'/></a>
              <%-- ${contentsVO.cateno} / ${contentsVO.mno } --%>
            </td>
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
 
 