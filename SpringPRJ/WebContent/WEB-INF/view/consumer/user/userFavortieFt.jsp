<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>트럭왔냠 - 관심매장</title>
	<style>
		.mypageMenu > div {
			padding: 0px;
		}
	</style>
</head>
<body>
<%@ include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<div class="container" style="width:90%;">
		<div class="row mypageMenu" style="text-align:center; padding:15px 0; margin-bottom:10px; border-bottom:1px solid #bebebe; font-size:14px;">
			<div class="col-xs-3">
				<a class="nav-link active" href="/consumer/user/mypage.do">회원정보</a>
			</div>
			<div class="col-xs-3">
				<a class="nav-link active" href="/consumer/user/userOrderInfo.do">주문내역</a>
			</div>
			<div class="col-xs-3">
				<a class="nav-link active" href="/consumer/user/userFavortieFt.do">관심매장</a>
			</div>
			<div class="col-xs-3">
				<a class="nav-link" href="/consumer/user/userCouponList.do">내 쿠폰목록</a>
			</div>
		</div>
		<div style="width:100%">
			<!-- 관심매장 넣을 곳 -->
			<table class="table table-striped" style="border: 1px solid #dddddd; width:90%; margin: 0 auto;" >
					<thead>
						<tr>
							<th colspan="5"
								style="background-color: #eeeeee; text-align: center;">내 쿠폰목록</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="text-align: left;">쿠폰코드</td>
							<td style="text-align: left;">쿠폰명</td>
							<td style="text-align: left;">내용</td>
							<td style="text-align: left;">개수</td>
							<td style="text-align: left;">쿠폰발행일</td>
						</tr>
						<%-- <%for(int i=0; i < cList.size(); i++) { %>
						<tr>
							<td style="text-align: left;"><%=cList.get(i).getCoupon_code()%></td>
							<td style="text-align: left;"><%=cList.get(i).getCoupon_name()%></td>
							<td style="text-align: left;"><%=cList.get(i).getCoupon_count()%></td>
							<td style="text-align: left;"><%=cList.get(i).getCoupon_count()%></td>
							<td style="text-align: left;"><%=cList.get(i).getCoupon_issuedate()%></td>
						</tr>
						<%} %> --%>
					</tbody>
		
				</table>
		</div>
	</div>

</body>
</html>