<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String festivalHTML = (String)request.getAttribute("festivalHTML");
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>트럭왔냠 - 축제 및 행사 정보</title>
	<link rel="stylesheet" href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" />
	<style>
		.table > thead > tr > th {
		    text-align: center;
		    font-size: 15px;
		    font-weight: bold;
		}
		tbody > tr{
			font-size:16px;
		}
		table > tbody:first-child > tr > td {
			background-color: white;
		}
		.font-11, .list-subject {
			padding-top:20px !important;
		}
	</style>
</head>
<body>
	<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="#444">
			<td style="padding:0;">
				<%@ include file="/WEB-INF/view/seller/top.jsp" %>
				<script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
			</td>
		</tr>
		<tr>
			<td style="background-color:#555; padding: 20px 0;">
				<div class="container" style="background-color:#ffffff; padding: 20px 40px 60px 40px; border-radius:8px;">
			<!-- 테이블  채우는 자리  -->		
				<h2 style="color:black;">지역행사정보</h2><small style="">출처 : cheftruck</small>
				<div style="height:1px; margin:20px 0; background-color:#eeeeee;"> </div>
				<div class="row">
					<table class="table table-striped" style="padding:0 10px; text-align: center; opacity: 0.9; background-color:white; border: 1px solid #dddddd">
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
				<%@ include file="/WEB-INF/view/seller/bottom.jsp" %> 
			</td>
		</tr>
	</table>
	

</body>
</html>