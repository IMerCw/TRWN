<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String ft_seq = (String)request.getParameter("ft_seq");
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>리뷰쓰기</title>
<style>
	 @font-face {
        font-family: 'Glyphicons Halflings';
        src:url('https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/fonts/glyphicons-halflings-regular.eot');
        src:url('https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/fonts/glyphicons-halflings-regular.eot?#iefix') format('embedded-opentype'),
          url('https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/fonts/glyphicons-halflings-regular.woff') format('woff'),
          url('https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/fonts/glyphicons-halflings-regular.ttf') format('truetype');
      }
</style>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap-toggle.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap-stars.css">
</head>
<body>
	<h3>&nbsp;<b>리뷰 쓰기</b></h3>
	<hr>
	<form action="<%=request.getContextPath()%>/admin/ft/ft_review_create.do" method="post"  name="review_create" enctype="multipart/form-data">
		<input type="hidden" name="ft_seq" value="<%=ft_seq%>">
		<input type="hidden" name="cmd" value="review_list">
		<div style="margin-top:25px; margin-bottom:25px;">
	    	<table width="100%" style="border-top:1px solid #A2A2A2; border-bottom:1px solid #A2A2A2">
	    		<tr style="border-bottom:1px solid #EAEAEA;">
	    			<td class="table_Hblock" width="20%">게시판</td>
	    			<td class="table_Cblock">
						푸드트럭 리뷰
					</td>
	    			<td class="table_Hblock" width="20%">노출상태</td>
	    			<td class="table_Cblock" width="20%">
	    				<input type="checkbox" disabled checked data-toggle="toggle" data-width="70" name="exp_yn">
					</td>
	    		</tr>
	    		<tr style="border-bottom:1px solid #EAEAEA;">
	    			<td class="table_Hblock">제목</td>
	    			<td colspan="3"  class="table_Cblock">
						<input type="text" class="form-control" name="rev_title">
					</td>
	    		</tr>
	    		<tr style="border-bottom:1px solid #EAEAEA;">
	    			<td class="table_Hblock">별점</td>
	    			<td class="table_Cblock">
			        <div class="stars stars-example-bootstrap">
			            <select id="example-bootstrap" name="rev_point" autocomplete="off">
				            <option value="1">1</option>
				            <option value="2">2</option>
				            <option value="3">3</option>
				            <option value="4">4</option>
				            <option value="5">5</option>
		                </select>
	              	</div>
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
						<textarea style="width:100%; height:280px" class="form-control" name="rev_text"></textarea>
					</td>
	    		</tr>
	    	</table>
	    	<div align="center" style="margin-top:10px;">
				<input type="button"  value="취소" class="btn btn-default "  style="width:80px;" onClick="javascript:history.back();">
				<input type="submit"  value="저장" class="btn btn-primary" style="width:80px;">
			</div>
		</div>
	</form>
</body>
<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap-toggle.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/admin/jquery.barrating.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/admin/examples.js"></script>
</html>