<%@page import="java.util.List"%>
<%@page import="poly.dto.consumer.CONSUMER_BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	
	List<CONSUMER_BoardDTO> bList = (List<CONSUMER_BoardDTO>)request.getAttribute("bList");
	
	%>
<html>
<head>
<title>Write!</title>
<%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %>
<script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script>
$(document).ready( function () {	//진수형이 알려주신 게시판
    $('#boardList').DataTable();
} );

</script>
</head>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<table style="height: 100%; width: 100%">
		<tr bgcolor="">
			<td>
				<div class="container" >
					<table class="table table-striped" id="boardList">
						<thead>
							<tr>
								<th style="text-align:center;">번호</th>
								<th style="text-align:center;">제목</th>
								<th style="text-align:center;">작성일</th>
								<th style="text-align:center;">작성자</th>
							</tr>
						</thead>
						<tbody>
							<%for (int i = 0; i < bList.size(); i++) {%>
							<tr>
								<td style="text-align:center;"><%=bList.get(i).getBoardPSeq() %></td>
								<td style="text-align:center;"><a href="/consumer/board/noticeDetail.do?boardPSeq=<%=bList.get(i).getBoardPSeq()%>">
								<%=bList.get(i).getTitle() %></a></td>		
								<td style="text-align:center;"><%=bList.get(i).getRegDate() %></td>
								<td style="text-align:center;">관리자</td>
							</tr>
							<%}%>
						</tbody>
					</table>
				</div>
				
			</td>
		</tr>
	</table>
</body>
</html>

	