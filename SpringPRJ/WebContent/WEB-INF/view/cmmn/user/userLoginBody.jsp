<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String joinCode = CmmUtil.nvl ((String)session.getAttribute("joinCode"));
%>
<%=joinCode %>

 <!--  로그인 css -->
<style type="text/css">

	.panel-login {
		border-color: #ccc;
		-webkit-box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
		-moz-box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
		box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
	}
	.panel-login>.panel-heading {
		background-color: #fff;
		border-color: #fff;
		text-align:center;
	}
	.panel-login>.panel-heading a{
		text-decoration: none;
		color: #999999;
		font-size: 20px;
		-webkit-transition: all 0.1s linear;
		-moz-transition: all 0.1s linear;
		transition: all 0.1s linear;
	}
	.panel-login>.panel-heading a.active{
		color:black;
		font-size: 20px;
	}
	.panel-login>.panel-heading hr{
		margin-top: 10px;
		margin-bottom: 0px;
		clear: both;
		border: 0;
		height: 1px;
		background-image: -webkit-linear-gradient(left,rgba(0, 0, 0, 0),rgba(0, 0, 0, 0.15),rgba(0, 0, 0, 0));
		background-image: -moz-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
		background-image: -ms-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
		background-image: -o-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
	}
	.panel-login input[type="text"],.panel-login input[type="email"],.panel-login input[type="password"] {
		height: 45px;
		border: 1px solid #ddd;
		font-size: 16px;
		-webkit-transition: all 0.1s linear;
		-moz-transition: all 0.1s linear;
		transition: all 0.1s linear;
	}
	.panel-login input:hover,
	.panel-login input:focus {
		outline:none;
		-webkit-box-shadow: none;
		-moz-box-shadow: none;
		box-shadow: none;
		border-color: #ccc;
	}


	.forgot-id_password {
		text-decoration: underline;
		color: #888;
	}
	.forgot-id_password:hover,
	.forgot-id_password:focus {
		text-decoration: underline;
		color: #666;
	}
	
	.btn-register {
		background-color: #1CB94E;
		outline: none;
		color: #fff;
		font-size: 14px;
		height: auto;
		font-weight: normal;
		padding: 14px 0;
		text-transform: uppercase;
		border-color: #1CB94A;
	}
	.btn-register:hover,
	.btn-register:focus {
		color: #fff;
		background-color: #1CA347;
		border-color: #1CA347;
	}
	
	.gender_color{
	color: gray;
	}
		
