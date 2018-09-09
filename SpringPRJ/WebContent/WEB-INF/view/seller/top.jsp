<%@page import="poly.dto.seller.SELLER_DissInfoDTO"%>
<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userEmail = CmmUtil.nvl( (String)session.getAttribute("userEmail") );
	String userNick = CmmUtil.nvl( (String)session.getAttribute("userNick") );
	String userSeq = CmmUtil.nvl((String)session.getAttribute("userSeq"));
	
	//nvl 널값이 들어오면 공백으로 바꿔줍니다.
	
	
	//위치정보 세션
	String myLat = CmmUtil.nvl((String)session.getAttribute("myLat"));	// 위도
	String myLon = CmmUtil.nvl((String)session.getAttribute("myLon"));	// 경도
	String myAddress = CmmUtil.nvl((String)session.getAttribute("myAddress")); // 내 주소 (지번)
	String regCode = CmmUtil.nvl((String)session.getAttribute("regCode"));	//지역코드 - 질병예방API용
	String skyCode = CmmUtil.nvl((String)session.getAttribute("skyCode"));  //skyCode 하늘상태(맑음:1, 구름조금:2, 구름많음:3, 흐림:4)
	String ptyCode = CmmUtil.nvl((String)session.getAttribute("ptyCode"));	//ptyCode 강수형태(없음:0, 비:1, 비/눈:2, 눈:3)
	String t3hCode = CmmUtil.nvl((String)session.getAttribute("t3hCode"));	//t3hCode 3시간 동안의 기온(단위 ℃)
	//nvl 널값이 들어오면 공백으로 바꿔줍니다.
	//식중독 위럼지수
	SELLER_DissInfoDTO dissInfoDTO = (SELLER_DissInfoDTO)session.getAttribute("dissInfoDTO");

