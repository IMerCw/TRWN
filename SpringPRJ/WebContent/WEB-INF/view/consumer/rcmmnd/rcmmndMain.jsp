<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
	<title>트럭왔냠 - 추천 메뉴</title>
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<!-- 반응형 웹 설정 -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	
	<!-- jQuery library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	<!-- Latest compiled JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<style>
		.rcmmndBox {
			text-align: center;
		    cursor: pointer;
		    height: 146px;
		    background-color: #eee;
		    border-radius: 8px;
		    margin-bottom: 12px;
		}
		.rcmmndBox img {
			padding:10px 0;
			width:64px;
			opacity: 0.82;
		}
		.rcmmndBox > p {
			font-size:20px;
			color:white;
			padding:10px 0;
		}		    
	</style>
</head>
<body>
	<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<div class="container-fluid" style="margin-top:20px;">
		<div class="col-xs-12 rcmmndBox" style="background-color:#fd8469; "onclick="location.href='/consumer/rcmmnd/rcmmndMenu.do'">
			<img src="<%=request.getContextPath()%>/resources/img/consumer/rcmmnd/statistics.png" />
			<p>트럭왔냠 추천 메뉴</p></div>
		<div class="col-xs-12 rcmmndBox" style="background-color:#84dbff;" onclick="location.href='/consumer/rcmmnd/wordCloudTrend.do'">
			<img src="<%=request.getContextPath()%>/resources/img/consumer/rcmmnd/networking.png" />
			<p>검색어 트렌드</p></div>
		<div class="col-xs-12 rcmmndBox" style="background-color:#ffd15c;"onclick="location.href='/consumer/rcmmnd/CustomRcmmnd.do'">
			<img src="<%=request.getContextPath()%>/resources/img/consumer/rcmmnd/brain.png" />
			<p>소비자 맞춤 추천 </p></div>
	</div>
</body>
</html>