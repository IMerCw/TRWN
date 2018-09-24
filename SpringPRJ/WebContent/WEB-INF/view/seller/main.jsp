<%@page import="poly.dto.seller.SELLER_OrderInfoDTO"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.seller.SELLER_DissInfoDTO"%>
<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	 int chart = (int)request.getAttribute("chart");
%>
<html>
	<head>
		<title>트럭왔냠 - 판매자 메인 페이지</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!-- icon -->
		<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/solid.js" integrity="sha384-+Ga2s7YBbhOD6nie0DzrZpJes+b2K1xkpKxTFFcx59QmVPaSA8c7pycsNaFwUK6l" crossorigin="anonymous"></script>
		<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/fontawesome.js" integrity="sha384-7ox8Q2yzO/uWircfojVuCQOZl+ZZBg2D2J5nkpLqzH1HY0C1dHlTKIbpRz/LG23c" crossorigin="anonymous"></script>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/seller/main.css" />
		
		<!-- chart -->
		<script src="https://www.amcharts.com/lib/3/amcharts.js?x"></script>
		<script src="https://www.amcharts.com/lib/3/serial.js?x"></script>
		<script src="https://www.amcharts.com/lib/3/themes/dark.js"></script>
	
		<!-- 트럭관리  -->
	
	<style>
	
		#chartdiv {	
	 	width		: 100%;
		height		: 500px;
		background-color: #161616;  
		}
		
		#chartdivM {
		  width: 100%;
		  height: 500px;
		  margin-left: auto;
		  margin-right: auto;
		
		  background-color: #30303d; 
		  color: #fff;
		}
		
		.amcharts-graph-g1 .amcharts-graph-fill {
		  filter: url(#blur);
		}
		
		.amcharts-graph-g2 .amcharts-graph-fill {
		  filter: url(#blur);
		}
		
		.amcharts-cursor-fill {
		  filter: url(#shadow);
		}
		
	</style>
	
	</head>
	
	<body>
	
 	<%@ include file="/WEB-INF/view/seller/top.jsp" %>
				
		<section>
			<% if(chart == 1){%>
			<div> 
				 <%@ include file="/WEB-INF/view/seller/chart.jsp" %>
			</div>
			<% }else{%>
			<div> 
				 <%@ include file="/WEB-INF/view/seller/chartNoB.jsp" %>
			</div>
			<%} %>
		</section>			

		<!-- Two -->
			<section id="two" class="wrapper style3">
				<div class="inner">
					<div id="flexgrid">
						<div>
							<header>
								<h3>푸드트럭 관리</h3>
								<p>#</p>
							</header>
							<ul class="actions">
								<li><a href="/seller/ft/truckConfig.do" class="button alt">Learn More</a></li>
							</ul>
						</div>
						<div>
							<header>
								<h3>주문대기열</h3>
							</header>
							<p>#</p>
							<ul class="actions">
								<li><a href="/seller/orderWait/orderWait.do?userSeq=<%=userSeq%>" class="button alt">Learn More</a></li>
							</ul>
						</div>
						<div>
							<header>
								<h3>지역행사정보</h3>
							</header>
							<p>#</p>
							<ul class="actions">
								<li><a href="/seller/loc/loc.do" class="button alt">Learn More</a></li>
							</ul>
						</div>
						<div>
							<header>
								<h3>주유정보</h3>
							</header>
							<p>#</p>
							<ul class="actions">
								<li><a href="/seller/gasStation/gas.do" class="button alt">Learn More</a></li>
							</ul>
						</div>
						<div>
							<header>
								<h3>상권분석</h3>
							</header>
							<p>#</p>
							<ul class="actions">
								<li><a href="/seller/ftDistrictData/ftDistrictDataMain.do" class="button alt">Learn More</a></li>
							</ul>
						</div>
						<div>
							<header>
								<h3>게시판</h3>
								
							</header>
							<p>#</p>
							<ul class="actions">
								<li><a href="/seller/board/boardList.do" class="button alt">Learn More</a></li>
							</ul>
						</div>
					</div>
				</div>
			</section>

			<!-- Footer -->
		
			<footer id="footer" class="wrapper">
					<div class="copyright">
						<h4>&copy; Copyright © <a href="#">트럭왔냠.</a>, All rights reserved.</h4>
					</div>
			</footer> 
			
			
	</body>
</html>