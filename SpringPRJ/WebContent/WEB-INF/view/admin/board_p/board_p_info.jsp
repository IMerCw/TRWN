<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_User_InfoDTO" %>
<%@page import="poly.dto.admin.ADMIN_Board_PostDTO" %>
<%@page import="poly.dto.admin.ADMIN_Board_RepleDTO" %>
<%@page import="poly.dto.admin.ADMIN_ImageDTO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String board_name = (String)request.getAttribute("board_name");
	ADMIN_Board_PostDTO bpDTO = (ADMIN_Board_PostDTO)request.getAttribute("bpDTO");
	List<ADMIN_Board_RepleDTO> repleList = (List<ADMIN_Board_RepleDTO>)request.getAttribute("repleList");
	ADMIN_ImageDTO imgDTO = (ADMIN_ImageDTO)request.getAttribute("imgDTO");
	ADMIN_User_InfoDTO bp_uDTO = (ADMIN_User_InfoDTO)request.getAttribute("bp_uDTO");
	List<ADMIN_User_InfoDTO> br_uDTOarr = (List<ADMIN_User_InfoDTO>)request.getAttribute("br_uDTOarr");
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
		padding-top:50px;
		padding-bottom:50px;
	}
	.table_CCblock{
		text-align:center;
	}
	.textarea_block{
		padding:6px;
	}
	.reple_block{
		text-align:center;
		border-right:1px solid #DDDDDD;
	}
	.reple_date_block{
		text-align:center;
		border-left:1px solid #DDDDDD;
		border-right:1px solid #DDDDDD;
		width:14%;
	}
</style>
<head>
<script>
	var check = false;
	var check2 = false;
	function reple_Edit(reple_seq){ // 댓글 수정
		var r_text= document.getElementById('r_text'+reple_seq);
		var r_html = document.getElementById('r_text'+reple_seq).innerHTML;
		if(check == false){
			$(r_text).replaceWith($(
					"<form id='r_obj"+reple_seq+"' action='<%=request.getContextPath()%>/admin/board_reple/board_reple_edit.do' method='post'>"+
					"<input type='hidden' name='reple_seq' value='"+reple_seq+"'>"+
					"<input type='hidden' name='board_p_seq' value='<%=bpDTO.getBoard_p_seq()%>'>"+
					"<table width='100%'><tr>"+
					"<td><textarea id='r_text"+reple_seq+"' name='content' class='form-control' style='width:100%; height:75px;'>"+r_html+"</textarea></td>"+
					"<td width='90px'><input type='submit' value='저장' id='r_btn"+reple_seq+"' class='form-control' style='margin-left:5px; width:90px; height:75px;'/></td>"+
					"</tr></table>"+
					"</form>"
			));
			check=true;
		}else{
			var r_btn= document.getElementById('r_btn'+reple_seq);
			var r_obj= document.getElementById('r_obj'+reple_seq);
			
			$(r_obj).replaceWith($("<span id='r_text"+reple_seq+"'>"+r_html+"</span>"));
			$(r_btn).replaceWith($(""));
			check=false;
		}
	}
	
	function reple_Lcreate(reple_seq){ // 덧글 달기
		var r_Lcreate= document.getElementById('r_Lcreate'+reple_seq);
		if(check2 == false){
			$(r_Lcreate).replaceWith($(
					"<form id='r_Lcreate"+reple_seq+"' action='<%=request.getContextPath()%>/admin/board_reple/board_reple_Lcreate.do' method='post'>"+
					"<input type='hidden' name='reple_seq' value='"+reple_seq+"'>"+
					"<input type='hidden' name='board_p_seq' value='<%=bpDTO.getBoard_p_seq()%>'>"+
					"<table width='100%'><tr>"+
					"<td><textarea name='content' class='form-control' style='width:100%; height:75px;'></textarea></td>"+
					"<td width='90px'><input type='submit' value='저장' id='r_Lbtn"+reple_seq+"' class='form-control' style='margin-left:5px; width:90px; height:75px;'/></td>"+
					"</tr></table>"+
					"</form>"
			)); 
			check2=true;
		}else{
			var r_Lbtn= document.getElementById('r_Lbtn'+reple_seq);
			$(r_Lcreate).replaceWith($("<span id='r_Lcreate"+reple_seq+"'></span>"));
			$(r_Lbtn).replaceWith($(""));
			check2=false;
		}
	}
