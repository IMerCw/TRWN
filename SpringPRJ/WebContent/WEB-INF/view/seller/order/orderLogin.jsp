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
	String userSeq = (String)request.getAttribute("userSeq");
			
%>    
<%= sum %>,<%= userSeq %>

	
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>order</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">		
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	 


</head>

<!-- //location.href="/seller/order/orderInfo.do?sum="+a+"&userSeq="+b; -->
<body>
	<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="black">
			<td>
			</td>
		</tr>
		<tr bgcolor="#EAEAEA">
			<td>
				<div class="container" style="height:90%">
				<div class="row">
			        <div class="page-header">
			          <h2>회원 로그인</h2>
			        </div>
			        <div class="">
			          <div class="login-box well">
			        <form accept-charset="UTF-8" role="form" method="post" action="">
			            <legend>로그인</legend>
			            <div class="form-group">
			                <label for="username-email">이메일 or 아이디</label>
			                <input name="user_id" value='' id="username-email" placeholder="E-mail or Username" type="text" class="form-control" />
			            </div>
			            <div class="form-group">
			                <label for="password">비밀번호</label>
			                <input name="password" id="password" value='' placeholder="Password" type="password" class="form-control" />
			            </div>
			            <div class="form-group">
			                <input type="submit" class="btn btn-default btn-login-submit btn-block m-t-md" value="Login" />
			            </div>
			            <span class='text-center'><a href="/bbs/index.php?mid=index&act=dispMemberFindAccount" class="text-sm">비밀번호 찾기</a></span>
			            <hr />
			           
			            <form>
			            
			            <legend>비회원 구매</legend>
			            </form>
			            <div>
			            	<textarea rows="8" style="width:100%; background-color:#f7f7f7; color:#b2b2b2;">
비회원정보수집 동의
비회원 개인정보보호정책은 비회원으로 주문하는 고객님의 개인정보 보호를 위하여 무신사가 실시하는 개인정보 수집의 목적과 그 정보의 정책에 관한 규정입니다.
제1조 개인정보 수집 범위
1.필수항목 : 성명, 전화번호, 휴대전화 번호, 주소, 이메일, 이메일 수신 여부 
2.선택항목 : 생년월일, 구매 상품, 상품의 사이즈
							
제2조 개인정보 수집 목적 및 이용목적
무신사((주)그랩)는 고객님께서 비회원으로 재화 혹은 용역을 주문하거나 각종 서비스를 이용하는데 있어, 원활한 주문 및 서비스 접수, 물품 배송, 대금 결제 및 편리하고 유익한 맞춤정보를 제공하기 위한 최소한의 정보를 수집합니다.
							
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
							
고객의 동의를 받아 보유하고 있는 거래정보 등을 고객께서 열람을 요구하는 경우 무신사는 지체 없이 그 정보를 열람·확인 할 수 있도록 조치합니다.
			            	
			            	</textarea>
			            </div>
			            <div class="form-group">
			                <a href="/seller/order/orderInfo.do?sum=<%=sum %>&userSeq=<%=userSeq %>" class="btn btn-default btn-block m-t-md">비회원 구매하기</a>
			            </div>
			        </form>
			          </div>
			        </div>
			      </div>
				
				</div>
			</td>
		</tr>
		<tr height="7%" bgcolor="black">
			<td>
				<%@ include file="/WEB-INF/view/seller/bottom.jsp" %>
			</td>
		</tr>
	</table>
	

</body>

</html>