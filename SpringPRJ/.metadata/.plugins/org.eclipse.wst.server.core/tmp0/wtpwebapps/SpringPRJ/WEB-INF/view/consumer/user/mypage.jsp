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
	<%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %>
	<script type="text/javascript">
		function userDelete(userSeq){
			location.href="/cmmn/user/userDelete.do?userSeq=" + userSeq;
		}
	</script>
	
</head>
<body>
<%@ include file="/WEB-INF/view/consumer/topBody.jsp" %>
				<div class="container" style="width:90%; padding:15px 0;">
					<div class="row" style="text-align:center;">
						<div class="col-sm-2">
							<a class="nav-link active" href="/consumer/user/mypage.do?userEmail=<%=userEmail%>&userSeq=<%=userSeq %>">회원 정보</a>
						</div>
						<div class="col-sm-2">
							주문 내역
						</div>
						<div class="col-sm-2">
							결제 내역
						</div>
						<div class="col-sm-2">
							관심 매장
						</div>
						<div class="col-sm-2">
							<a class="nav-link" href="/consumer/coupon/mycoupon.do?userEmail=<%=userEmail%>&userSeq=<%=userSeq %>">내 쿠폰목록</a>
						</div>
						<div class="col-sm-2">
							문의 내역
						</div>
					</div>
				</div>
				<div class="container" style="height: 100%">
					<!-- 	<h2>지역행사정보</h2> -->
					<div class="row" id="userDetailAjax" style="margin:0;">
						<table class="table table-striped" style="border: 1px solid #dddddd; width:90%; margin: 0 auto;" >
							<thead>
								<tr>
									<th colspan="3"
										style="background-color: #eeeeee; text-align: center;">회원목록 상세보기</th>
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

						<div align="right" style="width:90%; padding:15px 0;">

							<button class="btn btn-danger" onclick="userDelete('<%=uDTO.getUserSeq()%>');">탈퇴하기</button>
							<button class="btn btn-primary" onclick="location.herf='/consumer/user/userUpdateView.do?userSeq=<%=uDTO.getUserSeq()%>'">수정하기</button>

						</div>
						
					</div>
				</div>

</body>
</html>