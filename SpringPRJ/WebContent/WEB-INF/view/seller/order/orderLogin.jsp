<%@page import="poly.dto.cmmn.CMMN_UserDTO"%>
<%@page import="java.io.Console"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String sum = (String)request.getAttribute("sum");
	String ftSeq = (String) request.getAttribute("ftSeq");
%>    
<%-- <%= sum %>,<%= userSeq %>--%> <%-- 파라미터 확인 --%>
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>트럭왔냠 - 로그인</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">		
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" rel="stylesheet"> <%-- 구글 웹 폰트 --%>
<style>
		body {
			font-family: 'Noto Sans KR', sans-serif;
		}
	</style>
<script>
$(document).ready(function(){
	$('#sumbitBtn').click(function(){
		var email = $('#username-email').val();
		
		//alert(email);
		var pwd = $('#password').val();
		//alert(pwd);
		if(email == ""){
			alert("이메일을 입력해주세요 ");
			return false;
		}
		if(pwd == ""){
			alert("패스워드를 입력해주세요");
			return false;
		}
		var sum = <%=sum%>;
		
		$.ajax({
			url: "/seller/order/LoginOrder.do",
			data: {
				"email" : email,
				"pwd" : pwd
			},
			method: "post",
			success : function(data){
				console.log(data);
				console.log(data.userSeq);
				if(data.userAuth == '-1') {
					alert("로그인에 실패하였습니다. 아이디 및 비밀번호를 확인해 주세요.");
				} 
				else if(data != null){
					console.log(" data != null")
					// form 생성
					var form = document.createElement("form");     
					
					form.setAttribute("method","post");                    
					form.setAttribute("action","/seller/order/orderInfo.do");        
					
					document.body.appendChild(form);                        
					
					//input 생성
					var input_id = document.createElement("input");  
					
					input_id.setAttribute("type", "hidden");                 
					input_id.setAttribute("name", "sum");                        
					input_id.setAttribute("value", sum);                          
					
					form.appendChild(input_id);
					
					//input 생성
					var input_id2 = document.createElement("input");  
					
					input_id2.setAttribute("type", "hidden");                 
					input_id2.setAttribute("name", "userSeq");                        
					input_id2.setAttribute("value", +data.userSeq);                          
					
					form.appendChild(input_id2);
					
					//input 생성
					var input_id3 = document.createElement("input");  
					
					input_id3.setAttribute("type", "hidden");                 
					input_id3.setAttribute("name", "ftSeq");                        
					input_id3.setAttribute("value", <%=ftSeq%>);                          
					
					form.appendChild(input_id3);
					
					//폼전송
					
					form.submit();  
 
					
				}
			}
			
		}) 
		
	});
})



</script>

</head>

<body>
	<div class="container" style="height:90%">
		<div class="row">
	        <div class="page-header" style="margin: 5px 0 15px; padding:5px;">
	          <h2 style="margin-top:12px;">회원 로그인</h2>
	        </div>
	        <div class="">
	          <div class="login-box well">
	        <form accept-charset="UTF-8" role="form" method="post" action="/seller/order/orderInfo.do">
	            <h3 style="margin-top: 0px; margin-bottom: 20px;">회원 구매</h3>
	            <div class="form-group">
	                <label for="username-email">이메일 or 아이디</label>
	                <input name="user_id" value='' id="username-email" placeholder="E-mail or Username" type="text" class="form-control" />
	            </div>
	            <div class="form-group">
	                <label for="password">비밀번호</label>
	                <input name="password" id="password" value='' placeholder="Password" type="password" class="form-control" />
	            </div>
	            <div class="form-group">
	                <button type="button" 
	                	class="btn btn-default btn-login-submit btn-block m-t-md" 
	                	value="Login" id="sumbitBtn" style="font-size:20px;">로그인</button>
	            </div>
	           <!--  <span class='text-center'><a href="#" class="text-sm">비밀번호 찾기</a></span> -->
	            <hr />
	           
			</form>
			
	            <h3 style="margin-top: 10px; margin-bottom: 20px;">비회원 구매</h3>
	            <div>
	            	<textarea rows="8" style="width:100%; background-color:#f7f7f7; color:#b2b2b2;">
