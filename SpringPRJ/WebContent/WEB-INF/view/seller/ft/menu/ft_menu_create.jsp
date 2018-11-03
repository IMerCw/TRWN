<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.*" %>
<%@page import="poly.dto.admin.ADMIN_Ft_InfoDTO" %>
<%@page import="poly.dto.admin.ADMIN_Ft_Menu_CateDTO" %>
<%
	ADMIN_Ft_InfoDTO ftDTO2 = (ADMIN_Ft_InfoDTO)request.getAttribute("ftDTO");
	List<ADMIN_Ft_Menu_CateDTO> cateDTOarr = (List<ADMIN_Ft_Menu_CateDTO>)request.getAttribute("cateDTOarr");
	String cate_sort_no = (String)request.getAttribute("cate_sort_no");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>트럭왔냠 - 푸드트럭 메뉴추가</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap.css">
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
</head>
<body>

<h3>푸드트럭 메뉴추가</h3>
    <div style="border-bottom:1px solid #444444; margin-top:15px;"></div>
	<div style="margin-top:15px; margin-bottom:25px;">
		<form action="<%=request.getContextPath()%>/seller/ft/ft_menu_create.do" method="post" name="ft_menu_create" enctype="multipart/form-data">
			<input type="hidden" name="ft_seq" value="<%=ftDTO2.getFt_seq()%>">
			<table width="100%">
				<tr style="border-top:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">메뉴 카테고리</td>
					<td class="table_line">
						<select class="form-control" name="cate_sort_no">
							<%for(ADMIN_Ft_Menu_CateDTO cateDTO : cateDTOarr){ %>
								<option value="<%=cateDTO.getCate_sort_no()%>" <%if(Integer.parseInt(cate_sort_no) == cateDTO.getCate_sort_no()){%>selected<%} %>><%=cateDTO.getCate_name()%></option>
							<%} %>
						</select>
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td width="28%" class="table_Hline">메뉴 이미지</td>
					<td class="table_line">
						<input type="file" id="uploadFile" name="uploadFile">
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">메뉴이름</td>
					<td class="table_line">
						<input type="text" name="menu_name" class="form-control">
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">메뉴소개</td>
					<td class="table_line">
						<textarea name="menu_intro" class="form-control" style="height:80px;"></textarea>
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">메뉴가격</td>
					<td class="table_line">
						<input type="text" name="menu_price" class="form-control">
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">메뉴소요시간</td>
					<td class="table_line">
						<input type="text" name="menu_rqtime" class="form-control">
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">주재료원산지</td>
					<td class="table_line">
						<textarea name="orign" class="form-control" style="height:80px;"></textarea>
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">노출여부</td>
					<td class="table_line">
						<select class="form-control" name="exp_yn">
							<option value="1">노출</option>
							<option value="-1">비노출</option>
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
