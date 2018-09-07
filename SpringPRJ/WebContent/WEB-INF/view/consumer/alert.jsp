<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	String msg = (String)request.getAttribute("msg"); 
    	String url = (String)request.getAttribute("url");
    %>
<html>
<head>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";//이동
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
</body>
</html>