비회원정보수집 동의
비회원 개인정보보호정책은 비회원으로 주문하는 고객님의 개인정보 보호를 위하여 트럭왔냠이 실시하는 개인정보 수집의 목적과 그 정보의 정책에 관한 규정입니다.
제1조 개인정보 수집 범위
1.필수항목 : 성명, 전화번호, 휴대전화 번호, 주소, 이메일, 이메일 수신 여부 
2.선택항목 : 생년월일, 구매 상품, 상품의 사이즈
							
제2조 개인정보 수집 목적 및 이용목적
트럭왔냠은 고객님께서 비회원으로 재화 혹은 용역을 주문하거나 각종 서비스를 이용하는데 있어, 원활한 주문 및 서비스 접수, 물품 배송, 대금 결제 및 편리하고 유익한 맞춤정보를 제공하기 위한 최소한의 정보를 수집합니다.
							
1.e-mail, 전화번호 : 고지의 전달. 불만처리나 주문/배송정보 안내 등 원활한 의사소통 경로의 확보. 
2.성명, 주소 : 고지의 전달, 청구서, 정확한 상품 배송지의 확보.
3.은행계좌번호, 신용카드번호: 유료정보에 대한 이용 및 상품구매에 대한 결제
4.전화번호, 휴대전화번호 : 상품구매 전/후 만족도조사, 회원가입권유(포인트 또는 적립금 지급 등)및 영업 목적 전화 및 SMS발송

비회원주문시 제공하신 모든 정보는 상기 목적에 필요한 용도 이외로는 사용되지 않습니다.
단, 이용자의 기본적 인권 침해의 우려가 있는 민감한 개인정보(인종 및 민족, 사상 및 종교, 출신지 및 본적지, 정치적 성향 및 범죄기록, 건강상태 등)는 수집하지 않습니다.
							
제3조 개인정보의 보유기간 및 이용기간
고객의 개인정보는 다음과 같이 개인정보의 수집목적 또는 제공받은 목적이 달성되면 파기됩니다. 단, 상법 등 관련법령의 규정에 의하여 다음과 같이 거래 관련 권리 의무 관계의 확인 등을 이유로 일정기간 보유하여야 할 필요가 있을 경우에는 일정기간 보유합니다. 
1.계약 또는 청약철회 등에 관한 기록 : 5년
2.대금결제 및 재화등의 공급에 관한 기록 : 5년
3.소비자의 불만 또는 분쟁처리에 관한 기록 : 3년
							
고객의 동의를 받아 보유하고 있는 거래정보 등을 고객께서 열람을 요구하는 경우 트럭왔냠은 지체 없이 그 정보를 열람·확인 할 수 있도록 조치합니다.
		         	</textarea>
	            </div>
	            <form action="/seller/order/orderInfo_nmmbr.do" method="POST" id="nmbrForm">
	            	<input type="hidden" value="<%=sum%>" name="sum"/>
	            	<input type="hidden" value="<%=ftSeq%>" name="ftSeq"/>
	            	<div class="form-group" style="margin-top:16px;">
						<label for="usr">주문하시는 분의 성함</label>
						<input type="text"  placeholder="이름" class="form-control" name="cstmrName">
					</div>
					<div class="form-group">
						<label for="pwd">연락 받을 수 있는 휴대전화</label>
						<input type="text" placeholder="휴대전화" class="form-control" name="cstmrPhn">
					</div>
		            <div class="form-group" style="margin-top: 20px; ">
		                <button type="button" onclick="nmbrSubmit()"
		                	class="btn btn-default btn-block m-t-md" style="font-size:20px;">비회원 구매하기</button>
		            </div>
	           	</form>
	          </div>
	        </div>
	      </div>
	</div>
</body>
<script>
	
	function nmbrSubmit() {
		if($('input[name=cstmrName]').val() == '') {
			alert("성함을 입력해주세요.");
			return false;
		}
		if($('input[name=cstmrPhn]').val() == '') {
			alert("휴대전화를 입력해주세요.");
			return false;
		}
		
		$('#nmbrForm').submit();
	}
		
</script>
</html>