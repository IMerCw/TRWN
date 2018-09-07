<%@page import="poly.dto.consumer.CONSUMER_BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
		/* String title = CmmUtil.nvl((String)session.getAttribute("title"));
		String boardContent = CmmUtil.nvl((String)session.getAttribute("boardContent")); */

		CONSUMER_BoardDTO bDTO = (CONSUMER_BoardDTO)request.getAttribute("bDTO");
		
	
	%>
	
	
	
<html>
<head>
<title>Write!</title>
<%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<table style="height: 100%; width: 100%">
		<tr bgcolor="">
			<td>
				<div class="container">
					<p>고객센터에 문의하고 싶은 사항을 적어주시기 바랍니다.</p>
					<form action="/consumer/board/boardUpdateViewProc.do" method="POST">
						<div class="form-group">
							<input type="hidden" name="boardSeq" value="1" />
							<input type="hidden" name="boardPSeq" value="<%=bDTO.getBoardPSeq() %>" />
							<input type="hidden" name="userEmail" value="<%=userEmail %>" />
							<label for="title" >Title:</label>
							<input type="text" class="form-control"  name="title" value="<%=bDTO.getTitle() %>"> 
							<label for="boardContent">Comment:</label>
							<textarea class="form-control" rows="5"
								name="boardContent"><%=bDTO.getBoardContent() %></textarea>
						</div>
						<button type="submit" class="btn btn-primary">수정하기</button>
					</form>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>

	