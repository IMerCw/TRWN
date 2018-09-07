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
<%@ include file="/WEB-INF/view/seller/topCssScript.jsp" %>
</head>
<body>


<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="#444">
			<td style="padding:0;">
				
				<%@ include file="/WEB-INF/view/seller/top.jsp" %>
			</td>
		</tr>
		<tr bgcolor="">
			<td>
				<div class="container">
				<div class="col-sm-12" >
				
					<!-- 	<fieldset>
					<legend>주소그룹2</legend>
					<select name="sido2" id="sido2"></select>
					<select name="gugun2" id="gugun2"></select>
					<select name="dong2" id="dong2"></select>
					</fieldset> -->
					<fieldset style="margin-top:2%">
						<h3 style="display:inline; margin:0; padding:0;" class="col-sm-8">구군 별 푸드트럭 분포</h3>
							<select name="sido1" id="sido1" style="margin:0; padding:0;" class="col-sm-2"></select>
							<select name="gugun1" id="gugun1" style="display:none;"></select>
							<button type="button" onclick="findMap(); return false;" id="submitBttn" style="margin:0; padding:0;" class="col-sm-1">찾기</button>
					</fieldset>
					
				
				</div>
					<div class="col-sm-12" style="height:80%;">
						<div id="map" style="width:90%; height:350px; float:none;" class="col-sm-12"></div>
						<div style="height: 2px;background-color: black;margin: 10px 0;">
						
						</div>
						<div class="chart-container col-sm-5" style="position: relative; width:90%;" >
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
	    center : new daum.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
	    level : 14 // 지도의 확대 레벨 
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
};

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