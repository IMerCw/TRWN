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
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" rel="stylesheet"><%--구글 웹 폰트 --%>
<style>
	* {
		font-family: 'Noto Sans KR', sans-serif;
		margin: 0 auto;
	}
</style>
<%}%>
		<div class="top topSecondContainer">
			
			<div class="navigation" style="color:white;">
			<!--------------------------메뉴부분 시작 -------------------------->
				<!-- <div class="menuButton" style="float:left"><span style="font-size:50px;cursor:pointer" onclick="openNav()">&#9776;</span></div> -->
				<div class="menuButton" >
					<span style="font-size:30px;cursor:pointer" onclick="openNav()">
						<img src="/resources/img/consumer/menu48x48.png" height="42px" style="margin-top:8px; margin-left:5px;"/>
					</span>
				</div>
				
				<!--------------------------최상단 날씨,위치정보 -------------------------->
				<div id="nav_top" >
					<div id="nav_top_left" class="nav_top">
						<!-- <h3><span class="glyphicon glyphicon-cloud"></span>&nbsp;&nbsp;22°C</h3> -->
						
					</div>
					<div id="nav_top_right" class="nav_top">
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
					</div>
				</div>
		
		
			 <div id="mySidenav" class="sidenav">
					<div id="sidenav_inner">
						<div><a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a></div>
						<div>
							<%if(!"".equals(userEmail)) { %>
							<!-- 로그인 된 상태 -->
								<b><%=userEmail + "님 환영합니다." %></b>
								<!-- <button onclick="logout();">로그아웃</button> -->
								<a href="Javascript:logout();" >로그아웃</a>
							<%}else{ %>
							<!-- 로그인이 안된 상태 -->
							<a href="/cmmn/main.do">로그인</a>
							<%} %>
						</div>
						
						<div><a href="JavaScript:truckConfig()">내 트럭 관리</a></div>
						<%if(!userSeq.equals("")){ %>
						<div><a href=/seller/orderWait/orderWait.do?userSeq=<%=userSeq%>">주문 대기열</a></div>
						<%}%>
						<%if(!userSeq.equals("")){ %>
						<div><a href="/seller/sales/sales.do?userSeq=<%=userSeq%>">매출분석</a></div>
						<%} %>
						<div><a href="/seller/ftDistrictData/ftDistrictDataMain.do">상권분석</a></div>
						<div><a href="/seller/gasStation/gas.do">주유정보</a></div>
						<div><a href="/seller/loc/loc.do">행사정보</a></div>
						
						<div><a href="/seller/board/boardList.do">게시판</a></div>
					</div>
				</div>
				<div id="sidenav_outer" onclick="closeNav()"></div>
				
				 <%-- <div id="logo_main" style="clear:both">
				 	<a href="/seller/out/inOut.do">
				 		<img src="/resources/img/trwn/seller_logo160x89.png" width="100%"/>
				 	</a>
				 </div> 
				 <!--------------------------메뉴부분 시작 -------------------------->
			
			<div id="mySidenav" class="sidenav">
				<div id="sidenav_inner">
					<div>
						<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/cancel.png" />
						<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">닫기</a>
					</div>
					<div>
						<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/logout.png" />
						<%if(!"".equals(userEmail) && !"".equals(userSeq) && !"".equals(userNick)) { %>
							<!-- 로그인 된 상태 -->
							<a href="Javascript:logout();" >로그아웃</a>
								
						<%}else{ %>
							<!-- 로그인이 안된 상태 -->
							<a href="/cmmn/main.do">로그인</a>
						<%} %>
					</div>
					<div>
						<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/set_location.png" />
						<a href="/consumer/cnsmr/findMyLoc.do">내 위치 설정</a>
					</div>		
					<div>
						<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/adjacent_ft.png" />
						<a href="/consumer/cnsmr/findAdjFt.do?locPosition=<%=myLat%>,<%=myLon%>&myAddress=<%=myAddress%>">근처 푸드트럭</a>
					</div>
					<div>
						<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/message.png" />
						<a href="/consumer/weatherInfo.do?myAddress=<%=myAddress%>&regCode=<%=regCode%>">날씨/질병 정보</a>
					</div>				
					<div>
						<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/rcmmndMenu.png" />
						<a href="/consumer/rcmmnd/rcmmndMenu.do?myAddress=<%=myAddress%>">트럭왔냠 추천 메뉴</a>
					</div>				
					<div>
						<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/mypage.png" />
						<a href="/consumer/user/mypage.do">마이페이지</a>
					</div>
					<div>
						<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/notice.png" />
						<a href="/consumer/board/noticeList.do">공지사항</a>
					</div>
					<div>
						<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/info_centre.png" />
						<a href="/consumer/board/boardList.do" >고객센터</a>
					</div>
				</div>
			</div>
			<div id="sidenav_outer" onclick="closeNav()"></div>
				<!--------------------------메뉴부분 종료 --------------------------> --%>

			</div>
	
		<!-- 상단 3번째 질병예방 공지 -->
		<hr style="margin:15px"/>
		<div id = top_notice style="color:white;">
			
			 <%if(dissInfoDTO != null){ %>
		  		<% String riskFigure = dissInfoDTO.getRisk(); %> 
				<% if(riskFigure.equals("1")) {%>
						<div >
						  <strong style="color:green">관심!</strong>
						  &nbsp;&nbsp;&nbsp; 식중독 발생가능성은 낮으나 식중독 예방에 지속적인 관심이 요망됩니다.
						</div>
				<%} else if(riskFigure.equals("2")){ %>	
						<div >
						  <strong style="color:sky">주의!</strong>
						  &nbsp;&nbsp;&nbsp;식중독 발생가능성이 중간 단계이므로 식중독예방에 주의가 요망됩니다.
						</div>
				<%} else if(riskFigure.equals("3")){%>
						<div >
						  <strong style="color:yellow">경고!</strong> 
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
		
		
		<div class="middle">
		
		<!-- middle 데이터 채우는 자리  -->		
		</div>
		
		
		
		


	<script>

			/* 메뉴 열기 함수 */
		function openNav() {
		    document.getElementById("mySidenav").style.width = "200px";
		    document.getElementById('sidenav_outer').style.width="100%";
		}
			/* 메뉴 닫기 함수 */
		function closeNav() {
		    document.getElementById("mySidenav").style.width = "0";
		    document.getElementById('sidenav_outer').style.width="0";
		}
	</script>
	
    