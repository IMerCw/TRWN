<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap.css">
    <link rel="stylesheet" href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
	.navigation {
		position:relative;
		height:140px;
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
	    transition: 0.4s;

	}


	.sidenav a {
	    padding: 8px 8px 8px 32px;
	    text-decoration: none;
	    font-size: 20px;
	    color: #818181;
	    display:block;
	    transition: 0.3s;

	}

	.sidenav a:hover {
	    color: #f1f1f1;
	}

	#sidenav_outer {
		
	    background-color: rgba(0,0,0,0.45);
		width:0;
		height:100%;
		position:fixed;
		left:0px; top:0px;

	}
	#sidenav_inner {
		background-color: rgba(0,0,0);
		width: 200px;
		float:left;
		height:100%;


	}
	/*아이콘 사이즈 조절 */
	.glyphicon {
	    font-size: 50px;
	}
	.glyphicon-exclamation-sign{
		font-size: 28px;
	}

	#nav_top {
		margin-top:20px;
		overflow:hidden;
		height:50px;
		text-align:center;
		margin:0 auto;
	}
	.nav_top {
		height:100%;
	}
	#nav_top_left{
		float:left;
		line-height: 80px;

	}
	#nav_top_right{
		float:right;
	}
	#nav_top_menu{
		overflow:hidden;
	}
	#nav_top_menu_left{
		float:left;
	}
	 #nav_top_menu_left a{
	 	float:none;
		
	}
	.closebtn {
		font-size:50px;
	}
	#nav_top_menu_right{
		float:right;
		
	}
	#nav_top_left h3{
		margin:0;
		line-height: 50px;

	}
	.nav_top>h4 {
		line-height: 80px;
		float:left;
		margin:0;
		font-size:10px;
	}
	#logo_main {
        margin: 0 auto;
        height: 80px; width:160px;
        display:inline-block;
        text-align: center;
        position:absolute;
        left:40%;
    }
    #logo_main>img {
    	height:100%;
    	width:100%;
    }
    
	.topSecondContainer {
 		height:200px; 
 		background: #333333;
 	}
	/*스마트폰*/
	@media screen and (min-width: 426px) and (max-width: 767px) {
		body {
			
		}
		#contents_menu_top h3 {
			font-size: 16px;
		}
		#contents_menu_bottom a {
			font-size: 10px;
		}
		
	}
	
	/*스마트폰 320~425 에서는 메뉴가 일렬로 나열됩니다. */
	@media screen and (min-width: 320px) and (max-width: 425px) {
		body {
			width: 100%;
		}


	/******************태블릿PC******************/
	@media screen and (min-width: 768px) and (max-width: 959px) {
		body {
			
		}
			/*아이콘 사이즈 조절 */
		.glyphicon {
		    font-size: 25px;
		}
		.glyphicon-exclamation-sign{
			font-size: 18px;
		}
		#contents_menu_top h3 {
			font-size: 24px;
		}
		#contents_menu_bottom a {
			font-size: 14px;
		}
	
	}
</style>

<script>
	function logout(){
		location.href="/user/logout.do";
	}
</script>
	
    