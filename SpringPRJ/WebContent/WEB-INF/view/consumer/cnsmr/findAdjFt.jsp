<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.consumer.CONSUMER_Ft_InfoDTO" %>
<%@page import="poly.dto.consumer.CONSUMER_ImageDTO" %>
<%@page import="java.util.List"%>

<%

	List<CONSUMER_Ft_InfoDTO> ftList = (List<CONSUMER_Ft_InfoDTO>)request.getAttribute("ftList");
	List<CONSUMER_ImageDTO> imgDTOs = (List<CONSUMER_ImageDTO>)request.getAttribute("imgDTOs");
	String myLocLat = (String)request.getAttribute("locPositionLat");
	String myLocLon = (String)request.getAttribute("locPositionLon");
	
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
	.row {
		width:100%; margin:0 auto;
	}
	.col-xs-12{
		padding:0;
	}
	.panel{
		max-height:300px; 
	}
	.panel img { /* 푸드트럭 사진  */
	}
	.panel-body{ /* 푸드트럭 사진 밑 내용 소개 */
		text-align:center; 
	}
	
</style>
<title>트럭왔냠 - 근처 푸드트럭 찾기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>


<body>

	<!-- 다음 맵이 차지할 공간 -->
	<div id="map" style="width:100%;height:350px;"></div>
	<!-- 푸드트럭 목록 -->  
	<div class="FtListcontainer" style="margin:0;">
		<div class="row" style="margin: 0">
		<%if(ftList != null && ftList.isEmpty() == false) {%>
			<%for(int i = 0; i <ftList.size(); i++) {%>
		    	<div class="col-xs-12 col-sm-6" style="margin-top:20px; margin-bottom:20px;">
					<div class="card bg-light text-dark" style="text-align:center;">
						<div class="card-header" style="height:230px; background:#eeeeee;">
							<%if(ftList.get(i).getFile_id() != null) {%> 
								<!-- 푸드트럭 이미지가 있는 트럭의 경우 -->
								<% for(int j = 0; j < imgDTOs.size(); j++) {%>
									<%String fFileId = ftList.get(i).getFile_id();%>	
									<%String iFileId = imgDTOs.get(j).getFileId();%>
									<% if(fFileId.equals(iFileId)) { %>
										<!-- 트럭이미지의 포스트방식 전송 히든 양식-->
										<img src="<%=request.getContextPath()%>/resources/files/<%=imgDTOs.get(j).getFileSevname()%>" 
											onError="this.src='/resources/img/consumer/NfoundError.png;'"
											height="100%" width="100%">
									<%} %>
								<%} %>
							<%}else {%> <!-- 푸드트럭 이미지가 없는 트럭의 경우 -->
							<%} %>
						</div>
							
						<div class="card-body" style="font-size:2.5rem;">
							<%=ftList.get(i).getFt_name() %>
						</div> 
							<input type="hidden" name="ft_seq" value="<%=ftList.get(i).getFt_seq()%>" />
						<div class="card-body" style="font-size:18px; color:#888888; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
							<%=ftList.get(i).getFt_intro() %>
						</div> 
						<div class="card-body" style="">
							<%String []optime = ftList.get(i).getFt_optime().split("/"); %>
							<%= optime[0] %> / <%= optime[1] + " ~ " + optime[2] %>
						</div>
						<div class="card-body">
							리뷰 평점 : 
							<%-- 리뷰점수와 위생점수 별 모양 표시 --%>
							<%float avgRevPoint = Float.valueOf(ftList.get(i).getFt_avg_rev_point()); %>
							<%int j;%>
							<%for(j = 1; j <= avgRevPoint; j++ ) {%>
								<img src="/resources/img/consumer/starRating.png"/>
							<%} %>
							<%-- 별점 0.5 가 있을 경우 반 별 모양 추가 --%>
							<%if(avgRevPoint >= j-1 + 0.5) {%>
								<img src="/resources/img/consumer/starRatingHalf.png"/>
							<%} %>
							&nbsp;/&nbsp; 위생 점수: 
							<%float avgSntyPoint = Float.valueOf(ftList.get(i).getFt_snty_point()); %>
							<%int k;%>
							<%for(k = 1; k <= avgSntyPoint; k++ ) {%>
								<img src="/resources/img/consumer/SntystarRating.png"/>
							<%} %>
							<%-- 별점 0.5 가 있을 경우 반 별 모양 추가 --%>
							<%if(avgSntyPoint >= k-1 + 0.5) {%>
								<img src="/resources/img/consumer/SntystarRatingHalf.png"/>
							<%} %>
						</div>
						<div class="card-body">
							<button onclick="location.href='/consumer/cnsmr/ftDetail.do?ft_seq=<%=ftList.get(i).getFt_seq()%>'" 
								type="button" class="btn btn-primary" style="width:100%;">푸드트럭 자세히 보기</button>
						</div>
					</div>
				</div>
					<%} %>
				<%}else { %>
			</div>
		</div>
		<div class="alert alert-danger">
		  <strong>!!</strong> 근처에 푸드트럭이 없습니다.
		</div>
	<%} %>
