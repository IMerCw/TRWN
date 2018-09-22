<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"> -->
	<!-- <link rel="stylesheet" href="/img/b.css" /> -->    
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" rel="stylesheet"><%--구글 웹 폰트 --%>
	
<style>
	body {
		font-family: 'Noto Sans KR', sans-serif;
		margin: 0 auto;
	}
	
	a {
		text-decoration: none;
		color : black;
	}
	
	/* 사이드 메뉴 시작 */
	.navigation {
		position:relative;
		height:130px;
		overflow:hidden;
	}

	
	.menuButton {
		display: inline-block;

	}
	.sidenav {
	    height: 100%;
	    width: 0;
	    position: fixed;
	    z-index: 2;
	    top: 0;
	    left: 0;
	    overflow-x: hidden;
	}


	.sidenav a {
	    
	    text-decoration: none;
	    font-size: 17px;
	    color: #000000;
	    display:block;

	}

	#mySidenav{
		z-index:101;
	}
	#sidenav_outer {
		
	    background-color: rgba(0,0,0,0.45);
		width:0;
		height:100%;
		position:fixed;
		left:0px; top:0px;
		z-index:100;

	}
	
	#sidenav_inner {
		height:100%; width:100%;
		background-color: #ffffff;
		float:left;
	}
	.closebtn {
		font-size:50px;
	}
	#sidenav_inner div {
		padding: 8px 8px 8px 16px;
	    border-bottom: 1px solid #eeeeee;	
	}
	#sidenav_inner img {
		height: 18px; float:left;
		margin-right: 10px;
		margin-top: 3px;
	}
	/**************/
	
	/* 1번째 행 최상단 날씨 / 지역 div */
	.topFirstContainer{
		overflow:hidden; height:24px;
		background-color: #444444;
	}
	.topFirstContainer a{
		display:table-cell; color:#cbcbcb; font-size:12px;
	}
	#nav_top_left{
		float:left; display:table; font-weight:bold;
	}
	#nav_top_left img{
		margin-left:10px;
		height:24px;
		margin-right:3px;
	}

	#nav_top_right{
		float:right; display:table; height:100%; padding-top:1px;
	}

	
	
	
 	/* 2번째 행 메뉴 / 검색 / 뒤로가기 버튼 div  */
 	.topSecondContainer {
 		height:56px; 
 		background: #333333;
 	}
 	.menuButton{
 		float:left;
 	}

 	/* 메인 로고 그림 */
 	#logo_main{
 		display:table; margin: 0 auto;
 	}
 	
 	/* 검색 부분 */
 	#searchBttnContainer {
 		float:right; visibility: visible;
 	}
 	#searchBarContainer{
 		position: relative; 
 		height:48px; width:100%;
 		right:0; display:none;
 		padding-left:5px; padding-right:5px;
 	}
 	#searchBarContainer > input[type=text] {
 		margin-top:4px;
 		width:77%; height:75%;
 		border:1px solid #cccccc;
 		box-sizing:border-box;
 		padding-left:10px;
 	}
 	#searchButtonClose{
 		float:right;
 	}
	#submitBttn {
		background-color:#444444;
		border:1px solid #222222;
		color:#f2f2f2;
		width:23%;
		height:75%;
		box-sizing: border-box;
	}
 	
 	
 	
 	/* Carousel 사진 슬라이드 */
 	.container {
 		padding:0px;
 	}
	@media screen and (min-width: 768px) {
		.container{
		    width: 100%;
		}
	}
 	/* 메인페이지의 연락처 DIV */
 	#mainAddress {
 		width:100%;
 	}
 	
	/* 마이페이지 테이블 너비 */
 	table { 
 		width: 90%; margin: 0 auto;
 	}
 	
 	/* 푸터 footer */
 	/* Sticky footer styles
	-------------------------------------------------- */
	html {
	  position: relative;
	  min-height: 100%;
	}
	body {
	  margin-bottom: 60px; /* Margin bottom by footer height */
	}
	.footer {
	  position: absolute;
	  bottom: 0;
	  width: 100%;
	  height: 60px; /* Set the fixed height of the footer here */
	  line-height: 60px; /* Vertically center the text there */
	  
	}
	
	
	/* Custom page CSS
	-------------------------------------------------- */
 	
 	
	/*스마트폰*/
	@media screen and (min-width: 426px) and (max-width: 767px) {
		/* body {
			
		}
		#contents_menu_top h3 {
			font-size: 16px;
		}
		#contents_menu_bottom a {
			font-size: 10px;
		} */
		
	}
	
	/*스마트폰 320~425 에서는 메뉴가 일렬로 나열됩니다. */
	@media screen and (min-width: 320px) and (max-width: 425px) {
	/* 	body {
			width: 100%; */
	}


	/******************태블릿PC******************/
	@media screen and (min-width: 768px) and (max-width: 959px) {
	/* 	body {
			
		}
		
		#contents_menu_top h3 {
			font-size: 24px;
		}
		#contents_menu_bottom a {
			font-size: 14px;
		} */
	
	}
</style>


	
