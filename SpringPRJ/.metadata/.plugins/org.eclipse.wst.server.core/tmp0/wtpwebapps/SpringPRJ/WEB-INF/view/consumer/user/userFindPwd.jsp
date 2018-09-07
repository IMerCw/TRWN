<%@page import="poly.util.CmmUtil"%>
<%@page import="poly.dto.consumer.CONSUMER_UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<% CONSUMER_UserDTO uDTO = (CONSUMER_UserDTO)request.getAttribute("uDTO");  %>





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
	<script type="text/javascript">
	//비밀번호 조합
	   function checkUnion(str){
	      var reg1=/^[a-zA-Z0-9]{8,20}$/;//대문자 소만자 8 -20 자리 허용
	      var reg2=/[a-zA-Z]/g;
	      var reg3=/[0-9]/g;
	      return(reg1.test(str) && reg2.test(str) &&reg3.test(str))
	   }
	
	//비밀번호 일치 여부 확인 
		$(function(){
			var password = $('#password');
			$('#password').keyup(function(){
				
				$('font[id=check]').text('');
				if(!checkUnion(password.val())){
				   
					$('font[id=length]').text('');
					$('font[id=length]').html("8자리 이상 20자리 이하의 [영문+숫자] 조합");					
				}else{
					
					$('font[id=length]').css('color','green');
					$('font[id=length]').html("적합");
				}
			});
			
			$('#confirm_password').keyup(function(){
				if($('#password').val() != $('#confirm_password').val()){
					$('font[id=check]').text('');
					$('font[id=check]').css('color','red');
					$('font[id=check]').html("암호 틀림");
				}else{
					$('font[id=check]').text('');
					$('font[id=check]').css('color','green');
					$('font[id=check]').html("암호 일치");
				}
			});//confirm keyup
		
	
	
			//빈칸 확인 시작 
			$('#newPwdSumit').on('click',function(){
				
				 if($('#password').val() ==''){
					$('#password').focus();
					alert($('#password').attr('data-msg')+ '입력해주세요');
					
					return false;
				};
				if($('#confirm_password').val() ==''){
					$('#confirm_password').focus();
					alert($('#confirm_password').attr('data-msg')+ '입력해주세요');
				
					return false;
				};
				//비밀번호 유효성 검사
				if(!checkUnion($('#password').val())){
			         alert("비밀번호 유효성검사에 어긋남");
			         $('#password').focus();
			         return false;
			      }
				
				
				
			});
			
			
			
			//빈칸 확인 끝
		});
	</script>
	
	
	

</head>
<body>
	<table style="height: 100%; width: 100%">
		 
		<tr height="7%" bgcolor="#6abded">
			<td>
				<div class="container">
				<div class="top" >
						<div class="back">
						<a href="/user/userLogin.do" class="btn" role="button">뒤로가기</a>
						</div>
						<div class="logo">
						<a href="/maintest.do" class="btn" role="button" ><h1>트럭왔냠</h1></a>
						</div>
					</div>
				</div>
					<hr />
			</td>
		</tr> 
	
		<tr bgcolor="">
			<td>
				<div class="container" style="height:90%">
					<h2>비밀번호 변경</h2>
					<form method="post" action="/user/userUpdatePwd.do">
						<div class="form-group">
							<input type="password" class="form-control" id="password" name="userPwd" placeholder="새 비밀번호" data-msg="새 비밀번호를" value="" />		
							<font id="length" size="2" color="red"></font>
						</div>
						
						<div class="form-group">
							<input type="password" class="form-control" id="confirm_password" name="userPwdNew" placeholder="새 비밀번호 확인" data-msg="새 비밀번호 확인을" value="" />
							<font id="check" size="2" color="red"></font>
						</div>
							<input type="submit" class="col-sm-12 btn-primary" id="newPwdSumit" value="확인">
					<!-- 	<button type="submit" class="col-sm-12 btn-primary" id="newPwdSumit">확인</button> -->	
						<input type="hidden" value="<%=uDTO.getUserSeq()%>" name="userSeq" />
					</form>
				</div>
			</td>
		</tr>
	</table>
	
</body>
</html>