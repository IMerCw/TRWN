<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_User_InfoDTO" %>
<%@page import="poly.dto.admin.ADMIN_Board_PostDTO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 
 	List<ADMIN_Board_PostDTO> bDTOArr = (List<ADMIN_Board_PostDTO>)request.getAttribute("board_P_List");
 	List<ADMIN_User_InfoDTO> bp_uDTOarr = (List<ADMIN_User_InfoDTO>)request.getAttribute("bp_uDTOarr");
 	int date_3[] = (int[])request.getAttribute("date_3");
	int date_2[] = (int[])request.getAttribute("date_2");
	int date_1[] = (int[])request.getAttribute("date_1");
	int date_today[] = (int[])request.getAttribute("date_today");
	int date_week_avg[] = (int[])request.getAttribute("date_week_avg");
	int date_week_sum[] = (int[])request.getAttribute("date_week_sum");
	int date_month_avg[] = (int[])request.getAttribute("date_month_avg");
	int date_month_sum[] = (int[])request.getAttribute("date_month_sum");
%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>트럭왔냠 전체 관리자</title>

<!-- Bootstrap -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap.css">

<!-- 1) Load D3.js and billboard.js separately -->
    <!-- Load D3 -->
    <script src="https://d3js.org/d3.v4.min.js"></script>

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/billboard.css">
    <script src="<%=request.getContextPath()%>/resources/js/admin/billboard.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/demo.css"  type="text/css" /> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/editablegrid-1.0.10.css"  type="text/css" /> 
    <style>
    .table_Hline2{
		padding-top:6px;
		padding-bottom:6px;
		padding-left:15px;
		padding-right:15px;
		background-color:#F2F2F2;
		font-weight:bold;
		font-size:12px;
		border-right:1px solid #cccccc;
		text-align:center;
	}
	
	.table_Hline{
		padding-top:10px;
		padding-bottom:10px;
		padding-left:15px;
		padding-right:15px;
		background-color:#F2F2F2;
		font-weight:bold;
		font-size:12px;
		border-right:1px solid #cccccc;
		text-align:center;
		
	}
	.table_Dline2{
		padding-top:5px;
		padding-bottom:5px;
		padding-left:15px;
		padding-right:15px;
		font-size:11px;
		border-right:1px solid #cccccc;
		text-align:center;
	}
	
	.table_Dline{
		padding-top:8px;
		padding-bottom:8px;
		padding-left:15px;
		padding-right:15px;
		font-size:11px;
		border-right:1px solid #cccccc;
		text-align:center;
	}
	
	.table_line2{
		padding-top:5px;
		padding-bottom:5px;
		padding-left:15px;
		padding-right:15px;
		font-size:11px;
		border-right:1px solid #cccccc;
	}
	
	.table_line{
		padding-top:8px;
		padding-bottom:8px;
		padding-left:15px;
		padding-right:15px;
		font-size:11px;
		border-right:1px solid #cccccc;
		text-align:center;
	}
	
	body{
  background-color: #161616;  
}

#chartdiv {	
   width		: 100%;
	height		: 500px;
	background-color: #161616;  
}

.amcharts-graph-g2 .amcharts-graph-stroke {
  stroke-dasharray: 3px 3px;
  stroke-linejoin: round;
  stroke-linecap: round;
  -webkit-animation: am-moving-dashes 1s linear infinite;
  animation: am-moving-dashes 1s linear infinite;
}

@-webkit-keyframes am-moving-dashes {
  100% {
    stroke-dashoffset: -31px;
  }
}
@keyframes am-moving-dashes {
  100% {
    stroke-dashoffset: -31px;
  }
}


.lastBullet {
  -webkit-animation: am-pulsating 1s ease-out infinite;
  animation: am-pulsating 1s ease-out infinite;
}
@-webkit-keyframes am-pulsating {
  0% {
    stroke-opacity: 1;
    stroke-width: 0px;
  }
  100% {
    stroke-opacity: 0;
    stroke-width: 50px;
  }
}
@keyframes am-pulsating {
  0% {
    stroke-opacity: 1;
    stroke-width: 0px;
  }
  100% {
    stroke-opacity: 0;
    stroke-width: 50px;
  }
}

