<%@page import="poly.util.CmmUtil"%>
<%@page import="poly.dto.seller.SELLER_OrderInfoDTO"%>
<%@page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
  <%
    	String todayMD = (String)request.getAttribute("todayMD");
		String todayYMDhms = (String)request.getAttribute("todayYMDhms");
		String todayDD = (String)request.getAttribute("todayDD");
		SELLER_OrderInfoDTO sumChartWeek = (SELLER_OrderInfoDTO)request.getAttribute("sumChartWeek");
		List<SELLER_OrderInfoDTO> oList = (List<SELLER_OrderInfoDTO>)request.getAttribute("oList");
		List<SELLER_OrderInfoDTO> wList = (List<SELLER_OrderInfoDTO>)request.getAttribute("wList");
    	
		//out.println(todayMD);
    	//out.println(todayYMDhms);
    	//out.println(todayDD);
    	//out.println(sumChartWeek.getOrd_sumprice());
    	//DateUtil.getDate();
    	//String todayDate = (String)DateUtil.getDate();
	   	//int todayY = Integer.parseInt(todayYMDhms.substring(0, 4));
	   	//out.println(todayY);
	   	//int todayM = Integer.parseInt(todayYMDhms.substring(5, 7));
	   	//out.println(todayM);
	   	//int todayD = Integer.parseInt(todayYMDhms.substring(8, 10));
	   	//out.println(todayD);
    %> 
    
	<!-- 월별 매출액  -->
	<%
		List<SELLER_OrderInfoDTO> monthChart = (List<SELLER_OrderInfoDTO>)request.getAttribute("monthChart");
		String ss_userSeq = CmmUtil.nvl((String)session.getAttribute("userSeq"));
	%>
 	<%-- <!-- 일간 매출액 시작 -->
	<%
		int sumpriceT = 0;	//오늘 총매출
		int sumpriceW = 0;	//이번주 총매출
		int sumpriceM = 0;	//이번달 총매출
		int sumProfit[] = new int[7];
		
	   	for(int i=0; i<oList.size(); i++) {
				
			   	String str = oList.get(i).getOrd_date();
			   	int sumprice = oList.get(i).getOrd_sumprice();
			   	int orderY = Integer.parseInt(str.substring(0, 4));
			   	int orderM = Integer.parseInt(str.substring(5, 7));
			   	int orderD = Integer.parseInt(str.substring(8, 10));
				
				if(todayY == orderY && todayM == orderM && ((todayD == orderD))) {
					sumpriceT += sumprice;
				}
				
			   	if(todayY == orderY && todayM == orderM && ((todayD - orderD)<=7)) {
			   		sumpriceW += sumprice;
			   	}
			   	
			   	if(todayY == orderY && todayM == orderM && ((todayD - orderD)<=30)) {
			   		/* System.out.println("------------------------");
			   		System.out.println("substring 년도 : " + orderY);
				   	System.out.println("substring 월 : " + orderM);
				   	System.out.println("substring 일 : " + orderD);
			   		System.out.println("일 수 차이 : " + (todayD - orderD));
			   		System.out.println("------------------------"); */
			   		sumpriceM += sumprice;
					
			   	}
			
		
		}
	   	System.out.println("오늘 매출액: " + sumpriceT);
		System.out.println("이번주 매출액: " + sumpriceW);
		System.out.println("이번달 매출액: " + sumpriceM);
		String sumpriceToday = CmmUtil.addComma(sumpriceT);
		String sumpriceWeek = CmmUtil.addComma(sumpriceW);
		String sumpriceMonth = CmmUtil.addComma(sumpriceM);
		
	%>
	<!-- 일간 매출액 끝 --> --%>
    

	<div style="margin-bottom:20px" >
		
	 	 <!-- Nav tabs -->
		<ul class="nav nav-pills" style="background-color:black; padding: 10px;">
			<li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab" style="color:white;">&nbsp;&nbsp;&nbsp;&nbsp;7일간 매출</a></li>
			<li role="presentation"><a href="#tapp" aria-controls="tapp" role="tab" data-toggle="tab" style="color:white;">월별 매출</a></li>
			<li role="#"><a href="#" aria-controls="#" role="#" data-toggle="#" style="color:white;">매출분석</a></li>
		</ul>
		
			<!-- Tab panes -->
			
		<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="home">
					<div id="chartdiv"></div>
				</div> 
				<div role="tabpanel" class="tab-pane" id="tapp">
					<div id="chartdivM"></div>
				</div>
		</div> 
		
		
		<!-- 매출 정보 숫자 시작  -->
		<%--  <div style="margin-top:35px;">
			<div style="float:left; width:48%;">	<!-- float은 구석으로 차곡차곡 밀어 넣는 속성이기 때문에 두 div를 같은 위치에 밀어 넣고 싶은 땐  style="clear:both"를 해주어야 함 -->
				<div style="padding-bottom:5px; border-bottom:1px solid #cccccc; margin-bottom:15px;">
					<span style="border:1px solid #cccccc; padding-left:20px; padding-right:20px; padding-top:8px; padding-bottom:8px;">today - <%=todayMD %></span>
				</div>
			</div>
			<div style="float:right; width:48%;">
				<div style="padding-bottom:5px; border-bottom:1px solid #cccccc; margin-bottom:15px;">
					<span style="border:1px solid #cccccc; padding-left:20px; padding-right:20px; padding-top:8px; padding-bottom:8px;">오늘 총매출</span> <span style="float:right;"><%=sumpriceToday %> >원</span>
				</div>
				<div style="padding-bottom:5px; border-bottom:1px solid #cccccc; margin-bottom:15px;">
					<span style="border:1px solid #cccccc; padding-left:20px; padding-right:20px; padding-top:8px; padding-bottom:8px;">이번주 총매출</span> <span style="float:right;"><%=sumpriceWeek %> 원</span>
				</div>
				<div style="padding-bottom:5px; border-bottom:1px solid #cccccc; margin-bottom:15px;">
					<span style="border:1px solid #cccccc; padding-left:20px; padding-right:20px; padding-top:8px; padding-bottom:8px;">이번달 총매출</span> <span style="float:right;"> <%=sumpriceMonth %> 원</span>
				</div>
			</div>
			<div style="clear:both; border-bottom:1px solid #cccccc;"></div>
		</div>  --%>
		
	</div>
	


