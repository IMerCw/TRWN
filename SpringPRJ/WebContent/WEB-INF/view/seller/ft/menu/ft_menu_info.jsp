<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.*" %>
<%@page import="poly.dto.admin.ADMIN_Ft_InfoDTO" %>
<%@page import="poly.dto.admin.ADMIN_Menu_InfoDTO" %>
<%@page import="poly.dto.admin.ADMIN_Ft_Menu_CateDTO" %>
<%@page import="poly.dto.admin.ADMIN_ImageDTO" %>
<%
	ADMIN_Ft_InfoDTO ftDTO2 = (ADMIN_Ft_InfoDTO)request.getAttribute("ftDTO");
ADMIN_Menu_InfoDTO menuDTO = (ADMIN_Menu_InfoDTO)request.getAttribute("menuDTO");
	List<ADMIN_Ft_Menu_CateDTO> cateDTOarr = (List<ADMIN_Ft_Menu_CateDTO>)request.getAttribute("cateDTOarr");
	ADMIN_ImageDTO imgDTO = (ADMIN_ImageDTO)request.getAttribute("imgDTO");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>메뉴상세정보</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/bootstrap.css">
<style>
	.table_Hline{
		padding-top:12px;
		padding-bottom:12px;
		padding-left:20px;
		padding-right:20px;
		background-color:#F2F2F2;
		font-weight:bold;
	}
	.table_line{
		padding-top:12px;
		padding-bottom:12px;
		padding-left:20px;
		padding-right:20px;
	}
</style>
</head>
<body>

