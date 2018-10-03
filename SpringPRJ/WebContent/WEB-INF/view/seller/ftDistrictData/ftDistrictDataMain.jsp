<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style type="text/css">
fieldset { padding:10px; margin:10px; }
legend { margin:10px; }
body { font-family:gulim; font-size:12px; }
</style>


<script src="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c449b1cbc3c291def2d6edada3e87082&libraries=services,clusterer,drawing"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.js"></script>
<title>상권 분석</title>
</head>
<body>


<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="#444">
			<td style="padding:0;">
				
				<%@ include file="/WEB-INF/view/seller/top.jsp" %>
			</td>
		</tr>
		<tr bgcolor="">
			<td style="background-color:#555; padding: 20px 0;">
				<div class="container" style="background-color:#ffffff; padding: 20px 40px 60px 40px; border-radius:8px;">
				<div class="row">
					<!-- 	<fieldset>
					<legend>주소그룹2</legend>
					<select name="sido2" id="sido2"></select>
					<select name="gugun2" id="gugun2"></select>
					<select name="dong2" id="dong2"></select>
					</fieldset> -->
					<fieldset style="margin:12px; width:96%;">
						<div class="col-sm-8">
							<h3 style="display:inline; margin:0; padding:0;" class="col-sm-8">구군 별 푸드트럭 분포</h3>
						</div>
						<div class="col-sm-4" style="text-align:right;">
							<select name="sido1" id="sido1" style="width:80%; margin:0; background-color:white; padding:0;" class="col-sm-2"></select>
							<select name="gugun1" id="gugun1" style="display:none;"></select>
							<button type="button" onclick="findMap(); return false;" id="submitBttn" style="width:20%; margin:0; padding:0;" class="col-sm-1">찾기</button>
						</div>
					</fieldset>
					
				
				</div>
					<div class="container-fluid" style="height:80%;">
						<div id="map" style="width:100%; opacity:0.8; height:350px; float:none;" class="col-sm-12"></div>
						<div style="height: 2px;background-color: black;margin: 10px 0;">
						
						</div>
						<div class="chart-container col-sm-5" style="position: relative; width:90%; background-color:white; opacity: 0.9;" >
					   		<canvas style="width:50%; height:200px;" id="myChart" ></canvas>
						</div>
					</div>
				</div>
			</td>
		</tr>
		<tr height="7%" style="background-color:#444">
			<td>
				<%@ include file="/WEB-INF/view/seller/bottom.jsp" %>
			
			</td>
		</tr>
	</table>
	
</body>


<!-- 다음 맵 -->
<script>
	var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
	    center : new daum.maps.LatLng(37.5662952,126.9779450999999), // 지도의 중심좌표 
	    level : 10 // 지도의 확대 레벨 
	});
	
	// 마커 클러스터러를 생성합니다 
	var clusterer = new daum.maps.MarkerClusterer({
	    map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	    averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	    minLevel: 10 // 클러스터 할 최소 지도 레벨 
	});
	//alert("cluster 생성");
	
	
    var geocoder = new daum.maps.services.Geocoder();
    var ctx = document.getElementById("myChart").getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        options: {
        	
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    });


	
	

 	
function getCluster(resultArray, gugunData) {
		console.log(gugunData);
		getMyChart(gugunData);
		// 데이터에서 좌표 값을 가지고 마커를 표시합니다
        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
        var markers = $(resultArray).map(function(i, position) {
            return new daum.maps.Marker({
                position : new daum.maps.LatLng(position[0].y, position[0].x)
            });
        });
      	
		
        // 클러스터러에 마커들을 추가합니다
        clusterer.addMarkers(markers);
        
}

</script>

<script>
var dataLength; //ajax로 전송받은 어레이 길이
 // 구군명:갯수
var gugunData = {};
var resultArray = [];
var count = 0;

