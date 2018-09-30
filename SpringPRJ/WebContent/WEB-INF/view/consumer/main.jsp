<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="poly.dto.consumer.CONSUMER_ImageDTO" %>
<%@ page import="java.util.List" %>
<% List<CONSUMER_ImageDTO> imgDTOs = (List<CONSUMER_ImageDTO>)request.getAttribute("imgDTOs");  %>
<html>
<head>
<title>트럭왔냠 - 메인페이지</title>
<style>
	/* 메인페이지 배너 양쪽 그림자 제거 */
	.carousel-control.right, .carousel-control.left {
		background-image:none;
	}
	
	/* 반응형을 위한 이미지 width 조정 */
	.carousel-inner>.item>a>img, .carousel-inner>.item>img, .img-responsive, .thumbnail a>img {
		width:100%;
	}
	.carousel-control:focus, .carousel-control:hover {
		opacity: 0;
	}
	.carousel-inner{
  		width:100%;
  		max-height: 480px;
	}	

	#thirdMenu > div {
		height: 62px;
	    border: 1px solid #ccc;
	    border-radius: 8px;
	    width:24%;
	    display:inline-block;
	    padding-top:4px;
	    cursor:pointer;
	}
</style>
</head>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<%if(!imgDTOs.isEmpty()) {%>
		<div class="container">
		  <div id="myCarousel" class="carousel slide" data-ride="carousel">
		    <!-- Indicators -->
		    <ol class="carousel-indicators">
		      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		      <li data-target="#myCarousel" data-slide-to="1"></li>
		      <li data-target="#myCarousel" data-slide-to="2"></li>
		      <li data-target="#myCarousel" data-slide-to="3"></li>
		    </ol>
			
		    <!-- Wrapper for slides -->
				<%if(imgDTOs != null && imgDTOs.isEmpty() == false) {%>
				    <div class="carousel-inner">
				      <div class="item active">
				        <img src="<%=request.getContextPath()%>/resources/files/<%=imgDTOs.get(0).getFileSevname()%>"
				        	onError="this.src='/resources/img/consumer/NfoundError.png;'">
				      </div>
				      <div class="item">
				        <img src="<%=request.getContextPath()%>/resources/files/<%=imgDTOs.get(1).getFileSevname()%>"
				        	onError="this.src='/resources/img/consumer/NfoundError.png;'">
				      </div>
				      <div class="item">
				        <img src="<%=request.getContextPath()%>/resources/files/<%=imgDTOs.get(2).getFileSevname()%>"
				        	onError="this.src='/resources/img/consumer/NfoundError.png;'">
				      </div>
				      <div class="item">
				        <img src="<%=request.getContextPath()%>/resources/files/<%=imgDTOs.get(3).getFileSevname()%>"
				        	onError="this.src='/resources/img/consumer/NfoundError.png;'">
				      </div>
				    </div>
				<%} %> 
			    <!-- Left and right controls -->
			    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
			      <span class="glyphicon glyphicon-chevron-left"></span>
			      <span class="sr-only">Previous</span>
			    </a>
			    <a class="right carousel-control" href="#myCarousel" data-slide="next">
			      <span class="glyphicon glyphicon-chevron-right"></span>
			      <span class="sr-only">Next</span>
			    </a>
			  </div>
			</div>
		<%} %>
		<div class="container" style="padding:8px 15px; text-align:center; color:white; font-size:16px;">
			<div class="col-xs-6" onclick="location.href='/consumer/cnsmr/findAdjFt.do?locPosition=<%=myLat%>,<%=myLon%>&myAddress=<%=myAddress%>'" 
				style="cursor:pointer; height:38px; background-color:#e85376; border-radius:50px 0 0 50px; padding:8px 0; border-right: 1px solid white;">
				근처 푸드트럭
			</div>
			
			<div class="col-xs-6" onclick="location.href='/consumer/user/userOrderInfo.do'" 
				style="cursor:pointer; height:38px; background-color:#24A6BD; border-radius:0 50px 50px 0; padding:8px 0;">
				주문 조회
			</div>
		</div>
		<div class="container-fluid" style="text-align:center; font-size:18px; color:white;">
			<div class="row" style="cursor:pointer; background-color:#fd8469; padding: 4px 18px; height:56px; "onclick="location.href='/consumer/rcmmnd/rcmmndMenu.do'">
				<img src="<%=request.getContextPath()%>/resources/img/consumer/rcmmnd/statistics.png" style="width:46px; float:left;" />
				<p style="float:left; padding: 11px 12px;">트럭왔냠 추천 메뉴</p></div>
		
			<div class="row" style="cursor:pointer; background-color:#ffd15c; padding: 4px 18px; clear:both; height:56px;"onclick="location.href='/consumer/rcmmnd/CustomRcmmnd.do'">
				<img src="<%=request.getContextPath()%>/resources/img/consumer/rcmmnd/brain.png" style="width:46px; float:left;" />
				<p style="float:left; padding: 11px 12px;">소비자 맞춤 추천 </p></div>
				
			<div class="row" style="cursor:pointer; background-color:#5497d6; padding: 4px 18px; clear:both; height:56px;" onclick="location.href='/consumer/rcmmnd/wordCloudTrend.do'">
				<img src="<%=request.getContextPath()%>/resources/img/consumer/rcmmnd/networking.png"style="width:46px; float:left;"  />
				<p style="float:left; padding: 11px 12px;">검색어 트렌드</p></div>
			
		</div>
		<div class="container" id="thirdMenu" style="text-align:center; padding: 10px 14px;">	
			<div onclick="location.href='/consumer/board/noticeList.do'">
				<img src="<%=request.getContextPath()%>/resources/img/consumer/mainIcon/megaphone.png">
				<p>공지사항</p>
			</div>
			<div onclick="location.href='/consumer/board/boardList.do'">
				<img src="<%=request.getContextPath()%>/resources/img/consumer/mainIcon/customer-service.png">
				<p>고객센터</p>
			</div>
			<div onclick="location.href='/consumer/user/mypage.do'">
				<img src="<%=request.getContextPath()%>/resources/img/consumer/mainIcon/id-card.png">
				<p>마이페이지</p>
			</div>
			<div onclick="location.href='/consumer/user/userFavoriteFt.do'">
				<img src="<%=request.getContextPath()%>/resources/img/consumer/mainIcon/favorite_ft.png">
				<p>관심매장</p>
			</div>
		</div>
			


</body>

</html>