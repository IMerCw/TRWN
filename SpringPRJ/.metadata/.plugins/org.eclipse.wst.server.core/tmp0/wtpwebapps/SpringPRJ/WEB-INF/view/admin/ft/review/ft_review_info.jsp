<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_Ft_InfoDTO" %>
<%@page import="poly.dto.admin.ADMIN_Ft_ReviewDTO" %>
<%@page import="poly.dto.admin.ADMIN_ImageDTO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	ADMIN_Ft_InfoDTO ftDTO2 = (ADMIN_Ft_InfoDTO)request.getAttribute("ftDTO");
	ADMIN_Ft_ReviewDTO revDTO = (ADMIN_Ft_ReviewDTO)request.getAttribute("revDTO");
	List<ADMIN_Ft_ReviewDTO> repleList = (List<ADMIN_Ft_ReviewDTO>)request.getAttribute("repleList");
	ADMIN_ImageDTO imgDTO = (ADMIN_ImageDTO)request.getAttribute("imgDTO");
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
	function reple_Edit(review_seq){ // 답변 수정
		var r_text= document.getElementById('r_text'+review_seq);
		var r_html = document.getElementById('r_text'+review_seq).innerHTML;
		if(check == false){
			$(r_text).replaceWith($(
					"<form id='r_obj"+review_seq+"' action='<%=request.getContextPath()%>/admin/ft/ft_review_reple_edit.do' method='post'>"+
					"<input type='hidden' name='cmd' value='review_info'>"+
					"<input type='hidden' name='ft_seq' value='<%=revDTO.getFt_seq()%>'>"+
					"<input type='hidden' name='review_seq' value='<%=revDTO.getReview_seq()%>'>"+
					"<input type='hidden' name='edit_review_seq' value='"+review_seq+"'>"+
					"<table width='100%'><tr>"+
					"<td><textarea id='r_text"+review_seq+"' name='rev_text' class='form-control' style='width:100%; height:75px;'>"+r_html+"</textarea></td>"+
					"<td width='90px'><input type='submit' value='저장' id='r_btn"+review_seq+"' class='form-control' style='margin-left:5px; width:90px; height:75px;'/></td>"+
					"</tr></table>"+
					"</form>"
			));
			check=true;
		}else{
			var r_btn= document.getElementById('r_btn'+review_seq);
			var r_obj= document.getElementById('r_obj'+review_seq);
			
			$(r_obj).replaceWith($("<span id='r_text"+review_seq+"'>"+r_html+"</span>"));
			$(r_btn).replaceWith($(""));
			check=false;
		}
	}
