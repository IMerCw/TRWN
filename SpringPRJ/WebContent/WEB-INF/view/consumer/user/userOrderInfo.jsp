<%@page import="java.util.List"%>
<%@page import="poly.dto.consumer.CONSUMER_OrderInfoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	List<CONSUMER_OrderInfoDTO> oList = (List<CONSUMER_OrderInfoDTO>)request.getAttribute("oList");
	/* List<CONSUMER_OrderInfoDTO> oListM = (List<CONSUMER_OrderInfoDTO>)request.getAttribute("oListM"); */

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
	
	<script>
		function orderDetail(i) {	//i는 숫자임
			
			var j=0;
			var sum = j + i;
			alert(sum);
			var menu = "";
			menu = <%=oList.get(0).getMenu_name()%>;
			alert("menu : " + menu);
		}
		
	</script>
	
	<script>//주문모달 실패했음..
		<%-- function oListModal(){
    		var menu = $('#menu').val();
    		var price = $('#price').val();
    		var ordWay	 = $('#ordWay').val();
    		var buyWay	 = $('#buyWay').val();
    		var ordDate	 = $('#ordDate').val();
    		var amnt = $('#amnt').val();
    		
    		$.ajax({
    			type:'post',
    			/* url: "/consumer/user/userOrderInfo.do", */
    			data: {
    				/* 'content':content,
    				'boardPSeq':boardPSeq,
    				'userSeq':userSeq */<%=oList%>
    			},
    			success: function(data) {
    				console.log(data);
    				var contents ='';
                    
                    $.each(data,function (key,value){	//value.userSeq
                    	contents += "<div class='modal fade' id='myModal' tabindex=''-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>";
                		contents += "<div class='modal-dialog'><div class='modal-content'><div class='modal-header'><button type='button' class='close' data-dismiss='modal' aria-label='Close'>";
                		contents +=				"<span aria-hidden='true'>&times;</span></button><h4 class='modal-title' id='myModalLabel'>주문내역</h4></div>";
                		contents +=		"<div class='modal-body'>고객님께서" + value.menu + "메뉴"  + value.amnt + "개 주문하셨습니다.</div>";
                		contents += "<div class='modal-footer'><button type='button' class='btn btn-default'>보러가기</button><button type='button' class='btn btn-default' data-dismiss='modal'>닫기</button>";
                		contents +=		"</div></div></div></div>";
                     });
					$('#ListAjax').html(contents);
    			},  
    			error : function(error) {
    	            alert("error : " + error);
    	        
    			}
    			
    		})
    	
		} --%>
		
	</script>
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
							<th colspan="5" style="background-color: #f9f9f9; text-align: center;">주문내역</th>
						</tr>
						<tr>
							<td style="text-align: left;">메뉴</td>
							<td style="text-align: left;">금액</td>
							<td style="text-align: left;">수령방법</td>
							<td style="text-align: left;">결제방법</td>
							<td style="text-align: left;">주문일시</td>
						</tr>
					</thead>
					<%-- <tbody onclick="oListModal();" id="ListAjax">
						
						<%for(int i=0; i < oList.size(); i++) { %>
							<tr data-toggle="modal" data-target="#myModal">
								<td style="text-align: left;" id="menu"><%=oList.get(i).getMenu_name()%></td>
								<td style="text-align: left;" id="price"><%=oList.get(i).getOrd_sumprice()%></td>
								<td style="text-align: left;" id="ordWay"><%=oList.get(i).getOrd_way()%></td>
								<td style="text-align: left;" id="buyWay"><%=oList.get(i).getBuy_way()%></td>
								<td style="text-align: left;" id="ordDate"><%=oList.get(i).getOrd_date()%></td>
								<td style="text-align: left; width:0px" id="amnt"><%=oList.get(i).getOrd_amnt() %></td>
							</tr>
							
						<%} %>
					</tbody> --%>
					
					<tbody>
						
						<%for(int i=0; i < oList.size(); i++) { %>
							<tr data-toggle="modal" data-target="#myModal<%=i %>" <%-- onclick="orderDetail(<%=i%>);" --%>>
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
	
	
	<!-- 주문내역 상세보기 모달 -->
	<!-- Button trigger modal -->
	<!-- <button type="button" class="btn btn-default btn-lg"
		data-toggle="modal" data-target="#myModal">내 주문내역</button> -->

	<!-- Modal -->
	<%for(int i=0; i < oList.size(); i++) { %>
		<div class="modal fade" id="myModal<%=i %>" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">주문내역</h4>
					</div>
					<div class="modal-body">고객님께서 <%=oList.get(i).getMenu_name() %> 메뉴 <%=oList.get(i).getOrd_amnt() %>개 주문하셨습니다.</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default">보러가기</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	<%} %>

</body>
</html>