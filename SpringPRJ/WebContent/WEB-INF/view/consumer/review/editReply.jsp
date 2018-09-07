<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="poly.dto.consumer.CONSUMER_ImageDTO"%>
<%@ page import="poly.dto.consumer.CONSUMER_Ft_ReviewDTO"%>
<%@ page import="java.util.List"%>
<% 
	CONSUMER_Ft_ReviewDTO edit_reviewDTO = (CONSUMER_Ft_ReviewDTO) request.getAttribute("edit_reviewDTO");
	String review_seq = (String) request.getParameter("review_seq");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>트럭왔냠 - 리뷰 댓글 고치기</title>
</head>
<style>
</style>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<form action="/consumer/review/ReviewReplEditProc.do" method="POST">
	<input type="hidden" value="<%=review_seq %>" name="review_seq"/>
	<input type="hidden" value="<%=edit_reviewDTO.getReview_seq() %>" name="edit_review_seq"/>
	
		<div class="container-fluid">
			<div class="row" >
				<div class="col-xs-12">
					<h2>댓글 수정하기</h2>
				</div>
			</div>
			<div class="row" >
				<div class="col-xs-12"> 
					<div class="form-group">
						<textarea class="form-control" rows="4" name="rev_text"><%=edit_reviewDTO.getRev_text() %></textarea>
					</div>
				</div>
			</div>
			<div class="row" >
				<div class="col-xs-12">
					<button onclick="writeReply()" style="float:right;"class="btn btn-default">등록하기</button>
				</div>
			</div>	
		</div>
	</form>
	
</body>
</html>