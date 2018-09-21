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
	</style>
</head>
<body>
<%@ include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<div class="container">
		<div class="mypageMenu" style="text-align:center; padding:30px 0; margin-bottom:10px; border-bottom:1px solid #bebebe; font-size:14px;">
			<div class="col-xs-3">
				<a class="nav-link active" href="/consumer/user/mypage.do">회원정보</a>
			</div>
			<div class="col-xs-3">
				<a class="nav-link active" href="/consumer/user/userOrderInfo.do">주문내역</a>
			</div>
			<div class="col-xs-3">
				<a class="nav-link active" href="/consumer/user/userFavoriteFt.do">관심매장</a>
			</div>
			<div class="col-xs-3">
				<a class="nav-link" href="/consumer/user/userCouponList.do">내 쿠폰목록</a>
			</div>
		</div>
		<div>
			<!-- 	<h2>지역행사정보</h2> -->
			<table class="table table-font-size" style="border:1px solid #dddddd; width:100%; margin:0 auto;" >
				<thead>
					<tr>
						<th colspan="2"
							style="background-color: #f9f9f9; text-align: center;">회원목록 상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width:35%;">이메일 :</td>
						<td colspan="2" style="text-align: left; width:65%;"><%=uDTO.getUserEmail()%></td>
					</tr>
					<tr>
						<td style="width:35%;">비밀번호 :</td>
						<td colspan="2" style="text-align: left; width:65%;">*************</td>
					</tr>
					<tr>
						<td style="width:35%;">닉네임 :</td>
						<td colspan="2" style="text-align: left; width:65%;"><%=uDTO.getUserNick()%></td>
					</tr>
					<tr>
						<td style="width:35%;">성별 :</td>
						<td colspan="2" style="text-align: left; width:65%;"><%=uDTO.getUserGender()%></td>
					</tr>
					<tr>
						<td>핸드폰번호 :</td>
						<td colspan="2" style="text-align: left;"><%=uDTO.getUserHp()%></td>
					</tr>
				</tbody>
	
			</table>
	
			<div align="right" style="margin:10px;">
				<button class="btn btn-default" onclick="location.href='/consumer/user/userUpdateView.do?userSeq=<%=userSeq%>'">수정하기</button>
				<button class="btn btn-default" onclick="userDelete('<%=userSeq%>');">탈퇴하기</button>
			</div>

		</div>
	</div>

</body>
</html>