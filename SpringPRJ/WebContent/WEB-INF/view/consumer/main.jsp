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
			<!-- 네번째 라인 (이벤트 배너) 끝 -->
			
			<div id="mainAddress"  style="padding:50px;">
			<p>서울특별시 강서구 화곡동</p>
			<p>Tel: 02-000-0000</p>
			<p>Fax:02-000-0000</p>
			<p>E-mail: foodtruck@Truck.com</p>
			<br/>
			<p>트럭왔냠의 사전 서면 동의 없이 트럭왔냠의 일체의 정보, 콘텐츠 및 UI등을
			상업적 목적으로 전재, 전송, 스크래핑 등 무단 사용할 수 없습니다.</p>
			</div>
			


</body>

</html>