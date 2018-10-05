<%@page import="poly.dto.consumer.CONSUMER_CouponIssueDTO"%>
<%@page import="poly.dto.consumer.CONSUMER_UserDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CONSUMER_UserDTO uDTO = (CONSUMER_UserDTO)request.getAttribute("uDTO");
	List<CONSUMER_CouponIssueDTO> cList = (List<CONSUMER_CouponIssueDTO>)request.getAttribute("cList");
	if(cList == null) {
		System.out.println("내 쿠폰목록 cList 들어옴 실패 in userCouponList");
	} else {
		System.out.println("내 쿠폰목록 cList 들어옴 성공 in userCouponList");
	}
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>트럭왔냠 - 내 쿠폰목록</title>
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
			text-align:center;
			height:48px;
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
		<div style="width:100%">
		<!-- 내 쿠폰목록 넣을 곳 -->
		<table class="table table-font-size" style="border:1px solid #dddddd; width:100%; margin:0 auto;" >
			<thead>
				<tr>
					<th	colspan="5" style="background-color: #f9f9f9; text-align: center; font-size:20px;">내 쿠폰 목록</th>
				</tr>
			</thead>
			<tbody>
				<tr style="font-weight:bold;">
					<td>쿠폰명</td>
					<td>내용</td>
					<td>개수</td>
					<td>쿠폰 발행일</td>
					<td>쿠폰 사용 기간</td>
				</tr>
				<%if(cList != null) { %>
					<%for(int i=0; i < cList.size(); i++) { %>
					<tr>
						<td><%=cList.get(i).getCoupon_name()%></td>
						<td><%=cList.get(i).getCoupon_count()%></td>
						<td><%=cList.get(i).getCoupon_count()%></td>
						<td><%=cList.get(i).getCoupon_issuedate()%></td>
						<td><%=cList.get(i).getCoupon_date()%></td>
					</tr>
					<%} %>
				<%} if(cList == null || cList.isEmpty()) {%>
					<tr><td colspan="5" style="font-size: 28px; text-align: center; background: #ddd; padding: 20px;">사용 가능한 쿠폰 내역이 없습니다.</td></tr>
				<%} %>
			</tbody>
	
		</table>
		</div>
	</div>

</body>
</html>