<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%String cmd = (String)request.getAttribute("cmd"); %>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>트럭왔냠 전체 관리자</title>

<!-- Bootstrap -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap.css">

</head>
<body>
<%@ include file="../admin_top.jsp" %>

<div class="container">
	<%if(cmd.equals("coupon_create")){ %>
		<%@ include file="coupon_create.jsp" %>
	<%}else if(cmd.equals("coupon_list")){ %>
		<%@ include file="coupon_list.jsp" %>
	<%}else if(cmd.equals("coupon_search_list")){ %>
		<%@ include file="coupon_search_list.jsp" %>
	<%}else if(cmd.equals("coupon_edit")){ %>
		<%@ include file="coupon_edit.jsp" %>
	<%}else if(cmd.equals("coupon_issue_list")){ %>
		<%@ include file="coupon_issue_list.jsp" %>
	<%}else if(cmd.equals("coupon_issue_search_list")){ %>
		<%@ include file="coupon_issue_search_list.jsp" %>
	<%} %>
</div>
<hr>
<footer class="text-center">
  <%@ include file="../admin_bottom.jsp" %>
</footer>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/jquery-1.11.2.min.js"></script> 
<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap.min.js"></script>
</body>
</html>