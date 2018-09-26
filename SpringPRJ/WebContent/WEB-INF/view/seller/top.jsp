<%@page import="poly.dto.seller.SELLER_DissInfoDTO"%>
<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userEmail = CmmUtil.nvl( (String)session.getAttribute("userEmail") );
	String userNick = CmmUtil.nvl( (String)session.getAttribute("userNick") );
	String userSeq = CmmUtil.nvl((String)session.getAttribute("userSeq"));
	String ftName = CmmUtil.nvl((String)session.getAttribute("ftName"));
	String ftSeq =  CmmUtil.nvl((String)session.getAttribute("ftSeq"));
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
		<!-- Scripts -->
		<script src="<%=request.getContextPath()%>/resources/js/seller/jquery.min.js"></script>
		<script src="<%=request.getContextPath()%>/resources/js/seller/jquery.scrolly.min.js"></script>
		<script src="<%=request.getContextPath()%>/resources/js/seller/jquery.scrollex.min.js"></script>
		
		<!-- ajax form  -->
		<script src="http://malsup.github.com/jquery.form.js"></script>
		<script src="<%=request.getContextPath()%>/resources/js/seller/skel.min.js"></script>
		<script src="<%=request.getContextPath()%>/resources/js/seller/util.js"></script>
		<script src="<%=request.getContextPath()%>/resources/js/seller/main.js"></script>

		<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/seller/main.css" />
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">		
		
		<%@ include file="/WEB-INF/view/seller/topCssScript.jsp" %>
	<!-- 	
	</head>
	<body> 
	-->

		<!-- Header -->
			<header id="header" class="alt">
				<div class="logo">
					<a href="/seller/out/inOut.do" style="font-size:34px;">
					트럭왔냠 - <%=ftName %>
						<span>
						BY TRWN
						</span>
					</a>
				</div>
				<a href="#menu" class="toggle">
					<img src="<%=request.getContextPath()%>/resources/img/seller/menu-button.png">
				</a>
			</header>
			
		<!-- Nav -->
			<nav id="menu">
				<ul class="links" style="font-size: 18px; text-align: right;">
					<li>
						<%if(!"".equals(userEmail)) { %>
							<!-- 로그인 된 상태 -->
							<b style="color:#888;"><%=userEmail + "님 환영합니다." %></b>
							<a href="/cmmn/user/logout.do" >로그아웃</a>
							<%}else{ %>
							<!-- 로그인이 안된 상태 -->
							<a href="/cmmn/main.do">로그인</a>
						<%} %>
					</li>
					<li><a href="/seller/main.do">메인 페이지</a></li>
					<li><a href="/seller/ft/truckConfig.do">내 트럭 관리</a></li>
					<li>
						<%if(!userSeq.equals("")){ %>
						<a href="/seller/orderWait/orderWait.do?userSeq=<%=userSeq%>">주문 대기열</a>
						<%}%>
					</li>
					<li>
						<a href="#">주문 목록</a>
					</li>
					<li>
						<%if(!userSeq.equals("")){ %>
						<a href="/seller/sales/sales.do?userSeq=<%=userSeq%>">매출분석</a>
						<%} %>
					</li>
					<li><a href="/seller/ftDistrictData/ftDistrictDataMain.do">상권분석</a></li>
					<li><a href="/seller/foodSafety/fdSftyMain.do">식품안전정보</a></li>
					<li><a href="/seller/gasStation/gas.do">주유정보</a></li>
					<li><a href="/seller/loc/loc.do">행사정보</a></li>
					<li><a href="/seller/board/boardList.do">게시판</a></li>
					<li><a href="/seller/out/out_info.do?userAuth=2" style="color: #d9534f;">주문 화면으로 전환</a></li>
				</ul>
			</nav>
	
			<div class="style2" style="height:80px; width:100%; background-color:#444">
			
			
			</div>
			<div class="row" style="background-color:#505050; font-size:15px; height:32px; margin:0; padding-top:4px;">
				<div class="col-sm-8" style="overflow:hidden; color:white;">
					<!-- 날씨정보 / 값 받아 온 경우 -->
					<div class="col-sm-12" style="padding-right:0;">
					<%if(!"".equals(t3hCode)) {%>
						<%if (ptyCode.equals("0")) {%>
							<img src="/resources/img/consumer/skyCode<%=skyCode%>.png" width="24px"/>
						<%} else if(!(ptyCode.isEmpty())) { %>
							<img src="/resources/img/consumer/ptyCode<%=ptyCode%>.png" width="24px"/>
						<%}%>
						<a href="/seller/weatherInfo.do?myAddress=<%=myAddress%>&regCode=<%=regCode%> "style="padding-right:15px; color:white; font-weight:bold;"><%=t3hCode %>℃</a>
					<!-- 날씨정보/ 위치 설정 되지 않은 경우 -->
					<%} else { %>
						<!-- 위치 미 설정시 날씨 정보 공백 처리 -->
					<%} %>		
					
					<!--  질병예방 공지 -->
					<span style="width: 20px; padding: 2px 6px; border-left: 1px solid #929292;"></span>
					<%if(dissInfoDTO != null){ %>
							<% String riskFigure = dissInfoDTO.getRisk(); %> 
						<% if(riskFigure.equals("1")) {%>
							  <strong style="color:sky">관심!</strong>
							  &nbsp; 식중독 발생가능성은 낮으나 식중독 예방에 지속적인 관심이 요망됩니다.
						<%} else if(riskFigure.equals("2")){ %>	
							  <strong style="color:yellow">주의!</strong>
							  &nbsp;식중독 발생가능성이 중간 단계이므로 식중독예방에 주의가 요망됩니다.
						<%} else if(riskFigure.equals("3")){%>
							  <strong style="color:orange">경고!</strong>
							  &nbsp; 식중독 발생가능성이 높으므로 식중독 예방에 경계가 요망됩니다. 
						<%} else if(riskFigure.equals("4")){ %>
							  <strong style="color:tomato">위험!</strong>
							  &nbsp;식중독 발생가능성이 매우 높으므로 식중독예방에 각별한 경계가 요망됩니다.
						<%} %>
					<%}else{ %>
					<span><img src="<%=request.getContextPath()%>/resources/img/seller/exclamation.png" width="22px"/></span>
					<span style="display:inline-block; font-size:14px;">
						<a href="/seller/weather/findMyLoc.do" style="color:white;" >
							&nbsp; 질병지수 : 위치를 설정해주세요
						</a>
					</span>
					<%} %> 
					</div>
				</div>
				<div class="col-sm-4" style="text-align:right; font-size:14px;">
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

	