</body>
<div id="map" style="width:100%;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=60f4f121242d90c886eacd9609c92e78&libraries=services,clusterer,drawing"></script>
	<script>
	
		var mapContainer = document.getElementById('map') 
	    var mapOption = { 
	        center: new daum.maps.LatLng(<%=myLocLat%>, <%=myLocLon%>), 
	        level: 5
	    };
	
		var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다	
	
		// 마커를 표시할 위치와 title 객체 배열입니다  
		// 위도경도 정보를 split하여 double형으로 형변환
		var positions = [
			<%for(int i =0; i< ftList.size(); i++) {%>
				<% double truckPositionLat = Double.parseDouble(ftList.get(i).getGps_x()); %>
				<% double truckPositionLon = Double.parseDouble(ftList.get(i).getGps_y()); %>
			{
				title: '<%=ftList.get(i).getFt_name() %>', 
		        latlng: new daum.maps.LatLng(<%=truckPositionLat%>, <%=truckPositionLon%>),
		        ftSeq: '<%=ftList.get(i).getFt_seq()%>'
		    },
			<%} %>
			
		];
		
		
		// 마커 이미지의 이미지 주소입니다
		var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		    
		for (var i = 0; i < positions.length; i ++) {
		    
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new daum.maps.Size(24, 35); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
		    
		    // 마커를 생성합니다
		    var marker = new daum.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
		    });
		    
		    var infowindow = new daum.maps.InfoWindow({
		        content: positions[i].title // 인포윈도우에 표시할 내용
		    }); 
		    
		    var iwContent = '<div style="padding:5px; width:150px; text-align:center;"><p style="margin:4px 0; font-size:1.3rem; font-weight:bold;">'+positions[i].title+'</p>',
		    	iwPosition = new daum.maps.LatLng(positions[i].latlng + ", " +  positions[i].title); //인포윈도우 표시 위치입니다
			
			// 인포윈도우를 생성합니다
			var infowindow = new daum.maps.InfoWindow({
			    position : iwPosition, 
			    content : iwContent 
			});
		  
			// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
			infowindow.open(map, marker); 
		    
		    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
		    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
		    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
		    daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
		    
		    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
		    
		    daum.maps.event.addListener(marker, 'click', makeClickListener(positions[i]));
		    
		    
		}
		
		//마커 클릭시 푸드트럭 상세 페이지 이동
		function makeClickListener(position) {
			return function() {
				location.href = '/consumer/cnsmr/ftDetail.do?ft_seq=' + position.ftSeq;
			}
		}
		
		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
		    return function() {
		        infowindow.open(map, marker);
		    };
		}

		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
		    return function() {
		        infowindow.close();
		    };
		}

		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new daum.maps.LatLng(<%=Double.parseDouble(myLocLat) %>,<%=Double.parseDouble(myLocLon)%>); 
		
		// 마커를 생성합니다
		var marker = new daum.maps.Marker({
		    position: markerPosition
		});
		map.setCenter(new daum.maps.LatLng(<%=Double.parseDouble(myLocLat) %>,<%=Double.parseDouble(myLocLon)%>));
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		
	</script>
</html>