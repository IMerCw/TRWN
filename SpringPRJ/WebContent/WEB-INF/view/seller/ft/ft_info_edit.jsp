<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="poly.dto.admin.ADMIN_Ft_InfoDTO" %>
<%@page import="poly.dto.admin.ADMIN_ImageDTO" %>
<%
	ADMIN_Ft_InfoDTO ftDTO2 = (ADMIN_Ft_InfoDTO)request.getAttribute("ftDTO");
	String[] optime_array = ftDTO2.getFt_optime().split("/");
	String[] func_array = ftDTO2.getFt_func().split("/");
	ADMIN_ImageDTO imgDTO = (ADMIN_ImageDTO)request.getAttribute("imgDTO");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>푸드트럭 정보수정</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/bootstrap.css">
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
<script>
	window.onload = function(){
		document.getElementById("uploadFile_label").innerHTML = '<%=imgDTO.getFile_orgname()%>';
	}
	function file_delete(){
		var uploadFile_label= document.getElementById('uploadFile_label');
		$(uploadFile_label).text("파일없음");
		document.getElementById("org_file_id").value = '-1';
	}
</script> 
</head>
<body>

<h3>푸드트럭 정보수정</h3>
    <div style="border-bottom:1px solid #444444; margin-top:15px;"></div>
	<div style="margin-top:15px; margin-bottom:25px;">
		<form action="<%=request.getContextPath()%>/seller/ft/ft_info_edit.do" method="post"  name="ft_info_edit" enctype="multipart/form-data">
			<input type="hidden" name="ft_seq" value="<%=ftDTO2.getFt_seq()%>">
			<input type="hidden" name="org_file_id" id="org_file_id" value="<%=ftDTO2.getFile_id() %>">
			<table width="100%">
				<tr style="border-top:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD;">
					<td width="28%" class="table_Hline">푸드트럭 이미지</td>
					<td class="table_line">
						<input type="file" id="uploadFile" name="uploadFile" style="float:left; margin-top:5px; width: 60%;"> 
						<input type="button" value="삭제" class="btn btn-default" onclick="javascript:file_delete()" style="float:left;">
						<div style="clear:both;">
							<label id="uploadFile_label" style="margin-top:3px;"></label>
						</div>
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">푸드트럭 이름</td>
					<td class="table_line">
						<input type="text" name="ft_name" value="<%=ftDTO2.getFt_name()%>" class="form-control">
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">푸드트럭 소개</td>
					<td class="table_line">
						<textarea name="ft_intro" class="form-control" style="height:80px;"><%=ftDTO2.getFt_intro()%></textarea>
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">사업자 이름</td>
					<td class="table_line">
						<%=ftDTO2.getSel_name()%>
						<input type="hidden" value="<%=ftDTO2.getSel_name()%>" name="sel_name" />
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">사업자 번호</td>
					<td class="table_line">
						<%=ftDTO2.getSel_no()%>
						<input type="hidden" value="<%=ftDTO2.getSel_no()%>" name="sel_no" />
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">푸드트럭 서비스</td>
					<td class="table_line">
						<div class="checkbox">
							<%
							boolean delivery=false, order=false, catering=false;
							for(int i=0; i<func_array.length; i++){ 
								if(func_array[i].equals("배달"))delivery=true;
								if(func_array[i].equals("주문예약"))order=true;
								if(func_array[i].equals("케이터링"))catering=true;
							}%>
							<label><input type="checkbox" name="delivery" <%if(delivery){%>checked<%}%> value="배달">배달</label>&nbsp;&nbsp;
							<label><input type="checkbox" name="order" <%if(order){%>checked<%}%> value="주문예약">주문예약</label>&nbsp;&nbsp;
							<label><input type="checkbox" name="catering" <%if(catering){%>checked<%}%> value="케이터링">케이터링</label>
						</div>
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">영업일</td>
					<td class="table_line">
						<select class="form-control" name="ft_bday">
							<option value="월요일 ~ 금요일 [주 5일-평일]" <%if(optime_array[0].equals("월요일 ~ 금요일 [주 5일-평일]")){%>selected<%}%>>월요일 ~ 금요일 [주 5일-평일]</option>
							<option value="월요일 ~ 토요일 [주 6일]" <%if(optime_array[0].equals("월요일 ~ 토요일 [주 6일]")){%>selected<%}%>>월요일 ~ 토요일 [주 6일]</option>
							<option value="금요일 ~ 일요일 [주 3일]" <%if(optime_array[0].equals("금요일 ~ 일요일 [주 3일]")){%>selected<%}%>>금요일 ~ 일요일 [주 3일]</option>
							<option value="토요일 ~ 일요일 [주 2일-주말]" <%if(optime_array[0].equals("토요일 ~ 일요일 [주 2일-주말]")){%>selected<%}%>>토요일 ~ 일요일 [주 2일-주말]</option>
							<option value="월요일 ~ 일요일 [매일]" <%if(optime_array[0].equals("월요일 ~ 일요일 [매일]")){%>selected<%}%>>월요일 ~ 일요일 [매일]</option>
						</select>
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">영업시간</td>
					<td class="table_line">
						<div class="form-group">
				            <div style="float:left; width:50%; padding-left:15px; padding-right:15px; border-right:1px solid #cccccc;">
				               <p>OPEN</p>
				               <input class="form-control" name="ft_open_time" type="time" value="<%=optime_array[1]%>">
				            </div>
				            <div style="float:right; width:50%; padding-left:15px; padding-right:15px;">
				               <p>CLOSE</p>
				               <input class="form-control" name="ft_close_time" type="time" value="<%=optime_array[2]%>">
				         	</div>
				         </div>
					</td>
				</tr>
				<tr style="border-bottom:1px solid #DDDDDD;">
					<td class="table_Hline">푸드트럭 상태</td>
					<td class="table_line">
						<select class="form-control" name="ft_status">
							<option value="1" <%if(ftDTO2.getFt_status()==1){ %>selected<%} %>>활동정지</option>
							<option value="0" <%if(ftDTO2.getFt_status()==0){ %>selected<%} %>>정상</option>
							<option value="-1" <%if(ftDTO2.getFt_status()==-1){ %>selected<%} %>>탈퇴대기</option>
						</select>
					</td>
				</tr>
			</table>
			<div style="margin-top:10px; text-align:center;">
				<button type="button" class="btn btn-default" style="width:80px;" onClick="javascript:history.back();">취소</button>
				<button type="submit" class="btn btn-primary" style="width:80px;" >저장</button>
			</div>
			</form>
		</div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/jquery-1.11.2.min.js"></script> 
<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap.min.js"></script>
</body>
</html>
