<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
 
 
<script type="text/javascript">
  function update(grpno) {
    $('#panel_create').hide();
    $('#panel_update').show();
    
    var params = 'grpno=' + grpno;
    $.ajax({
      url: "./read.do",
      type: "get", // get
      cache: false,
      async: true,  // true: 비동기
      dataType: "json", // 응답 형식: json, xml, html...
      data: params,
      success: function(rdata) {
        // alert(rdata);
        var frm_update = $('#frm_update'); // 폼이 여러개인경우
        $('#grpno', frm_update).val(rdata.grpno);
        $('#name', frm_update).val(rdata.name);
        $('#seqno', frm_update).val(rdata.seqno);
        $('#visible', frm_update).val(rdata.visible);
        $('#id', frm_update).val(rdata.id);
        
        $('#main_panel').hide(); 
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR<br><br>';
        msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
        msg += '<strong>error</strong><br>'+error + '<hr>';
        console.log(msg);
      }
    });

    // 처리중 출력
    $('#main_panel').html("<IMG src='./images/ani06.gif' style='width: 10%;'>");
    $('#main_panel').show();
    
  }

  // 하나의 그룹 삭제
  function deleteOne(grpno) {
    $('#panel_create').hide();
    $('#panel_update').hide();
    
    var params = 'grpno=' + grpno;
    $.ajax({
      url: "./read.do",
      type: "get", // get
      cache: false,
      async: true,  // true: 비동기
      dataType: "json", // 응답 형식: json, xml, html...
      data: params,
      success: function(rdata) {
        // alert(rdata);
        var frm_delete = $('#frm_delete'); // 폼이 여러개인경우
        $('#grpno', frm_delete).val(rdata.grpno);
        
        var str = '';
        str = rdata.name + " (" + rdata.rdate+ ")";

        $('#main_panel').hide();
        $('#msg_delete').html(str);
        $('#panel_delete').show();
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR<br><br>';
        msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
        msg += '<strong>error</strong><br>'+error + '<hr>';
        console.log(msg);
      }
    });

    // 처리중 출력
    $('#main_panel').html("<IMG src='./images/ani06.gif' style='width: 10%;'>");
    $('#main_panel').show();
    
  }
  
  // 우선순위 up 10 -> 1
  function seqnoUp(grpno) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_up.do');
    $('#grpno', frm_seqno).val(grpno);
    frm_seqno.submit();
  }
  
  // 우선순위 down 1 -> 10
  function seqnoDown(grpno) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_down.do');
    $('#grpno', frm_seqno).val(grpno);
    frm_seqno.submit();
  }
  
  function cancel() {
    $('#panel_update').hide();
    $('#panel_delete').hide();
    $('#panel_create').show();
  }
  
</script>
</head> 

<body>
<DIV class='container' style='width: 100%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 90%;'>

  <!-- 우선 순위 증가 감소 폼, GET -> POST -->
  <FORM name='frm_seqno' id='frm_seqno' method='post' action=''>
    <input type='hidden' name='grpno' id='grpno' value=''>
  </FORM>
  
  <DIV class='title_line'>카테고리 그룹 목록</DIV>

  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
        
      <label for='title'>카테고리 그룹명</label>
      <input type='text' name='name' id='name' value='' required="required" style='width: 25%;'>

      <label for='seqno'>순서</label>
      <input type='number' name='seqno' id='seqno' value='1' required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
  
      <label for='visible'>공개여부</label>
      <select name='visible' id='visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>
       
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="cancel();">취소</button>
    </FORM>
  </DIV>

  <DIV id='panel_update' style='display: none; padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_update' id='frm_update' method='POST' 
                action='./update.do'>
      <input type='hidden' name='grpno' id='grpno' value=''>

      <label for='title'>카테고리 그룹명</label>
      <input type='text' name='name' id='name' size='15' value='' required="required" style='width: 30%;'>

      <label for='seqno'>순서</label>
      <input type='number' name='seqno' id='seqno' value='' required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
  
      <label for='visible'>공개여부</label>
      <select name='visible' id='visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>

      <button type="submit" id='submit'>저장</button>
      <button type="button" onclick="cancel();">취소</button>
    </FORM>
  </DIV>

  <DIV id='panel_delete' style='display: none; padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_delete' id='frm_delete' method='POST' 
                action='./delete.do'> 
      <input type='hidden' name='grpno' id='grpno' value=''>

      <DIV id='msg_delete' style='margin: 20px auto;'></DIV>
            
      <button type="submit" id='submit'>삭제</button>
      <button type="button" onclick="cancel();">취소</button>
    </FORM>
  </DIV>

  <DIV id='main_panel' class='main_panel'></DIV>

<TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 40%;'/>
    <col style='width: 10%;'/>
    <col style='width: 20%;'/>    
    <col style='width: 20%;'/>
  </colgroup>

  <thead>  
  <TR>
    <TH style='text-align: center ;'>순서</TH>
    <TH>카테고리명</TH>
    <TH style='text-align: center ;'>공개여부</TH>
    <TH style='text-align: center ;'>등록일</TH>    
    <TH style='text-align: center ;'>기타</TH>
  </TR>
  </thead>
  
  <tbody>
  <c:forEach var="diecategrpVO" items="${list }">
  <TR>
    <TD style='text-align: center ;'>${diecategrpVO.seqno }</TD>
    <TD><A href='../diecate/list_by_grpno.do?grpno=${diecategrpVO.grpno }'>${diecategrpVO.name }</A></TD>
    <TD style='text-align: center ;'>${diecategrpVO.rdate.substring(0, 10) }</TD>
    <TD style='text-align: center ;'>
      <c:choose>
        <c:when test="${diecategrpVO.visible == 'Y'}">
          <IMG src='./images/show.png'>
        </c:when>
        <c:when test="${diecategrpVO.visible == 'N'}">
          <IMG src='./images/hide.png'>
        </c:when>
      </c:choose>
    </TD>
    
    <TD style='text-align: center ;'>
      <A href="javascript:seqnoUp(${diecategrpVO.grpno })"><IMG src='./images/up.png' title='우선순위 높임' style='width: 16px;'></A>
      <A href="javascript:seqnoDown(${diecategrpVO.grpno })"><IMG src='./images/down.png' title='우선순위 높임' style='width: 16px;'></A>
     
      <A href="javascript:update(${diecategrpVO.grpno })"><IMG src='./images/update.png' title='수정'></A>
      <A href="javascript:deleteOne(${diecategrpVO.grpno })"><IMG src='./images/delete.png' title='삭제'></A>
    </TD>
  </TR>
  </c:forEach> 
  </tbody>

</TABLE>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" />
</DIV> <!-- container END -->
</body>

</html> 