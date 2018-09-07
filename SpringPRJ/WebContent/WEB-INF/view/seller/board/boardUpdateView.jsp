<%@page import="poly.dto.seller.SELLER_BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String boardSeq = (String)request.getAttribute("boardSeq");
	SELLER_BoardDTO bDTO = (SELLER_BoardDTO)request.getAttribute("bDTO");
%>

<!-- 
			session.setAttribute("userSeq", uDTO.getUserSeq());
			session.setAttribute("userAuth", uDTO.getUserAuth());
			session.setAttribute("userEmail", uDTO.getUserEmail());
			session.setAttribute("userNick", uDTO.getUserNick());
			session.setAttribute("userGender", uDTO.getUserGender());
			session.setAttribute("userHp", uDTO.getUserHp());
			session.setAttribute("userStatus", uDTO.getUserStatus());
 -->

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<%@ include file="/WEB-INF/view/seller/topCssScript.jsp" %>
</head>
<body>
	<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="#444">
			<td style="padding:0;">
				<%@ include file="/WEB-INF/view/seller/top.jsp" %>
			
			</td>
		</tr>
		<tr bgcolor="">
			<td>
				<div class="container">
			<!-- 	<h2>지역행사정보</h2> -->
					<div class="row">
					<form method="post" action="/seller/board/boardUpdateProc.do">
						<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기</th>
								</tr>
							</thead>
							<tbody>
								
								
								<tr>
									<td><input type="text" class="form-control" value="<%=bDTO.getTitle()%>" name="Title" maxlength="50" /></td>
								</tr>
								<tr>
									<td><textarea class="form-control" name="boardContent" maxlength="2048" style="height: 350px;"><%=bDTO.getContent() %></textarea></td>
								</tr>
							</tbody>
							
						</table>
						<input type="hidden" name="regDate"/>
						<input type="hidden" name="boardSeq" value="<%=boardSeq%>"/>
						<input type="submit" class="btn btn-paimary pull-right" value="등록">
						<input type="hidden" name="userSeq" value="<%=userSeq%>"/>
						<input type="hidden" name="boardPSeq" value="<%=bDTO.getBoardPSeq()%>"/>
					
					</form>
					</div>
				</div>

			</td>
		</tr>
		<tr height="7%" style="background-color:#444">
			<td>
			<%-- 	<%@ include file="/WEB-INF/view/bottom.jsp" %> --%>
			
			</td>
		</tr>
	</table>

	

</body>
</html>