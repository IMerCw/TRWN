<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="poly.dto.admin.ADMIN_Ft_InfoDTO" %>
<%@page import="poly.dto.admin.ADMIN_Ft_Menu_CateDTO" %>
<%
	ADMIN_Ft_Menu_CateDTO cateDTO = (ADMIN_Ft_Menu_CateDTO)request.getAttribute("cateDTO");
	ADMIN_Ft_InfoDTO ftDTO2 = (ADMIN_Ft_InfoDTO)request.getAttribute("ftDTO");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>카테고리 수정</title>
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
    <div>
		<h3>카테고리 수정</h3>
	</div>
     <hr>
	<form action="<%=request.getContextPath()%>/admin/ft/ft_cate_edit.do" method="post"  name="cate_edit">
		<input type="hidden" name="cmd" value="category_list">
		<input type="hidden" name="ft_seq" value="<%=ftDTO2.getFt_seq()%>">
		<input type="hidden" name="cate_sort_no" value="<%=cateDTO.getCate_sort_no() %>">
		<table width="100%">
			<tr style="border-top:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD;">
				<td width="25%" class="table_Hline">카테고리 이름</td>
				<td class="table_line"><input type="text" class="form-control" name="cate_name" value="<%=cateDTO.getCate_name()%>"></td>
			</tr>
			<tr style="border-bottom:1px solid #DDDDDD;">
				<td class="table_Hline">노출여부</td>
				<td class="table_line">
					<select class="form-control" name="exp_yn">
						<option value="1" <%if(cateDTO.getExp_yn()==1){ %>selected<%} %>>노출</option>
						<option value="-1" <%if(cateDTO.getExp_yn()==-1){ %>selected<%} %>>비노출</option>
					</select>
				</td>
			</tr>
		</table>
		<div style="margin-top:15px; text-align:center;">
			<button type="button" class="btn btn-default" style="width:80px;" onClick="location.href='<%=request.getContextPath()%>/admin/ft/ft_info.do?cmd=category_list&ft_seq=<%=ftDTO2.getFt_seq()%>'">취소</button>
			<button type="button" class="btn btn-primary" style="width:80px;" onClick="javascript:cate_edit.submit()">저장</button>
		</div>
	</form>
</body>
</html>