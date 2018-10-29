<%@page import="java.util.List"%>
<%@page import="poly.dto.consumer.CONSUMER_OrderInfoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%>
<%
	List<CONSUMER_OrderInfoDTO> oList = (List<CONSUMER_OrderInfoDTO>)request.getAttribute("oList");
	DecimalFormat df = new DecimalFormat("#,##0"); //자릿수 콤마 만들어주는 객체
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
		
		.orderInfo > .row{
			font-size:14px; padding:4px 0;
		}
		.orderInfo > .row > div:first-child {
			font-weight:bold;
		}
	</style>
	
</head>
<body>
	<%@ include file="/WEB-INF/view/consumer/topBody.jsp"%>
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
		
		
		<div class="row">
			<div class="col-xs-12" style="background-color:#f9f9f9; border-bottom: 2px solid #ddd; border-top: 1px solid #dddddd; 
				text-align:center; font-size:20px; padding:10px 0; font-weight:bold;">주문 내역</div>
		</div>
		<%if(oList != null) {%>
			<%for(int i=0; i < oList.size(); i++) { %>
				<div class="container orderInfo" style="margin-top:10px; background-color:#eeeeee; border-radius:10px 10px 0 0;">
					<div class="row">
						<div class="col-xs-3">푸드트럭</div>
						<div class="col-xs-9"><%=oList.get(i).getFt_name()%></div>
					</div>
					<div class="row">
						<div class="col-xs-3">주문 금액</div>
						<div class="col-xs-9"><%=df.format(oList.get(i).getOrd_sumprice())%> 원</div>
					</div>
					<div class="row">
						<div class="col-xs-3">수령 방법</div>
						<div class="col-xs-9"><%= ("-1".equals(oList.get(i).getOrd_way()) ? "직접" : "배달")%></div>
					</div>
					<div class="row">
						<div class="col-xs-3">주문 일시</div>
						<div class="col-xs-9"><%=oList.get(i).getOrd_date()%></div>
					</div>
					<!-- 상세 내역 보기 내용 -->
				</div>
				<%-- 주문 메뉴 SPLIT --%>
				<% String []ordHis = oList.get(i).getOrd_his().split("-"); %>
				
				<div class="container orderInfo" id="orderInfoDetail<%=i%>" style="background-color:#ccc; border-radius:0 0 10px 10px; display:none;">
				<div class="row">
					<div class="col-xs-12" style="text-align:center; border-bottom: 1px solid #ddd;">주문 메뉴</div>
				</div>
				<%for(String ordItm : ordHis) {%>
					<div class="row">
						<div class="col-xs-3">메뉴 명</div>
						<div class="col-xs-3"><%=ordItm.split(":")[0]%></div>
						<div class="col-xs-3" style="font-weight:bold;">수량</div>
						<div class="col-xs-3"><%=ordItm.split(":")[1]%></div>
					</div>					
				<%} %>
					<div class="row">
						<div class="col-xs-3">결제 방법</div>
						<div class="col-xs-9"><%="P".equals(oList.get(i).getBuy_way())? "휴대폰 결제" : "계좌 이체" %></div>
					</div>					
					<div class="row">
						<div class="col-xs-3">배달 위치</div>
						<div class="col-xs-9"><%= (oList.get(i).getAddress()).split(",")[0]%></div>
					</div>
					<div class="row">
						<div class="col-xs-3"></div>
						<div class="col-xs-9"><%= (oList.get(i).getAddress()).split(",")[1]%></div>
					</div>				
				</div>
				<div class="row">
					<div class="col-xs-12">
						<button type="button" id="ordBttn<%=i%>" onClick="javascript:getDetailOrder(<%=i%>);"
							class="btn btn-primary" style="margin:10px 0; font-size:16px; width:100%;">상세 주문 내역 보기</button>
					</div>
				</div>
			<%} %>
		<%}if(oList.isEmpty()) { %>
			<div class="col-xs-12" style="font-size: 28px; text-align: center; background: #ddd; padding: 20px;">주문 내역이 없습니다.</div>
		<%} %>

						
		
	</div>

	
<script>
function getDetailOrder(i) {
	if ($('#orderInfoDetail'+i).css('display') == 'none' ){
		$('#orderInfoDetail'+i).css('display','');
		$('#ordBttn'+i).html('상세 주문 내역 닫기');
	} else {
		$('#orderInfoDetail'+i).css('display','none');
		$('#ordBttn'+i).html('상세 주문 내역 보기');
	}
}
</script>

</body>
</html>