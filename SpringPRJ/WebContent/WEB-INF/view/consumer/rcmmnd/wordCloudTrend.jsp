<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<style>
	text:hover {
	    stroke: black;
	    cursor:unset;
	}
	/****************/
	.axis path,	.axis line {
	  fill: none;
	  stroke: #000;
	  shape-rendering: crispEdges;
	}
	
	.x.axis path {
	  display: none;
	}
	
	.line {
	  fill: none;
	  stroke: steelblue;
	  stroke-width: 1.5px;
	}
	</style>
	<script src="//d3js.org/d3.v3.min.js"></script>
 	<script src="<%=request.getContextPath()%>/resources/js/consumer/d3Cloud/d3.layout.cloud.js"></script>
 	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
 	
	<meta name="viewport" content="width=device-width, initial-scale=1"><!-- 반응형 웹 설정 -->
	<title>트럭왔냠 - 검색어 트렌드</title>
   
</head>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
<div class="container-fluid" style="margin-bottom: 20px; border-bottom: 4px solid white; 
		width: 30%; padding: 12px; text-align: right; margin-right: 10px;">
	<h3>검색어 트렌드</h3>
</div>
	
<div id="cloud" style="overflow:hidden; 
	text-align:center; background-color: white;
    border-radius: 8px; border: 1px solid #b1aeae;
   "></div>
<div style="height:20px"></div>
<%-- 워드 클라우드 자바스크립트 --%>

<script type="text/javascript">
  var windowWidth = $( window ).width();

  var cloudWeight = 14,   // change me
      cloudWidth = windowWidth,
      cloudHeight = 260;

  var fill = d3.scale.category20();
  
  d3.csv('<%=request.getContextPath()%>/resources/js/consumer/d3Cloud/searchTrend.csv', 
		  function(d) {
      		return {
        		text: d.word,
        		size: +d.freq*cloudWeight
      		}
    }, function(data) {
      d3.layout.cloud().size([cloudWidth, cloudHeight]).words(data)
        //.rotate(function() { return ~~(Math.random() * 2) * 90; })
        .rotate(0)
        .fontSize(function(d) { return d.size; })
        .on("end", draw)
        .start();
	
      function draw(words) {
        d3.select("#cloud").append("svg")
            .attr("width", cloudWidth)
            .attr("height", cloudHeight)
            .attr("viewBox", "0 0 100 240" )
            .attr("xmlns", "http://www.w3.org/2000/svg")
          .append("g")
            .attr("transform", "translate(" + 50 + "," + cloudHeight/2 + ")")
          .selectAll("text")
            .data(words)
          .enter().append("text")
            .style("font-size", function(d) { return d.size + "px"; })
            .style("font-family", "'Noto Sans KR', sans-serif")
            .style("fill", function(d, i) { return fill(i); })
            .attr("text-anchor", "middle")
            .attr("transform", function(d) {
              return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
            })
          .text(function(d) { return d.text; });
      }
    });
</script>


</body>
</html>