<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.consumer.CONSUMER_DissInfoDTO" %>
<%
	CONSUMER_DissInfoDTO dissInfoDTO = (CONSUMER_DissInfoDTO)request.getAttribute("dissInfoDTO");
%>
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
	<%@ include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<br/>
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