<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userSeq = CmmUtil.nvl((String)session.getAttribute("userSeq"));
	String userAuth = CmmUtil.nvl((String)session.getAttribute("userAuth"));
%>
<html>
	<head>
		<title>inOut TETST</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/seller/main.css" />
		<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" rel="stylesheet"><%--구글 웹 폰트 --%>
		<style>
			body {
				font-family: 'Noto Sans KR', sans-serif;
				margin: 0 auto;
			}
		</style>
	</head>
	<body>

		<!-- Header -->
			<header id="header" class="alt">
				<div class="logo"><a href="#">트럭왔냠 <span>by TRWN</span></a></div>
				<a href="#menu" class="toggle"><span>Menu</span></a> 
			</header>

		<!-- Nav -->
			<!-- <nav id="menu">
				<ul class="links">
					<li><a href="index.html">Home</a></li>
					<li><a href="generic.html">Generic</a></li>
					<li><a href="elements.html">Elements</a></li>
				</ul>
			</nav> -->

		<!-- Banner -->
		<!--
			To use a video as your background, set data-video to the name of your video without
			its extension (eg. images/banner). Your video must be available in both .mp4 and .webm
			formats to work correctly.
		-->
		<form action="/seller/out/out_info.do" method="POST">
		<input type="hidden" value="<%=userSeq%>" name="userSeq"/>
		<input type="hidden" value="<%=userAuth%>" name="userAuth"/>
			<section id="banner">
				<div class="inner">
					<div id="floatL">
			            <div onclick = "location.href='/seller/main.do'" id="truck_in">
			                <h1>IN</h1>
			                <p>푸드트럭 안</p>
			                <hr width="100%"/>
			            </div>
					</div>
					<div id="floatR">
				        <button type="submit" style="background: none;">
				            <div id="truck_out" >
				                <hr width="100%"/>
				                <h1>OUT</h1>
				                <p style="font-family:'Noto Sans KR', sans-serif;">푸드트럭 밖</p>
				            </div>
				        </button>
					</div>
				</div>
			</section>
		</form>
	
		<!-- Footer -->
			<footer id="footer" class="wrapper">
				<div class="inner">
					<div class="copyright">
						&copy; Untitled Design: <a href="https://templated.co/">TEMPLATED</a>. Images <a href="https://unsplash.com/">Unsplash</a>. Video <a href="http://coverr.co/">Coverr</a>.
					</div>
				</div>
			</footer>

		<!-- Scripts -->
			<script src="<%=request.getContextPath()%>/resources/js/seller/jquery.min.js"></script>
			<script src="<%=request.getContextPath()%>/resources/js/seller/jquery.scrolly.min.js"></script>
			<script src="<%=request.getContextPath()%>/resources/js/seller/jquery.scrollex.min.js"></script>
			<script src="<%=request.getContextPath()%>/resources/js/seller/skel.min.js"></script>
			<script src="<%=request.getContextPath()%>/resources/js/seller/util.js"></script>
			<script src="<%=request.getContextPath()%>/resources/js/seller/main.js"></script>

	</body>
</html>