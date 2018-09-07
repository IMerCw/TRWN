<%@page import="poly.util.CmmUtil"%>
<%@page import="poly.dto.seller.SELLER_OrderInfoDTO"%>
<%@page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>chart</title>
<%-- <%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %> --%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

</head>
<body>
	<%-- <div>
		<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>	<!-- topBody에서 session으로 userEmail을 받는다. -->
	</div> --%>
	<div style="margin-bottom:20px">
	
		<div role="tabpanel" style="margin: 20px">
		
		 	 <!-- Nav tabs -->
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="#Week" aria-controls="profile" role="tab" data-toggle="tab">이번주 매출</a></li>
				<li role="presentation"><a href="#Month" aria-controls="messages" role="tab" data-toggle="tab">월별 매출</a></li>
				<li role="#"><a href="#" aria-controls="#" role="#" data-toggle="#">매출분석</a></li>
			</ul>
		
			<!-- Tab panes -->
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane fade in active" id="Week">
					<canvas id="myChartWeek" style="width: 100%;"></canvas>
				</div>
				<div role="tabpanel" class="tab-pane fade" id="Month">
					<canvas id="myChartMonth" style="width: 100%;"></canvas>
				</div>
			</div>
		</div>
		<!-- 매출 정보 숫자 시작  -->
		<div style="margin-top:35px;">
			<div style="float:left; width:48%;">	<!-- float은 구석으로 차곡차곡 밀어 넣는 속성이기 때문에 두 div를 같은 위치에 밀어 넣고 싶은 땐  style="clear:both"를 해주어야 함 -->
				<div style="padding-bottom:5px; border-bottom:1px solid #cccccc; margin-bottom:15px;">
					<span style="border:1px solid #cccccc; padding-left:20px; padding-right:20px; padding-top:8px; padding-bottom:8px;">today - 0</span>
				</div>
			</div>
			<div style="float:right; width:48%;">
				<div style="padding-bottom:5px; border-bottom:1px solid #cccccc; margin-bottom:15px;">
					<span style="border:1px solid #cccccc; padding-left:20px; padding-right:20px; padding-top:8px; padding-bottom:8px;">오늘 총매출</span> <span style="float:right;">0원</span>
				</div>
				<div style="padding-bottom:5px; border-bottom:1px solid #cccccc; margin-bottom:15px;">
					<span style="border:1px solid #cccccc; padding-left:20px; padding-right:20px; padding-top:8px; padding-bottom:8px;">이번주 총매출</span> <span style="float:right;">0원</span>
				</div>
				<div style="padding-bottom:5px; border-bottom:1px solid #cccccc; margin-bottom:15px;">
					<span style="border:1px solid #cccccc; padding-left:20px; padding-right:20px; padding-top:8px; padding-bottom:8px;">이번달 총매출</span> <span style="float:right;">0원</span>
				</div>
			</div>
			<div style="clear:both; border-bottom:1px solid #cccccc;"></div>
		</div>
		
		
	</div>
	
<script>//이번주 매출
var ctx = document.getElementById("myChartWeek").getContext('2d');
var myChartWeek = new Chart(ctx, {
    type: 'bar',
    data: {
    	
	    labels: ["0"],		
	    
	    datasets: [{
	            label: '최근 일주일간 매출',
	            data: [0],	//데이터 들어가는 곳
	            backgroundColor: 
	                'rgba(75, 192, 192, 0.2)',
	            borderColor: 
	                'rgba(75, 192, 192, 1)',
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
</script>

<script>//이번달 매출
var ctx = document.getElementById("myChartMonth").getContext('2d');
var myChartMonth = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: [0],		//월간
        datasets: [{
            label: '연간 매출',
            data: [0],	//데이터 들어가는 곳
            backgroundColor: 
                'rgba(102, 195, 214, 0.2)',
            borderColor: 
                'rgba(102, 195, 214, 1)',
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
</script>

</body>
</html>