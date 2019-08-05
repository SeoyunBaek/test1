<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>이벤트</title>

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
/*    $(document).ready(function(){ // window.onload = function() { ... }

  });
 */
  function panel_img(file){
    var panel = '';
    panel += "<DIV id='panel' class='popup_img' style='width: 80%; margin: 0px 5%;'>";
    panel += "  <A href=\"javascript: $('#main_panel').hide();\"><IMG src='./storage/"+file+"' style='width: 100%;'></A>";
    panel += "</DIV>";
    
    $('#main_panel').html(panel);
    $('#main_panel').show();
    
  }
</script>
</head>

<body>
<DIV class='container' style='width: 100%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 90%;'> 

<%--   <ASIDE style='float: left;'>
    <!-- 카테고리 그룹 > 해외 여행 > 스위스 -->
    <A href='../categrp/list.do'>카테고리 그룹</A> >
    <A href='../cate/list_by_categrpno.do?categrpno=${categrp_CateVO.categrpno }'>${categrp_CateVO.name }</A> > 
    <A href='./list.do?cateno=${categrp_CateVO.cateno }'>${categrp_CateVO.title }</A>  </A>
  </ASIDE> --%>
  <ASIDE style='float: right;'>
<%--     <c:if test="${custoVO.files.length() > 0 }">
      <A href='./download.do?diecateno=${custoVO.diecateno}'>다운로드</A>
      <span class='menu_divide' >│</span> 
    </c:if> --%>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./list_all_event.do?diecateno=${param.diecateno}'>목록</A>
    
      <!-- ne => 같지 않을 경우 -->
    <span class='menu_divide' >│</span> 
    <A href='./update.do?diecateno=${eventVO.diecateno }&eventno=${eventVO.eventno }'>수정</A>
    <!-- &nowPage=${param.nowPage } -->
    <span class='menu_divide' >│</span> 
    <A href='./delete.do?diecateno=${eventVO.diecateno }&eventno=${eventVO.eventno }'>삭제</A>
<%--   <c:if test="${sessionScope.id ne null}"></c:if> --%>
  </ASIDE>
  
  <div class='menu_line'></div>

  <DIV id='main_panel'></DIV>  <!-- 이미지 출력 -->
  
  <FORM name='frm' method="get" action='./update.do'>
      <%-- <input type="hidden" name="diecateno" value="${custoVO.diecateno}"> --%>
 <input type='hidden' name='eventno' id='eventno' value='1'>
 <input type='hidden' name='diecateno' id='diecateno' value='1'>
      <fieldset class="fieldset">
        <ul>
          <li class="li_none">
            <span>${eventVO.title}</span>
            <span class='menu_divide' >│</span> 
            <%-- (<span>${custoVO.name}</span>) --%>
            <span>${eventVO.rdate.substring(0, 16)}</span>
            <span class='menu_divide' >│</span> 
            <span>${eventVO.id}</span>
             <DIV>
              <c:forEach var ="fileVO"  items="${file_list }">
                <A href="javascript: panel_img('${fileVO.file }')"><IMG src='./storage/${fileVO.thumb }' style='margin-top: 2px;'></A>
              </c:forEach>
            </DIV>
          </li>
          <li class="li_none">
            <DIV>${eventVO.contents }</DIV>
          </li>
           <li class="li_none">
            <DIV style='text-decoration: underline;'>검색어:(키워드) ${eventVO.word }</DIV>
          </li>
        </ul>
      </fieldset>
  </FORM>
<%--     <A href='./update.do?memno=${custoVO.memno }&custoqusno=${custoVO.custoqusno}'>수정</A>
    <span class='menu_divide' >│</span> 
    <A href='./delete.do?memno=${custoVO.memno }&custoqusno=${custoVO.custoqusno}'>삭제</A>
    <span class='menu_divide' >│</span> 
    <A href='../ctsans/reply.do?custoqusno=1&answerno=1'>답변</A> --%>

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


   