<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1"><!-- 반응형 웹 설정 -->
<title>트럭 왔냠 - 메인 페이지</title>

</head>
<body style="margin: 0 auto">
	
	<div style="text-align:center; width:100%; padding:28px 0;">
		<!-- <h2>트럭왔냠 메인 페이지</h2> -->
		<img src="<%=request.getContextPath()%>/resources/img/consumer/main_logo_240px.png" />
	</div>
	<div>
	 	<div><%@ include file="/WEB-INF/view/cmmn/user/userLoginBody.jsp" %></div>
	</div>
	<!--test git  -->
	<!-- test git	 -->
</body>
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" rel="stylesheet">
<style>
	body {
		font-family: 'Noto Sans KR', sans-serif;
		background-color: #f5f5f5;
		padding: 100px 0;
	}
	/* 로그인/회원가입 글자 색상 */
	.panel-login>.panel-heading a{
	}
	.panel-login>.panel-heading a.active{
	}
	.panel-login {
		border-color:#e4e4e4;
	}
	/* 폼 자동 채우기 색상 교체*/
	input:-webkit-autofill {
	    -webkit-box-shadow:0 0 0 50px white inset; /* Change the color to your own background color */
	    -webkit-text-fill-color: #333;
	}
	input:-webkit-autofill:focus {
	    -webkit-box-shadow: /*your box-shadow*/,0 0 0 50px white inset;
	    -webkit-text-fill-color: #333;
	}
	/* 로그인 버튼 */
	#login-submit{
		color: black;
  	 	font-size: 20px;
ㄴ	}
	/* 이메일 중복 체크  버튼*/
	#emailCheck{
		height:45px;
	
	}
	/* 회원약관 버튼 */
	#agree{
		height:45px;
		padding: 10px 0;
	}
	.btn-primary{
	    background-color: #bbbbbb;
	    border-color: #c7c7c7;
	}
	.btn-primary.active, .btn-primary:hover{
		background-color: #bbbbbb;
	    border-color: #c7c7c7;
	}
</style>
</html>