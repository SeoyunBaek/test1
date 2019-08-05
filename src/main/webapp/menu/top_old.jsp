<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <!-- 화면 상단 메뉴 -->
  <DIV id='top_menu'
          style="background-image: url('${pageContext.request.contextPath}/menu/images/top_logo.jpg')" >
 
    <NAV class='top_menu_list'>
      <span style='padding-left: 0.5%;'></span>
      <A class='menu_link' href='${pageContext.request.contextPath}/index.jsp'>HOME</A><span class='top_menu1'> | </span>
      <A class='menu_link' href='${pageContext.request.contextPath}/custo_qus/list_all_custo.do'>문의사항</A><span class='top_menu1'> | </span>
      <A class='menu_link' href='${pageContext.request.contextPath}/ctsans/list_all_ctsans.do'>답변</A><span class='top_menu1'> | </span>
      <A class='menu_link' href='${pageContext.request.contextPath}/review/list_all_review.do'>리뷰</A><span class='top_menu1'> | </span>
    </NAV>
  </DIV>
  
<%--   <!-- 화면을 2개로 분할하여 좌측은 메뉴, 우측은 내용으로 구성 -->  
  <DIV class="row" style='margin-top: 2px;'>
    <DIV class="col-md-2"> <!-- 메뉴 출력 컬럼 -->
      <img src='${pageContext.request.contextPath}/menu/images/myimage.png' style='width: 100%;'>
      <div style='margin-top: 5px;'>
        <img src='${pageContext.request.contextPath}/menu/images/myface.png'>왕눈이
      </div>
       ▷ 블로그 소개
       <!-- Spring 출력 카테고리 그룹 / 카테고리 -->
       <c:import url="/diecate/list_index_left.do" /> 
    </div>
      
    <DIV class="col-md-10 cont">  <!-- 내용 출력 컬럼 -->   --%>
    
      
   
 
 
 
 
 
 
 
 
 
 