<%@page import="poly.dto.consumer.CONSUMER_UserDTO"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.consumer.CONSUMER_BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@page import="java.util.Arrays"%>
<%@page import="java.util.regex.Pattern"%>
<%
	List<CONSUMER_BoardDTO> bList = (List<CONSUMER_BoardDTO>)request.getAttribute("bList");
	String []today = (String[]) request.getAttribute("today");
%>
<html>
<head>
<title>트럭왔냠 - 고객센터</title>
<%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %>

<style>
.ellipsis {
    white-space: nowrap; 
    overflow: hidden;
    text-overflow:ellipsis;
}
</style>
</head>
<body>

	<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>	<!-- topBody에서 session으로 userEmail을 받는다. -->
	<div class="container-fluid" style="text-align:left;">
		<div class="row" style="border-bottom:1px solid #eeeeee; padding:8px 0;">
			<div class="col-xs-12" style="font-size:20px;">
				<h5>트럭왔냠 고객센터</h5>
			</div>
			<div class="clearfix visible-xs"></div>
		</div>
		<%for (int i = 0; i < bList.size(); i++) {%>
			<%String regDate[] = bList.get(i).getRegDate().split("/"); %>
			<%String []regDateSub = regDate[0].split("\\. "); %>
			<%boolean newListCheck = regDateSub[0].equals(today[0]) && regDateSub[1].equals(today[1]) && regDateSub[2].equals(today[2]);%>
			<div class="row" style=" padding:8px 0;">
				<span style="font-size:15px; color:red; padding:0px; position:absolute; margin-top:5px; ">
					<%if(newListCheck) {%>
						ㆍ
					<%}%>	
				</span>
				<div class="col-xs-12" style="font-size:20px; 
					text-overflow: ellipsis;  white-space: nowrap; overflow: hidden;">
					<a href="/consumer/board/boardDetail.do?boardPSeq=<%=bList.get(i).getBoardPSeq()%>&boardSeq=1">
						<%=bList.get(i).getTitle() %>
					</a>
				</div>
				<div class="clearfix visible-xs"></div>
			</div>
			<div class="row" style="border-bottom:1px solid #eeeeee; padding:8px 0;">
				<div class="col-xs-3" style="color:#9f9f9f;"><%=bList.get(i).getUserNick() %></div>
					<!-- 현재날짜와 같을 경우 mm:ss 만 표시 -->
				<div class="col-xs-6" style="color:#9f9f9f; float:right;">
					<%if(newListCheck) {%>
						<%=regDate[1].substring(0,6) %>
					<%}else { %>
						<%=regDate[0]%>
					<%} %>
				</div>
				<div class="clearfix visible-xs"></div>
			</div>
		<%}%>
			
			
	</div>
		<div style="margin:20px; align:right">
			<form action="/consumer/board/boardWrite.do">
				<input type="hidden" name="userSeq" value="<%=userSeq %>" />
				<input type="hidden" name="userNick" value="<%=userNick %>" /> 
				<input type="hidden" name="userEmail" value="<%=userEmail %>" />
				<div style="height:5px"></div>
				<div style="text-align:right"><button type="submit" class="btn btn-default">문의하기</button></div>
			</form>
		</div>
	
</body>

</html>

	