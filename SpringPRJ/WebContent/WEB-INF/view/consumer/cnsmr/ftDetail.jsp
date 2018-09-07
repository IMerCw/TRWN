<%@page import="java.util.List"%>
<%@page import="poly.dto.consumer.CONSUMER_Ft_InfoDTO"%>
<%@page import="poly.dto.consumer.CONSUMER_Ft_ReviewDTO"%>
<%@page import="poly.dto.consumer.CONSUMER_ImageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("euc-kr");
	CONSUMER_Ft_InfoDTO fDTO = (CONSUMER_Ft_InfoDTO) request.getAttribute("fDTO");
	double ftLat = Double.parseDouble(fDTO.getGps_x()); // 스트링 형 위도 Latitude를 double로 반환 
	double ftLon = Double.parseDouble(fDTO.getGps_y());// 스트링 형 경도 Longitude를 double로 변환
	
	List<CONSUMER_Ft_ReviewDTO> fReviewDTO = (List<CONSUMER_Ft_ReviewDTO>) request.getAttribute("fReviewDTO"); //리뷰 데이터를 리스트 형식으로 받아옴
	List<CONSUMER_ImageDTO> ImgDTOs = (List<CONSUMER_ImageDTO>) request.getAttribute("ImgDTOs"); //리뷰 데이터를 리스트 형식으로 받아옴
	CONSUMER_ImageDTO imgDTO = (CONSUMER_ImageDTO) request.getAttribute("imgDTO");
	String cmd = (String) request.getAttribute("cmd"); 	/* cmd 값에 따라 메뉴 탭 이동 // 0 - 정보 , 1 - 메뉴 , 2 - 리뷰*/
	String FtLikeResult = (String) request.getAttribute("FtLikeResult"); //관심매장이 추가되었는지 여부 확인 >> -1 안됨 / +1 됨
	/* 푸드트럭 예약,케이터링, 주문예약 가능 여부 bool 선언 */
	boolean isDelivery = false;
	boolean isCatering = false;
	boolean isReserve = false;
	String []ftFunc = fDTO.getFt_func().split("/");
	for(int i = 0; i < ftFunc.length; i++) {
		switch(ftFunc[i]) {
			case "배달": isDelivery = true; break;
			case "케이터링": isCatering = true; break;
			case "주문예약": isReserve = true; break;
			default: break;
		}
	}
	
	String []optime = fDTO.getFt_optime().split("/");
	//푸드트럭 운영 요일
	String operateDate = optime[0];
	String opDay = operateDate.substring(0, 9);
	String opDayWeek = operateDate.substring(10);
	//푸드트럭 운영 시간
	String operateTime = optime[1] + " - " + optime[2];
%>
<html>
<head>
<title>트럭왔냠 - 푸드트럭 상세 보기</title>

</head>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>


<html>
<head>
<title>푸드트럭 상세 보기 </title>
<style>
	
	#ft-detail-menu {
		text-align: center;
	}
	
	.nav-tabs>li {
		display: inline-block;
		width: 33.3%;
	}
	.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover{
		color:white;
		background-color:#337ab7;
		margin:0;
	}
	
	/* 메뉴 탭 고정  */
	#myHeader {
		z-index:100;
	}
	.sticky {
	  position: fixed;
	  top: 0;
	  width: 100%;
	}
	.nav-tabs>li:first-child {
		float:left;
	}
	.nav-tabs>li:last-child {
		float:right;
	}
	.nav-tabs>li>a{
		margin:0;
	}
	.tab-pane {
		background-color:#f2f2f2; padding-left:10px; padding-right:10px; padding-top:15px; padding-bottom:15px;
	}

	/* 관심매장등록, 공유하기 버튼 */
	.ftDetailBttn {
		max-width:100%; height:auto;
	}
	
	/* 회색 테두리의 하얀색 박스*/
	.contentBox{
		border:1px solid #cccccc; box-sizing: border-box; 
	 	margin-bottom: 15px; background-color:#ffffff;
	}

	#ft-detail-menu{
		background-color:#ffffff;
	}
	.nav-tabs>li>a{
		border:0;
	}
	.col-xs-12 div {
		padding: 10px 0
	}
	
	/* 각 행 */
	.row {
		padding:15px 0;
	}
	/* 배달/예약/케이터링 가능 뱃지 */
	.label {
		display:inline-block;
		margin:3px 0;
	}
	/* 리뷰 페이지 */
	.table > thead > tr th:nth-child(1) {
		width:20%;
	}
	.table > thead > tr th:nth-child(2) {
		width:50%;
	}
	.table > thead > tr th:nth-child(3) {
		width:10%;
	}
	.table > thead > tr th:nth-child(4) {
		width:20%;
	}
	.table>thead>tr>th{
		padding: 5px 2px; text-align:center;
	}
	
	.ftIcon {
		max-width:100%; height:auto; max-height:30px;
	}
