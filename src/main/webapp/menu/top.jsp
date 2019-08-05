<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Header -->
  <header class="header-v4">
    <!-- Header desktop -->
    <div class="container-menu-desktop">
      <!-- Topbar -->
      <div class="top-bar">
        <div class="content-topbar flex-sb-m h-full container" style='justify-content:flex-end'>
          <div class="left-top-bar">
          </div>

          <div class="right-top-bar flex-w h-full">
            <a href="#" class="flex-c-m trans-04 p-lr-25">
              Help & QNA
            </a>
            <a href="#" class="flex-c-m trans-04 p-lr-25">
              My Account
            </a>
          </div>
        </div>
      </div>

      <div class="wrap-menu-desktop how-shadow1">
        <nav class="limiter-menu-desktop container">
          
          <!-- Logo desktop -->   
          <a href="" class="logo">
            <span class="mtext-103 cl2">DIESTA</span>
          </a>

          <!-- Menu desktop -->
          <div class="menu-desktop">
            <ul class="main-menu">
              <li>
                <a href="">Home</a>
                <ul class="sub-menu">
                  <li><a href="${pageContext.request.contextPath}/custo_qus/list_all_custo.do">문의사항</a></li>
                  <li><a href="${pageContext.request.contextPath}/review/list_all_review.do">리뷰</a></li>
                  <li><a href="${pageContext.request.contextPath}/employ/list_all_employ.do">채용공고</a></li>
                </ul>
              </li>

              <li class="label1">
                <a href="${pageContext.request.contextPath}/custo_qus/list_all_custo.do">문의사항</a>
              </li>
              <li class="label1" data-label1="hot">
                <a href="${pageContext.request.contextPath}/review/list_all_review.do">리뷰</a>
              </li>              
              <li class="label1">
                <a href="${pageContext.request.contextPath}/employ/list_all_employ.do">채용공고</a>
              </li>
            </ul>
          </div>  

          <!-- Icon header -->
          <div class="wrap-icon-header flex-w flex-r-m">

            <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti js-show-cart" data-notify="${count}">
              <i class="zmdi zmdi-shopping-cart"></i>
            </div>

            <a href="" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti" data-notify="0">
              <i class="zmdi zmdi-favorite-outline"></i>
            </a>
          </div>
        </nav>
      </div>  
    </div>

    <!-- Header Mobile -->
    <div class="wrap-header-mobile">
      <!-- Logo moblie -->    
      <div class="logo-mobile">
        <a href="">DIESTA</a>
      </div>

      <!-- Icon header -->
        <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti js-show-cart" data-notify="${count}">
          <i class="zmdi zmdi-shopping-cart"></i>
        </div>

        <a href="" class="dis-block icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti" data-notify="0">
          <i class="zmdi zmdi-favorite-outline"></i>
        </a>
      
      <!-- Button show menu -->
      <div class="btn-show-menu-mobile hamburger hamburger--squeeze">
        <span class="hamburger-box">
          <span class="hamburger-inner"></span>
        </span>
      </div>
      </div>


    <!-- Menu Mobile -->
    <div class="menu-mobile">
      <ul class="topbar-mobile">
        <li>
          <div class="right-top-bar flex-w">
            <a href="" class="flex-c-m p-lr-10 trans-04">
              Help & QNA
            </a>
            <a href="" class="flex-c-m p-lr-10 trans-04">
              My Account
            </a>
          </div>
        </li>
      </ul>

      <ul class="main-menu-m">
        <li>
          <a href="">Home</a>
          <ul class="sub-menu-m">
            <li><a href="">Homepage 1</a></li>
            <li><a href="">Homepage 2</a></li>
            <li><a href="">Homepage 3</a></li>
          </ul>
          <span class="arrow-main-menu-m">
            <i class="fa fa-angle-right" aria-hidden="true"></i>
          </span>
        </li>
        <li>
          <a href="" class="label1 rs1" data-label1="hot">Earring</a>
        </li>
      </ul>
    </div>

</header>

<%--   <!-- Cart -->
  <div class="wrap-header-cart js-panel-cart">
    <div class="s-full js-hide-cart"></div>

    <div class="header-cart flex-col-l p-l-65 p-r-25">
      <div class="header-cart-title flex-w flex-sb-m p-b-8">
        <span class="mtext-103 cl2">
          Cart
        </span>

        <div class="fs-35 lh-10 cl2 p-lr-5 pointer hov-cl1 trans-04 js-hide-cart">
          <i class="zmdi zmdi-close"></i>
        </div>
      </div>
    
     <c:choose>
       <c:when test="${count == 0}">
         <div class="container">
         <span class="mtext-110 cl2">장바구니에 담긴 상품이 없습니다.</span>
         </div>
       </c:when>
       <c:otherwise>
       
         <c:forEach var="goods_Mem_CartVO" items="${list }" varStatus="stat">
           <div class="header-cart-content flex-w js-pscroll">
           
           <ul class="header-cart-wrapitem w-full">
           <li class="header-cart-item flex-w flex-t m-b-12">
           
           <div class="header-cart-item-img" onclick="delCart(${goods_Mem_CartVO.cartno});">
           <c:choose>
           <c:when test="${map.thumb != ''}">
           <IMG id='thumb' src='./images/${map.thumb }'> <!-- 이미지 파일명 출력 -->
           </c:when>
           <c:otherwise>
           <!-- 파일이 존재하지 않는 경우 -->
           <A><IMG src='./images/none.png'></A>
           </c:otherwise>
           </c:choose>
           </div>
 
           <div class="header-cart-item-txt p-t-8">
           <a href="" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
                ${goods_Mem_CartVO.title}</a>
           <span class="header-cart-item-info">
                ${goods_Mem_CartVO.goodsqty} x <span style='text-decoration:line-through'>${goods_Mem_CartVO.price}</span>
                <span style='color:#717fe0'>${goods_Mem_CartVO.totprice}</span>
           </span>
           </div>
            </li>
            </ul>
            </div>
          </c:forEach>
          
        <div class="w-full">
          <div class="header-cart-total w-full p-tb-40">
          Total: ${totalPrice }
          </div> 
          <div class="header-cart-buttons flex-w w-full">
          <a href="./listCart.do?memno=1"  class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-r-8 m-b-10">
             View Cart
          </a>
          <a href="./listCart.do?memno=1"  class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-b-10">
              Check Out
          </a>
          </div>
          </div>
        </c:otherwise>
        </c:choose>
        </div>
      </div> --%>

