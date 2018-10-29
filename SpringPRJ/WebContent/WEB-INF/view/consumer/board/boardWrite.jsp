<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>트럭왔냠 - 고객센터</title>
<%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<div class="container">
		<div class="container-fluid" style="margin-bottom:20px;">
			<!-- 목록으로 가기 // 뒤로 가기 -->
			<a href="/consumer/board/boardList.do">
				<img src="/resources/img/consumer/left-arrow.png" width="35px" style="margin-top:10px;"/>
			</a>
		</div>
		<div class="container-fluid">
			<h4>고객센터에 문의하고 싶은 사항을 적어주시기 바랍니다.</h4>
			<form action="/consumer/board/boardWriteProc.do" method="POST">
				<div class="form-group">
					<input type="hidden" name="boardSeq" value="2" />
					<input type="hidden" name="userEmail" value="<%=userEmail %>" />
					<input type="hidden" name="userSeq" value="<%=userSeq %>" />
					<label for="title">제목:</label>
					<input type="text" class="form-control"  name="title"> 
					<label for="boardContent">내용:</label>
					<textarea class="form-control" rows="5"
						name="boardContent"></textarea>
				</div>
				<button type="submit" class="btn btn-primary">글쓰기</button>
			</form>
		</div>
	</div>
</body>
</html>

	