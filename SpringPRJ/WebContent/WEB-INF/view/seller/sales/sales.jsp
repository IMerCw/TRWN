<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int dayIndex =  (int)request.getAttribute("dayIndex");
double percentD = 	(double)request.getAttribute("percentD") ;
int timeIndex = (int)request.getAttribute("timeIndex"); 
double percentT = (double)request.getAttribute("percentT") ;
double percentM = (double) request.getAttribute("percentM");
double percentF = (double) request.getAttribute("percentF");
int[] arrayDay2 = (int[])request.getAttribute("arrayDay");
String stringDay = "";
String stringTime ="";
 %>
 
 <%-- 요일은 = <%=dayIndex %>
요일% = <%=percentD %>
시간은 = <%=timeIndex %>*3 ~ +3시간 까지
시간대% = <%=percentT %>
남자비율은 = <%=percentM %>
여자비율은 = <%=percentF %>
요일별 데이터는 = 
	<% for(int i=0; i< arrayDay2.length; i++){
		out.println(arrayDay2[i]);	
	}
	%> --%> 
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>트럭왔냠 - 매출 분석</title>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<!-- 차트 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

	
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
				<div class="container" style="background-color:#ffffff; padding: 20px 40px 80px 40px; border-radius:8px;">
					<h2 style="">매출분석</h2>
					<hr>
					<h3>
						<span class="label label-Warning">
						<%
						switch(dayIndex)  {
								case 0 : stringDay="일"; break;
								case 1 : stringDay="월"; break;
								case 2 : stringDay="화"; break;
								case 3 : stringDay="수"; break;
								case 4 : stringDay="목"; break;
								case 5 : stringDay="금"; break;
								case 6 : stringDay="토"; break;
								}
						%>
						<%=stringDay%>요일,
						 <%
						switch(timeIndex)  {
								case 0 : stringTime="0시~3시"; break;
								case 1 : stringTime="3시~6시"; break;
								case 2 : stringTime="6시~9시"; break;
								case 3 : stringTime="9시~12시"; break;
								case 4 : stringTime="12시~15시"; break;
								case 5 : stringTime="15시~18시"; break;
								case 6 : stringTime="18시~21시"; break;
								case 7 : stringTime="21시~24시"; break;
								}
						%>
						<%=stringTime%>의 매출비중이 높고 , *20~30세* 
						<%if(percentM > percentF){ %>
						남성 (<%= percentM%>%)
						<%}else{ %>
						여성 (<%= percentF%>%)
						<%} %>
						이 주요고객</span>
					</h3>
					<br>
					<div class="col-sm-12" style="font-size: 18px;">
						분석지역 내 매출특성은
						<span style="font-weight:bold; color: #d9534f;">
							<%=stringDay%>요일
							(<%=percentD %>%),
						</span>
						
						<span style="font-weight:bold; color: #d9534f;">
							<%=stringTime%>
							(<%=percentT %>%) 
						</span>
						사이의 매출이 높은 것으로 나타났습니다.
					</div>
					<div class="col-sm-12" style="height:12px;"></div>
					<div class="col-sm-12" style="font-size: 18px;">
					 	<span style="font-weight:bold; color: #000000;">
					 	*20~30세*
					 	</span>
						<%if(percentM > percentF){ %>
						<span style="font-weight:bold; color: #337ab7;">
						남성 (<%= percentM%>%)
						</span>
						<%}else{ %>
						<span style="font-weight:bold; color: #ff9390;">
						여성 (<%= percentF%>%)
						</span>
						<%} %>
						 이 주요고객인 것으로 분석 되었습니다 .	
					</div>
					<div class="col-sm-12" style="height:24px;"></div>
					<br>
					<div style="border:1px solid black; background-color:white;" class="col-sm-12">
					
						<div class="col-sm-6">
							<canvas id="myChart" width="400" height="400"></canvas>
						</div>
						<div class="col-sm-6">
							<canvas id="myChart2" width="400" height="400"></canvas>
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
	
	<!-- 요일별 차트 -->
	<script>
	var arrayDay = [];
	
	<%for(int i = 0; i < arrayDay2.length; i++) {%>
		arrayDay.push(<%=arrayDay2[i]%>);
	<%}%>
	
	for(var j=0; j<arrayDay.length; j++){
		console.log("arrayDay " + j+ ":" +arrayDay[j]);
		
	}
		var ctx = document.getElementById("myChart").getContext('2d');
		var myChart = new Chart(ctx, {
		    type: 'line',
		    data: {
		        labels: [ "일", "월", "화", "수", "목", "금", "토"],
		        datasets: [{
		            label: '# day',
		            data: arrayDay,
		            backgroundColor: [
		            	 'rgba(0,0,0,0)'
		            ],
		            borderColor: [
		                'rgba(255,99,132,1)',
		                'rgba(54, 162, 235, 1)',
		                'rgba(255, 206, 86, 1)',
		                'rgba(75, 192, 192, 1)',
		                'rgba(153, 102, 255, 1)',
		                'rgba(255, 159, 64, 1)'
		            ],
		            borderWidth: 1
		        }]
		    },
		    
		    
		     options: {
		       elements: {
		            line: {
		                tension: 0, // disables bezier curves
		            }
		        },
		        scales: {
		            yAxes: [{
		                ticks: {
		                    min: 0,
		                    stepSize: 1
		                }
		            }]
		        }
		    } 
		});
		</script>
		<!-- 성별 차트 -->
	<script>
		var ctx = document.getElementById("myChart2").getContext('2d');
		var myChart2 = new Chart(ctx, {
		    type: 'pie',
		    data: {
		        labels: ["여성", "남성"],
		        datasets: [{
		            label: '# of Votes',
		            data: [<%=percentF %>, <%=percentM %>],
		            backgroundColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)'
		            ],
		            borderColor: [
		                'rgba(255,99,132,1)',
		                'rgba(54, 162, 235, 1)'
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
		</script>
</body>
</html>