.amcharts-graph-column-front {
  -webkit-transition: all .3s .3s ease-out;
  transition: all .3s .3s ease-out;
}
.amcharts-graph-column-front:hover {
  fill: #496375;
  stroke: #496375;
  -webkit-transition: all .3s ease-out;
  transition: all .3s ease-out;
}

.amcharts-graph-g3 {
  stroke-linejoin: round;
  stroke-linecap: round;
  stroke-dasharray: 500%;
  stroke-dasharray: 0 \0/;    /* fixes IE prob */
  stroke-dashoffset: 0 \0/;   /* fixes IE prob */
  -webkit-animation: am-draw 40s;
  animation: am-draw 40s;
}

.noselect{
  -webkit-touch-callout: none;
  -webkit-user-select: none;
  -khtml-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

@-webkit-keyframes am-draw {
    0% {
        stroke-dashoffset: 500%;
    }
    100% {
        stroke-dashoffset: 0%;
    }
}
@keyframes am-draw {
    0% {
        stroke-dashoffset: 500%;
    }
    100% {
        stroke-dashoffset: 0%;
    }
}
</style>
<script>
	var rs_RankSet_Check;
	var currentDate = new Date();
    var divClock = document.getElementById("divClock");
    
    var dd = currentDate.getDate();
    var mm = currentDate.getMonth()+1; //January is 0!
    var yyyy = currentDate.getFullYear();

    var hour = currentDate.getHours();
    var minute = currentDate.getMinutes();
    
    var dd_3 = dd-3;
    var dd_2 = dd-2;
    var dd_1 = dd-1;
	window.onload = function(){
        
        if(hour<10){
        	hour='0'+hour
        }
        
        if(minute<10){
        	minute='0'+minute
        }
        
        if(dd<10) {
            dd='0'+dd;
            dd_3s='0'+dd_3;
            dd_2s='0'+dd_2;
            dd_1s='0'+dd_1;
        } 
        

        if(mm<10) {
            mm='0'+mm
        } 

        //실시간 검색어 순위 셋팅
        var msg;
        msg = yyyy+".";
        msg += mm+".";
        msg += dd+"　";
        msg += hour+":"
        msg += minute+":";
        msg += "00 기준";
        
        
        //매출현황 테이블 셋팅 
        document.getElementById("rs_rank").innerHTML=msg;
        if(dd_3>0){
        	document.getElementById("date-3").innerHTML=mm+"월 "+dd_3s+"일";
        }else{
        	document.getElementById("date-3").style.backgroundColor="#cccccc";
        }
        if(dd_2>0){
        	document.getElementById("date-2").innerHTML=mm+"월 "+dd_2s+"일";
        }else{
        	document.getElementById("date-2").style.backgroundColor="#cccccc";
        }
        if(dd_1>0){
        	document.getElementById("date-1").innerHTML=mm+"월 "+dd_1s+"일";
        }else{
        	document.getElementById("date-1").style.backgroundColor="#cccccc";
        }
        document.getElementById("date-today").innerHTML=mm+"월 "+dd+"일 (오늘)";
	}
	
	function rs_RankSet1(){
		document.getElementById('rs_RankSet_Btn1').style.backgroundColor="#ffffff";
		document.getElementById('rs_RankSet_Btn2').style.backgroundColor="#f2f2f2";
		document.getElementById('rs_RankSet_F1').style.display="block";
		document.getElementById('rs_RankSet_F2').style.display="none";
	}
	function rs_RankSet2(){
		document.getElementById('rs_RankSet_Btn1').style.backgroundColor="#f2f2f2";
		document.getElementById('rs_RankSet_Btn2').style.backgroundColor="#ffffff";
		document.getElementById('rs_RankSet_F1').style.display="none";
		document.getElementById('rs_RankSet_F2').style.display="block";
	}
</script>
</head>
<body background="<%=request.getContextPath()%>/resources/img/admin/truck_background.jpg" style="background-size: 100%;">
	<%@include file="admin_top.jsp"%>
	<div class="container" style="background-color:rgba(255,255,255,0.9); padding-top:15px; padding-bottom:30px;">
		<div class="row" style="margin-bottom:15px;">
			<div class="col-xs-12 col-sm-9" style="margin-bottom:15px;">
				<div style="height:320px; border:1px solid #cccccc;">
					<h5 style="float:left;">&nbsp;&nbsp;&nbsp;<b>공지사항</b></h5>
					<div style="border-bottom:1px solid #cccccc; margin-bottom:10px; clear:both;"></div>
					<div style="width:auto; height: 262px; margin-left:10px; margin-right:10px;">
						<table style="width:100%; border:1px solid #cccccc;" id="htmlgrid" class="testgrid">
							<tr style="border-bottom:1px solid #cccccc;">
								<th width="12%" class="table_Hline2">게시물 번호</th>
								<th width="60%" class="table_Hline2">제목</th>
								<th width="10%" class="table_Hline2">조회수</th>
								<th width="18%" class="table_Hline2">날짜</th>
							</tr>
							<% int i=0;
							for(ADMIN_Board_PostDTO bpDTO : bDTOArr){%>
								<tr style="cursor:pointer;" onclick="location.href='<%=request.getContextPath()%>/admin/board_p/board_p_info.do?board_p_seq=<%=bDTOArr.get(i).getBoard_p_seq()%>'">
									<td class="table_Dline2"><%=bpDTO.getBoard_p_seq()%></td>
									<td class="table_line2">
									<%if(!bDTOArr.get(i).getBoard_level().equals(String.valueOf(bDTOArr.get(i).getBoard_p_seq()))){ %>
   									<img src="<%=request.getContextPath()%>/resources/img/admin/reple_icon.png">
   								<%} %>
					<%=bDTOArr.get(i).getTitle()%>&nbsp;<b>[<%=bDTOArr.get(i).getReple_count()%>]</b>
					<%if(!bDTOArr.get(i).getFile_id().equals("-1")){ %>
						<img src="<%=request.getContextPath()%>/resources/img/admin/c3.png">
					<%} %>
									</td>
									<td class="table_line2" align="center"><%=bpDTO.getBoard_count()%></td>
									<td class="table_line2" align="center"><%=bpDTO.getReg_date()%></td>
								</tr>
							<%i++; if(i==9){break;}}%>
						</table>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-3" style="min-width:262px;">
				<div style="height:320px; border:1px solid #cccccc;">
					<h5>&nbsp;&nbsp;&nbsp;<b>실시간 검색 순위</b></h5>
					<div style="border-bottom:1px solid #cccccc; margin-bottom:10px; clear:both;"></div>
					<div style="width:auto; height: 242px; margin-left:10px; margin-right:10px;"> 
						<div class="row" align="center">
							<span style="cursor:pointer; border:1px solid #cccccc; font-size:11px; padding-left:33px; padding-right:33px; padding-top:3px; padding-bottom:3px;"
							id="rs_RankSet_Btn1" onclick="javascript:rs_RankSet1()" class="noselect">
								1~10위
							</span>
							<span style="cursor:pointer; border:1px solid #cccccc; font-size:11px; padding-left:30px; padding-right:30px; padding-top:3px; padding-bottom:3px; background-color:#f2f2f2;"
							id="rs_RankSet_Btn2" onclick="javascript:rs_RankSet2()" class="noselect">
								11위 20위
							</span>
							<div style="border-bottom:1px solid #cccccc; margin-top:3px; margin-left:24px; margin-right:24px; padding-top:10px; height:215px; display:block;" id="rs_RankSet_F1">
							
							</div>
							<div style="border-bottom:1px solid #cccccc; margin-top:3px; margin-left:24px; margin-right:24px; padding-top:10px; height:215px; display:none;" id="rs_RankSet_F2">
							
							</div>
						</div>
					</div>
					<div style="border-top:1px solid #cccccc; margin-bottom:10px; background-color:#f2f2f2; height:30px;clear:both;">
						<h6 style="padding-left:15px; padding-right:15px;" id="rs_rank"></h6>
					</div>
				</div>			
			</div>
		</div>
		<div style="width:100%; border:1px solid #cccccc; height:160px; background-color:#ffffff; margin-bottom:20px;">
			<table style="width:100%; height:100%;">
				<tr height="60px">
					<td style="border-right:1px solid #cccccc; width:25%;"></td>
					<td style="border-right:1px solid #cccccc; width:25%;"></td>
					<td style="border-right:1px solid #cccccc; width:25%;"></td>
					<td style="width:25%;"></td> 
				</tr>
				<tr height="40px">
					<td style="border-right:1px solid #cccccc; width:25%;"></td>
					<td style="border-right:1px solid #cccccc; width:25%;"></td>
					<td style="border-right:1px solid #cccccc; width:25%;"></td>
					<td style="width:25%;"></td>
				</tr>
			</table>
		</div>
		<script src="https://www.amcharts.com/lib/3/amcharts.js?x"></script>
		<script src="https://www.amcharts.com/lib/3/serial.js?x"></script>
		<script src="https://www.amcharts.com/lib/3/themes/dark.js"></script>
		<div id="chartdiv"></div>
		<div class="row" style="margin-bottom:25px; margin-top:25px;">
			<div class="col-xs-12 col-sm-12" align="center">
				<h5 style="float:left;">&nbsp;|&nbsp;<b>매출통계</b></h5>
				<div style="border-bottom:1px solid #cccccc; margin-bottom:10px; clear:both;"></div>
			</div>
			<div class="col-xs-12 col-sm-6" align="center" style="padding-top:30px;">
				<!-- Markup -->
				<div id="LinkedTooltips_1"></div>
			</div>
			<div class="col-xs-12 col-sm-6"  align="center">
				<table class="testgrid" style="width:100%; border:1px solid #cccccc;">
					<tr style="border-bottom:1px solid #cccccc;">
						<th class="table_Hline" width="30%">날짜</th>
						<th class="table_Hline" width="23%">주문</th>
						<th class="table_Hline" width="23%">결제</th>
						<th class="table_Hline" width="23%">환불</th> 
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline" id="date-3"></td>
						<td class="table_line"><%=date_3[0]%>원<br>(<%=date_3[3]%>건)</td>
						<td class="table_line"><%=date_3[1]%>원<br>(<%=date_3[4]%>건)</td>
						<td class="table_line"><%=date_3[2]%>원<br>(<%=date_3[5]%>건)</td>
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline" id="date-2"></td>
						<td class="table_line"><%=date_2[0]%>원<br>(<%=date_2[3]%>건)</td>
						<td class="table_line"><%=date_2[1]%>원<br>(<%=date_2[4]%>건)</td>
						<td class="table_line"><%=date_2[2]%>원<br>(<%=date_2[5]%>건)</td>
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline" id="date-1"></td>
						<td class="table_line"><%=date_1[0]%>원<br>(<%=date_1[3]%>건)</td>
						<td class="table_line"><%=date_1[1]%>원<br>(<%=date_1[4]%>건)</td>
						<td class="table_line"><%=date_1[2]%>원<br>(<%=date_1[5]%>건)</td>
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline" id="date-today"></td>
						<td class="table_line"><%=date_today[0]%>원<br>(<%=date_today[3]%>건)</td>
						<td class="table_line"><%=date_today[1]%>원<br>(<%=date_today[4]%>건)</td>
						<td class="table_line"><%=date_today[2]%>원<br>(<%=date_today[5]%>건)</td>
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline">최근 7일 평균</td>
						<td class="table_line"><%=date_week_avg[0]%>원<br>(<%=date_week_avg[3]%>건)</td>
						<td class="table_line"><%=date_week_avg[1]%>원<br>(<%=date_week_avg[4]%>건)</td>
						<td class="table_line"><%=date_week_avg[2]%>원<br>(<%=date_week_avg[5]%>건)</td>
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline">최근 7일 합계</td>
						<td class="table_line"><%=date_week_sum[0]%>원<br>(<%=date_week_sum[3]%>건)</td>
						<td class="table_line"><%=date_week_sum[1]%>원<br>(<%=date_week_sum[4]%>건)</td>
						<td class="table_line"><%=date_week_sum[2]%>원<br>(<%=date_week_sum[5]%>건)</td>
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline">최근 30일 평균</td>
						<td class="table_line"><%=date_month_avg[0]%>원<br>(<%=date_month_avg[3]%>건)</td>
						<td class="table_line"><%=date_month_avg[1]%>원<br>(<%=date_month_avg[4]%>건)</td>
						<td class="table_line"><%=date_month_avg[2]%>원<br>(<%=date_month_avg[5]%>건)</td>
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline">최근 30일 합계</td>
						<td class="table_line"><%=date_month_sum[0]%>원<br>(<%=date_month_sum[3]%>건)</td>
						<td class="table_line"><%=date_month_sum[1]%>원<br>(<%=date_month_sum[4]%>건)</td>
						<td class="table_line"><%=date_month_sum[2]%>원<br>(<%=date_month_sum[5]%>건)</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12" align="center">
				<h5 style="float:left;">&nbsp;|&nbsp;<b>푸드트럭 위치검색</b></h5>
				<div style="border-bottom:1px solid #cccccc; margin-bottom:10px; clear:both;"></div>
				<div style="width:100%; height:auto;">
					<%@include file="admin_truck_loc.jsp"%>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12" align="center" style="margin-top:30px;">
				<h5 style="float:left;">&nbsp;|&nbsp;<b>푸드트럭 랭크</b></h5>
				<div style="border-bottom:1px solid #cccccc; margin-bottom:10px; clear:both;"></div>
				<div style="width:100%; height:auto;">
					<%@include file="admin_truck_slider.jsp"%>
				</div>
			</div>
		</div>
	</div>
	<footer class="text-center">
		<hr>
		<%@include file="admin_bottom.jsp"%>
	</footer>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/admin/jquery-1.11.2.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="<%=request.getContextPath()%>/resources/js/admin/Easygraphs.js"></script>
	<script>
	// Script
	if(dd_3<=0){
		var chart = bb.generate({
		  data: {
		    x: "x",
		    columns: [
		    	["x", yyyy+"-"+mm+"-"+dd_2, yyyy+"-"+mm+"-"+dd_1, yyyy+"-"+mm+"-"+dd],
				["주문", <%=date_2[0]%>, <%=date_1[0]%>, <%=date_today[0]%>],
				["결제", <%=date_2[1]%>, <%=date_1[1]%>, <%=date_today[1]%>],
				["환불", <%=date_2[2]%>, <%=date_1[2]%>, <%=date_today[2]%>]
		    ]
		  },
		  axis: {
		    x: {
		      type: "timeseries",
		      tick: {
		        format: "%y-%m-%d"
		      }
		    }
		  },
		  tooltip: {
		    linked: true
		  },
		  bindto: "#LinkedTooltips_1"
		});
	}else if(dd_2<=0){
		var chart = bb.generate({
			  data: {
			    x: "x",
			    columns: [
			    	["x", yyyy+"-"+mm+"-"+dd_1, yyyy+"-"+mm+"-"+dd],
					["주문", <%=date_1[0]%>, <%=date_today[0]%>],
					["결제", <%=date_1[1]%>, <%=date_today[1]%>],
					["환불", <%=date_1[2]%>, <%=date_today[2]%>]
			    ]
			  },
			  axis: {
			    x: {
			      type: "timeseries",
			      tick: {
			        format: "%y-%m-%d"
			      }
			    }
			  },
			  tooltip: {
			    linked: true
			  },
			  bindto: "#LinkedTooltips_1"
			});
	}else if(dd_1<=0){
		var chart = bb.generate({
			  data: {
			    x: "x",
			    columns: [
			    	["x", yyyy+"-"+mm+"-"+dd],
					["주문", <%=date_today[0]%>],
					["결제", <%=date_today[1]%>],
					["환불", <%=date_today[2]%>]
			    ]
			  },
			  axis: {
			    x: {
			      type: "timeseries",
			      tick: {
			        format: "%y-%m-%d"
			      }
			    }
			  },
			  tooltip: {
			    linked: true
			  },
			  bindto: "#LinkedTooltips_1"
			});
	}else{
		var chart = bb.generate({
			  data: {
			    x: "x",
			    columns: [
			    	["x", yyyy+"-"+mm+"-"+dd_3, yyyy+"-"+mm+"-"+dd_2, yyyy+"-"+mm+"-"+dd_1, yyyy+"-"+mm+"-"+dd],
					["주문", <%=date_3[0]%>, <%=date_2[0]%>, <%=date_1[0]%>, <%=date_today[0]%>],
					["결제", <%=date_3[1]%>, <%=date_2[1]%>, <%=date_1[1]%>, <%=date_today[1]%>],
					["환불", <%=date_3[2]%>, <%=date_2[2]%>, <%=date_1[2]%>, <%=date_today[2]%>]
			    ]
			  },
			  axis: {
			    x: {
			      type: "timeseries",
			      tick: {
			        format: "%y-%m-%d"
			      }
			    }
			  },
			  tooltip: {
			    linked: true
			  },
			  bindto: "#LinkedTooltips_1"
			});
	}
	</script>
	
	<script>
	var chartData = [
	    {
	        "date": "2018-01",
	        "distance": 227,
	        "townName": "New York",
	        "townName2": "1분기",
	        "townSize": 25,
	        "latitude": 40.71,
	        "duration": 18
	    },
	    {
	        "date": "2018-02",
	        "distance": 371,
	        "townName": "Washington",
	        "townSize": 14,
	        "latitude": 38.89,
	        "duration": 42
	    },
	    {
	        "date": "2018-03",
	        "distance": 433,
	        "townName": "Wilmington",
	        "townSize": 6,
	        "latitude": 34.22,
	        "duration": 37
	    },
	    {
	        "date": "2018-04",
	        "distance": 345,
	        "townName": "Jacksonville",
	        "townName2": "2분기",
	        "townSize": 7,
	        "latitude": 30.35,
	        "duration": 26
	    },
	    {
	        "date": "2018-05",
	        "distance": 480,
	        "townName": "Miami",
	        "townSize": 10,
	        "latitude": 25.83,
	        "duration": 69
	    },
	    {
	        "date": "2018-06",
	        "distance": 386,
	        "townName": "Tallahassee",
	        "townSize": 7,
	        "latitude": 30.46,
	        "duration": 55
	    },
	    {
	        "date": "2018-07",
	        "distance": 348,
	        "townName": "New Orleans",
	        "townName2": "3분기",
	        "townSize": 10,
	        "latitude": 29.94,
	        "duration": 88
	    },
	    {
	        "date": "2018-08",
	        "distance": 238,
	        "townName": "Houston",
	        "townSize": 16,
	        "latitude": 29.76,
	        "duration": 76
	    },
	    {
	        "date": "2018-09",
	        "distance": 218,
	        "townName": "Dalas",
	        "townSize": 17,
	        "latitude": 32.8,
	        "duration": 95
	    },
	    {
	        "date": "2018-10",
	        "distance": 349,
	        "townName": "Oklahoma City",
	        "townName2": "4분기",
	        "townSize": 11,
	        "latitude": 35.49,
	        "duration": 67
	    },
	    {
	        "date": "2018-11",
	        "distance": 603,
	        "townName": "Kansas City",
	        "townSize": 10,
	        "latitude": 39.1,
	        "duration": 54
	    },
	    {
	        "date": "2018-12",
	        "distance": 534,
	        "townName": "Denver",
	        "townSize": 18,
	        "latitude": 39.74,
	        "duration": 45
	    }
	];
	var chart = AmCharts.makeChart("chartdiv", {
	  type: "serial",
	  theme: "dark",
	  dataDateFormat: "YYYY-MM",
	  dataProvider: chartData,

	  addClassNames: true,
	  startDuration: 1,
	  color: "#FFFFFF",
	  marginLeft: 0,
	  categoryField: "date",
	  categoryAxis: {
	    parseDates: true,
	    minPeriod: "MM",
	    autoGridCount: false,
	    gridCount: 50,
	    gridAlpha: 0.1,
	    gridColor: "#FFFFFF",
	    axisColor: "#555555",
	    dateFormats: [{
	        period: 'DD',
	        format: 'DD'
	    }, {
	        period: 'WW',
	        format: 'MMM DD'
	    }, {
	        period: 'MM',
	        format: 'MMM'
	    }, {
	        period: 'YYYY',
	        format: 'YYYY'
	    }]
	  },

	  valueAxes: [{
	    id: "a1",
	    title: "매출",
	    gridAlpha: 0,
	    axisAlpha: 0
	  },{
	    id: "a2",
	    position: "right",
	    gridAlpha: 0,
	    axisAlpha: 0,
	    labelsEnabled: false
	  },{
	    id: "a3",
	    title: "영업이익률",
	    position: "right",
	    gridAlpha: 0,
	    axisAlpha: 0,
	    inside: true,
	  }],
	  graphs: [{
	    id: "g1",
	    valueField:  "distance",
	    title:  "영업이익",
	    type:  "column",
	    fillAlphas:  0.9,
	    valueAxis:  "a1",
	    balloonText:  "영업이익:[[value]]원",
	    legendValueText:  "[[value]]원",
	    legendPeriodValueText:  "total: [[value.sum]]원",
	    lineColor:  "#263138",
	    alphaField:  "alpha",
	  },{
	    id: "g2",
	    valueField: "latitude",
	    classNameField: "bulletClass",
	    title: "순이익",
	    type: "line",
	    valueAxis: "a2",
	    lineColor: "#786c56",
	    lineThickness: 1,
	    legendValueText: "[[value]]원",
	    descriptionField: "townName",
	    bullet: "round",
	    bulletSizeField: "townSize",
	    bulletBorderColor: "#786c56",
	    bulletBorderAlpha: 1,
	    bulletBorderThickness: 2,
	    bulletColor: "#000000",
	    labelText: "[[townName2]]",
	    labelPosition: "right",
	    balloonText: "순이익:[[value]]원",
	    showBalloon: true,
	    animationPlayed: true,
	  },{
	    id: "g3",
	    title: "영업이익률",
	    valueField: "duration",
	    type: "line",
	    valueAxis: "a3",
	    lineColor: "#ff5755",
	    balloonText: "영업이익률:[[value]]%",
	    lineThickness: 1,
	    legendValueText: "[[value]]",
	    bullet: "square",
	    bulletBorderColor: "#ff5755",
	    bulletBorderThickness: 1,
	    bulletBorderAlpha: 1,
	    dashLengthField: "dashLength",
	    animationPlayed: true
	  }],

	  chartCursor: {
	    zoomable: false,
	    categoryBalloonDateFormat: "MM",
	    cursorAlpha: 0,
	    valueBalloonsEnabled: false
	  },
	  legend: {
	    bulletType: "round",
	    equalWidths: false,
	    valueWidth: 120,
	    useGraphSettings: true,
	    color: "#FFFFFF"
	  }
	});
	</script>
</body>
</html>