<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <style>
    text:hover {
        stroke: black;
    }
  </style>
  <script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
  <script src="<%=request.getContextPath()%>/resources/js/consumer/d3Cloud/d3.layout.cloud.js"></script>
  <meta name="viewport" content="width=device-width, initial-scale=1"><!-- 반응형 웹 설정 -->
<title>트럭왔냠 - 검색어 트렌드</title>
    
</head>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
<div id="cloud" style="overflow:hidden; text-align:center;"></div>


<script type="text/javascript">
  var weight = 16,   // change me
      width = 320,
      height = 240;

  var fill = d3.scale.category20();
  d3.csv('<%=request.getContextPath()%>/resources/js/consumer/d3Cloud/searchTrend.csv', function(d) {
      return {
        text: d.word,
        size: +d.freq*weight
      }
    },
    function(data) {
      d3.layout.cloud().size([width, height]).words(data)
        //.rotate(function() { return ~~(Math.random() * 2) * 90; })
        .rotate(0)
        .fontSize(function(d) { return d.size; })
        .on("end", draw)
        .start();
	
      function draw(words) {
        d3.select("#cloud").append("svg")
            .attr("width", '90%')
            .attr("height", height)
            .attr("viewBox", "0 0 100 240" )
            .attr("xmlns", "http://www.w3.org/2000/svg")
          .append("g")
            .attr("transform", "translate(" + 50 + "," + height/2 + ")")
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