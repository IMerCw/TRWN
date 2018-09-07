<%@page import="poly.dto.admin.ADMIN_ImageDTO"%>
<%@page import="poly.dto.seller.SELLER_ImageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ADMIN_Ft_InfoDTO ftDTO = (ADMIN_Ft_InfoDTO)request.getAttribute("ftDTO");
	String[] array_optime = ftDTO.getFt_optime().split("/");
	String[] array = ftDTO.getFt_func().split("/");
	ADMIN_ImageDTO LimgDTO = (ADMIN_ImageDTO)request.getAttribute("LimgDTO");
	String cmd = (String)request.getAttribute("cmd");
	if(cmd==null){
		cmd="";
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<!-- Bootstrap -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/bootstrap.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/ft_info.css">
	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	    <![endif]-->

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>board</title>
	<%-- <%@ include file="/WEB-INF/view/seller/topCssScript.jsp" %> --%>
</head>
<body>
	<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="#444">
			<td style="padding:0">
				<%@ include file="/WEB-INF/view/seller/top.jsp" %>
			
			</td>
		</tr>
		<tr bgcolor="">
			<td>
					<!-- 판매자 푸드트럭관리 -->
				<div class="container">
					<!-- 푸드트럭이미지 & 푸드트럭 소개 -->
					<div id="leftContents" style="height:auto;">
						<!-- 트럭이미지 -->
						<div style="height:280px; border:1px solid #cccccc; margin:8px;">
							<%if(LimgDTO!=null){ %>
								<img src="<%=request.getContextPath()%>/resources/files/<%=LimgDTO.getFile_sevname()%>" width="100%" height="100%">
							<%}else{ %>
								&lt;등록된 이미지가 없습니다.&gt;
							<%} %>
						</div>
						<!-- 트럭 이름 -->
						<div style="font-size:24px; line-height:46px; height:52px; font-weight:bold;">
							<%=ftDTO.getFt_name() %>
						</div>
						<!-- 배달/케이터/주문예약 가능 불가능 설정 -->
						<div class="truckDelivery" style="margin-top:5px; margin-bottom:5px;">
							<%for(int i=0; i<array.length; i++) {%>
								<div style="background-color:#F2F2F2; margin-right:4px; width:80px; padding-top:2px; padding-bottom:2px; font-size:12px;"><%=array[i]%></div> 
							<%}%>
						</div>
						<div style="margin-top:10px;">
							<div style="text-align:center; margin-left:8px; margin-right:8px; margin-bottom:3px; padding-top:3px; padding-bottom:6px; border:1px solid #cccccc;">
								<b style="font-size:12px;">영업일 / 시간</b><br><span style="font-size:12px;"><%=array_optime[0]%></span><br><span style="font-size:12px;"><%=array_optime[1]%>~<%=array_optime[2]%></span>
							</div> 
							<div style="float:left; width:47%; text-align:center; margin-left:8px; margin-right:2px; margin-bottom:3px; padding-top:3px; padding-bottom:6px; border:1px solid #cccccc;">
								<b style="font-size:12px;">가입일</b><br><span style="font-size:12px;"><%=ftDTO.getFt_join()%></span>
							</div>
							<div style="float:right; width:47%; text-align:center; margin-left:2px; margin-right:8px; margin-bottom:3px; padding-top:3px; padding-bottom:6px; border:1px solid #cccccc;">
								<b style="font-size:12px;">푸드트럭 상태</b><br>
								<span style="font-size:12px;">
									<%if(ftDTO.getFt_status()==1){%>활동정지<%}%>
									<%if(ftDTO.getFt_status()==0){%>정상<%}%>
									<%if(ftDTO.getFt_status()==-1){%>탈퇴대기<%}%>
								</span>
							</div> 
							<div style="float:left; width:47%; text-align:center; margin-left:8px; margin-right:2px; margin-bottom:3px; padding-top:3px; padding-bottom:6px; border:1px solid #cccccc;">
								<b style="font-size:12px;">사업자이름</b><br><span style="font-size:12px;"><%=ftDTO.getSel_name()%></span>
							</div>
							<div style="float:right; width:47%; text-align:center; margin-left:2px; margin-right:8px; margin-bottom:3px; padding-top:3px; padding-bottom:6px; border:1px solid #cccccc;">
								<b style="font-size:12px;">사업자번호</b><br><span style="font-size:12px;"><%=ftDTO.getSel_no()%></span>
							</div> 
							<div style="float:left; width:47%; text-align:center; margin-left:8px; margin-right:2px; margin-bottom:3px; padding-top:3px; padding-bottom:6px; border:1px solid #cccccc;">
								<b style="font-size:12px;">푸드트럭번호</b><br><span style="font-size:12px;"><%=ftDTO.getFt_seq()%></span>
							</div>
							<div style="float:right; width:47%; text-align:center; margin-left:2px; margin-right:8px; margin-bottom:3px; padding-top:3px; padding-bottom:6px; border:1px solid #cccccc;">
								<b style="font-size:12px;">회원번호</b><br><span style="font-size:12px;"><%=ftDTO.getUser_seq()%></span>
							</div> 
						</div>
						<div style="clear:both;"></div>
						<!-- 설정 버튼 -->
						<div style="margin-top:10px;"> 
							<input type="button" class="btn btn-default" style="border-radius:0; background-color:#444444; color:#ffffff; width:160px;" value="리뷰관리" onclick="location.href='<%=request.getContextPath()%>/seller/ft/ft_info.do?cmd=review_list&ft_seq=<%=ftDTO.getFt_seq()%>'">
							<input type="button" class="btn btn-default" style="border-radius:0; background-color:#444444; color:#ffffff; width:160px;" value="정보변경" onclick="location.href='<%=request.getContextPath()%>/seller/ft/ft_info.do?cmd=ft_info_edit&ft_seq=<%=ftDTO.getFt_seq()%>'">
						</div>
					</div>
			
					<!------------------ 오른쪽 ------------------>
					<div id="rightContents">
						<%if(cmd.equals("ft_info_edit")){ %>
							<%@ include file="ft_info_edit.jsp" %>
						<%}else if(cmd.equals("review_list")){ %>
							<%@ include file="review/ft_review_list.jsp" %>
						<%}else if(cmd.equals("review_info")){%>
							<%@ include file="review/ft_review_info.jsp" %>
						<%}else if(cmd.equals("review_edit")){%>
							<%@ include file="review/ft_review_edit.jsp" %>
						<%}else if(cmd.equals("review_create")){ %>
							<%@ include file="review/ft_review_create.jsp" %>
						<%}else if(cmd.equals("category_list")){%>
							<%@ include file="category/ft_category_list.jsp" %>
						<%}else if(cmd.equals("category_edit")){%>
							<%@ include file="category/ft_category_edit.jsp" %>
						<%}else if(cmd.equals("menu_create")){%>
							<%@ include file="menu/ft_menu_create.jsp" %>
						<%}else if(cmd.equals("menu_info")){%>
							<%@ include file="menu/ft_menu_info.jsp" %>
						<%}else if(cmd.equals("menu_edit")){%>
							<%@ include file="menu/ft_menu_edit.jsp" %>
						<%}else{ %>
							<%@ include file="menu/ft_menu.jsp" %>
						<%} %>
					</div>
				</div>
			<hr>

			</td>
		</tr>
		<tr height="7%" style="background-color:#444">
			<td>
				<%@ include file="/WEB-INF/view/seller/bottom.jsp" %>
			
			</td>
		</tr>
	</table>
	

</body>
</html>