</style>


</head>
<body>
	<div id="map" style="width: 100%; height: 350px;"></div>
	
	<!-- 정보/메뉴/리뷰 탭 스크롤 내려도 고정됨 -->
	<div class="header" id="myHeader" align="center">
		<ul class="nav nav-tabs" id="ft-detail-menu">
			<li class="active">
				<a data-toggle="tab" href="#menu0" id="ftDetailInfo">정보</a>
			</li>
			<li><a data-toggle="tab" href="#menu1" id="ftDetailMenu">메뉴</a></li>
			<li><a data-toggle="tab" href="#menu2" id="ftDetailReview">리뷰</a></li>
		</ul>
	</div>
	<!-- 메뉴 탭 안의 들어갈 내용 -->
	<div class="tab-content">
		<div id="menu0" class="tab-pane fade in active">
			<div class="container-fluid contentBox">
				<div class="row" style="padding: 5px 0;">
					<div class="col-xs-8">
						<!-- 푸드트럭 이름 -->
						<h2 style="text-align:left; margin-top:15px;"><%=fDTO.getFt_name()%></h2>
					</div>
					<div class="col-xs-2" style="height:64px; padding:15px; text-align:right;" id="favoriteContainer">
						<!-- 관심매장 등록 버튼 -->
						<%if(FtLikeResult.equals("1")) {%>
							<img src="/resources/img/consumer/favorite_on.png" class="ftDetailBttn" onclick="favoriteBttnRmvClick()" id="XTfavoriteBttn"/>
						<%}else { %>
							<img src="/resources/img/consumer/favorite_off.png" class="ftDetailBttn" onclick="favoriteBttnAddClick()" id="NONfavoriteBttn"/>
						<%} %>
					</div>
					<div class="col-xs-2" style="height:64px; padding:15px;">
						<!-- 공유하기 버튼 -->
						<img src="/resources/img/consumer/share-symbol.png" class="ftDetailBttn" onclick="shareBttnClick()" id="shareBttn"/>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-2">
						<!-- 운행 중 -->
						<%if(fDTO.getFt_status() == 0) { %>
							<span class="label label-primary">운행 중</span>
						<%}else { %>
							<span class="label label-default">미 운행중</span>
						<%} %>
					</div>
					<div class="col-xs-6">
					</div>
					<div class="col-xs-4" style="text-align:right;">
						<%if(isDelivery) { %>
							<span class="label label-success">배달 가능</span>
						<%} %>
						<%if(isReserve) {%>
							<span class="label label-warning">예약 가능</span>
						<%} %>
						<%if(isCatering) {%>
							<span class="label label-danger">케이터링 가능</span>
						<%} %>		
					</div>
				</div>
				
				<!-- 구분 선-->
				<div style="clear:both; border-top:1px solid #cccccc; margin-top:8px; margin-bottom:24px; margin-left:5px; margin-right:5px;"></div>
				<!-- 푸드트럭 사진 -->
				<div class="row">		
					<div class="col-xs-12" style="text-align:center;">
						<!-- 푸드트럭 대표 사진 -->
						<%if (imgDTO != null) {%>
							<img src="<%=request.getContextPath()%>/resources/files/<%=imgDTO.getFileSevname()%>" style=" max-width:100%; height:auto;">
						<%} else { %>
	 						<img src="/resources/img/consumer/temp.png" style=" max-width:100%; height:auto;"> 
	 					<%	} %>
					</div>
				</div>
				<!-- 푸드트럭 운영시간  -->
				<div class="row">
					<div class="col-xs-2 ftDetailContents">
						<img src="/resources/img/consumer/clock-circular.png" class="ftIcon" />
					</div>
				   	<div class="col-xs-4 ftDetailContents">
						<p><%=opDay%></p>
						<p style="font-size:5px;"><%=opDayWeek%></p>
					</div>
			   		<div class="col-xs-2 ftDetailContents" style="height:2px; margin:14px; background: #cccccc">
					</div>
			   		<div class="col-xs-2 ftDetailContents">
						<%=operateTime%>
					</div>
				</div>
				<!-- 소개 -->
				<div class="row">
					<div class="col-xs-2 ftDetailContents">
						<img src="/resources/img/consumer/left-quote.png" class="ftIcon"/>
					</div>
					<div class="col-xs-10 ftDetailContents">
						<%=fDTO.getFt_intro()%>
					</div>
				</div>
				<!-- 위치 -->
				<div class="row">
					<div class="col-xs-2 ftDetailContents">
						<img src="/resources/img/consumer/placeholder-filled-point.png" class="ftIcon"/>
					</div>
					<div class="col-xs-10 ftDetailContents">
						<%=fDTO.getGps_sido() +" " + fDTO.getGps_sigungu() + " " + fDTO.getGps_dong()%>
					</div>
				</div>
				<!-- 사업자번호 -->
				<div class="row">
					<div class="col-xs-2 ftDetailContents">
						<img src="/resources/img/consumer/man-with-tie.png" class="ftIcon"/>
					</div>
					<div class="col-xs-10 ftDetailContents">
						사업자번호:&nbsp;<%=fDTO.getSel_no()%>
					</div>
				</div>
				
			</div>
		</div>
		<div id="menu1" class="tab-pane fade">
		<!-- 푸드트럭 메뉴 페이지-->
		</div>
		<div id="menu2" class="tab-pane fade">
		<!-- 푸드트럭 리뷰 페이지-->
		</div>
	</div>



