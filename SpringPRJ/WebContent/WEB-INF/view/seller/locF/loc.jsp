<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String festivalHTML = (String)request.getAttribute("festivalHTML");
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>board</title>
	<link rel="stylesheet" href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" />
	
	<%-- <%@ include file="/WEB-INF/view/seller/topCssScript.jsp" %> --%>
</head>
<body>
	<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="#444">
			<td style="padding:0;">
				<%@ include file="/WEB-INF/view/seller/top.jsp" %>
				<script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
			</td>
		</tr>
		<tr bgcolor="">
			<td>
			<div class="container">
			<!-- 테이블  채우는 자리  -->		
		
		<h2>지역행사정보</h2><small>출처 : cheftruck</small>
			<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					
					<tbody>
					
						<%-- <% for (int i = 0; i < festivalHTML.size(); i++) { %>
						 System.out.println("elem test" + i + ": " + elem.eq(i).text()); %> --%>
						<tr>
							<td><%=festivalHTML %></td>
							
						</tr>
					</tbody>
				</table>
				
			</div>
			<script>
			    $('.table table-striped').DataTable();
			</script>	
		
			
			</div>

			</td>
		</tr>
		<tr height="7%" style="background-color:#444">
			<td>
			<%-- 	<%@ include file="/WEB-INF/view/seller/bottom.jsp" %> --%>
			
			</td>
		</tr>
	</table>
	

</body>
</html>