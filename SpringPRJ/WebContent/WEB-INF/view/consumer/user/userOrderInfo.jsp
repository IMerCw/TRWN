<%@page import="java.util.List"%>
<%@page import="poly.dto.consumer.CONSUMER_OrderInfoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	List<CONSUMER_OrderInfoDTO> oList = (List<CONSUMER_OrderInfoDTO>)request.getAttribute("oList");

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>트럭왔냠 - 주문내역</title>
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
		<div style="width:100%">
			<!-- 주문내역 넣을 곳 -->
			<table class="table table-font-size" style="border:1px solid #dddddd; width:100%; margin:0 auto;" >
					<thead>
						<tr>
							<th colspan="5"
								style="background-color: #f9f9f9; text-align: center;">주문내역</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="text-align: left;">메뉴</td>
							<td style="text-align: left;">금액</td>
							<td style="text-align: left;">수령방법</td>
							<td style="text-align: left;">결제방법</td>
							<td style="text-align: left;">주문일시</td>
						</tr>
						<%for(int i=0; i < oList.size(); i++) { %>
						<tr>
							<td style="text-align: left;"><%=oList.get(i).getMenu_name()%></td>
							<td style="text-align: left;"><%=oList.get(i).getOrd_sumprice()%></td>
							<td style="text-align: left;"><%=oList.get(i).getOrd_way()%></td>
							<td style="text-align: left;"><%=oList.get(i).getBuy_way()%></td>
							<td style="text-align: left;"><%=oList.get(i).getOrd_date()%></td>
						</tr>
						<%} %>
					</tbody>
		
				</table>
		</div>
	</div>
	

</body>
</html>