<script>
	//Ajax 댓글
	<%-- function ajaxTest(){
		
			var content = $('#contentAjax').val();
			var boardPSeq = $('#boardPSeqAjax').val();
			var userSeq	 = $('#userSeqAjax').val();
			var repleSeq = $('#repleSeqAjax').val();
			var ssUserSeq = <%=userSeq%>;
			
		if(userSeq) {
			
			$.ajax({
				type:'post',
				url: "/board/reple.do",
				data: {
					'content':content,
					'boardPSeq':boardPSeq,
					'userSeq':userSeq
				},
				success: function(data) {
					console.log(data);
					var contents ='';
	                
	                $.each(data,function (key,value){
	                	
	                    contents += "<div><h6><strong>userSeq : " + value.userSeq + "&nbsp;&nbsp;Date : " + value.regDate +"</strong></h6>";
	                    contents += "<span>" + value.content + "</span>";
	                    
	                    /* if(ssUserSeq.equals(value.userSeq)){
	                    contents += "<div class='btn-group' role='group' aria-label='...' style='float:right'>";
	                    contents += "<button type='button' class='btn btn-default'>수정</button><button type='button' class='btn btn-default'>삭제</button></div>";
	                    } */
	                    
	                    contents += "<div class='btn-group' role='group' aria-label='...' style='float:right'>";
	                    contents += "<button type='button' class='btn btn-default'>수정</button><button type='button' class='btn btn-default'>삭제</button></div>";
	                    
	                    contents += "</div><input type='hidden' id='repleSeqAjax' value='" + value.repleSeq + "'/>";
	        			contents += "<hr style='margin:20px '/>";
	                 });
	                    
					$('#ListAjax').html(contents);
				},  
				error : function(error) {
		            alert("error : " + error);
				}
				
			})
			
		} else {
			alert("로그인 후 이용해 주시기 바랍니다.");
			location.href="/user/userLogin.do";
		}
		
	} --%>

