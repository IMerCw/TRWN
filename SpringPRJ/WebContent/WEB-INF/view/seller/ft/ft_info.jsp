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

<style>
	* {
		font-family: 'Noto Sans KR', sans-serif !important;
	}
</style>
<body>
	<table style="height: 100%; width: 100%; margin:0;">
		<tr height="7%" bgcolor="#444">
			<td style="padding:0">
				<%@ include file="/WEB-INF/view/seller/top.jsp" %>
			</td>
		</tr>
		<tr bgcolor="">
			<td style="background-color:#555; padding: 20px 0;">
				<div class="container" style="background-color:#ffffff; width: 95%; padding: 20px 10px 80px 10px; border-radius:8px;">
					<!-- 판매자 푸드트럭관리 -->
					<!-- 푸드트럭이미지 & 푸드트럭 소개 -->
					<div class="col-sm-4" id="" style="text-align:center; height:auto;">
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
						<div class="col-sm-12" style="margin:20px 0;">
							<%for(int i=0; i<array.length; i++) {%>
								<div class="col-sm-4" style="padding:0; font-size:1.2rem; border: 1px solid #cccccc;  background-color:#F2F2F2; "><%=array[i]%></div> 
							<%}%>
						</div>
						<div class="container-fluid" style="margin-top:10px;">
							<div class="col-sm-12 col-xs-12" style="text-align:center; border:1px solid #cccccc;">
								<b style="font-size:12px;">영업일 / 시간</b><br><span style="font-size:12px;"><%=array_optime[0]%></span><br><span style="font-size:12px;"><%=array_optime[1]%>~<%=array_optime[2]%></span>
							</div> 
							<div class="col-sm-6 col-xs-12" style="text-align:center; height: 56px; border:1px solid #cccccc;">
								<b style="font-size:12px;">가입일</b><br><span style="font-size:12px;"><%=ftDTO.getFt_join()%></span>
							</div>
							<div class="col-sm-6 col-xs-12" style="text-align:center; height: 56px; padding: 10px 0; border:1px solid #cccccc;">
								<b style="font-size:12px;">푸드트럭 상태</b><br>
								<span style="font-size:12px;">
									<%if(ftDTO.getFt_status()==1){%>활동정지<%}%>
									<%if(ftDTO.getFt_status()==0){%>정상<%}%>
									<%if(ftDTO.getFt_status()==-1){%>탈퇴대기<%}%>
								</span>
							</div> 
							<div class="col-sm-6 col-xs-12" style="text-align:center; height: 56px; padding: 10px 0; border:1px solid #cccccc;">
								<b style="font-size:12px;">사업자이름</b><br><span style="font-size:12px;"><%=ftDTO.getSel_name()%></span>
							</div>
							<div class="col-sm-6 col-xs-12" style="text-align:center; height: 56px; padding: 10px 0; border:1px solid #cccccc;">
								<b style="font-size:12px;">사업자번호</b><br><span style="font-size:12px;"><%=ftDTO.getSel_no()%></span>
							</div> 
							<div class="col-sm-6 col-xs-12" style="text-align:center; height: 56px; padding: 10px 0; border:1px solid #cccccc;">
								<b style="font-size:12px;">푸드트럭번호</b><br><span style="font-size:12px;"><%=ftDTO.getFt_seq()%></span>
							</div>
							<div class="col-sm-6 col-xs-12" style="text-align:center; height: 56px; padding: 10px 0; border:1px solid #cccccc;">
								<b style="font-size:12px;">회원번호</b><br><span style="font-size:12px;"><%=ftDTO.getUser_seq()%></span>
							</div> 
						</div>
						<div style="clear:both;"></div>
						<!-- 설정 버튼 -->
						<div style="margin-top:10px;"> 
							<button type="button" class="btn btn-default" style="border-radius:0; background-color:#444444; color:#ffffff; font-size:16px; height:34px; width:160px;"  onclick="location.href='<%=request.getContextPath()%>/seller/ft/ft_info.do?cmd=review_list&ft_seq=<%=ftDTO.getFt_seq()%>'">
								리뷰 관리
							</button>
							<button type="button" class="btn btn-default" style="border-radius:0; background-color:#444444; color:#ffffff; font-size:16px; height:34px; width:160px;"onclick="location.href='<%=request.getContextPath()%>/seller/ft/ft_info.do?cmd=ft_info_edit&ft_seq=<%=ftDTO.getFt_seq()%>'">
								정보 변경
							</button>
						</div>
					</div>
			
					<!------------------ 오른쪽 ------------------>
					<div class="col-sm-8" style="padding:0;" id="">
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
			</td>
		</tr>
		<tr height="7%" style="background-color:#444">
			<td>
				<%@ include file="/WEB-INF/view/seller/bottom.jsp" %>
			</td>
		</tr>
	</table>
	
