<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>트럭왔냠 전체 관리자</title>

<!-- Bootstrap -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap.css">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
          
</head>
<body background="<%=request.getContextPath()%>/resources/img/admin/truck_background.jpg" style="background-size: 100%;">
<%@ include file="../admin_top.jsp" %>

<div class="container" style="background-color:rgba(255,255,255,0.9);  padding-top:15px; padding-bottom:30px;  padding-left:30px; padding-right:30px;">
	<h2>게시판리스트</h2>
    <div style="border-bottom:1px solid #444444; margin-top:15px;"></div>
	<div style="margin-top:15px; margin-bottom:25px;">
        <form class="form-inline" action="<%=request.getContextPath()%>/admin/board/boardSearch_list.do" method="GET">
            <div class="form-group">
            	<h4>게시판 검색</h4>
                    <select class="form-control" name="option">
                        <option value="board_name">이름</option>
                    </select>
                    <input type="text" class="form-control" name="value">
                    <input type="submit" value="검색" class="btn btn-default">
            </div>
        </form>
    </div>
    <div style="border-bottom:1px solid #cccccc; margin-top:15px; margin-bottom:15px;"></div>
	<div id="table_container">
		<%@ include file="board_table.jsp" %>
    	<!-- <iframe src="./editablegrid-1.0.10/examples/ft_table.html" width="100%" style="border:0px; max-height:auto; min-height:450px;"></iframe> -->
    </div>
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