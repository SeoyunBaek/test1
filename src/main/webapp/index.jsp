<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>디에스타(Diesta)</title>

<link href="./css/style.css" rel='Stylesheet' type='text/css'>  <!-- 나중에 지우기 -->

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

<script type="text/javascript">

</script>

</head>
<body class="animsition">

<jsp:include page="/menu/top.jsp" flush='false' />
  
  <%-- <!-- breadcrumbs -->
  <div class="container">
    <div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
    
      <a href='${pageContext.request.contextPath}' class="stext-109 cl8 hov-cl1 trans-04">
        Home
        <i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
      </a>

      <a href='${pageContext.request.contextPath}/diecate/list.do' class="stext-109 cl8 hov-cl1 trans-04">
        Categories
        <i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
      </a>     

      <span class="stext-109 cl4">
        Earring
      </span>
    </div>
  </div> --%>
  
  <TABLE style='width: 50%; margin: 30px auto; border-collapse: collapse;'>
    <tr>
      <td><img src='./menu/images/diesta02.jpg' style='width: 100%; display: block;'></td>
    </tr>    
  </TABLE>



<jsp:include page="/menu/bottom.jsp" flush='false' />


<!--===============================================================================================-->  
  <script src="./vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
  <script src="./vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
  <script src="./vendor/bootstrap/js/popper.js"></script>
  <script src="./vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
  <script src="./vendor/select2/select2.min.js"></script>
  <script>
    $(".js-select2").each(function(){
      $(this).select2({
        minimumResultsForSearch: 20,
        dropdownParent: $(this).next('.dropDownSelect2')
      });
    })
  </script>
<!--===============================================================================================-->
  <script src="./vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
<!--===============================================================================================-->
  <script src="./vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
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
  <script src="./js/main.js"></script>

</body>
</html>