//찾기 버튼 누를 때 함수
function findMap(){
	myChart.destroy(); //그래프 초기화
	clusterer.clear(); //클러스터 초기화
	resultArray = []; //초기화
	gugunData = {}; //초기화
	count = 0;
	var sido = $("#sido1 option:selected").val(); //선택된 시도
	$('#gugun1>option').each(function() {
		gugunData[$(this).text()]= 0;	
	});
	console.log(gugunData);
	
	
	
	$.ajax({
		url : "/seller/ftDistrictData/ftDistrictDataProc.do",	
		method : "post",
		data : {
			"keyWord" : sido,
		},
		success : function(data){
			dataLength = data.length
			// WTM 좌표를 WGS84 좌표계의 좌표로 변환한다
			for(var i = 0; i < dataLength ; i++) {
				var siteWhlAddrArr = data[i].siteWhlAddr.split(" ");
				for(var key in gugunData) {
					if(siteWhlAddrArr[1] == key) {
						 gugunData[key] +=  1;
					}
				}
				geocoder.transCoord(data[i].x, data[i].y, callback, {
				    input_coord: daum.maps.services.Coords.WTM,
				    output_coord: daum.maps.services.Coords.WGS84
				});
			};
			
			
				
		}
	});
	console.log(sido);
	
	/* 
	var search = "부산광역시청"
	console.log(search);
	
	//주소-좌표 변환 객체를 생성합니다.
	var geocoder = new daum.maps.services.Geocoder();
	
	
	//주소로 좌표를 검색합니다.
	geocoder.addressSearch(search, function(result, status){
		console.log("status : "+status); //status
		
		//정상적으로 검색이 완료됐으면
		if(status === daum.maps.services.Status.OK){
			var coords = new daum.maps.LatLng(result[0].y, result[0].x);
			
			console.log("좌표따기 : " + coords);
			console.log("y : " + result[0].y);
			console.log("x : " + result[0].x);
			
			//지도의 중심을 결과값으로 받은 위치로 이동시킵니다.
			map.setCenter(coords);
		}
	}); 
	*/
	
	 if(sido == "서울"){
		map.setCenter(new daum.maps.LatLng(37.567476, 126.977917));
	}else if(sido == "부산"){
		map.setCenter(new daum.maps.LatLng(35.180013, 129.074957));
	}else if(sido == "대구"){
		map.setCenter(new daum.maps.LatLng(35.879482, 128.602207));
	}else if(sido == "인천"){
		map.setCenter(new daum.maps.LatLng(37.456252, 126.705906));
	}else if(sido == "광주"){
		map.setCenter(new daum.maps.LatLng(35.160368, 126.851446));
	}else if(sido == "대전"){
		map.setCenter(new daum.maps.LatLng(36.3517848, 127.384687));
	}else if(sido == "울산"){
		map.setCenter(new daum.maps.LatLng(35.539637, 129.311380));
	}else if(sido == "강원"){
		map.setCenter(new daum.maps.LatLng(37.8304115, 128.2260705));
	}else if(sido == "경기"){
		map.setCenter(new daum.maps.LatLng(37.5662952, 126.9779450999999));
	}else if(sido == "경상남도"){
		map.setCenter(new daum.maps.LatLng(35.345432, 128.529071));
	}else if(sido == "경상북도"){
		map.setCenter(new daum.maps.LatLng(36.361181, 128.613365));
	}else if(sido == "전라남도"){
		map.setCenter(new daum.maps.LatLng(34.802469, 126.811276));
	}else if(sido == "전라북도"){
		map.setCenter(new daum.maps.LatLng(35.813591, 126.907465));
	}else if(sido == "제주"){
		map.setCenter(new daum.maps.LatLng(33.379874, 126.568968));
	}else if(sido == "충청남도"){
		map.setCenter(new daum.maps.LatLng(36.634259, 126.972876));
	}else if(sido == "충청북도"){
		map.setCenter(new daum.maps.LatLng(36.806978, 127.610151));
	}
	
	
	 
	
	
};// 찾기버튼 끝

var callback = function(result, status) {
    if (status === daum.maps.services.Status.OK) {
        count++;
        resultArray.push(result);
      	if(count == dataLength) {
      		getCluster(resultArray, gugunData);
      	}
    }
};

/* ChartJs 그래프 */
function getMyChart(gugunData) {

	
	ctx = document.getElementById("myChart").getContext('2d');
	ctx.canvas.width = 300;
	ctx.canvas.height = 300;
	var gugunLables = [];
	var gugunDataValues = [];
	for(var key in gugunData) {
		gugunLables.push(key);
		gugunDataValues.push(gugunData[key]);
	};
	
	
	myChart = new Chart(ctx, {
	    type: 'bar',
	    data: {
	        labels: gugunLables,
	        datasets: [{
	            label: '구군 별 푸드트럭 분포',
	            data: gugunDataValues,
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)',
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)',
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)',
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)'
	            ],
	            borderWidth: 1
	        }]
	    },
	    options: {
	        scales: {
	        	xAxes: [{
	                gridLines: {
	                    offsetGridLines: true
	                }
	            }],
	            yAxes: [{
	                ticks: {
	                    beginAtZero:true
	                }
	            }]
	        }
	    }
	});
}


</script>
<%@ include file="/WEB-INF/view/seller/ftDistrictData/sojaeji.jsp" %>
<!-- 소재지 select box -->
<script type="text/javascript">
new sojaeji('sido1', 'gugun1');
new sojaeji('sido2', 'gugun2', 'dong2');
</script>
</html>