<h3>메뉴상세정보</h3>
    <div style="border-bottom:1px solid #444444; margin-top:15px;"></div>
	<div style="margin-top:15px; margin-bottom:25px;">
			<input type="hidden" name="ft_seq" value="<%=ftDTO2.getFt_seq()%>">
			<div style="padding:10px; width:100%;">
				<table style="margin-right:15px;">
					<tr>
						<td>
							<div style="border:1px solid #cccccc; width:320px; height:380px;">
								<%if(!menuDTO.getFile_id().equals("-1")){%>
				    				<%if(imgDTO.getFile_id().equals(menuDTO.getFile_id())){ %>
				    					<img src="<%=request.getContextPath()%>/resources/files/<%=imgDTO.getFile_sevname()%>" width="100%" height="100%">
				    				<%} %>
						    	<%}else{ %>
						    			등록된 이미지가 없습니다.
						    		<%} %>
							</div>
						</td>
						<td valign="top">
							<div style="min-width:420px; max-width:420px; margin-top:10px; margin-left:15px; margin-right:8px;">
							<div style="width:100%; margin-top:4px; text-align:right;">
								<div style=" float:right; background-color:#444444; color:#ffffff; width:120px; height:38px; z-index:1;  font-size:12px; text-align:left;"> 
									<div style="padding-left:10px; padding-top:10px; color:#ffffff;">메뉴순번 <%=menuDTO.getMenu_sort_no() %></div>
									<div style="position:relative; float:right; top:-25px;"> 
										<div style="background-color:#444444; color:#ffffff; border:1px solid #454545; width:16px; height:17px; font-size:10px; text-align:center; cursor:pointer;"
										onClick="location.href='<%=request.getContextPath()%>/seller/ft/ft_menu_up.do?cmd=menu_info&ft_seq=<%=ftDTO2.getFt_seq()%>&menu_seq=<%=menuDTO.getMenu_seq()%>&cate_sort_no=<%=menuDTO.getCate_sort_no()%>&menu_sort_no=<%=menuDTO.getMenu_sort_no()%>'">▲</div> 
										<div style="background-color:#444444; color:#ffffff; border:1px solid #454545; width:16px; height:17px; font-size:10px; text-align:center; cursor:pointer;"
										onClick="location.href='<%=request.getContextPath()%>/seller/ft/ft_menu_down.do?cmd=menu_info&ft_seq=<%=ftDTO2.getFt_seq()%>&menu_seq=<%=menuDTO.getMenu_seq()%>&cate_sort_no=<%=menuDTO.getCate_sort_no()%>&menu_sort_no=<%=menuDTO.getMenu_sort_no()%>'">▼</div>
									</div>
								</div>
								<div style="float:right; border-right:1px solid #ffffff; background-color:#444444; color:#ffffff; width:120px; height:38px; padding-left:10px; padding-top:10px; font-size:12px; text-align:left;">
									메뉴번호 <%=menuDTO.getMenu_seq() %>
								</div> 
							</div>
							<div style="clear:both;"></div>
							<table width="100%" style="margin-top:15px;">
								<tr style="border-top:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD;">
									<td class="table_Hline" width="40%">메뉴 카테고리</td>
									<td class="table_line">
											<%for(ADMIN_Ft_Menu_CateDTO cateDTO : cateDTOarr){ %>
												<%if(cateDTO.getCate_sort_no()==menuDTO.getCate_sort_no()){ %>
													<%=cateDTO.getCate_name()%>
												<%} %>
											<%} %>
									</td>
								</tr>
								<tr style="border-bottom:1px solid #DDDDDD;">
									<td class="table_Hline">메뉴이름</td>
									<td class="table_line">
										<%=menuDTO.getMenu_name()%>
									</td>
								</tr>
								<tr style="border-bottom:1px solid #DDDDDD;">
									<td class="table_Hline">메뉴가격</td>
									<td class="table_line">
										<%=menuDTO.getMenu_price()%>원 
									</td>
								</tr>
								<tr style="border-bottom:1px solid #DDDDDD;">
									<td class="table_Hline">메뉴소요시간</td>
									<td class="table_line">
										<%=menuDTO.getMenu_rqtime()%>분
									</td>
								</tr>
								<tr style="border-bottom:1px solid #DDDDDD;">
									<td class="table_Hline">주재료원산지</td>
									<td class="table_line">
										<%=menuDTO.getOrign()%>
									</td>
								</tr>
								<tr style="border-bottom:1px solid #DDDDDD;">
									<td class="table_Hline">노출상태</td>
									<td class="table_line">
											<%if(menuDTO.getExp_yn()==1){%> 노출<%}%>
											<%if(menuDTO.getExp_yn()==-1){%> 비노출<%}%>
									</td>
								</tr>
							</table>
							</div>
						</td>
					</tr>
				</table>
				</div>
				<div style="clear:both;"></div>
				<div style="border-bottom:1px solid #DDDDDD;">
					<div style="background-color:#444444; color:#ffffff; padding:8px;">&nbsp;&nbsp;메뉴소개</div>
					<div class="table_line">
						<%=menuDTO.getMenu_intro()%>
					</div>
				</div>
			</div>
			<div style="margin-top:10px; text-align:center;">
				<button type="button" class="btn btn-default" style="width:80px;" onClick="location.href='<%=request.getContextPath()%>/admin/ft/ft_info.do?ft_seq=<%=ftDTO2.getFt_seq()%>'">목록</button>
				<button type="button" class="btn btn-primary" onClick="location.href='<%=request.getContextPath()%>/seller/ft/ft_info.do?cmd=menu_edit&ft_seq=<%=ftDTO2.getFt_seq()%>&menu_seq=<%=menuDTO.getMenu_seq()%>'">메뉴정보수정</button>
				<button type="button" class="btn btn-danger"  onClick="location.href='<%=request.getContextPath()%>/seller/ft/ft_menu_delete.do?ft_seq=<%=ftDTO2.getFt_seq()%>&menu_seq=<%=menuDTO.getMenu_seq()%>'" style="position:relative; left:250px; width:80px;">삭제</button>
			</div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/jquery-1.11.2.min.js"></script> 
<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap.min.js"></script>
</body>
</html>