</script>
<meta charset="utf-8">
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
	<h2>게시물보기</h2> 
    <div style="border-bottom:1px solid #444444; margin-top:15px;"></div>
	<div style="margin-top:25px; margin-bottom:25px;">
    	<table width="100%" style="border-top:1px solid #A2A2A2; border-bottom:1px solid #A2A2A2">
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock" width="14%">게시판</td>
    			<td colspan="3" class="table_Cblock"><%=board_name%></td>
    			<td class="table_Hblock" width="14%">노출상태</td>
    			<td class="table_Cblock" width="16%">
    				<%if(bpDTO.getExp_yn()==1){%>
    					<input type="checkbox" disabled checked data-toggle="toggle" data-width="70">
    				<%}else{ %>
    					<input type="checkbox" disabled data-toggle="toggle" data-width="70">
    				<%} %>
				</td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">제목</td>
    			<td colspan="5" class="table_Cblock"><%=bpDTO.getTitle()%>&nbsp;<b>[<%=bpDTO.getReple_count()%>]</b></td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">작성자</td>
    			<td class="table_Cblock"><%=bp_uDTO.getUser_nick()%></td>
    			<td class="table_Hblock" width="14%">작성일</td>
    			<td class="table_Cblock"><%=bpDTO.getReg_date()%></td>
    			<td class="table_Hblock">조회수</td>
    			<td class="table_Cblock"><%=bpDTO.getBoard_count()%></td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">내용</td>
    			<td colspan="5" class="table_Context">
    				<%if(!bpDTO.getFile_id().equals("-1")){ %>
					<div align="center">
						<img src="<%=request.getContextPath()%>/resources/files/<%=imgDTO.getFile_sevname()%>" style="margin-bottom:5px; min-width:auto; max-width:100%;">
					</div>
					<%}%>
    				<%=bpDTO.getContent()%>
    			</td>
    		</tr>
    		<tr>
    			<td class="table_Hblock">댓글</td>
    			<td colspan="5" style="padding:8px;">
    				<table width="100%" style="border-top:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD;">
    				<%if(repleList!=null){ int i=0;%>
    				<%for(ADMIN_Board_RepleDTO brDTO : repleList){%>
    					<tr style="border-bottom:1px solid #DDDDDD;">
    						<td class="reple_block" width="15%"><%=br_uDTOarr.get(i).getUser_nick()%></td>
    						<td class="textarea_block">
    							<%if(!brDTO.getBoard_reple_level().equals(String.valueOf(brDTO.getReple_seq()))){ %>
   									<img src="<%=request.getContextPath()%>/resources/img/admin/reple_icon.png">
   								<%} %>
   								<span id="r_text<%=brDTO.getReple_seq()%>">
   									<%=brDTO.getBoard_reple_content()%>
   								</span>
   								<span id="r_Lcreate<%=brDTO.getReple_seq()%>"></span>
    						</td>
    						<td class="reple_date_block"><%=brDTO.getReg_date()%></td>
    						<td class="table_CCblock" width="20%" style="padding-left:5px; text-align:left;">
    							<input type="button"  value="수정" class="btn btn-default" onClick="javascript:reple_Edit(<%=brDTO.getReple_seq()%>);">
    							<%if(brDTO.getBoard_reple_level().equals(String.valueOf(brDTO.getReple_seq()))){ %>
    							<input type="button"  value="답글" class="btn btn-default" onClick="javascript:reple_Lcreate(<%=brDTO.getReple_seq()%>);">
    							<%} %>
    							<input type="button"  value="삭제" class="btn btn-default" onClick="location.href='<%=request.getContextPath()%>/board_reple/board_reple_delete.do?board_p_seq=<%=brDTO.getBoard_p_seq()%>&reple_seq=<%=brDTO.getReple_seq()%>'">
    						</td>
    					</tr>
    				<%i++;}
    				} %>
    					<tr>
	    					<form action="<%=request.getContextPath()%>/admin/board_reple/board_reple_create.do" method="post">
	    						<input type="hidden" value="<%=bpDTO.getBoard_p_seq()%>" name="board_p_seq">
	    						<td class="reple_block" >관리자</td>
	    						<td colspan="2" class="textarea_block"><textarea name="content" style="width:100%; height:75px;" class="form-control"></textarea></td>
	    						<td class="textarea_block"><input type="submit" value="저장" class="btn btn-default" style="width:100%; height:75px;"></td>
	    					</form>
    					</tr>
    				</table>
    			</td>
    		</tr>
    	</table>
</div>
	<div align="center">
		<input type="button"  value="목록" class="btn btn-default" style="width:80px;" onClick="location.href='<%=request.getContextPath()%>/admin/board_p/board_p_list.do'">
		<input type="button"  value="수정" class="btn btn-default" style="width:80px;" onClick="location.href='<%=request.getContextPath()%>/admin/board_p/board_p_edit.do?board_p_seq=<%=bpDTO.getBoard_p_seq()%>'">
		<%if(String.valueOf(bpDTO.getBoard_p_seq()).equals(bpDTO.getBoard_level())){ %>
		<input type="button"  value="답변" class="btn btn-default" style="width:80px;" onClick="location.href='<%=request.getContextPath()%>/admin/board_p/board_p_Lcreate.do?board_p_seq=<%=bpDTO.getBoard_p_seq()%>'">
		<%} %>
		<input type="button"  value="삭제" class="btn btn-default" style="width:80px;" onClick="location.href='<%=request.getContextPath()%>/admin/board_p/board_p_delete.do?board_p_seq=<%=bpDTO.getBoard_p_seq()%>'">
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
<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap-toggle.min.js"></script>

</body>
</html>