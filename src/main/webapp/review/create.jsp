<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>리뷰</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

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


<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

<script type="text/JavaScript">
/*  window.onload=function(){
  CKEDITOR.replace('review');  // <TEXTAREA>태그 id 값
}; */
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
    <A href='./list.do?cateno=${categrp_CateVO.cateno }'>${categrp_CateVO.title }</A>
    > 등록  
  </ASIDE> --%>
  
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>등록</A>
  </ASIDE> 

  <div class='menu_line'></div>
  <DIV class='content' style='width: 100%;'>
    <FORM name='frm' method='POST' action='./create.do'
               enctype="multipart/form-data" class="form-horizontal">
     
       <input type='hidden' name='goodsno' id='goodsno' value='1'>
       <input type='hidden' name='reviewno' id='reviewno' value=' 1'>
      
      <div class="form-group">   
        <label for="writing" class="col-md-1 control-label">리뷰</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='writing' id='writing' value='리뷰' required="required" style='width: 80%;'>
        </div>
      </div>   
      
      <div class="form-group">   
        <label for="grade" class="col-md-1 control-label">평점</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='grade' id='grade' value='3.7'>
        </div>
      </div>
      
      <div class="form-group">   
        <label for="askcont" class="col-md-1 control-label">검색어</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='word' id='word' value='귀걸이,배송'>
        </div>
      </div>
      
       <div class="form-group">   
        <label for="filesMF" class="col-md-1 control-label">업로드 파일</label>
        <div class="col-md-11">
          <input type="file" class="form-control input-lg" name='filesMF' id='filesMF' size='40' multiple="multiple">
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>   
 
      <DIV style='text-align: right;'>
        <button type="submit" class="btn btn-primary btn-md">등록</button>
       <%-- <button type="button" onclick="location.href='./list_by_cateno.do?cateno=${categrp_CateVO.cateno}'">취소[목록]</button> --%>
       <button type='button' onclick="location.href='./list_by_review_search_paging.do?goodsno=${goodsVO.goodsno }&reviewno=${reviewVO.reviewno }&word=${word}&nowPage=${nowPage}'" class="btn btn-primary btn-md">취소[목록]</button>
      </DIV>
    </FORM>
  </DIV>


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