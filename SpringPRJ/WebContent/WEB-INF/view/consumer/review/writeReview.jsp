<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="poly.util.CmmUtil" %>
<%
	String ftSeq = CmmUtil.nvl((String)request.getAttribute("ft_seq"));
	String ftName = CmmUtil.nvl((String)request.getAttribute("ft_name"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>트럭왔냠 - 리뷰 작성</title>
<style>
	.container-fluid{
		background-color: none;
	}
	.row {
	 	box-sizing: border-box; 
	 	margin-bottom: 15px; background-color:#ffffff;
	}
	#ft-detail-menu{
		background-color:#ffffff;
	}
	.nav-tabs>li>a{
		border:0;
	}
	.col-xs-12 div {
		padding: 10px 0
	}
</style>
</head>
<body>
	<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<form action="/consumer/review/writeReviewProc.do" method="POST" enctype="multipart/form-data">
		<input type="hidden" value="<%=ftSeq%>" name="ft_seq"/>
		<div class="container-fluid">
			<div class="row" >
				<div class="col-xs-12">
					<!-- 목록으로 가기 // 뒤로 가기 -->
					<a href="/consumer/cnsmr/ftDetail.do?ft_seq=<%=ftSeq%>&cmd=2">
						<img src="/resources/img/consumer/left-arrow.png" width="35px" style="margin:20px 0;"/>	
					</a>
					<div style="display:inline-block"><%=ftName %>에 리뷰 쓰기</div>
				</div>
				<div class="col-xs-12">
					<div class="form-group">
					 	<label for="subject">리뷰 제목</label>
						<input type="text" class="form-control" name="rev_title">
					</div>
				</div>
				<div class="col-xs-12">
					<div class="form-group">
						<label for="contents">리뷰 내용</label>
						<textarea class="form-control" rows="10" name="rev_text"></textarea>
					</div>
				</div>
				<div class="col-xs-12">
					<div class="form-group">
						<label for="rating">푸드트럭 음식 평점</label>
						<select class="form-control" name="rev_point">
						  <option value="5">5</option>
						  <option value="4">4</option>
						  <option value="3">3</option>
						  <option value="2">2</option>
						  <option value="1">1</option>
						</select>
					</div>
				</div>
				<div class="col-xs-12">
					<div class="form-group">
						<label for="rating">푸드트럭 위생 점수</label>
						<select class="form-control" name="rev_snty_point">
						  <option value="5">5</option>
						  <option value="4">4</option>
						  <option value="3">3</option>
						  <option value="2">2</option>
						  <option value="1">1</option>
						</select>
					</div>
				</div>
				<div class="col-xs-12">
					<div class="form-group">
							<input type="file" id="uploadFile" name="uploadFile">
					</div>
				</div>
				<div class="col-xs-12">
					<button type="submit" class="btn btn-primary" style="width:100%;">리뷰 등록</button>
				</div>
			</div>
		</div>
	</form>
</body>
</html>