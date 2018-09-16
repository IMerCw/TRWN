<%@page import="java.util.List"%>
<%@page import="poly.dto.consumer.CONSUMER_BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<%
		
		CONSUMER_BoardDTO bDTO = (CONSUMER_BoardDTO)request.getAttribute("bDTO");
		
		%>
<html>
<head>
<title>트럭왔냠 - 공지사항</title>
<%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %>


</head>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<div class="container-fluid">
		<div class="row" >
			<div class="col-xs-4">
				<!-- 목록으로 가기 // 뒤로 가기 -->
				<a href="/consumer/board/noticeList.do">
					<img src="<%=request.getContextPath()%>/resources/img/consumer/left-arrow.png" width="35px" style="margin-top:10px;"/>
				</a>
			</div>
		</div>
	</div>
	
	<div class="container-fluid">
		<div class="row" >
			<div class="col-xs-12">
				<h2 style="font-weight:bold"><%=bDTO.getTitle() %></h2>
			</div>
		</div>
		
		<div class="row" style="margin-top:15px; margin-bottom:15px;">
			<div class="col-xs-6">
				<img src="<%=request.getContextPath()%>/resources/img/consumer/personalCon/psnlCn (0).png"style="margin-right:10px;"/>
				
				관리자
			</div>
			<div class="col-xs-6" style="text-align:right; font-size: 12px; padding-top: 6px;">
				<%=bDTO.getRegDate() %>
			</div>
		</div>

		<div class="row" >
			<div style="background-color:#cecece; height:2px; margin:20px 10px;">
			</div>
		</div>
		<div class="row" >
			<div class="col-xs-12">
				<%=bDTO.getContent() %>
			</div>
		</div>
	</div>	
			
</body>
</html>

	