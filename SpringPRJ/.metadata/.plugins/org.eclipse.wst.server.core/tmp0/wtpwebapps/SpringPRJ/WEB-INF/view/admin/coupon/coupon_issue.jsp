<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_User_InfoDTO" %>
<%@page import="poly.dto.admin.ADMIN_CouponDTO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	List<ADMIN_User_InfoDTO> uDTOarr = (List<ADMIN_User_InfoDTO>)request.getAttribute("uDTOarr");
	List<ADMIN_CouponDTO> cpDTOarr = (List<ADMIN_CouponDTO>)request.getAttribute("cpDTOarr");
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>쿠폰 발급</title>
</head>
<body>
	<input type="hidden" name="user_seq" id="user_seq" value="">
	<table width="100%">
		<tr style="border-top:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD;">
			<td width="25%" class="table_Hline">쿠폰선택</td>
			<td class="table_line">
				<select class="form-control" name="coupon_code">
					<%for(ADMIN_CouponDTO cpDTO : cpDTOarr){ %>
						<option value="<%=cpDTO.getCoupon_code()%>"><%=cpDTO.getCoupon_name()%></option>
					<%} %>
				</select>
			</td>
		</tr>
		<tr style="border-bottom:1px solid #DDDDDD;">
			<td class="table_Hline">발급대상</td>
			<td class="table_line">
			  <div class="form-group">
			    <div class="input-group">
			      <div class="input-group-addon">
			      	<select class="issue_option" id="issue_option" onchange="issue_option_select(this.form)" style="padding-left:3px; padding-right:3px; background-color:#fefefe">
						<option value="user_email" selected>이메일</option>
						<option value="user_hp">핸드폰번호</option> 
					</select>
			      </div>
			      <input type="text" class="form-control" placeholder="ex) hong@naver.com" style="height:38px; padding-right:55px;" name="value" id="value">
			      <input type="button" class="btn btn-default" id="check_btn" onclick="javascript:user_check();" style="position:absolute; margin-left:-52px; z-index:10; height:38px; float:right; border-radius:0px 4px 4px 0px;" value="확인">
			    </div>
			  </div>
			  <label id="check_result" style="float:left;"></label>
			  <input type="button" id="check_reset" class="btn btn-default" onclick="javascript:user_check_reset();" value="다시설정" style="float:right; margin-top:-6px; display:none;">
			</td>
		</tr>
		<tr style="border-bottom:1px solid #DDDDDD;">
			<td class="table_Hline">발급수량</td>
			<td class="table_line">
				<input type="text" class="form-control" name="coupon_count">		
			</td>
		</tr>
	</table>
	<script>
		function user_check(){
			var option = document.getElementById('issue_option').value;
			var value = document.getElementById('value').value;
			var check = false;
			var check2 = true;
			var check_option = "user_email";
			var user_seq;
			<%for(ADMIN_User_InfoDTO uDTO : uDTOarr){%>
				if(option==check_option){
					if(value=='<%=uDTO.getUser_email()%>'){
						user_seq = <%=uDTO.getUser_seq()%>;
						check=true;
					}
				}else{
					if(value=='<%=uDTO.getUser_hp()%>'){
						user_seq = <%=uDTO.getUser_seq()%>;
						check=true;
					}
				}
			<%}%>
			if(check){
				document.getElementById('user_seq').value=user_seq;
				document.getElementById('check_result').style.display="block";
				document.getElementById('check_result').innerHTML="발급가능한 대상입니다.";
				document.getElementById('check_result').style.color="#5F8C31";
				document.getElementById('issue_option').disabled = "disabled";
				document.getElementById('value').disabled = "disabled";
				document.getElementById('check_reset').style.display="block";
			}else{
				document.getElementById('check_result').style.display="block";
				document.getElementById('check_result').innerHTML="검색된 회원이 없습니다.";
				document.getElementById('check_result').style.color="#D9534F";
			}
		}

		function  user_check_reset(){
			document.getElementById('value').removeAttribute("disabled");
			document.getElementById('issue_option').removeAttribute("disabled");
			document.getElementById('value').value="";
			document.getElementById('check_result').style.display="none";
			document.getElementById('check_reset').style.display="none";
			check=false;
		}
		
		function issue_option_select(e){
			 var select = coupon_issue.issue_option.selectedIndex;
			if(select==0){
				document.getElementById('value').placeholder="ex) hong@naver.com";
			}else if(select==1){
				document.getElementById('value').placeholder="ex) 010-0000-0000";
			}
		}
		
		$(function () {
			  $('[data-toggle="tooltip"]').tooltip()
			})
	</script>
</body>
</html>