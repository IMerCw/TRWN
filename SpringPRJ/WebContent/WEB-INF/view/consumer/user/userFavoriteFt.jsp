<%@page import="poly.dto.consumer.CONSUMER_FtLikeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	List<CONSUMER_FtLikeDTO> fList = (List<CONSUMER_FtLikeDTO>)request.getAttribute("fList");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>트럭왔냠 - 관심매장</title>
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
		<!-- 관심매장 넣을 곳 -->
		<table class="table table-font-size" style="border:1px solid #dddddd; width:100%; margin:0 auto;" >
			<thead>
				<tr>
					<th	colspan="3" style="background-color: #f9f9f9; text-align: center; font-size:20px;">관심매장 목록</th>
				</tr>
			</thead>
			<tbody>
			
				<tr style="font-weight:bold;">
					<td>푸드트럭명</td>
					<td>관심매장등록일</td>
				</tr>
				
				<%for(int i=0; i < fList.size(); i++) { %>
				<tr>
					<td><%=fList.get(i).getFt_name()%></td>
					<td><%=fList.get(i).getLike_regdate()%></td>
				</tr>
				<%} %>
			</tbody>

		</table>
	</div>

</body>
</html>