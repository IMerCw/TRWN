<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_BoardDTO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	List<ADMIN_BoardDTO> bDTO_seq = (List<ADMIN_BoardDTO>)request.getAttribute("boardList");
	String board_seq = (String)request.getAttribute("board_seq");
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>트럭왔냠 전체 관리자</title>

<!-- Bootstrap -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap.css">

<script>
	function boardSelect(board_select){
		location.href="<%=request.getContextPath()%>/admin/board_p/board_p_list.do?board_select="+board_select;
	}
</script>
</head>
<body background="<%=request.getContextPath()%>/resources/img/admin/truck_background.jpg" style="background-size: 100%;">
<%@ include file="../admin_top.jsp" %>

<div class="container" style="background-color:rgba(255,255,255,0.9);  padding-top:15px; padding-bottom:30px;  padding-left:30px; padding-right:30px;">
	<h2>게시물리스트</h2>
    <div style="border-bottom:1px solid #444444; margin-top:15px;"></div>
	<div style="margin-top:25px; margin-bottom:25px;">
        <form class="form-inline" action="<%=request.getContextPath()%>/admin/board_p/board_p_search_list.do" method="GET">
        	<input type="hidden" name="board_seq" value="<%=board_seq%>">
        	<div class="form-group" style="margin-right:25px; margin-bottom:5px;" > 
        		<span style="font-size:16px; margin-right:8px;">선택게시판</span>
                    <select class="form-control" name="board_select" onchange="boardSelect(this.value)">
                    		<option value="all">전체보기</option>
						<%for(ADMIN_BoardDTO bDTO : bDTO_seq){ %>
						<%if(board_seq != null && String.valueOf(bDTO.getBoard_seq()).equals(board_seq)){ %>
	                        <option selected value="<%=bDTO.getBoard_seq()%>"><%=bDTO.getBoard_name()%></option>
                        <%}else{ %>
                        	<option value="<%=bDTO.getBoard_seq()%>"><%=bDTO.getBoard_name()%></option>
                        <%} 
                        }%>
                    </select>
            </div>
            <br/> 
            <div class="form-group" >
            	<span style="font-size:16px; margin-right:8px;">게시물검색</span> 
                    <select class="form-control" name="option">
                        <option value="title">제목</option>
                        <!-- <option value="">작성자</option> -->
                        <option value="content">내용</option>
                    </select>
                    <input type="text" name="value" class="form-control">
                    <input type="submit" value="검색" class="btn btn-default">
            </div>
            <div style="border-bottom:1px solid #cccccc; margin-top:15px;"></div>
        </form>
    </div>
	<div id="table_container">
		<%@ include file="board_p_table.jsp" %>
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