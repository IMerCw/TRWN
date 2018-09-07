<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		 
		<tr height="7%">
			<td>
				<div class="container">
				<div class="top" >
						<div class="back">	
						<a href="/cmmn/user/userLogin.do" class="btn" role="button">뒤로가기</a>
						</div>
						<div class="logo">
						<a href="#" class="btn" role="button" ><h1>트럭왔냠</h1></a>
						</div>
					</div>
				</div>
					<hr />
			</td>
		</tr> 
	
		<tr bgcolor="">
			<td>
				<div class="container" style="height:90%">
					<div class="middle">
						<div class="select_id_pw">
						<a href="#" class="btn" role="button" id="showEmail">아이디 찾기</a>
						</div>
						<div class="select_id_pw">
						<a href="#" class="btn" role="button" id="showPwd">비밀번호 찾기</a>
						</div>
					</div>
					
					<div id="hideEmailPwd">
					
						<div id="showEmailFind">
						<h2>이메일 찾기</h2>
							<form method="post" action="/cmmn/user/userFindEmail.do">
								<div class="form-group">
									<input type="text" class="form-control" id="name" name="userNick" placeholder="닉네임" />		
								</div>
								
								<div class="form-group">
									<input type="text" class="form-control" id="phone" name="userHp" placeholder="핸드폰 번호 입력" />
								</div>
									<button type="submit" class="col-sm-12 btn-primary">확인</button>
							</form>
						</div>
						<div id="showPwdFind">
						<h2>비밀번호 찾기</h2>
							<form method="post" action="/cmmn/user/userFindPwd.do" >
								<div class="form-group">
									<input type="text" class="form-control" id="name" name="userNick" placeholder="닉네임" />		
								</div>
								<div class="form-group">
									<input type="email" class="form-control" id="email" name="userEmail" placeholder="이메일 입력" />
								</div>
								
								<div class="form-group">
									<input type="text" class="form-control" id="phone" name="userHp" placeholder="핸드폰 번호 입력" />
								</div>
									<button type="submit" class="col-sm-12 btn-primary">확인</button>
							</form>
						</div>
					</div>	
					
				</div>
			</td>
		</tr>
	</table>
	
	<script type="text/javascript">
	$(document).ready(function(){
		$("#hideEmailPwd").hide();
		
		
		$("#showEmail").click(function(){
			$("#hideEmailPwd").show();
			$("#showEmailFind").show();
			$("#showPwdFind").hide();
			//console.log($("#showEmailFind"));
			//console.log($("#showPwdFind"));
		});
		
		
		$("#showPwd").click(function(){
			$("#hideEmailPwd").show();
			$("#showEmailFind").hide();
			$("#showPwdFind").show();
		});
		
	});
	</script>

	

</body>
</html>