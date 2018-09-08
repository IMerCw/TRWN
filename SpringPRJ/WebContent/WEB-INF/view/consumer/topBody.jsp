<%@page import="poly.util.CmmUtil"%>
<%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 정보 세션
	String userEmail = CmmUtil.nvl( (String)session.getAttribute("userEmail") );
	String userNick = CmmUtil.nvl( (String)session.getAttribute("userNick") );
	String userSeq = CmmUtil.nvl((String)session.getAttribute("userSeq"));
	
	//위치정보 세션
	String myLat = CmmUtil.nvl((String)session.getAttribute("myLat"));	// 위도
	String myLon = CmmUtil.nvl((String)session.getAttribute("myLon"));	// 경도
	String myAddress = CmmUtil.nvl((String)session.getAttribute("myAddress")); // 내 주소 (지번)
	String regCode = CmmUtil.nvl((String)session.getAttribute("regCode"));	//지역코드 - 질병예방API용
	String skyCode = CmmUtil.nvl((String)session.getAttribute("skyCode"));  //skyCode 하늘상태(맑음:1, 구름조금:2, 구름많음:3, 흐림:4)
	String ptyCode = CmmUtil.nvl((String)session.getAttribute("ptyCode"));	//ptyCode 강수형태(없음:0, 비:1, 비/눈:2, 눈:3)
	String t3hCode = CmmUtil.nvl((String)session.getAttribute("t3hCode"));	//t3hCode 3시간 동안의 기온(단위 ℃)
	//nvl 널값이 들어오면 공백으로 바꿔줍니다.

%>
	<!-- 반응형 웹 설정 -->
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- 전체를 감싸는 DIV -->
    <div class="topContainer">
    	<!-- 1번째 행 메뉴 / 검색 / 컨테이너 -->
		<div class="topSecondContainer">
			<!--------------------------메뉴부분 시작 -------------------------->
			<div class="menuButton">
				<span style="font-size:30px;cursor:pointer" onclick="openNav()">
					<img src="/resources/img/consumer/menu48x48.png" height="42px" style="margin-top:8px; margin-left:5px;"/>
				</span>
			</div>
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
						<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/event_menu.png" />
						<a href="/consumer/user/CnsmrEvnt.do">이벤트</a>
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
	
						
			<!--------------------------메뉴부분 종료 -------------------------->
			<!-- 검색 버튼/창 DIV -->	

				<!-- 검색 돋보기 버튼 부분 -->
				<div id="searchBttnContainer">
					<a id="searchButton" href="javascript:void(0)" onclick="toggleNav()">
						<img src="/resources/img/consumer/magnifyingGlass48x48.png" height="42px" style="margin-top:8px; margin-right:5px;"/>
					</a>
				</div>

			<!-- 로고 이미지 DIV -->
			
			<div id="logo_main">
				<a href="/consumer/main.do"><img src="/resources/img/consumer/logoWhite48x48.png" height="46px" style="margin-top:6px;"/></a>
			</div>
		
			
		</div>
		<!-- 1번째 행 종료 -->
		
 		<!-- 2번째 행 날씨정보 / 위치정보 -->
 		<div style="clear:both">
		<div class="topFirstContainer">

			<div id="nav_top_left" >
				<!-- 날씨정보 / 값 받아 온 경우 -->
				<%if(!"".equals(t3hCode)) {%>
					<%if (ptyCode.equals("0")) {%>
						<img src="/resources/img/consumer/skyCode<%=skyCode%>.png" />
					<%} else if(!(ptyCode.isEmpty())) { %>
						<img src="/resources/img/consumer/ptyCode<%=ptyCode%>.png" />
					<%}%>
					<a href="/consumer/weatherInfo.do?myAddress=<%=myAddress%>&regCode=<%=regCode%>"><%=t3hCode %>℃</a>				
				<!-- 날씨정보/ 위치 설정 되지 않은 경우 -->
				<%} else { %>
					<!-- 위치 미 설정시 날씨 정보 공백 처리 -->
				<%} %>
			</div>
			<div id="nav_top_right" >
				<!-- 위치정보 있을 경우-->
				<img src="/resources/img/consumer/mapMarker.png" style="height:12px; margin-bottom:2px; margin-right:3px"/>
				<a id="myLocLink" href="/consumer/cnsmr/findMyLoc.do"></a>
				<%if(!"".equals(myAddress)) {%>
					<a href="/consumer/cnsmr/findMyLoc.do"><%=myAddress%></a>
				<!-- 좌표에서 주소변환을 위한 스크립트 끝 -->
				<!-- 위치정보 없을 경우 -->
				<%} else{ %>
					<a href="/consumer/cnsmr/findMyLoc.do">위치를 설정해 주세요.</a>
				<%} %>
				&nbsp;&nbsp;
			</div>
		</div>
		
		<!-- 2번째 행 종료 -->
		<form method="POST" action="/consumer/cnsmr/findFtByMenu.do" style="margin:0;">
			<!-- 검색 박스 부분 (기본 숨겨진 상태/클릭시 열림) -->
			<div id="searchBarContainer">
				<input type="hidden" value="<%=myAddress%>" name="myAddress" />
				<input type="hidden" value="<%=myLat%>,<%=myLon%>" name="locPosition" />
				<%-- <input type="hidden" value="<%=regCode%>" name="regCode" /> --%>
				<input type="text" name="keyWord"  maxlength="15" placeholder="메뉴를 검색하세요." style="margin-right:-5px;"/>
				<button type="submit" id="submitBttn">검색</button>
			</div>
		</form>	
		
		</div>
	</div>
	<!-- 푸터 -->
	<footer class="footer">
		<div style="padding-top:28px;"></div>
		<div class="container" style="padding:0px 10px; background-color: #f5f5f5;"><span class="text-muted">© All Rights Reserved.</span></div>
	</footer>

<!--  top body끝  -->
		
<!--  top script  -->
<script>
		/* 메뉴 열기 함수 */
	function openNav() {
	    document.getElementById("mySidenav").style.width = "220px";
	    document.getElementById('sidenav_outer').style.width="100%";
	}
		/* 메뉴 닫기 함수 */
	function closeNav() {
	    document.getElementById("mySidenav").style.width = "0";
	    document.getElementById('sidenav_outer').style.width="0";
	}
</script>
<!--  top script  끝-->

<!-- 검색 창 열기 기능 자바스크립트 -->
<script>
	var check;
	window.onload=function(){
		check=true;
	};
	function toggleNav() {
		var srchBarCon = document.getElementById("searchBarContainer");
		
		if(check){
		    document.getElementById('searchButton').style.opacity = "0.6";
		    srchBarCon.style.display = "block";
		    check=false;
		}else{
		    document.getElementById('searchButton').style.opacity = "1";
		    srchBarCon.style.display = "none";
		    check=true;
		}
	}
</script>
<!------------------------->
<!-- 로그아웃폼 -->
<script>
	function logout() {
		location.href="/cmmn/user/logout.do";
	}
</script>

