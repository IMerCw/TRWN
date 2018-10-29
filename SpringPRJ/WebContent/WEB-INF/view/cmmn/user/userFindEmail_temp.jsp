<%@page import="poly.dto.cmmn.CMMN_UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<% CMMN_UserDTO uDTO = (CMMN_UserDTO)request.getAttribute("uDTO");  %>



<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	
	<style>
		<!--container 범위 css -->
		
		
		<!--top 범위 css -->
			/* middle 범위 가운데로 모으기 */
		#middle {
			margin-left:100px; 
			margin-right:100px;
		} 
		#middle .form-group{
			margin-top:30px;
			margin-bottom:30px;
		}
		/* middle 범위 가운데로 모으기 끝 */
		/*top 범위 css */
			.top{
			margin-top:50px;
			}
			.back{
			width:10%;
			display:inline-block;
			}
			.top > .logo{
			display:inline-block;
			text-align:center;
			width:80%;
			
			}
			<!--middle 범위 css -->
			.middle{
			height: 50%;
			background-color:gray;
			}
			
			.select_id_pw{
				width:45%;
				display:inline-block;
				text-align:center;
				float:left;
				margin-bottom: 10%;
				margin-left: 5%;
				border: 1px solid black;
			}
			
		/*top 범위 css */	
		/* 	.top{
			margin-top:50px;
			position:relative;
			}
			.back{
			width:10%;
			display:inline-block;
			}
			.top > .logo{
			display:inline-block;
			text-align:center;
			width:80%;
			
			}
			
		<!--top 범위 css -->	
			
		<!--middle 범위 css -->
			.middle{
			height: 50%;
			background-color:gray;
			}
			
			.select_id_pw{
				width:45%;
				display:inline-block;
				text-align:center;
				float:left;
				margin-top: 20%;
				margin-left: 5%;
				border: 1px solid black;
			}
		<!--아이디 찾기 css끝 -->
		 */
	/* 	<!--비밀번호 찾기 css -->
			.select_pw{
				width:50%;
				display:inline-block;
				text-align:center;
				background-color:yellow;
			}
		<!--비밀번호 찾기 css 끝 --> */
	</style>
	
	
	

</head>
<body>
	<table style="height: 100%; width: 100%">
		 
		<tr height="7%" bgcolor="#6abded">
			<td>
				<div class="container" style="text-align:center;">
					<div class="logo">
						<a href="/cmmn/main.do" class="btn" role="button" ><h1>트럭왔냠</h1></a>
					</div>
				</div>
					<hr />
			</td>
		</tr> 
	
		<tr bgcolor="">
			<td>
				<div class="container" style="height:90%">
					<div>
					<%
						if (uDTO.getUserEmail() == null) {
					%>
						<script>
						 alert("해당하는 아이디가 없습니다");
						 location.href="/cmmn/user/userFindInfo.do";
						</script>
					<%
						}else{
					%>
						<h3>회원님의 아이디는 
							<%= uDTO.getUserEmail() %>입니다.
						</h3>
					<%
						}
					%>
					
					</div>
					
					<div class="middle">
						<div class="select_id_pw">
						<a href="/cmmn/user/userFindInfo.do" class="btn" role="button">비밀번호 찾기</a>
						</div>
						
						<div class="select_id_pw">
						<a href="/cmmn/main.do" class="btn" role="button">로그인</a>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
	
</body>
</html>