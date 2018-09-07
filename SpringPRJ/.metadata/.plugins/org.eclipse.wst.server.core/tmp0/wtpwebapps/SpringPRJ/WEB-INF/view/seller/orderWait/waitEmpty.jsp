<%@page import="poly.dto.seller.SELLER_WaitDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>

<% List<SELLER_WaitDTO> wList = (List<SELLER_WaitDTO>)request.getAttribute("wList"); %>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>board</title>
	<%@ include file="/WEB-INF/view/seller/topCssScript.jsp" %>
	
	<script type="text/javascript">
		window.setTimeout('window.location.reload()',3000);
	</script>

</head>
<body>
	<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="#333333">
			<td>
				<%@ include file="/WEB-INF/view/seller/topBody.jsp" %>
			</td>
		</tr>
		<tr bgcolor="">
			<td>
				<div class="container" style="height:100%;">
					<div id="newWaitList">
						<div style="height:10%;" class="col-sm-12">
							<div class="col-sm-6" style="margin-top:3%;"><span style="border:1px solid black; border-radius:5px 5px 5px 5px;">&nbsp;&nbsp;조리중인 주문 &nbsp;&nbsp;</span></div>
							<div class="col-sm-6" style="text-align:right; margin-top:3%;"><span style="border:1px solid black; border-radius:5px 5px 5px 5px;">&nbsp;&nbsp; 대기열 : 0 &nbsp;&nbsp; </span></div>			
						</div>
						<div class="col-sm-12" style="padding:0;">
							<div class="col-sm-8" style="background-color:#D5D5D5; height:70%;" id="waitFirst">
								<div style="background-color:white; margin-top:10%; height:20%; text-align:center;" >
									대기열이 없습니다.
								</div>
								<div style="background-color:white; margin-top:10%; height:50%; text-align:center;">메뉴 이름  : 수량 </div>
							</div>
							<div class="col-sm-4" style="height:70%;">
								<div style="height:80%;" id="waitSecond">
									대기열이 없습니다.
								</div>
								<!-- <div style="border:1px solid black; text-align:center; height:10%;">소요시간 : 10분</div> -->
							</div>
						</div>
					</div>
						<button type="button" class="btn btn-secondary col-sm-12" onclick="JavaScript:waitComplete();" style="height:15%; font-size:400%; margin-top:1%; ">완료</button>
					</div>
			</td>
		</tr>
		<tr height="7%" bgcolor="#333333">
			<td>
				<%@ include file="/WEB-INF/view/seller/bottom.jsp" %>
			
			</td>
		</tr>
	</table>
	

</body>
</html>