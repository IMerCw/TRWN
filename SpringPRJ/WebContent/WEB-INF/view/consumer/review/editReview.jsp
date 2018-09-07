<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="poly.dto.consumer.CONSUMER_ImageDTO"%>
<%@ page import="poly.dto.consumer.CONSUMER_Ft_ReviewDTO"%>
<%@ page import="java.util.List"%>
<% 
	CONSUMER_Ft_ReviewDTO edit_reviewDTO = (CONSUMER_Ft_ReviewDTO) request.getAttribute("edit_reviewDTO");
	CONSUMER_ImageDTO imgDTO = (CONSUMER_ImageDTO)request.getAttribute("imgDTO");
	String imgFileOrgname;
	if(imgDTO != null){
		imgFileOrgname = imgDTO.getFileOrgname();
	}else {
		imgFileOrgname = "파일 없음";
	}
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>트럭왔냠 - 리뷰 글 수정하기</title>
</head>
<style>
</style>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<form action="/consumer/review/ReviewEditProc.do" method="POST" enctype="multipart/form-data">
   	<input type="hidden" value="<%=edit_reviewDTO.getFt_seq()%>" name="ft_seq">
   	<input type="hidden" value="<%=edit_reviewDTO.getFile_id() %>" name="org_file_id" id="org_file_id">
	<input type="hidden" value="<%=edit_reviewDTO.getUser_seq()%>" name="userSeq"/>
	<input type="hidden" value="<%=edit_reviewDTO.getReview_seq()%>" name="edit_review_seq"/>
	
		<div class="container-fluid">
			<div class="row" >
				<div class="col-xs-12">
					<h2>리뷰 글 수정하기</h2>
				</div>
			</div>
			<!-- 리뷰 글 제목 -->
			<div class="row" >
				<div class="col-xs-12"> 
					<div class="form-group">
						<input type="text" class="form-control" name="rev_title" value="<%=edit_reviewDTO.getRev_title() %>" />
					</div>
				</div>
			</div>
			<!-- 리뷰 글 내용 -->
			<div class="row" >
				<div class="col-xs-12"> 
					<div class="form-group">
						<textarea class="form-control" rows="4" name="rev_text"><%=edit_reviewDTO.getRev_text() %></textarea>
					</div>
				</div>
			</div>
			<!-- 리뷰 평점 -->
			<div class="row" >
				<div class="col-xs-2">평점</div> 
				<div class="col-xs-10"> 
					<div class="form-group">
						<div class="stars stars-example-bootstrap">
				            <select id="example-bootstrap" name="rev_point" autocomplete="off">
				            	<%for(int i=1; i<6; i++){ %>
				            		<%if(i==edit_reviewDTO.getRev_point()){ %>
				            			<option value="<%=i%>" selected><%=i%></option>
				            		<%}else{ %>
				            			<option value="<%=i%>"><%=i%></option>
				            		<%} %>
					            <%} %>
			                </select>
		              	</div>
					</div>
				</div>
			</div>
    			 
			
			<!-- 리뷰 글 이미지 -->
			<div class="row" >
				<div class="col-xs-12"> 
					<div class="form-group">
						<div id="uploadBttn" class="btn btn-default">파일 업로드</div>
						<input type="file" id="uploadFile" name="uploadFile" style="float:left; margin-top:5px; "> 
						<input type="button" value="삭제" class="btn btn-default" onclick="javascript:file_delete()" style="float:left;">
						<div style="clear:both;">
							<div id="uploadFile_label" style="margin-top:3px;"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="row" >
				<div class="col-xs-12">
					<button type="submit" style="float:right;"class="btn btn-default">등록하기</button>
				</div>
			</div>	
		</div>
	</form>
	
</body>

<script>

	window.onload = function(){
		document.getElementById("uploadFile_label").innerHTML = '<%=imgFileOrgname%>';		
	}



	
	function file_delete(){
		var uploadFile_label= document.getElementById('uploadFile_label');
		$(uploadFile_label).text("파일없음");
		document.getElementById("org_file_id").value = '-1';
	}
	
	
</script> 

</html>