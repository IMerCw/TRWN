<%@page import="poly.dto.seller.SELLER_DissInfoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.consumer.CONSUMER_DissInfoDTO" %>
<%-- <%
	SELLER_DissInfoDTO dissInfoDTO = (SELLER_DissInfoDTO)request.getAttribute("dissInfoDTO");
%> --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>트럭 왔냠 - 날씨/식중독 정보</title>
	<style>
	.grayText{
		color:gray;
	}
	* {
		word-break:break-all;
	}

	</style>
</head>
<body>
	<%@include file="/WEB-INF/view/seller/top.jsp" %>
	<%@include file="/WEB-INF/view/seller/topCssScript.jsp" %>

	<br/>
	<!-- 날씨 예보 -->
	<div class="container-fluid">
		<div class="panel panel-default">
			<div class="panel panel-body" style="margin:0;">
	  			<div class="row">
					<div class="col-xs-2" style="height:48px;"></div>
					<div class="col-xs-6" style="height:48px;"><h3 style="margin:10px 0;"><%=myAddress %></h3></div>
					<%if(!"".equals(t3hCode)) {%>
						<div class="col-xs-1" style="height:48px;">
							<%if (ptyCode.equals("0")) {%>
								<div style="display:inline-block;"><img src="/resources/img/consumer/skyCode<%=skyCode%>.png" /></div>
							<%} else if(!(ptyCode.isEmpty())) { %>
								<div style="display:inline-block;"><img src="/resources/img/consumer/ptyCode<%=ptyCode%>.png" /></div>
							<%}%>
						</div>
						<div class="col-xs-2" style="height:48px;">
							<!-- 날씨정보 / 값 받아 온 경우 -->
							<div style="display:inline-block; padding-top:5px 0;"> <h2 style="display:inline-block; margin:0;"><%=t3hCode %>℃</h2></div>
						</div>									
					<%} %>
					<div class="col-xs-1" style="height:48px;"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="row" style="height:15px;"></div>
	<!-- 식중독 예방 정보 -->
	<div class="container-fluid">
		<div class="panel panel-default">
		    <div class="panel-heading">
		  		<h3>식중독 위험 지수</h3>
		  		<% String riskFigure = dissInfoDTO.getRisk(); %> 
				<% if(riskFigure.equals("1")) {%>
						<div class="alert alert-success">
						  <strong>관심!</strong>
						  <br/> 식중독 발생가능성은 낮으나 식중독 예방에 지속적인 관심이 요망됩니다.
						</div>
				<%} else if(riskFigure.equals("2")){ %>	
						<div class="alert alert-info">
						  <strong>주의!</strong>
						  <br/> 식중독 발생가능성이 중간 단계이므로 식중독예방에 주의가 요망됩니다.
						</div>
				<%} else if(riskFigure.equals("3")){%>
						<div class="alert alert-warning">
						  <strong>경고!</strong> 
						  <br/> 식중독 발생가능성이 높으므로 식중독 예방에 경계가 요망됩니다. 
						</div>
				<%} else if(riskFigure.equals("4")){ %>
						<div class="alert alert-danger">
						  <strong>위험!</strong>
						  <br/> 식중독 발생가능성이 매우 높으므로 식중독예방에 각별한 경계가 요망됩니다.
						</div>
				<%} %>
			</div>
		 </div>
		    <div class="panel-body">
		    	<p class="grayText">질병예측 날짜:</p> 
		    	<%=dissInfoDTO.getDt().substring(0, 4)%>년 
		    	<%=dissInfoDTO.getDt().substring(4, 6)%>월 
		    	<%=dissInfoDTO.getDt().substring(6, 8)%>일 
		    </div>
		    <div class="panel-body">
		    	<p class="grayText">식중독 예측 진료 건수 :</p> 
		    	<%=dissInfoDTO.getCnt()%> </div>
		    <div class="panel-body">
		    	<p class="grayText">식중독 위험도 지침 :</p>
		    	<%=dissInfoDTO.getDissRiskXpln()%> 
		    </div>
		    
		</div>
</body>

</html>