%>
<% if(userSeq == null){ %>
<script>
	location.href="/cmmn/main.do";
</script>
<%}%>

	<!-- <script>
	function logout(){
		location.href="/user/logout.do";
	}
	</script> -->
	
		
	
	<!-- Scripts -->
		<script src="<%=request.getContextPath()%>/resources/js/seller/jquery.min.js"></script>
		<script src="<%=request.getContextPath()%>/resources/js/seller/jquery.scrolly.min.js"></script>
		<script src="<%=request.getContextPath()%>/resources/js/seller/jquery.scrollex.min.js"></script>
		
		<!-- ajax form  -->
		<script src="http://malsup.github.com/jquery.form.js"></script>

		<script src="<%=request.getContextPath()%>/resources/js/seller/skel.min.js"></script>
		<script src="<%=request.getContextPath()%>/resources/js/seller/util.js"></script>
		<script src="<%=request.getContextPath()%>/resources/js/seller/main.js"></script>
		
		<!-- icon -->
		<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/solid.js" integrity="sha384-+Ga2s7YBbhOD6nie0DzrZpJes+b2K1xkpKxTFFcx59QmVPaSA8c7pycsNaFwUK6l" crossorigin="anonymous"></script>
		<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/fontawesome.js" integrity="sha384-7ox8Q2yzO/uWircfojVuCQOZl+ZZBg2D2J5nkpLqzH1HY0C1dHlTKIbpRz/LG23c" crossorigin="anonymous"></script>

		<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/seller/main.css" />
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">		
		

	<!-- 	
	</head>
	<body> 
	-->

		<!-- Header -->
			<header id="header" class="alt">
				<div class="logo" style="backgournd-color:black">
					<a href="/seller/out/inOut.do">
					트럭왔냠 
						<span>
						BY TRWN
						</span>
					</a>
				</div>
				<a href="#menu" class="toggle"><span>Menu</span></a>
			</header>

		<!-- Nav -->
			<nav id="menu">
				<ul class="links">
					<li>
						<%if(!"".equals(userEmail)) { %>
							<!-- 로그인 된 상태 -->
								<b><%=userEmail + "님 환영합니다." %></b>
								<a href="Javascript:logout();" >로그아웃</a>
							<%}else{ %>
							<!-- 로그인이 안된 상태 -->
							<a href="/cmmn/main.do">로그인</a>
						<%} %>
					</li>
					<li><a href="JavaScript:truckConfig()">내 트럭 관리</a></li>
					<li>
						<%if(!userSeq.equals("")){ %>
						<a href=/seller/orderWait/orderWait.do?userSeq=<%=userSeq%>">주문 대기열</a>
						<%}%>
					</li>
					<li>
						<%if(!userSeq.equals("")){ %>
						<a href="/seller/sales/sales.do?userSeq=<%=userSeq%>">매출분석</a>
						<%} %>
					</li>
					<li><a href="/seller/ftDistrictData/ftDistrictDataMain.do">상권분석</a></li>
					<li><a href="/seller/gasStation/gas.do">주유정보</a></li>
					<li><a href="/seller/loc/loc.do">행사정보</a></li>
					<li><a href="/seller/board/boardList.do">게시판</a></li>
				</ul>
			</nav>

	
			<div class="style2" style="height:80px; width:100%; background-color:#444">
			
			
			</div>
			<div style="background-color:#505050" class="col-sm-12">
				<div class="col-sm-6">
					<!-- 날씨정보 / 값 받아 온 경우 -->
					<%if(!"".equals(t3hCode)) {%>
						<%if (ptyCode.equals("0")) {%>
							<img src="/resources/img/consumer/skyCode<%=skyCode%>.png" />
						<%} else if(!(ptyCode.isEmpty())) { %>
							<img src="/resources/img/consumer/ptyCode<%=ptyCode%>.png" />
						<%}%>
						<a href="/seller/weatherInfo.do?myAddress=<%=myAddress%>&regCode=<%=regCode%> "style="color:white;"><%=t3hCode %>℃</a>				
					<!-- 날씨정보/ 위치 설정 되지 않은 경우 -->
					<%} else { %>
						<!-- 위치 미 설정시 날씨 정보 공백 처리 -->
					<%} %>		
					
					<!--  질병예방 공지 -->
					<div id = top_notice style="color:white;">
						
						 <%if(dissInfoDTO != null){ %>
					  		<% String riskFigure = dissInfoDTO.getRisk(); %> 
							<% if(riskFigure.equals("1")) {%>
									<div >
									  <strong style="color:sky">관심!</strong>
									  &nbsp;&nbsp;&nbsp; 식중독 발생가능성은 낮으나 식중독 예방에 지속적인 관심이 요망됩니다.
									</div>
							<%} else if(riskFigure.equals("2")){ %>	
									<div >
									  <strong style="color:yellow">주의!</strong>
									  &nbsp;&nbsp;&nbsp;식중독 발생가능성이 중간 단계이므로 식중독예방에 주의가 요망됩니다.
									</div>
							<%} else if(riskFigure.equals("3")){%>
									<div >
									  <strong style="color:orange">경고!</strong> 
									  &nbsp;&nbsp;&nbsp; 식중독 발생가능성이 높으므로 식중독 예방에 경계가 요망됩니다. 
									</div>
							<%} else if(riskFigure.equals("4")){ %>
									<div >
									  <strong style="color:tomato">위험!</strong>
									  &nbsp;&nbsp;&nbsp;식중독 발생가능성이 매우 높으므로 식중독예방에 각별한 경계가 요망됩니다.
									</div>
							<%} %>
						<%}else{ %>
							<a href="/seller/weather/findMyLoc.do" style="color:white;">
								<p>&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-exclamation-sign"></span>  질병지수 : 위치를 설정해주세요 </p>
							</a>
						<%} %> 
					</div>
				</div>
				<div style="text-align:right">
					
						<!-- 위치정보 있을 경우-->
						<img src="/resources/img/consumer/mapMarker.png" style="height:12px; margin-bottom:2px; margin-right:3px"/>
						<a id="myLocLink" href="/consumer/cnsmr/findMyLoc.do"></a>
						<%if(!"".equals(myAddress)) {%>
							<a href="/seller/weather/findMyLoc.do" style="color:white;"><%=myAddress%></a>
						<!-- 좌표에서 주소변환을 위한 스크립트 끝 -->
						<!-- 위치정보 없을 경우 -->
						<%} else{ %>
							<a href="/seller/weather/findMyLoc.do" style="color:white;">위치를 설정해 주세요.</a>
						<%} %>
						&nbsp;&nbsp;
					
				</div>
			</div>
