<%@ page contentType="text/html; charset=UTF-8" %>

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

<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
 
<script type="text/JavaScript">
  window.onload=function(){
    CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  };
</script>

</head> 

<body>
<DIV class='container' style='width: 100%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 90%;'> 

  <ASIDE style='float: left;'>
    <A href='../diecate/list.do'>카테고리 목록</A> >
    <A href='./list_by_diecate.do?diecateno=${diecateVO.diecateno }'>${diecateVO.title }</A>
  </ASIDE> 
  
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE> 

  <div class='menu_line'></div>
  <DIV class='content' style='width: 100%;'>
    <FORM name='frm' method='POST' action='./create.do'
               enctype="multipart/form-data" class="form-horizontal">
               
      <!-- 테스트를 위하여 카테고리를 1번 지정 -->         
      <input type='hidden' name='diecateno' id='diecateno' value='${param.diecateno}'>
      
      <!-- 테스트를 위하여 회원번호를 1번 지정 -->
      <input type='hidden' name='memno' id='memno' value='1'>
      
      <div class="form-group">   
        <label for="title" class="col-md-1 control-label">글 제목</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='title' id='title' value='제품1' required="required" style='width: 80%;'>
        </div>
      </div> 
      
      <div class="form-group">   
        <label for="price" class="col-md-1 control-label">판매가</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='price' id='price' value='15900' style='width: 50%;'>
        </div>
      </div>
      <div class="form-group">   
        <label for="dcprice" class="col-md-1 control-label">할인가</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='dcprice' id='dcprice' value='1000' style='width: 50%;'>
        </div>
      </div>
      <div class="form-group">   
        <label for="totprice" class="col-md-1 control-label">결제금액</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='totprice' id='totprice' value='14900' style='width: 50%;'>
        </div>
      </div>
        
      <div class="form-group">   
        <label for="content" class="col-md-1 control-label">내용</label>
        <div class="col-md-11">
          <textarea class="form-control input-lg" name='content' id='content'  rows='10'>예쁜 귀걸이</textarea>
        </div>
      </div>      
      <div class="form-group">   
        <label for="content" class="col-md-1 control-label">공개여부</label>
        <div class="col-md-11">
          <select class="form-control input-lg" name='visible' id='visible'>
            <option value='Y' selected="selected">Y</option>
            <option value='N'>N</option>
          </select>
        </div>
      </div>
      
      <div class="form-group">   
        <label for="content" class="col-md-1 control-label">검색어</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='word' id='word' value='귀걸이,악세사리,연예인협찬'>
        </div>
      </div>      

      <div class="form-group">   
        <label for="filesMF" class="col-md-1 control-label">업로드 파일</label>
        <div class="col-md-11">
          <input type="file" class="form-control input-lg" name='filesMF' id='filesMF' size='40' multiple="multiple">
          <br>
          Preview 이미지는 자동 생성됩니다.
        </div>
      </div>   

      <DIV style='text-align: right;'>
        <button type="submit">등록</button>
        <button type="button" onclick="location.href='./list_by_diecate_search_paging.do?diecateno=${diecateVO.diecateno}'">취소</button>      
      </DIV>
    </FORM>
  </DIV>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 