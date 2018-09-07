<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_Board_PostDTO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String board_name = (String)request.getAttribute("board_name");
	ADMIN_Board_PostDTO bpDTO = (ADMIN_Board_PostDTO)request.getAttribute("bpDTO");
%>
<html>
<style>
	.table_Hblock{
		padding-left:10px;
		padding-right:10px;
		background-color:#F2F2F2;
		min-width:85px;
	}
	.table_Cblock{
		padding:15px;
	}
	.table_Context{
		padding-left:15px;
		padding-right:15px;
		padding-top:15px;
		padding-bottom:15px;
	}
	.table_CCblock{
		text-align:center;
	}
	.textarea_block{
		padding:5px;
	}
	.reple_block{
		text-align:center;
		border-right:1px solid #DDDDDD;
	}
	.reple_date_block{
		text-align:center;
		border-left:1px solid #DDDDDD;
		border-right:1px solid #DDDDDD;
	}
</style>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>트럭왔냠 전체 관리자</title>

<!-- Bootstrap -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap-toggle.css">
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
	<form action="<%=request.getContextPath()%>/admin/board_p/board_p_Lcreate_ok.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="board_seq" value="<%=bpDTO.getBoard_seq()%>">
	<input type="hidden" name="board_p_seq" value="<%=bpDTO.getBoard_p_seq()%>">
	<h2>게시물답변</h2>
    <div style="border-bottom:1px solid #444444; margin-top:15px;"></div>
	<div style="margin-top:25px; margin-bottom:25px;">
    	<table width="100%" style="border-top:1px solid #A2A2A2; border-bottom:1px solid #A2A2A2">
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock" width="14%">게시판</td>
    			<td  class="table_Cblock">
                	<%=board_name %>
				</td>
    			<td class="table_Hblock" width="14%">노출상태</td>
    			<td class="table_Cblock" width="16%">
    				<input type="checkbox" checked disabled data-toggle="toggle" data-width="70" name="exp_yn">
				</td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">제목</td>
    			<td colspan="3"  class="table_Cblock">
					<input type="text" class="form-control" name="title" value="[답글] ">
				</td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">이미지 첨부</td>
    			<td colspan="3" class="table_Context">
					<input type="file" id="uploadFile" name="uploadFile">
				</td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">내용</td>
    			<td colspan="3" class="table_Context">
<textarea style="width:100%; height:450px" class="form-control" name="content">
[ TITLE : <%=bpDTO.getTitle()%> ]
[ CONTENT : <%=bpDTO.getContent()%> ]
</textarea>
				</td>
    		</tr>
    	</table>
	</div>
	<div align="center">
		<input type="button" value="취소" class="btn btn-default "  style="width:80px;" onClick="javascript:history.back();">
		<input type="submit" value="저장" class="btn btn-primary" style="width:80px;">
	</div>
	</form>
</div>
<hr>
<footer class="text-center">
  <%@ include file="../admin_bottom.jsp" %>
</footer>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/jquery-1.11.2.min.js"></script> 
<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap-toggle.min.js"></script>

</body>
</html>