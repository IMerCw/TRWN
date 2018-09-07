<%@page import="poly.dto.consumer.CONSUMER_CouponIssueDTO"%>
<%@page import="poly.dto.consumer.CONSUMER_UserDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	CONSUMER_UserDTO uDTO = (CONSUMER_UserDTO)request.getAttribute("uDTO");
	List<CONSUMER_CouponIssueDTO> cList = (List<CONSUMER_CouponIssueDTO>)request.getAttribute("cList");
%>


<html>
<head>
	<title>userDetail</title>
	<%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %>
	<script type="text/javascript">
		function userDelete(userSeq){
			location.href="/cmmn/user/userDelete.do?userSeq=" + userSeq;
		}
	</script>
			
</head>
<body>
	<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<table style="height: 100%; margin: 0 auto;">
		<tr>
			<td>
				<div class="container">
					<ul class="nav nav-tabs row">
						<li class="nav-item col-sm-3" style="text-align:center"><a class="nav-link active" href="/consumer/user/mypage.do?userEmail=<%=userEmail%>&userSeq=<%=userSeq %>">회원정보</a></li>
						<li class="nav-item col-sm-3" style="text-align:center"><a class="nav-link" href="#">주문내역</a></li>
						<li class="nav-item col-sm-3" style="text-align:center"><a class="nav-link" href="#">결제내역</a></li>
						<li class="nav-item col-sm-3" style="text-align:center"><a class="nav-link" href="/consumer/coupon/mycoupon.do?userEmail=<%=userEmail%>&userSeq=<%=userSeq %>">내 쿠폰목록</a></li>
					</ul>
				</div>
			</td>
		</tr>
		<tr bgcolor="">
			<td>
				<div class="container" style="height: 100%; margin: 0 auto;">
					<table class="table table-striped" id="boardList">
						<thead>
							<tr>
								<th style="text-align:center;">쿠폰고유번호</th> 
								<th style="text-align:center;">쿠폰명</th>
								<th style="text-align:center;">수량</th>
								<th style="text-align:center;">발행일</th>
							</tr>
						</thead>
						<tbody>
							<%for (int i = 0; i < cList.size(); i++) {%>
							<tr>
								<td style="text-align:center;"><%=cList.get(i).getCoupon_code() %></td>
								<td class="ellipsis" style="text-align:center;"><%=cList.get(i).getCoupon_name() %></td>			
								<td style="text-align:center;"><%=cList.get(i).getCoupon_count() %></td>
								<td style="text-align:center; "><%=cList.get(i).getCoupon_issuedate() %></td>
							</tr>
							<%}%>
						</tbody>
					</table>
				</div>
			</td>
		</tr>
	</table>

</body>
</html>