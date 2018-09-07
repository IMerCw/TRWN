<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.*" %>
<%@page import="poly.dto.admin.ADMIN_Ft_InfoDTO" %>
<%@page import="poly.dto.admin.ADMIN_Ft_Menu_CateDTO" %>
<%@page import="poly.dto.admin.ADMIN_Menu_InfoDTO" %>
<%@page import="poly.dto.admin.ADMIN_ImageDTO" %>
<%
	ADMIN_Ft_InfoDTO ftDTO2 = (ADMIN_Ft_InfoDTO)request.getAttribute("ftDTO");
	List<ADMIN_Ft_Menu_CateDTO> cateDTOarr = (List<ADMIN_Ft_Menu_CateDTO>)request.getAttribute("cateDTOarr");
	ADMIN_Menu_InfoDTO menuDTO = (ADMIN_Menu_InfoDTO)request.getAttribute("menuDTO");
	ADMIN_ImageDTO imgDTO = (ADMIN_ImageDTO)request.getAttribute("imgDTO");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>푸드트럭 메뉴수정</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/bootstrap.css">
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

<h3>푸드트럭 메뉴수정</h3>
    <div style="border-bottom:1px solid #444444; margin-top:15px;"></div>
	<div style="margin-top:15px; margin-bottom:25px;">
		<form action="<%=request.getContextPath()%>/admin/ft/ft_menu_edit.do" method="post" name="ft_menu_edit" enctype="multipart/form-data">
			<input type="hidden" name="ft_seq" value="<%=ftDTO2.getFt_seq()%>">
			<input type="hidden" name="menu_seq" value="<%=menuDTO.getMenu_seq()%>">
			<input type="hidden" name="org_file_id" id="org_file_id" value="<%=menuDTO.getFile_id() %>">
			<input type="hidden" name="org_cate_sort_no" value="<%=menuDTO.getCate_sort_no()%>">
			<input type="hidden" name="menu_sort_no" value="<%=menuDTO.getMenu_sort_no() %>">
			<table width="100%">
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">메뉴 카테고리</td>
					<td class="table_line">
						<select class="form-control" name="cate_sort_no">
							<%for(ADMIN_Ft_Menu_CateDTO cateDTO : cateDTOarr){ %>
								<option value="<%=cateDTO.getCate_sort_no()%>" <%if(cateDTO.getCate_sort_no()==menuDTO.getCate_sort_no()){ %>selected<%}%>><%=cateDTO.getCate_name()%></option>
							<%} %>
						</select>
					</td>
				</tr>
				<tr style="border-top:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD;">
					<td width="28%" class="table_Hline">메뉴 이미지</td>
					<td class="table_line">
						<input type="file" id="uploadFile" name="uploadFile" style="float:left; margin-top:5px;"> 
						<input type="button" value="삭제" class="btn btn-default" onclick="javascript:file_delete()" style="float:left;">
						<div style="clear:both;">
							<label id="uploadFile_label" style="margin-top:3px;"></label>
						</div>
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">메뉴이름</td>
					<td class="table_line">
						<input type="text" name="menu_name" class="form-control" value="<%=menuDTO.getMenu_name()%>">
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">메뉴소개</td>
					<td class="table_line">
						<textarea name="menu_intro" class="form-control" style="height:80px;"><%=menuDTO.getMenu_intro()%></textarea>
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">메뉴가격</td>
					<td class="table_line">
						<input type="text" name="menu_price" class="form-control" value="<%=menuDTO.getMenu_price()%>">
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">메뉴소요시간</td>
					<td class="table_line">
						<input type="text" name="menu_rqtime" class="form-control" value="<%=menuDTO.getMenu_rqtime()%>">
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">주재료원산지</td>
					<td class="table_line">
						<textarea name="orign" class="form-control" style="height:80px;"><%=menuDTO.getOrign()%></textarea>
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">노출여부</td>
					<td class="table_line">
						<select class="form-control" name="exp_yn">
							<option value="1" <%if(menuDTO.getExp_yn()==1){ %>selected<%} %>>노출</option>
							<option value="-1" <%if(menuDTO.getExp_yn()==-1){ %>selected<%} %>>비노출</option>
						</select>
					</td>
				</tr>
			</table>
			<div style="margin-top:10px; text-align:center;">
				<button type="button" class="btn btn-default" style="width:80px;" onClick="javascript:history.back();">취소</button>
				<button type="submit" class="btn btn-primary" style="width:80px;" >저장</button>
			</div>
			</form>
		</div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/jquery-1.11.2.min.js"></script> 
<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap.min.js"></script>
</body>
</html>