<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=60f4f121242d90c886eacd9609c92e78"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new daum.maps.LatLng(<%=ftLat + ", " + ftLon%>), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	
	var map = new daum.maps.Map(mapContainer, mapOption);
	
	// 마커가 표시될 위치입니다 
	var markerPosition  = new daum.maps.LatLng(<%=ftLat + ", " + ftLon%>); 
	
	// 마커를 생성합니다
	var marker = new daum.maps.Marker({
	    position: markerPosition
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	
	var iwContent = '<div style="padding:5px;"> <%=fDTO.getFt_name()%> <br><a href="http://map.daum.net/link/map/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">큰지도보기</a> <a href="http://map.daum.net/link/to/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	    iwPosition = new daum.maps.LatLng(<%=ftLat + ", " + ftLon%>); //인포윈도우 표시 위치입니다
	
	// 인포윈도우를 생성합니다
	var infowindow = new daum.maps.InfoWindow({
	    position : iwPosition, 
	    content : iwContent 
	});
	  
	// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
	infowindow.open(map, marker); 
</script>

<!-- 푸드트럭 상세 메뉴 AJAX -->
<script>
	/* 메뉴 탭 선택 시 */
	$('#ftDetailMenu').click(function(){
		$.ajax({
			type:'GET',
			url:"/consumer/cnsmr/ftDetailMenu.do",
			data: {
				"ft_seq" : <%=fDTO.getFt_seq()%>
			},
			success: function(data) {
				$('#menu1').html(data);
			},
			error: function(error) {
				alert("error :" + error);
			}
			
		})
	});
	/* 리뷰 탭 선택 시 */
	$('#ftDetailReview').click(function(){
		$.ajax({
			type: 'GET',
			url: "/consumer/cnsmr/ftDetailReview.do",
			data: {
				"ft_seq" : <%=fDTO.getFt_seq()%>
			},
			dataType: 'text',
			success: function(data) {
				$('#menu2').html(data);
				
			},
			error: function(error) {
				alert("error :" + error);
			}
			
		})
	});

</script>
<!-- 메뉴 탭 고정을 위한 JS -->

<script>
window.onscroll = function() {myFunction()};

var header = document.getElementById("myHeader");
var sticky = header.offsetTop;

function myFunction() {
  if (window.pageYOffset > sticky) {
    header.classList.add("sticky");
  } else {
    header.classList.remove("sticky");
  }
}
</script>
<!-------------------->

<!-- cmd값에 따라서 클릭 이벤트 발생 -->
<script>
	var cmd = <%=cmd%>;
	
	//1번 메뉴이동 //2번 리뷰 이동
	if(cmd == 1) {
		var ftDetailMenu = document.getElementById('ftDetailMenu');
		ftDetailMenu.click();	
	}
	else if(cmd == 2){
		var ftDetailReview = document.getElementById('ftDetailReview');
		ftDetailReview.click();	
	}
	
	
</script>
<!-- 관심매장 추가 / 공유하기 버튼 스크립트-->
<script>
	/* 로그인(userSeq) / 비 로그인(0) 상태 구분  */
	<%if (!"".equals(userSeq)) {%>
		var userSeq = <%=userSeq%>; 
	<%}%>
	
	var favoriteBttn = document.getElementById('favoriteBttn');
	var shareBttn = document.getElementById('shareBttn');
	
	function favoriteBttnRmvClick() {
		alert("이미 관심매장으로 추가되어 있습니다.");
		var p = confirm('관심매장에서 삭제 하시겠습니까?');
		//관심매장 삭제하기
		if(p){
			$.ajax({
				type:'POST',
				url:"/consumer/cnsmr/favoriteFtRemove.do",
				data: {
					"ft_seq" : <%=fDTO.getFt_seq()%>,
					"user_seq" : userSeq,
				},
				success: function(data) {
					if(data==1) {
						alert('관심매장에서 삭제 되었습니다.');
						var content = '<img src="/resources/img/consumer/favorite_off.png" class="ftDetailBttn" onclick="favoriteBttnAddClick()" id="NONfavoriteBttn"/>';
						$('#favoriteContainer').html(content);
					}
				},
				error: function(error) {
					alert("error :" + error);
				}
				
			})
		}
		
	}
	function favoriteBttnAddClick() {
		<%if("".equals(userSeq)){%>
			alert('로그인을 해주시기 바랍니다.');
		<%} else {%>
			<%if(!FtLikeResult.equals("1")) {%>
			var r = confirm('관심매장에 추가 하시겠습니까?');
			if(r) {
				$.ajax({
					type:'POST',
					url:"/consumer/cnsmr/favoriteFtAdd.do",
					data: {
						"ft_seq" : <%=fDTO.getFt_seq()%>,
						"user_seq" : userSeq,
						
					},
					success: function(data) {
						if(data==1) {
							alert('관심매장으로 추가되었습니다.');
							var content = '<img src="/resources/img/consumer/favorite_on.png" class="ftDetailBttn" onclick="favoriteBttnRmvClick()" id="XTfavoriteBttn"/>';
							$('#favoriteContainer').html(content);
						}
					},
					error: function(error) {
						alert("error :" + error);
					}
					
				})
			}
			<%}%>
		<%}%>
	};
	function shareBttnClick() {
		alert("공유하기!");
		alert(window.location.href);
		
	};
	
</script>
</body>
</html>


</body>
</html>