</script>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>리뷰 보기</title>

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
<body>
	<h3>리뷰보기</h3> 
    <div style="border-bottom:1px solid #444444; margin-top:15px;"></div>
	<div style="margin-top:25px; margin-bottom:25px;">
    	<table width="100%" style="border-top:1px solid #A2A2A2; border-bottom:1px solid #A2A2A2">
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock" width="14%">게시판</td>
    			<td colspan="3" class="table_Cblock">푸드트럭 리뷰</td>
    			<td class="table_Hblock" width="14%">노출상태</td>
    			<td class="table_Cblock" width="16%">
    				<%if(revDTO.getExp_yn()==1){%>
    					<input type="checkbox" disabled checked data-toggle="toggle" data-width="70">
    				<%}else{ %>
    					<input type="checkbox" disabled data-toggle="toggle" data-width="70">
    				<%} %>
				</td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">제목</td>
    			<td colspan="5" class="table_Cblock"><%=revDTO.getRev_title()%>&nbsp;<b>[<%=repleList.size()%>]</b></td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">작성자</td>
    			<td class="table_Cblock">/작성자/</td>
    			<td class="table_Hblock" width="14%">작성일</td>
    			<td class="table_Cblock"><%=revDTO.getRev_regdate()%></td>
    			<td class="table_Hblock">평점</td>
    			<td class="table_Cblock">
    				<%for(int x=0; x<5; x++){ 
						if(x<revDTO.getRev_point()){%>
						<img src="<%=request.getContextPath()%>/resources/img/admin/star.png" width="14%">
						<%}else{ %>
						<img src="<%=request.getContextPath()%>/resources/img/admin/non_star.png" width="14%">
						<%} %>
					<%} %>
    			</td>
    		</tr>
    		<tr style="border-bottom:1px solid #EAEAEA;">
    			<td class="table_Hblock">내용</td>
    			<td colspan="5" class="table_Context">
    				<%if(!revDTO.getFile_id().equals("-1")){ %>
						<div align="center">
							<img src="<%=request.getContextPath()%>/resources/files/<%=imgDTO.getFile_sevname()%>" style="margin-bottom:5px; min-width:auto; max-width:100%;">
						</div>
					<%}%>
    				<%=revDTO.getRev_text()%>
    			</td>
    		</tr>
    		<tr>
    			<td class="table_Hblock">답글</td>
    			<td colspan="5" style="padding:8px;">
    				<table width="100%" style="border-top:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD;">
    				<%if(repleList!=null){ %>
    				<%for(ADMIN_Ft_ReviewDTO revpDTO : repleList){ %>
    					<tr style="border-bottom:1px solid #DDDDDD;">
    						<td class="reple_block" width="15%">/작성자/</td>
    						<td class="textarea_block">
   								<span id="r_text<%=revpDTO.getReview_seq()%>">
   									<%=revpDTO.getRev_text()%>
   								</span>
   								<span id="r_Lcreate<%=revpDTO.getReview_seq()%>"></span>
    						</td>
    						<td class="reple_date_block"><%=revpDTO.getRev_regdate()%></td>
    						<td class="table_CCblock" width="20%" style="padding-left:5px; text-align:left;">
    							<input type="button"  value="수정" class="btn btn-default" onClick="javascript:reple_Edit(<%=revpDTO.getReview_seq()%>);">
    							<input type="button"  value="삭제" class="btn btn-default" onClick="location.href='<%=request.getContextPath()%>/admin/ft/ft_review_delete.do?cmd=review_info&ft_seq=<%=ftDTO2.getFt_seq()%>&review_seq=<%=revDTO.getReview_seq()%>&revp_seq=<%=revpDTO.getReview_seq()%>'">
    						</td>
    					</tr>
    				<%}
    				} %>
    					<tr>
	    					<form action="<%=request.getContextPath()%>/admin/ft/ft_review_reple_create.do" method="post">
	    						<input type="hidden" value="<%=revDTO.getFt_seq()%>" name="ft_seq">
	    						<input type="hidden" value="<%=revDTO.getReview_seq()%>" name="review_seq">
	    						<input type="hidden" value="review_info" name="cmd">
	    						<td class="reple_block" >관리자</td>
	    						<td colspan="2" class="textarea_block"><textarea name="rev_text" style="width:100%; height:75px;" class="form-control"></textarea></td>
	    						<td class="textarea_block"><input type="submit" value="저장" class="btn btn-default" style="width:100%; height:75px;"></td>
	    					</form>
    					</tr>
    				</table>
    			</td>
    		</tr>
    	</table>
</div>
	<div align="center">
		<input type="button"  value="목록" class="btn btn-default" style="width:80px;" onClick="location.href='<%=request.getContextPath()%>/admin/ft/ft_info.do?cmd=review_list&ft_seq=<%=revDTO.getFt_seq()%>'">
		<input type="button"  value="수정" class="btn btn-default" style="width:80px;" onClick="location.href='<%=request.getContextPath()%>/admin/ft/ft_info.do?cmd=review_edit&ft_seq=<%=revDTO.getFt_seq()%>&review_seq=<%=revDTO.getReview_seq()%>'">
		<input type="button"  value="삭제" class="btn btn-default" style="width:80px;" onClick="location.href='<%=request.getContextPath()%>/admin/ft/ft_review_delete.do?cmd=review_list&ft_seq=<%=revDTO.getFt_seq()%>&review_seq=<%=revDTO.getReview_seq()%>'">
	</div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/jquery-1.11.2.min.js"></script> 
<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap-toggle.min.js"></script>
</body>
</html>