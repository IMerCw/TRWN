<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="poly.util.CmmUtil"%>
<%@ page import="poly.dto.consumer.CONSUMER_Menu_InfoDTO"%>
<%@ page import="poly.dto.consumer.CONSUMER_ImageDTO"%>
<%@ page import="poly.dto.consumer.CONSUMER_Ft_InfoDTO"%>
<%
	request.setCharacterEncoding("euc-kr");
	List<CONSUMER_Ft_InfoDTO> fDTO = (List<CONSUMER_Ft_InfoDTO>)request.getAttribute("fDTO");
	List<CONSUMER_Menu_InfoDTO> menuDTO = (List<CONSUMER_Menu_InfoDTO>)request.getAttribute("menuDTO");
	List<CONSUMER_ImageDTO> imgDTOs = (List<CONSUMER_ImageDTO>)request.getAttribute("imgDTOs");
	String keyWord = CmmUtil.nvl((String)request.getAttribute("keyWord"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메뉴로 푸드트럭 찾기</title>
<style>
	/* topbody 아래의 컨테이너 */
	.container-fluid{
		background-color:#f2f2f2;
	}
	/* 행의 margin제거 */
	.row{
		margin:0; 
		padding:6px 0;
		text-align:center;
		
	}
	/* 메뉴의 이미지를 높이를 고정 */
	.imgRow > img{
		height:260px; margin:10px 0;
	}
</style>
</head>
<body>
<!-- 검색 결과가 없을 경우 If there is no result for the keyword-->
<%if(menuDTO.isEmpty() == true) {%>
	<div class="container-fluid" style="height:100%;">
		<div class="row">
			<h2>"<u><%=keyWord %></u>"에 대한 검색 결과가 없습니다. </h2>
		</div>
	</div>
<%} else { %>
	<!-- 검색 결과가 있을 경우 -->
	<div class="container-fluid" style="height:100%;">
		<div class="row"><h4>"<u><%=keyWord %></u>" 검색 결과 - 가까운 위치부터 정렬한 검색결과입니다.</h4></div>
		<%for(int i = 0; i < menuDTO.size(); i++) {%>
			<div class="col-sm-6">
				<div class="container-fluid" onclick="location.href='/consumer/cnsmr/ftDetail.do?ft_seq=<%=menuDTO.get(i).getFt_seq()%>'" style="background:white; margin-bottom:30px; border: 1px solid #aaaaaa;">
					<!-- 메뉴 이미지 -->
					<div class="row imgRow">
						<%for(int j = 0; j < imgDTOs.size(); j++) {%>
							<%if(menuDTO.get(i).getFile_id().equals(imgDTOs.get(j).getFileId())) { %>
								<img src="<%=request.getContextPath()%>/resources/files/<%=imgDTOs.get(j).getFileSevname()%>" width="100%"/>
							<%}%>
						<%} %>
					</div>
					<!-- 메뉴 이름 -->
					<div class="row">
						<%=menuDTO.get(i).getMenu_name() %>
					</div>
					<!-- 해당 메뉴를 판매하는 푸드트럭 이름 -->
					<div class="row" style="margin-bottom: 10px;">
						<%=menuDTO.get(i).getFt_name() %>
					</div>
				</div>
			</div>
		<%if(i%2 == 1 && i != 0) {%> <!-- 각각 높이가 같은 각 행에 2개씩 들어가도록 위치를 맞춰 줌 -->
			<div class="clearfix visible-sm"></div> 
		<%} %>
		<%}%>
	</div>
	<%} %>
</body>
</html>