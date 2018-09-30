<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.consumer.CONSUMER_RcmmndFtDTO" %>
<%@page import="java.util.List"%>

<%
	List<CONSUMER_RcmmndFtDTO> rftDTOArr = (List<CONSUMER_RcmmndFtDTO>)request.getAttribute("rftDTOArr");
	Double rcmmndRate;
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
	.row {
		width:100%; margin:0 auto;
	}
	.col-xs-12{
		padding:0;
	}
	.panel{
		max-height:300px; 
	}
	.panel img { /* 푸드트럭 사진  */
	}
	.panel-body{ /* 푸드트럭 사진 밑 내용 소개 */
		text-align:center; 
	}
	
</style>
<title>트럭왔냠 - 소비자 맞춤 추천</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>

<body>
	<div class="container-fluid" style="margin-bottom: 20px; border-bottom: 4px solid white; 
		width: 30%; padding: 12px; text-align: right; margin-right: 10px;">
		<h3>소비자 맞춤 추천</h3>
	</div>
	<!-- 푸드트럭 목록 -->  
	<div class="container-fluid" style="margin:0; padding:12px;">
		<%if(rftDTOArr != null && rftDTOArr.isEmpty() == false) {%>
			<%for(CONSUMER_RcmmndFtDTO rftDTO: rftDTOArr ) {%>
			<div class="row" style="margin: 12px 0; text-align:right; background-color:#eeeeee; border-radius:8px;">
		    	<div class="col-xs-6" style="padding:16px; height:256px;">
					<img src="<%=request.getContextPath()%>/resources/files/<%=rftDTO.getFileSevname()%>" 
							onError="this.src='/resources/img/consumer/NfoundError.png;'"
							height="100%" width="100%">
				</div>
		    	<div class="col-xs-6" style="padding:16px; height:256px;">
					<div class="col-xs-12" style="height:88px;">
						<%-- 추천도 반올림 계산 --%>
						<% 
							rcmmndRate = Double.parseDouble(rftDTO.getRcmmndRating());
							
						%>
						
						<h3>추천도 <%=(Math.round(rcmmndRate * 10000)) / 100.0%> % </h3>
					</div> 
					<div class="col-xs-12" style="height:40px; font-size:2rem; float:right;">
						<h4><%=rftDTO.getFtName() %></h4>
					</div> 
					<div class="col-xs-12" style="height:60px;">
						<h5><%=rftDTO.getFtIntro() %></h5>
					</div> 
					<div class="col-xs-12" style="height:40px;">
						<button onclick="location.href='/consumer/cnsmr/ftDetail.do?ft_seq=<%=rftDTO.getFtSeq()%>'" 
							type="button" style="width:100%;" class="btn btn-primary"><h4 style="margin:0;">푸드트럭 자세히 보기</h4></button>
					</div>
				</div>
			</div>
				<%} %>
			<%}else { %>
			<div class="alert alert-danger">
			  <strong>!!</strong> 추천 대상이 없습니다. 리뷰를 좀 더 작성 해주세요.
			</div>
			<%} %>
	</div>
</body>
</html>