</script>
			
	<!-- Chart code -->
	<script>
	

	var chart = AmCharts.makeChart( "chartdiv", {
	  "type": "serial",
	  "theme": "dark",
	  "dataProvider": [ {
	    "country": 0,
	    "visits": 0
	  }, {
	    "country": 1,
	    "visits": 0
	  }, {
	    "country": 2,
	    "visits": 0
	  }, {
	    "country": 3,
	    "visits": 0
	  }, {
	    "country": 4,
	    "visits": 0
	  }, {
	    "country": 5,
	    "visits": 0
	  }, {
	    "country": 6,
	    "visits": 0
	  } ],
	  "valueAxes": [ {
	    "gridColor": "#FFFFFF",
	    "gridAlpha": 0.2,
	    "dashLength": 0
	  } ],
	  "gridAboveGraphs": true,
	  "startDuration": 1,
	  "graphs": [ {
	    "balloonText": "[[category]]: <b>[[value]]</b>",
	    "fillAlphas": 0.8,
	    "lineAlpha": 0.2,
	    "type": "column",
	    "valueField": "visits"
	  } ],
	  "chartCursor": {
	    "categoryBalloonEnabled": false,
	    "cursorAlpha": 0,
	    "zoomable": false
	  },
	  "categoryField": "country",
	  "categoryAxis": {
	    "gridPosition": "start",
	    "gridAlpha": 0,
	    "tickPosition": "start",
	    "tickLength": 20
	  },
	  "export": {
	    "enabled": true
	  }
	
	} );
	</script>
		

	
	<script>
	
	
	
	 var chartDataM = [{
	   "year": "00",
	       "cars": 1691,
	       "motorcycles": 0
	}, {
	   "year": "01",
	       "bicycles": 0
	}, {
	   "year": "02",
	     
	       "bicycles": 0
	}, {
	   "year": "03",
	      
	       "bicycles": 0
	}, {
	   "year": "04",
	      
	       "bicycles": 0
	}, {
	   "year": "05",
	       "bicycles": 0
	}, {
	   "year": "06",
	      
	       "bicycles": 0
	}, {
	   "year": "07",
	     
	       "bicycles": 0
	}, {
	   "year": "08",
	     
	       "bicycles": 0
	}, {
	   "year": "9",
	     
	       "bicycles": 0
	}, {
	   "year": "10",
	     
	       "bicycles": 0
	}, {
	   "year": "11",
	    
	       "bicycles": 0
	}, {
	   "year": "12",
	       "cars": 1580,
	       "bicycles": 0
	}]; 
	var chart =  AmCharts.makeChart("chartdivM", {
	    "type": "serial",
	"theme": "dark",
	
	    "fontFamily": "Lato",
	    "autoMargins": true,
	    "addClassNames": true,
	    "zoomOutText": "",
	    "defs": {
	        "filter": [
	            {
	                "x": "-50%",
	                "y": "-50%",
	                "width": "200%",
	                "height": "200%",
	                "id": "blur",
	                "feGaussianBlur": {
	                    "in": "SourceGraphic",
	                    "stdDeviation": "50"
	                }
	            },
	            {
	                "id": "shadow",
	                "width": "150%",
	                "height": "150%",
	                "feOffset": {
	                    "result": "offOut",
	                    "in": "SourceAlpha",
	                    "dx": "2",
	                    "dy": "2"
	                },
	                "feGaussianBlur": {
	                    "result": "blurOut",
	                    "in": "offOut",
	                    "stdDeviation": "10"
	                },
	                "feColorMatrix": {
	                    "result": "blurOut",
	                    "type": "matrix",
	                    "values": "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 .2 0"
	                },
	                "feBlend": {
	                    "in": "SourceGraphic",
	                    "in2": "blurOut",
	                    "mode": "normal"
	                }
	            }
	        ]
	    },
	    "fontSize": 15,
	    "pathToImages": "../amcharts/images/",
	    "dataProvider": chartDataM,
	    "dataDateFormat": "DD",
	    "marginTop": 0,
	    "marginRight": 1,
	    "marginLeft": 0,
	    "autoMarginOffset": 5,
	    "categoryField": "year",
	    "categoryAxis": {
	        "gridAlpha": 0.07,
	        "axisColor": "#DADADA",
	        "startOnAxis": true,
	        "tickLength": 0,
	        "parseDates": true,
	        "minPeriod": "DD"
	    },
	    "valueAxes": [
	        {
	            "ignoreAxisWidth":true,
	            "stackType": "regular",
	            "gridAlpha": 0.07,
	            "axisAlpha": 0,
	            "inside": true
	        }
	    ],
	    "graphs": [
	        {
	            "id": "g1",
	            "type": "line",
	            "title": "Cars",
	            "valueField": "cars",
	            "fillColors": [
	                "#0066e3",
	                "#802ea9"
	            ],
	            "lineAlpha": 0,
	            "fillAlphas": 0.8,
	            "showBalloon": false
	        },
	        {
	            "id": "g2",
	            "type": "line",
	            "title": "Motorcycles",
	            "valueField": "motorcycles",
	            "lineAlpha": 0,
	            "fillAlphas": 0.8,
	            "lineColor": "#5bb5ea",
	            "showBalloon": false
	        },
	        {
	            "id": "g3",
	            "title": "Bicycles",
	            "valueField": "bicycles",
	            "lineAlpha": 0.5,
	            "lineColor": "#FFFFFF",
	            "bullet": "round",
	            "dashLength": 2,
	            "bulletBorderAlpha": 1,
	            "bulletAlpha": 1,
	            "bulletSize": 15,
	            "stackable": false,
	            "bulletColor": "#5d7ad9",
	            "bulletBorderColor": "#FFFFFF",
	            "bulletBorderThickness": 3,
	            "balloonText": "<div style='margin-bottom:30px;text-shadow: 2px 2px rgba(0, 0, 0, 0.1); font-weight:200;font-size:30px; color:#ffffff'>[[value]]</div>"
	        }
	    ],
	    "chartCursor": {
	        "cursorAlpha": 1,
	        "zoomable": false,
	        "cursorColor": "#FFFFFF",
	        "categoryBalloonColor": "#8d83c8",
	        "fullWidth": true,
	        "categoryBalloonDateFormat": "DD",
	        "balloonPointerOrientation": "vertical"
	    },
	    "balloon": {
	        "borderAlpha": 0,
	        "fillAlpha": 0,
	        "shadowAlpha": 0,
	        "offsetX": 40,
	        "offsetY": -50
	    }
	});
	
	/* // we zoom chart in order to have better blur (form side to side)
	chart.addListener("dataUpdated", zoomChart);
	
	function zoomChart(){
	    chart.zoomToIndexes(1, chartData.length - 2);
	} */
	</script>

</html>