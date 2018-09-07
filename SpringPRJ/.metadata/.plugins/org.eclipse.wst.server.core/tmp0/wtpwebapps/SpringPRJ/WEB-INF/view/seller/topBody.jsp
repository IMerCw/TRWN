<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userEmail = CmmUtil.nvl( (String)session.getAttribute("userEmail") );
	String userNick = CmmUtil.nvl( (String)session.getAttribute("userNick") );
	String userSeq = CmmUtil.nvl((String)session.getAttribute("userSeq"));
	//nvl 널값이 들어오면 공백으로 바꿔줍니다.
	
%>
    <div class="container">
		<div class="top">
<!-- 창원이형이 주신 top body  -->
			
			<div class="navigation" style="color:white;">
				<!--------------------------최상단 날씨,위치정보 -------------------------->
				<div id="nav_top" >
					<div id="nav_top_left" class="nav_top">
						<h3><span class="glyphicon glyphicon-cloud"></span>&nbsp;&nbsp;22°C</h3>
					</div>
					<div id="nav_top_right" class="nav_top">
						<h4>서울시 강서구 우장산동 우장산로 10길</h4>
					</div>
				</div>
		
				<!--------------------------메뉴부분 시작 -------------------------->
				<div class="menuButton"><span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776;</span></div>
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
							<a href="/user/userLogin.do">로그인</a>
							<%} %>
						</div>
						
						<%if(!userSeq.equals("")){ %>
						<div><a href="/user/userDetail.do?userSeq=<%=userSeq%>">마이페이지</a></div>
						<%}%>
						<div><a href="#">정산관리</a></div>
						<div><a href="#">리뷰</a></div>
						<div><a href="/board/boardList.do">게시판</a></div>
					</div>
				</div>
				<div id="sidenav_outer" onclick="closeNav()"></div>
				 <div id="logo_main">
				 	<a href="/seller/out/inOut.do">
				 		<img src="/resources/img/consumer/logoWhite48x48.png" width="100%"/>
				 	</a>
				 </div>
						
				<!--------------------------메뉴부분 종료 -------------------------->
			</div>
	
		<!-- 상단 3번째 질병예방 공지 -->
		<hr style="margin:15px"/>
		<div id = top_notice style="color:white;">
			<p>&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-exclamation-sign"></span>  주의요망 : 금일 질병위험 지수 높음</p>
		</div>
		<hr style="margin:15px " />
		
		
<!-- 창원이형이 주신 top body끝  -->
		
		
		</div>
		
		
		<div class="middle">
		
		<!-- middle 데이터 채우는 자리  -->		
		</div>
		
		
		
		
	</div>


<!-- 창원이형이 주신 top script  -->
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
	
<!-- 창원이형이 주신 top script  끝-->
    