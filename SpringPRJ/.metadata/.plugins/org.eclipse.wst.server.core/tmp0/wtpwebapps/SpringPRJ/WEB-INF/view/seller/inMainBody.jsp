<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
	body {
		margin: 0 auto;
		
	    font-family: "Lato", sans-serif;
	    
	}
	a {
		text-decoration: none;
		color : black;
	}

	/*화면 중앙 내용 부분 */
	#contents {
		height:640px;
		text-align: center;
	}
	/* 매출 그래프 */
	#sales_graph {
		width:100%;
		height:280px;
	}

	/*푸드트럭관리 및 주문대기열 */

	#contents_menu_top{
		width:80%;
		height:180px;
		margin: 0 auto;
		margin-bottom: 30px;
	}
	#contents_menu_top h3{
		line-height: 180px;
		margin:0;
	}

	#contents_menu_top div{
		width:45%;
		height: auto;
		margin: 0 auto;
		border: 1px solid black;
		border-radius: 5px;
		
	}
	#truck_config{
		float:left;
	}
	#order_waiting{
		float:right;
	}
	/*본문 마지막 행 */

/* height: auto 였는데 bottom 클릭이 안됨 창원이형이랑 회의 */
	#contents_menu_bottom{
		width:80%;
		height:20%;  
		margin: 0 auto;
		position:relative;
		overflow:hidden;
	}
	#contents_menu_bottom a{
		line-height:100px;
		margin:0;
	}
	#contents_bottom_left{
		width:45%;
		height:60%;
		float:left;
	}
	#contents_bottom_right{
		width:45%;
		
		float:right;
	}

	/* 마지막행 버튼 크기 조절*/
	.contents_bottom{
		float:left;
		
		width:20%;
		height: 100px;
		border: 1px solid black;
		border-radius: 5px;
		
	}

	#bbs{
		float:left;
		width:46%; 
	}
	#account{
		float:right;
		width:46%;
	}
	#event{
		float:left;
		width:46%;
	}
	#carfuel{
		float: right;
		width:46%;
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
	/*화면 중앙 내용 부분 */
		#contents {
			height:auto;
			text-align: center;
		}
		/* 매출 그래프 */
		#sales_graph {
			width:100%;
			height:auto;
		}

		/*푸드트럭관리 및 주문대기열 */
		#contents_menu_top{
			height:400px;
			margin: 20px auto;
		}
		#contents_menu_top h3{
			/*line-height: 120px;*/
			font-size:20px;
			margin:0;
			line-height: 200px;
		}

		#contents_menu_top div{
			width: 100%;
			height: 200px;
			margin: 10px auto;
			float:none;
			border: 1px solid black;
			border-radius: 5px;
			
		}

		/*본문 마지막 행 */

		#contents_menu_bottom{
			
			height:400px;
			margin: 20px auto;
			
			
		}
		#contents_menu_bottom a{
			margin:0;
			line-height:65px;
		}
		#contents_bottom_left{
			width:100%;
			height:auto;
			margin: 10px auto;
		}
		#contents_bottom_right{
			width:100%;
			height:auto;
			margin: 10px auto;
		}

		/* 마지막행 버튼 크기 조절*/
		.contents_bottom{
			float:none;
			
			width:20%;
			height: 65px;
			border: 1px solid black;
			border-radius: 5px;
			
		}
		.contents_bottom div{
			float:none;
		}
		#bbs{
			width:46%;
		}
		#account{
			width:46%;
		}
		#event{
			width:46%;
		}
		#carfuel{
			width:46%;
		}
		
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

</head>
<body>



	<!-- 중간 내용부분 -->
	<div id="contents">
		<!-- 매출 그래프 표시할 부분 -->
		<div id="sales_graph">매출 그래프 표시부분 </p></div>
		<!-- 본문 기능 부분 -->
		<div id="contents_menu_top">
			<a href="JavaScript:truckConfig()"><div id="truck_config"><h3>푸드트럭 관리</h3></div></a>
			<a href="/seller/orderWait/orderWait.do?userSeq=<%=userSeq%>"><div id="order_waiting"><h3>주문대기열</h3></div></a>
		</div>
		<div id="contents_menu_bottom">
			<div id="contents_bottom_left">
				<a href="/seller/board/boardList.do"><div id="bbs" class="contents_bottom">게시판</div></a>
				<a href="/seller/ftDistrictData/ftDistrictDataMain.do"><div id="account" class="contents_bottom">상권 분석</div></a>
			</div>
			<div id="contents_bottom_right">
				<a href="/seller/loc/loc.do"><div id="event" class="contents_bottom">지역행사정보</div></a>
				<a href="/seller/gasStation/gas.do"><div id="carfuel" class="contents_bottom">주유정보</div></a>
			</div>
		</div>
	</div>
