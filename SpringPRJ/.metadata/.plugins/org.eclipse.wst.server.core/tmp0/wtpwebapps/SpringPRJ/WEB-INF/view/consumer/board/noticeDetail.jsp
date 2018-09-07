<%@page import="java.util.List"%>
<%@page import="poly.dto.consumer.CONSUMER_BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<%
		
		CONSUMER_BoardDTO bDTO = (CONSUMER_BoardDTO)request.getAttribute("bDTO");
		
		%>
<html>
<head>
<title>Detail!</title>
<%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %>


</head>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<table style="height: 100%; width: 100%">
		<tr bgcolor="">
			<td>
				<div class="container">
					<table class="table table-striped" style="text-align:center;">
						<tr>
							<td>번호</td>
							<td><%=bDTO.getBoardPSeq() %></td>
							<td>작성자</td>
							<td><%=bDTO.getUserEmail() %></td>
						</tr>
						<tr>
							<td>제목</td>
							<td colspan="3"><%=bDTO.getTitle() %></td>
						</tr>
						<tr>	
							<td>내용</td>
							<td colspan="3"><%=bDTO.getBoardContent() %></td>
						</tr>
						<tr>	
							<td>작성일</td>
							<td colspan="3"><%=bDTO.getRegDate() %></td>
						</tr>
					</table>
				</div>
				
			</td>
		</tr>
	</table>
</body>
</html>

	