</style>
<!--  로그인 끝 -->


	<!-- 로그인 시작 -->
	<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	<!------ Include the above in your HEAD tag ---------->
	
	<div class="container">
	    	<div class="row">
				<div class="col-md-6 col-md-offset-3">
					<div class="panel panel-login">
						<div class="panel-heading">
							
							<!-- 로그인 회원가입 TOP부분 -->
							<div class="row" style="border-bottom: 1px solid #d9d9d9; margin: 8px; ">
								<div class="col-xs-6" id="login_header" style="padding-bottom: 12px; margin-bottom: -1px;">
									<a href="#" id="login-form-link" class="active">로그인</a>
								</div>
								<div class="col-xs-6" id="register_header" style="padding-bottom: 12px; margin-bottom: -1px;">
									<a href="#"  id="register-form-link">회원가입</a>
								</div>
							</div>
							<!-- 로그인 회원가입 TOP부분 -->
							
						</div>
							<!-- 로그인 회원가입 정보입력 부분 -->
						<div class="panel-body">
							<div class="row">
								<div class="col-lg-12">
								
									<!-- 로그인 정보입력 시작 -->
									<form id="login-form" action="/cmmn/user/loginProc.do" method="post" role="form" style="display: block;">
										<div class="form-group">
											<input type="text" name="user_Email" id="email" tabindex="1" class="form-control" placeholder="이메일" value="" data-msg="이메일을">
										</div>
										<div class="form-group">
											<input type="password" name="user_Pwd" id="userPassword" tabindex="2" class="form-control" placeholder="비밀번호" data-msg="비밀번호를">
										</div>
										<div class="form-group text-center">
											<input type="checkbox" tabindex="3" class="" name="remember" id="remember">
											<label for="remember"> 아이디 기억하기</label>
										</div>
										<div class="form-group">
											<div class="row">
												<div class="col-sm-12">
													<input type="submit" name="login-submit" id="login-submit" 
															tabindex="4" class="form-control btn" value="로그인" style="padding:0;">
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="row">
												<div class="col-lg-12">
													<div class="text-center">
														<a href="/cmmn/user/userFindInfo.do" tabindex="5" class="forgot-id_password">아이디/비밀번호 찾기</a>
													</div>
												</div>
											</div>
										</div>
									</form>
									
									<!-- 로그인 정보입력 끝 -->
									<!-- 회원가입 정보입력 시작 -->
									
									<form id="register-form" action="/cmmn/user/userRegProc.do" method="post" role="form" style="display: none;">
										<div class="form-group">
											<div class="input-group">
												<input type="text" name="email" class="form-control" id="email_input" placeholder="*이메일 입력" data-msg="이메일을" />
												<span class="input-group-btn">
													<input type="button" class="btn btn-primary" id="emailCheck" value="이메일 중복체크" />
												</span>
											</div>
										</div>
										
										<div class="form-group">
											<input type="password" name="userPassword" id="register_userPassword" tabindex="2" class="form-control" placeholder="비밀번호" value="" data-msg="비밀번호를"  >
											<font id="length" size="2" color="red"></font>
										</div>
										<div class="form-group">
											<input type="password" name="confirm-password" id="register_confirm-password" tabindex="2" class="form-control" placeholder="비밀번호확인" data-msg="비밀번호확인을" >
											<font id="check" size="2" color="red"></font>
										</div>
										<div class="form-group">
											<input type="text" name="nickname" id="nickname" tabindex="3" class="form-control" placeholder="닉네임" data-msg="닉네임을" >
										</div>
										<div class="form-group">
											<select class="form-control" tabindex="4" class="gender_color" name="gender" style="height:45px;" >
												<option class="gender_color" data-msg="*성별을 ">*성별</option>
												<option class="gender_color" value="M">남자</option>
												<option class="gender_color" value="F">여자</option>
											</select>
										</div>
										<div class="form-group">
											<input type="text" name="phone" id="phone" tabindex="5" class="form-control" placeholder="핸드폰 번호 입력" data-msg="핸드폰 번호를" maxlength="15" >
										</div>
										<div class="form-group">
											<p><a class="btn btn-primary col-sm-12" data-target="#modal1" data-toggle="modal" id="agree" style="width:100%;" >회원약관</a></p>
										</div>
										
										
										<!-- 가입하기 버튼 -->
										<div class="form-group">
											<input type="submit" name="register-submit" id="register-submit" 
													tabindex="6" class="form-control btn " value="가입하기" style="width:100%; height:45px;">
										</div>
										
										<!-- 이메일 유효성 검사를 위한 value   -->
											<input type="hidden" value="0" id="count"/>
										<!-- 이메일 인증 회원 상태   -->
											<input type="hidden" value="AuthN" name="userStatus" />
										
										<!-- 가입하기 버튼끝  -->
									</form>
									
									<!-- 회원가입 정보입력 끝 -->
								</div>
							</div>
						</div>
						
						<!-- 로그인 회원가입 정보입력 부분 -->
						
					</div>
				</div>
			</div>
		</div>
		
		
	


	<!-- 로그인 끝 -->
	
	<!-- 회원 약관 모달 -->
