<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String userSeq = CmmUtil.nvl((String)session.getAttribute("userSeq"));
	String userAuth = CmmUtil.nvl((String)session.getAttribute("userAuth"));
%>
<!--
	Transitive by TEMPLATED
	templated.co @templatedco
	Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
-->
<html>
	<head>
		<title>inOut</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/seller/main.css" />
		<style>
			
	
	  	  
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
			<section id="banner">
				<div class="inner">
					<div id="floatL">
						 <a href="/seller/main.do">
				            <div id="truck_in" onmouseover="changeBg('in')" onmouseout="changeBg_out('in')">
				                <h1>IN</h1>
				                <p>푸드트럭 안</p>
				                <hr width="100%"/>
				            </div>
				        </a>
					</div>
					<div id="floatR">
				        <a href="/seller/out/out_info.do?userSeq=<%=userSeq%>&userAuth=<%=userAuth%>">
				            <div id="truck_out"  onmouseover="changeBg('out')" onmouseout="changeBg_out('out')">
				                <hr width="100%"/>
				                <h1>OUT</h1>
				                <p>푸드트럭 밖</p>
				            </div>
				        </a>
					</div>
				</div>
			</section>

	
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