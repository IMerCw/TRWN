<%@page import="java.util.List"%>
<%@page import="poly.util.CmmUtil"%>
<%@page import="poly.dto.consumer.CONSUMER_Ft_InfoDTO"%>
<%@page import="poly.dto.consumer.CONSUMER_Ft_ReviewDTO"%>
<%@page import="poly.dto.consumer.CONSUMER_ImageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("euc-kr");
	List<CONSUMER_Ft_ReviewDTO> repleList = (List<CONSUMER_Ft_ReviewDTO>) request.getAttribute("repleList"); //리뷰 데이터를 리스트 형식으로 받아옴
// 	List<ImageDTO> ImgDTOs = (List<ImageDTO>) request.getAttribute("ImgDTOs"); //리뷰 데이터를 리스트 형식으로 받아옴
 	String userSeq = CmmUtil.nvl((String)session.getAttribute("userSeq"));
	
 	CONSUMER_Ft_InfoDTO fDTO = (CONSUMER_Ft_InfoDTO) request.getAttribute("fDTO");
	
	/* DTO NULL체크 불리언  */
	boolean dtoNullCheck = repleList.isEmpty() == false;
%>



<html>
<body>
	<div class="container-fluid contentBox">
		<div class="row" style="padding:15px;">
			<!-- 리뷰 평점 숫자 -->
	    	<div class="col-xs-4" style="font-size: 20px; text-align:center; padding:40px 0;">
				리뷰 평점
				<br/>
				<!-- /* 리뷰 평점 계산 */ -->
				<% if(dtoNullCheck) { %>
				<%
					int sumRate = 0;
					for(CONSUMER_Ft_ReviewDTO frDTO:repleList){
						sumRate += frDTO.getRev_point();
					}
					double avgRate = (double) sumRate / repleList.size();	
					avgRate = (Math.round(avgRate*10))/10.0; /* 소수점 첫 째자리까지 계산 */
				%>
				<%=avgRate %>
				<%} else { %>
					<p>리뷰가 아직 없습니다.</p>
				<%} %>
			</div>
			<!-- 리뷰 별 갯수 -->
			<div class="col-xs-6">
				
				<%for(int i = 0; i < 5; i++) {%>
					<p>
					<%for(int k = 0; k < i; k++) {%>
						<img src="/resources/img/consumer/starRating.png" style="visibility:hidden;"/>
					<%} %>
					<%for(int j = i; j < 5; j++) {%>
						<img src="/resources/img/consumer/starRating.png">
					<%} %>
					</p>
				<%} %>
			</div>
			<div class="col-xs-2">
				<!-- 리뷰 별 계산 -->
				<%if(dtoNullCheck) {%>
				<%
					int five = 0, four = 0, three = 0, two = 0, one  = 0;
					for(CONSUMER_Ft_ReviewDTO frDTO: repleList) {
						switch(frDTO.getRev_point()) {
							case 5 : five++; break;
							case 4 : four++; break;
							case 3 : three++; break;
							case 2 : two++; break;
							case 1 : one++; break;
							default: break;
						}
					}
				%>
					<p><%=five%></p>
					<p><%=four%></p>
					<p><%=three%></p>
					<p><%=two%></p>
					<p><%=one%></p>
				<%} else { %>
					<p></p>
					<p></p>
					<p></p>
					<p></p>
					<p></p>
				<%} %>
			</div>
		</div>
	</div>
	<!----------------- 리뷰 글 쓰기 ----------------->
	<form action="/consumer/review/writeReivew.do" method="POST">
	<div class="container-fluid" style="padding:0px;">
		<input type="hidden" value="<%=fDTO.getFt_seq()%>" name="ft_seq" /> <!-- 푸드트럭 번호 --> 
		<input type="hidden" value="<%=userSeq%>" name="userSeq" /> <!-- 회원 번호 -->
		<input type="hidden" value="<%=fDTO.getFt_name()%>" name="ft_name" /> <!-- 푸드트럭 이름 -->
		<button type="submit" class="btn btn-primary"
			style="width:100%; height:42px; margin-bottom:15px; font-size:18px;">리뷰 글쓰기</button>
	</div>
	</form>
	<!----------------- 리뷰 글 목록 ----------------->
	<div class="container-fluid">
		<% if (dtoNullCheck) { %>
  			<% for (int i = 0; i < repleList.size(); i++) { %>
  				<div class="row contentBox" onclick="location.href='/consumer/review/viewReview.do?&review_seq=<%=repleList.get(i).getReview_seq()%>'" style="padding:15px;">
	  				<div class="row">
		  				<!-- 리뷰 작성자 닉네임 -->
						<div class="col-xs-4"><%=repleList.get(i).getUser_nick()%>님</div>
						<!-- 리뷰 작성일  -->
						<div class="col-xs-8" style="text-align:right;"> <%=repleList.get(i).getRev_regdate()%></div>
					</div>
					<div class="row">
						<!-- 리뷰 제목 -->
						<div class="col-xs-6"><%=repleList.get(i).getRev_title()%></div>
						<!-- 평점 갯수 -->
						<div class="col-xs-6" style="text-align:right;">
							<%for(int q = 0; q < (repleList.get(i).getRev_point()); q++) {%>
								<img src="/resources/img/consumer/starRating.png">
							<%} %>
						</div>
					</div>
				</div>
					
			<% } %>
		<%} else { %>
			<div class="row"><div class="col-xs-12"><h2>리뷰가 없습니다. 리뷰를 작성해 주세요.</h2></div></div>
		<%} %>
	</div>
<br/>

</body>
<script>
	function redirectTo(url) {
		window.location.href = url;
	}

</script>
</html>
