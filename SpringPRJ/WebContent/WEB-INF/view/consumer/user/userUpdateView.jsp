<%@page import="poly.dto.consumer.CONSUMER_UserDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
CONSUMER_UserDTO uDTO = (CONSUMER_UserDTO)request.getAttribute("uDTO");
%>


<html>
<head>
	<title>web</title>
	<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	<style>
		.mypageMenu > div {
			padding: 0px;
		}
		
		@media (max-width:768px) {
			.table-font-size tr td{
				font-size: 9px;
				
			}
			.table-font-size tr th{
				font-size: 12px;
				
			}
		}
	</style>
</head>

<body>
	<%@ include file="/WEB-INF/view/consumer/topBody.jsp" %>
	
	
	<div class="container" style="width:100%;">
		<form action="/cmmn/user/userUpdateProc.do" method="post">
		
			<table class="table table-font-size" style="border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #f9f9f9; text-align: center;">회원정보 수정하기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%; text-align:left;">회원번호 :</td>
						<td colspan="2">
							<%=uDTO.getUserSeq() %>
						</td>
					</tr>
					<tr>
						<td >이메일 :</td>
						<td colspan="2" style="text-align:left;" >
							<%=uDTO.getUserEmail() %>
						</td>
					</tr>
					<tr>
						<td >새 비밀번호 :</td>
						<td colspan="2" style="text-align:left;">
							<div class="form-group">
								<input type="password" name="userPassword" id="register_userPassword" tabindex="2" class="form-control" placeholder="새 비밀번호" data-msg="비밀번호를">
								<font id="length" size="2" color="red"></font>
							</div>
						</td>
					</tr>
					<!-- 새 비밀번호 확인 유효성검사 -->
					<tr>
						<td >새 비밀번호 확인:</td>
						<td colspan="2" style="text-align:left;">
							<div class="form-group">
									<input type="password" name="confirm-password" id="register_confirm-password" tabindex="2" class="form-control" placeholder="새 비밀번호확인" data-msg="새 비밀번호확인을"> 
									<font id="check" size="2" color="red"></font>
							</div>
						</td>
					</tr>
					<tr>
						<td >닉네임 :</td>
						<td colspan="2" style="text-align:left;">
							<input type="text" name="nickname" id="nickname" tabindex="3" class="form-control" data-msg="닉네임을" value="<%=uDTO.getUserNick()%>" >
						</td>
					</tr>
					<tr>
						<td >성별 :</td>
						<td colspan="2" style="text-align:left;">
							<%=uDTO.getUserGender() %>
						</td>
					</tr>
					<tr>
						<td >핸드폰번호 :</td>
						<td colspan="2" style="text-align:left;">
							<input type="text" name="phone" id="phone" tabindex="5" class="form-control" data-msg="핸드폰 번호를" value="<%=uDTO.getUserHp() %>" >
								
						</td>
					</tr>
					
					<tr>
						<td colspan="3">
							<div class="form-group">
								<input type="submit" name="register-submit" id="register-submit" class="form-control btn btn-primary" value="수정하기" />
							</div>
						</td>
					</tr>
					
				</tbody>
			</table>

			<input type="hidden" name="userSeq" value="<%=uDTO.getUserSeq() %>">
		</form>
	</div>
	
	
<script>
function checkUnion(str){
    var reg1=/^[a-zA-Z0-9]{8,20}$/;//대문자 소만자 8 -20 자리 허용
    var reg2=/[a-zA-Z]/g;
    var reg3=/[0-9]/g;
    return(reg1.test(str) && reg2.test(str) &&reg3.test(str))
 }

//비밀번호 일치 여부 확인 
	$(function(){
		var register_userPassword = $('#register_userPassword');
		$('#register_userPassword').keyup(function(){
			
			$('font[id=check]').text('');
			if(!checkUnion(register_userPassword.val())){
			   
				$('font[id=length]').text('');
				$('font[id=length]').html("8자리 이상 20자리 이하의 [영문+숫자] 조합");					
			}else{
				
				$('font[id=length]').css('color','green');
				$('font[id=length]').html("적합");
			}
		});
		
		$('#register_confirm-password').keyup(function(){
			if($('#register_userPassword').val() != $('#register_confirm-password').val()){
				$('font[id=check]').text('');
				$('font[id=check]').css('color','red');
				$('font[id=check]').html("암호 틀림");
			}else{
				$('font[id=check]').text('');
				$('font[id=check]').css('color','green');
				$('font[id=check]').html("암호 일치");
			}
		});//confirm keyup
	});
	
	<!--가입하기 빈칸 있는지 정보확인 js시작-->
	$('#register-submit').on('click',function(){
		 	
			
		
			if($('#register_userPassword').val() ==''){
				$('#register_userPassword').focus();
				alert($('#register_userPassword').attr('data-msg')+ '입력해주세요');
				
				return false;
			};
			if($('#register_confirm-password').val() ==''){
				$('#register_confirm-password').focus();
				alert($('#register_confirm-password').attr('data-msg')+ '입력해주세요');
			
				return false;
			};
			 if($('#register_userPassword').val() != $('#register_confirm-password').val()){
				$('#register_confirm-password').focus();
				alert('새 비밀번호와 비밀번호 확인이 일치하지 않습니다.');
				
				return false;
			};
			//비밀번호 유효성 검사
			if(!checkUnion($('#register_userPassword').val())){
		         alert("비밀번호 유효성검사에 어긋남");
		         $('#register_userPassword').focus();
		         return false;
		      };
			
			
				
			
		
		
	});

</script>

</body>
</html>