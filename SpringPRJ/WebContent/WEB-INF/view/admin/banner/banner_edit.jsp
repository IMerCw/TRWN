<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_Banner_PopDTO" %>
<%@page import="poly.dto.admin.ADMIN_ImageDTO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <%
 	ADMIN_Banner_PopDTO bnDTO = (ADMIN_Banner_PopDTO)request.getAttribute("bnDTO");
 	ADMIN_ImageDTO imgDTO = (ADMIN_ImageDTO)request.getAttribute("imgDTO");
 	
%>
<html>
<style>
	.table_Hline{
		padding-top:15px;
		padding-bottom:15px;
		padding-left:20px;
		padding-right:20px;
		background-color:#F2F2F2;
		font-weight:bold;
	}
	.table_line{
		padding-top:15px;
		padding-bottom:15px;
		padding-left:20px;
		padding-right:20px;
	}
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>배너/팝업 수정</title>
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
<div class="container">
<h2>배너/팝업 수정</h2>
    <div style="border-bottom:1px solid #444444; margin-top:15px;"></div>
	<div style="margin-top:15px; margin-bottom:25px;">
<form action="<%=request.getContextPath()%>/admin/banner/banner_edit.do" method="post" enctype="multipart/form-data" name="banner_edit" >
	<input type="hidden" name="banner_seq" value="<%=bnDTO.getBanner_seq()%>">
	<input type="hidden" name="org_file_id" id="org_file_id" value="<%=bnDTO.getFile_id() %>">
	<table width="100%">
		<tr style="border-top:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD;">
			<td width="25%" class="table_Hline">배너 이름</td>
			<td class="table_line"><input type="text" class="form-control" name="banner_name" value="<%=bnDTO.getBanner_name()%>"></td>
		</tr>
		<tr style="border-top:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD;">
			<td width="28%" class="table_Hline">이미지 첨부</td>
			<td class="table_line">
				<input type="file" id="uploadFile" name="uploadFile" style="float:left; margin-top:5px;"> 
				<input type="button" value="삭제" class="btn btn-default" onclick="javascript:file_delete()" style="float:left;">
				<div style="clear:both;">
					<label id="uploadFile_label" style="margin-top:3px;"></label>
				</div>
			</td>
		</tr>
		<tr style="border-bottom:1px solid #DDDDDD;">
			<td class="table_Hline">배너위치</td>
			<td class="table_line">
				<div>
					<input type="text" name="banner_loc" class="form-control" value="<%=bnDTO.getBanner_loc()%>">
				</div>			
			</td>
		</tr>
		<tr style="border-bottom:1px solid #DDDDDD;">
			<td class="table_Hline">노출여부</td>
			<td class="table_line">
				<div>
					<select class="form-control" name="exp_yn">
						<option value="1" <%if(bnDTO.getExp_yn()==1){%>selected<%}%>>노출</option>
						<option value="-1"  <%if(bnDTO.getExp_yn()==-1){%>selected<%}%>>비노출</option>
					</select>
				</div>			
			</td>
		</tr>
	</table>
	</form>
	<div style="margin-top:10px; text-align:center;">
		<button type="button" class="btn btn-default" style="width:80px;" onClick="location.href='<%=request.getContextPath()%>/admin/banner/banner_main.do'">취소</button>
		<button type="button" class="btn btn-primary" style="width:80px;" onClick="banner_edit.submit()">저장</button>
	</div>
	</div>
	</div>
</body>
</html>