<div class="modal" id="modal1">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- 회원약관 모달 Header -->
      <div class="modal-header">
        <h4 class="modal-title">트럭왔냠 회원약관</h4>
      </div>

      <!-- 회원약관 body -->
      <div class="modal-body">
         <div class="col-lg-10" id="provision">
                    <textarea class="form-control" rows="8" style="resize:none" readonly>약관동의
                    </textarea>
                    <div class="radio">
                        <label>
                            <input type="radio" id="radioY" name="provisionYn" value="Y" autofocus="autofocus" />
                           		 동의합니다.
                        </label>
                    </div>
                    <div class="radio">
                        <label>
                            <input type="radio" id="radioN" name="provisionYn" value="N">
                            	동의하지 않습니다.
                        </label>
                    </div>
                </div>
      </div>

      <!-- 회원약관 footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="provistionY_Y" data-dismiss="modal">확인</button>
        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>


	
	<!-- 로그인/회원가입js -->
	<script>
	<!--로그인 처음 화면 js-->
		$(function() {
	
	    $('#login-form-link').click(function(e) {
			$("#login-form").delay(100).fadeIn(100);
	 		$("#register-form").fadeOut(100);
			$('#register-form-link').removeClass('active');
			$(this).addClass('active');
			e.preventDefault();
		});
		$('#register-form-link').click(function(e) {
			$("#register-form").delay(100).fadeIn(100);
	 		$("#login-form").fadeOut(100);
			$('#login-form-link').removeClass('active');
			$(this).addClass('active');
			e.preventDefault('btn-warning');
		});
	});
		<!--로그인 처음 화면 js끝-->
		
		<!-- 로그인 빈칸 정보 확인 js 시작-->
		$('#login-submit').on('click',function(){
			if($('#email').val() ==''){
				$('#email').focus();
				alert($('#email').attr('data-msg')+ '입력해주세요');
				return false;
			}; 
			if($('#userPassword').val() ==''){
				$('#userPassword').focus();
				alert($('#userPassword').attr('data-msg')+ '입력해주세요');
				
				return false;
			};
		});
		
		
		
		<!-- 로그인 빈칸 정보 확인 js 시작-->
		
		<!--******************************************************아래부터는 회원가입******************-->
		<!--비밀번호확인 체크 시작js-->
		//비밀번호 조합
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
	
		

		
		<!--비밀번호확인 체크끝js-->
		//전화번호 유효성 검사 함수
		   $('#phone').keydown(function(e){
		      if((e.keyCode<48 || e.keyCode>57)&&e.keyCode!=8&&(e.keyCode<96||e.keyCode>105)){
		         alert("전화번호는 숫자만 입력됩니다.");
		         return false;
		      }
		   });
		
		<!--이메일 체크js -->
		$('#emailCheck').on('click',function(){
 			$.ajax({
 				type:'POST',
 				url:'/cmmn/user/emailCheck.do',
 				data:{
					"email" : $('#email_input').val()	 					
 				},
 				success : function(data){
	 				if(data > 0 ){
	 					$('#emailCheck').val('사용중인 이메일');
	 					$('#count').val('0');
	 					$('#emailCheck').removeClass('btn-warning')
	 					$('#emailCheck').removeClass('btn-primary')
	 					$('#emailCheck').addClass('btn-danger');
	 				}else{
	 					$('#emailCheck').val('사용가능 이메일');
	 					$('#emailCheck').removeClass('btn-warning')
	 					$('#emailCheck').removeClass('btn-danger')
	 					$('#emailCheck').addClass('btn-primary active');
	 					$('#count').val('1');
	 				}
	 				
	 			},//success
	 			error:function(x,e){
					if(x.status==0){
			            alert('네트워크가 정상적으로 동작하지 않습니다.');
			            alert('네트워크 상태를 확인 하거나 업체에게 문의해 주세요.')
			            }else if(x.status==404){
			            alert('페이지를 찾을수가 없습니다. 지금은 주문을 받을 수 없습니다. 업체에게 문의하세요.');
			            }else if(x.status==500){
			            alert('서버에서 오류가 발생했습니다. 지금은 주문을 받을 수 없습니다. 업체에게 문의하세요.');
			            }else if(e=='parsererror'){
			            alert('json파싱에 실패했습니다.');
			            }else if(e=='timeout'){
			            alert('응답 요청 시간이 지났습니다.');
			            }else {
			            alert('Unknow Error.n'+x.responseText);
			            }
			    }
 			
 			})//ajax
 			
 		});//on click
 	
		
		
		
		<!--회원약관js provistionY_Y-->
		//회원가입약관
		$('#provistionY_Y').click(function(e){
			// alert($('#radioY').is(":checked"));
			 if($('#radioY').is(":checked")){
			 	
				$('#agree').attr('backgroundColor','black');
				$('#modal1').fadeOut(100);
				
				
			}else{
				alert('동의하셔야 다음으로 진행할 수 있습니다.');
				 
			}
		});
		<!--회원약관js끝-->
		
		<!--가입하기 빈칸 있는지 정보확인 js시작-->
		$('#register-submit').on('click',function(){
			 	if($('#email_input').val() ==''){
					$('#email_input').focus();
					alert($('#email_input').attr('data-msg')+ '입력해주세요');
					return false;
				}
				
				//이메일 유효성 검사
				var emavld = /[a-z0-9]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
				if(!emavld.test($('#email_input').val())){
			         alert("이메일 형식을 올바르게 입력해주세요 ")
			         email.focus();
			         return false;
			      }
				
				if($('#count').val() == '0'){
					alert("이메일 인증을 해주세요");
					$('#email_input').focus();
					return false;
				};
				
			
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
				
				if($('#nickname').val() ==''){
					$('#nickname').focus();
					alert($('#nickname').attr('data-msg')+ '입력해주세요');
					return false;
				};
				if($('select > option:selected').val() == "*성별"){
					
					alert($('select > option:selected').attr('data-msg')+ '선택해주세요');
					return false;
					};
				
				if($('#phone').val() ==''){
					$('#phone').focus();
					alert($('#phone').attr('data-msg')+ '입력해주세요');
					return false;
				};
				if($('#radioY').is(":checked")){
				}else{
					alert('약관 동의 해주세요');
					return false;
				};
					
				
			
			
		});
		
		<!--가입하기 빈칸 있는지 정보확인js끝-->
		
		
		
	</script>
	<!--  로그인/회원가입js끝 -->