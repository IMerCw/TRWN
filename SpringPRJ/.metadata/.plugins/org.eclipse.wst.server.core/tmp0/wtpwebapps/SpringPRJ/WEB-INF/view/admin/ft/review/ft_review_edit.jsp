<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_Ft_ReviewDTO" %>
<%@page import="poly.dto.admin.ADMIN_ImageDTO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	ADMIN_Ft_ReviewDTO revDTO = (ADMIN_Ft_ReviewDTO)request.getAttribute("revDTO");
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
		padding-top:50px;
		padding-bottom:50px;
	}
	.table_CCblock{
		text-align:center;
	}
	.textarea_block{
		padding:6px;
	}
	.reple_block{
		text-align:center;
		border-right:1px solid #DDDDDD;
	}
	.reple_date_block{
		text-align:center;
		border-left:1px solid #DDDDDD;
		border-right:1px solid #DDDDDD;
		width:14%;
	}
</style>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>리뷰 보기</title>
<style>
	 @font-face {
        font-family: 'Glyphicons Halflings';
        src:url('https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/fonts/glyphicons-halflings-regular.eot');
        src:url('https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/fonts/glyphicons-halflings-regular.eot?#iefix') format('embedded-opentype'),
          url('https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/fonts/glyphicons-halflings-regular.woff') format('woff'),
          url('https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/fonts/glyphicons-halflings-regular.ttf') format('truetype');
      }
</style>
<!-- Bootstrap -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap-toggle.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap-stars.css">

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
	<h3>리뷰수정</h3> 
    <div style="border-bottom:1px solid #444444; margin-top:15px;"></div>
	<div style="margin-top:25px; margin-bottom:25px;">
	<form name="review_edit_form" method="post" action="<%=request.getContextPath()%>/admin/ft/ft_review_edit.do" enctype="multipart/form-data">
    	<input type="hidden" name="cmd" value="review_info">
    	<input type="hidden" name="review_seq" value="<%=revDTO.getReview_seq()%>">
    	<input type="hidden" name="ft_seq" value="<%=revDTO.getFt_seq()%>">
    	<input type="hidden" name="org_file_id" id="org_file_id" value="<%=revDTO.getFile_id() %>">
    	<table width="100%" style="border-top:1px solid #A2A2A2; border-bottom:1px solid #A2A2A2">
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock" width="14%">게시판</td>
    			<td colspan="3" class="table_Cblock">푸드트럭 리뷰</td>
    			<td class="table_Hblock" width="14%">노출상태</td>
    			<td class="table_Cblock" width="16%">
    				<%if(revDTO.getExp_yn()==1){%>
    					<input type="checkbox" checked data-toggle="toggle" data-width="70" name="exp_yn">
    				<%}else{ %>
    					<input type="checkbox" data-toggle="toggle" data-width="70" name="exp_yn">
    				<%} %>
				</td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">제목</td>
    			<td colspan="5" class="table_Cblock">
    				<input type="text" name="rev_title" value="<%=revDTO.getRev_title()%>" class="form-control">
    			</td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">작성자</td>
    			<td class="table_Cblock">/작성자/</td>
    			<td class="table_Hblock" width="14%">작성일</td>
    			<td class="table_Cblock"><%=revDTO.getRev_regdate()%></td>
    			<td class="table_Hblock">평점</td>
    			<td class="table_Cblock">
    			 <div class="stars stars-example-bootstrap">
			            <select id="example-bootstrap" name="rev_point" autocomplete="off">
			            	<%for(int i=1; i<6; i++){ %>
			            		<%if(i==revDTO.getRev_point()){ %>
			            			<option value="<%=i%>" selected><%=i%></option>
			            		<%}else{ %>
			            			<option value="<%=i%>"><%=i%></option>
			            		<%} %>
				            <%} %>
		                </select>
	              	</div>
    			</td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;" height="20px">
    			<td class="table_Hblock">이미지 첨부</td>
    			<td colspan="5" class="table_Cblock">
					<input type="file" id="uploadFile" name="uploadFile" style="float:left; margin-top:5px;"> 
					<input type="button" value="삭제" class="btn btn-default" onclick="javascript:file_delete()" style="float:left;">
					<div style="clear:both;">
						<label id="uploadFile_label" style="margin-top:3px;"></label>
					</div>
				</td>
	    	</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">내용</td>
    			<td colspan="5" class="table_Cblock">
    				<textarea style="width:100%; height:280px" class="form-control" name="rev_text"><%=revDTO.getRev_text()%></textarea>
    			</td>
    		</tr>
    	</table>
    </form>
</div>
	<div align="center">
		<input type="button"  value="취소" class="btn btn-default" style="width:80px;" onClick="location.href='<%=request.getContextPath()%>/admin/ft/ft_info.do?cmd=review_info&ft_seq=<%=revDTO.getFt_seq()%>&review_seq=<%=revDTO.getReview_seq()%>'">
		<input type="button"  value="저장" class="btn btn-default" style="width:80px;" onClick="review_edit_form.submit();">
	</div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap-toggle.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/admin/jquery-1.11.2.min.js"></script> 
<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/admin/jquery.barrating.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/admin/examples.js"></script>
</body>
</html>