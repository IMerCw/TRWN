<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_Board_PostDTO" %>
<%@page import="poly.dto.admin.ADMIN_ImageDTO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String board_name = (String)request.getAttribute("board_name");
	ADMIN_Board_PostDTO bpDTO = (ADMIN_Board_PostDTO)request.getAttribute("bpDTO");
	ADMIN_ImageDTO imgDTO = (ADMIN_ImageDTO)request.getAttribute("imgDTO");
%>
<html>
<style>
	.table_Hblock{
		padding-left:10px;
		padding-right:10px;
		background-color:#F2F2F2;
		min-width:85px;
	}
	.table_Cblock{
		padding:15px;
	}
	.table_Context{
		padding-left:15px;
		padding-right:15px;
		padding-top:15px;
		padding-bottom:15px;
	}
	.table_CCblock{
		text-align:center;
	}
	.textarea_block{
		padding:5px;
	}
	.reple_block{
		text-align:center;
		border-right:1px solid #DDDDDD;
	}
	.reple_date_block{
		text-align:center;
		border-left:1px solid #DDDDDD;
		border-right:1px solid #DDDDDD;
	}
</style>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>트럭왔냠 전체 관리자</title>

<!-- Bootstrap -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap-toggle.css">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<script>
	window.onload = function(){
		document.getElementById("uploadFile_label").innerHTML = '<%=imgDTO.getFile_orgname()%>';
	}
	function file_delete(){
		var uploadFile_label= document.getElementById('uploadFile_label');
		$(uploadFile_label).text("파일없음");
		document.getElementById("org_file_id").value = '-1';
	}
</script> 
</head>
<body>
<%@ include file="../admin_top.jsp" %>

<div class="container">
	<form action="<%=request.getContextPath()%>/admin/board_p/board_p_edit_ok.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="org_file_id" id="org_file_id" value="<%=bpDTO.getFile_id() %>">
	<h2>게시물 수정</h2>
    <div style="border-bottom:1px solid #444444; margin-top:15px;"></div>
	<div style="margin-top:25px; margin-bottom:25px;">
		<input type="hidden" name="board_p_seq" value="<%=bpDTO.getBoard_p_seq()%>">
    	<table width="100%" style="border-top:1px solid #A2A2A2; border-bottom:1px solid #A2A2A2">
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock" width="14%">게시판</td>
    			<td colspan="3" class="table_Cblock"><%=board_name %></td>
    			<td class="table_Hblock" width="14%">노출상태</td>
    			<td class="table_Cblock" width="16%">
    				<%if(bpDTO.getExp_yn()==1){%>
    					<input type="checkbox" checked data-toggle="toggle" data-width="70" name="exp_yn">
    				<%}else{ %>
    					<input type="checkbox" data-toggle="toggle" data-width="70" name="exp_yn">
    				<%} %>
				</td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">제목</td>
    			<td colspan="5"  class="table_Cblock">
					<input type="text" class="form-control" value="<%=bpDTO.getTitle()%>" name="title">
				</td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">작성자</td>
    			<td class="table_Cblock">/작성자/</td>
    			<td class="table_Hblock" width="14%">작성일</td>
    			<td class="table_Cblock"><%=bpDTO.getReg_date()%></td>
    			<td class="table_Hblock">조회수</td>
    			<td class="table_Cblock"><%=bpDTO.getBoard_count()%></td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">이미지 첨부</td>
    			<td colspan="5" class="table_Context">
					<input type="file" id="uploadFile" name="uploadFile" style="float:left; margin-top:5px;"> 
					<input type="button" value="삭제" class="btn btn-default" onclick="javascript:file_delete()" style="float:left;">
					<div style="clear:both;">
						<label id="uploadFile_label" style="margin-top:3px;"></label>
					</div>
				</td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">내용</td>
    			<td colspan="5" class="table_Context">
					<textarea style="width:100%; height:450px" class="form-control" name="content"><%=bpDTO.getContent()%></textarea>
				</td>
    		</tr>
    	</table>
	</div>
	<div align="center">
		<input type="button" value="취소" class="btn btn-default " style="width:80px;" onClick="javascript:history.back();">
		<input type="submit" value="저장" class="btn btn-primary" style="width:80px;">
	</div>
	</form>
</div>
<hr>
<footer class="text-center">
  <%@ include file="../admin_bottom.jsp" %>
</footer>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/jquery-1.11.2.min.js"></script> 
<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap-toggle.min.js"></script>

</body>
</html>