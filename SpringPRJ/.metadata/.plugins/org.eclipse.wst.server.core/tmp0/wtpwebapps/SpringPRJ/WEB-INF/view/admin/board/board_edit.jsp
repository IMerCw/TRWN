<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_BoardDTO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <%
	ADMIN_BoardDTO bDTO_one = (ADMIN_BoardDTO)request.getAttribute("bDTO");
%>
 <html>
<style>
	.table_Hline{
		padding-top:15px;
		padding-bottom:15px;
		padding-left:20px;
		padding-right:20px;
		background-color:#F2F2F2;
		font-weight:bold;
	}
	.table_line{
		padding-top:15px;
		padding-bottom:15px;
		padding-left:20px;
		padding-right:20px;
	}
</style>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판 수정</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/bootstrap.css">
</head>
<body>
<%@ include file="../admin_top.jsp" %>

<div class="container">
<h2>게시판수정</h2>
    <div style="border-bottom:1px solid #444444; margin-top:15px;"></div>
	<div style="margin-top:15px; margin-bottom:25px;">
<form action="<%=request.getContextPath()%>/admin/board/board_edit_ok.do" method="post"  name="board_edit">
	<input type="hidden" name="board_seq" value="<%=bDTO_one.getBoard_seq()%>">
	<table width="100%">
		<tr style="border-top:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD;">
			<td width="28%" class="table_Hline">게시판 이름</td>
			<td class="table_line"><input type="text" class="form-control" value="<%=bDTO_one.getBoard_name() %>" id="board_name" name="board_name"></td>
		</tr>
		<tr style="border-bottom:1px solid #DDDDDD;">
			<td class="table_Hline">읽기권한</td>
			<td class="table_line">
				<select class="form-control" id="read" name="read">
					<%if(bDTO_one.getBoard_read()==0){ %><option selected value="0">일반회원</option><%}else{%><option value="0">일반회원</option><%}%>
					<%if(bDTO_one.getBoard_read()==1){ %><option selected value="1">사업자회원</option><%}else{%><option value="1">사업자회원</option><%}%>
					<%if(bDTO_one.getBoard_read()==9){ %><option selected value="9">관리자</option><%}else{%><option value="9">관리자</option><%}%>
				</select>
			</td>
		</tr>
		<tr style="border-bottom:1px solid #DDDDDD;">
			<td class="table_Hline">쓰기권한</td>
			<td class="table_line">
				<select class="form-control" id="write" name="write">
					<%if(bDTO_one.getBoard_write()==0){ %><option selected value="0">일반회원</option><%}else{%><option value="0">일반회원</option><%}%>
					<%if(bDTO_one.getBoard_write()==1){ %><option selected value="1">사업자회원</option><%}else{%><option value="1">사업자회원</option><%}%>
					<%if(bDTO_one.getBoard_write()==9){ %><option selected value="9">관리자</option><%}else{%><option value="9">관리자</option><%}%>
				</select>
			</td>
		</tr>
		<tr style="border-bottom:1px solid #DDDDDD;">
			<td class="table_Hline">댓글권한</td>
			<td class="table_line">
				<select class="form-control" id="reple" name="reple">
					<%if(bDTO_one.getBoard_reple()==0){ %><option selected value="0">일반회원</option><%}else{%><option value="0">일반회원</option><%}%>
					<%if(bDTO_one.getBoard_reple()==1){ %><option selected value="1">사업자회원</option><%}else{%><option value="1">사업자회원</option><%}%>
					<%if(bDTO_one.getBoard_reple()==9){ %><option selected value="9">관리자</option><%}else{%><option value="9">관리자</option><%}%>
				</select>
			</td>
		</tr>
		<tr style="border-bottom:1px solid #DDDDDD;">
			<td class="table_Hline">노출여부</td>
			<td class="table_line">
				<select class="form-control" id="exp_yn" name="exp_yn">
					<%if(bDTO_one.getExp_yn()==1){ %><option selected value="1">노출</option><%}else{%><option value="1">노출</option><%}%>
					<%if(bDTO_one.getExp_yn()==-1){ %><option selected value="-1">비노출</option><%}else{%><option value="-1">비노출</option><%}%>
				</select>
			</td>
		</tr>
	</table>
	<div style="margin-top:10px; text-align:center;">
		<button type="button" class="btn btn-default" style="width:80px;" onClick="location.href='<%=request.getContextPath()%>/admin/board/board_list.do'">취소</button>
		<button type="submit" class="btn btn-primary" style="width:80px;" >저장</button>
	</div>
	</form>
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
