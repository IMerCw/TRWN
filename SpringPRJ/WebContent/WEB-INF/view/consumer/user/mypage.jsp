<%@page import="poly.dto.consumer.CONSUMER_UserDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	CONSUMER_UserDTO uDTO = (CONSUMER_UserDTO)request.getAttribute("uDTO");
%>


<html>
<head>
	<title>트럭왔냠 - 마이페이지</title>
	<script type="text/javascript">
		//탈퇴 여부 마지막 확인
		function userDelete(userSeq){
			r = confirm("정말로 회원 탈퇴를 하시겠습니까?");
			if(r) {
				location.href="/cmmn/user/userDelete.do?userSeq=" + userSeq;	
			}
			
		}
	</script>
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
		.table>tbody>tr>td {
			font-size:18px;
			height:60px;
		}
		#mypageMenu > div > a {
			border-bottom:1px solid #aaaaaa;
			padding:5px 10px;
		}
		#mypageMenu > div  {
			margin-bottom:12px;
		}
	</style>
</head>
<body>
<%@ include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<div class="container">
		<div id="mypageMenu" class="row" style="width:100%; text-align:center; padding:15px 0; font-size:18px;">
			<div class="col-sm-3 col-xs-6">
				<a class="nav-link active" href="/consumer/user/mypage.do">회원정보</a>
			</div>
			<div class="col-sm-3 col-xs-6">
				<a class="nav-link active" href="/consumer/user/userOrderInfo.do">주문내역</a>
			</div>
			<div class="col-sm-3 col-xs-6">
				<a class="nav-link active" href="/consumer/user/userFavoriteFt.do">관심매장</a>
			</div>
			<div class="col-sm-3 col-xs-6">
				<a class="nav-link" href="/consumer/user/userCouponList.do">쿠폰목록</a>
			</div>
		</div>
		<table class="table table-font-size" style="background:#ffffff; border:1px solid #dddddd; width:100%; margin:0 auto;" >
			<thead>
				<tr>
					<th colspan="2"
						style="background-color: #f9f9f9; text-align: center; font-size:20px;">회원목록 상세보기</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>이메일 :</td>
					<td colspan="2" style="text-align: left;"><%=uDTO.getUserEmail()%></td>
				</tr>
				<tr>
					<td>비밀번호 :</td>
					<td colspan="2" style="text-align: left;">*************</td>
				</tr>
				<tr>
					<td>닉네임 :</td>
					<td colspan="2" style="text-align: left;"><%=uDTO.getUserNick()%></td>
				</tr>
				<tr>
					<td>성별 :</td>
					<td colspan="2" style="text-align: left;"><%=uDTO.getUserGender()%></td>
				</tr>
				<tr>
					<td>핸드폰번호 :</td>
					<td colspan="2" style="text-align: left;"><%=uDTO.getUserHp()%></td>
				</tr>
			</tbody>

		</table>

		<div class="col-xs-12" style="padding-top: 16px; text-align:right;">
			<button class="btn btn-primary" style="font-size:18px;" onclick="location.href='/consumer/user/userUpdateView.do?userSeq=<%=userSeq%>'">수정하기</button>
			<button class="btn btn-danger" style="font-size:18px;" onclick="userDelete('<%=userSeq%>');">탈퇴하기</button>
		</div>
	</div>

</body>
</html>