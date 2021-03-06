<%@page import="poly.util.CmmUtil"%>
<%@page import="poly.dto.consumer.CONSUMER_FtMenuCateDTO"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.consumer.CONSUMER_Ft_InfoDTO"%>
<%@page import="poly.dto.consumer.CONSUMER_Menu_InfoDTO"%>
<%@page import="poly.dto.consumer.CONSUMER_ImageDTO"%>
<%@page import="poly.dto.consumer.CONSUMER_FtMenuCateDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("euc-kr");
	List<CONSUMER_Menu_InfoDTO> menuDTOs = (List<CONSUMER_Menu_InfoDTO>) request.getAttribute("menuDTOs"); // 메뉴 DTO 리스트
	List<CONSUMER_ImageDTO> imgDTOs = (List<CONSUMER_ImageDTO>) request.getAttribute("imgDTOs"); // 이미지 DTO 리스트
	List<CONSUMER_FtMenuCateDTO> cateDTOs = (List<CONSUMER_FtMenuCateDTO>) request.getAttribute("cateDTOs"); //카테고리 데이터 리스트
	String userSequence = (String) session.getAttribute("userSeq");
	String ftSeq = (String) request.getParameter("ft_seq");
	DecimalFormat df = new DecimalFormat("#,##0");
%>

<html>
<style>
	#OrderBttnContainer{
		width:100%;
		position: fixed;
		bottom: 0;
		left:0;
		height:60px;
	}
	/* 행의 margin제거 */
	.ftMenuRow{
		margin:0; 
		padding:6px 0;
		text-align:center;
		
	}
	/* 메뉴의 이미지를 높이를 고정 */
	.imgRow > img{
		height:100%;
	}
	.footer{
		background-color: #f2f2f2;
	}

</style>
<body>
	
	<div class="container-fluid">
	<%if(menuDTOs.isEmpty() == false) {%>
		<%for(int k = 0; k < cateDTOs.size(); k++) {%>
			<div class="col-sm-12">
				<!-- 메뉴카테고리 명 출력 -->
				<div style="margin-bottom: 20px;">
					<h3><%=cateDTOs.get(k).getCate_name() %></h3>
					<div style="border-bottom:3px solid black; height:10px; width:80px;"></div>
				</div>
			</div>
			
			<%for (int i = 0; i < menuDTOs.size(); i++) { %>
				<%if(cateDTOs.get(k).getCate_sort_no() == menuDTOs.get(i).getCate_sort_no()) {%>
					<div class="col-sm-6" style="overflow:hidden; margin-bottom:6px; border-radius:4px;">
						<div class="contentBox" style="padding: 0px 12px; text-align:center;">
							<!-- 메뉴 이미지 -->
							<div class="row ftMenuRow imgRow" style=" overflow:hidden; padding:8% 0;">
								<%for(int j = 0; j < imgDTOs.size(); j++) {%>
									<!--fileId NULL 확인 -->
									<%if(!"".equals(imgDTOs.get(j).getFileSevname())) {%>
										<!-- imgDTO와 menuDTOs 같은 fileId일 경우 출력-->
										<%if(imgDTOs.get(j).getFileId().equals(menuDTOs.get(i).getFile_id())) {%>
											<!-- 메뉴 사진 -->
											<img src="<%=request.getContextPath()%>/resources/files/<%=imgDTOs.get(j).getFileSevname()%>" 
												style="max-height:240px; max-width:240px; width:auto;"
												onError="this.src='/resources/img/consumer/NfoundError.png;'">
										<%} %> 		
									<%} else {%>
										<img src="/resources/img/consumer/temp.png" alt="메뉴이미지준비중" style="max-height:300px; width:100%;"/>
									<%} %>
								<%} %>
							</div>
							<div class="row ftMenuRow"><%=menuDTOs.get(i).getMenu_name() %></div>
							<div class="row ftMenuRow" style="height: 60px; text-overflow: ellipsis; white-space: nowrap; overflow: hidden;">
								<%=menuDTOs.get(i).getMenu_intro() %>
							</div>
							<div class="row ftMenuRow"><%=df.format(menuDTOs.get(i).getMenu_price()) %> 원</div>
						</div>
					</div>
				<%} %>
			<%} %>
			<!-- 등록된 음식이 없을 경우 -->	
			<%} %>
		<%} else{%>
			<h2>등록된 메뉴가 없습니다.</h2>
		<%} %>	
	</div>
	<br/><br/> <!-- 메뉴가 버튼에 가리지 않도록 공백 설정 -->
	<form action="/seller/out/out_info.do" method="POST" id="sbmtOrdrForm">
		<input type="hidden" value="<%=userSequence%>" name="userSeq"/>
		<input type="hidden" value="1" name="userAuth"/>
		<input type="hidden" value="<%=ftSeq%>" name="ftSeq"/>
	<div class="header" id="myHeader2">
		<button type="button" onclick="goToOrder(); return false;" class="btn btn-primary" id="OrderBttnContainer" style="font-size:18px;">예약/배달 주문하러 가기</button>
	</div>
	</form>
</body>
<script>
	function goToOrder() {
		<%if ("".equals(userSequence)) {%>
		
			alert('로그인을 해주시기 바랍니다.');
			
		<%}else {%>
		
			$('#sbmtOrdrForm').submit();
			
		<%}%>
		
	}
	
</script>
</html>