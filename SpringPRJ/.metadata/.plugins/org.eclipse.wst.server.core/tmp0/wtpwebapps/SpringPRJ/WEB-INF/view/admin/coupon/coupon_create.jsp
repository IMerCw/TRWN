<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<title>쿠폰 만들기</title>
</head>
<body>
	<table width="100%">
		<tr style="border-top:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD;">
			<td width="25%" class="table_Hline">쿠폰이름</td>
			<td class="table_line"><input type="text" class="form-control" name="coupon_name"></td>
		</tr>
		<tr style="border-bottom:1px solid #DDDDDD;">
			<td class="table_Hline">쿠폰옵션</td>
			<td class="table_line">
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">할인금액</div>
				      <input type="text" class="form-control" data-toggle="tooltip" data-placement="top" title="구매금액 기준 할인" style="height:38px;" name="dc_money1">
				      <div class="input-group-addon">
				      	<select name="dc" onchange="dc_select(this.form)" style="padding-left:3px; padding-right:3px; background-color:#fefefe">
							<option value="1" selected>% 할인</option>
							<option value="2">원 할인</option> 
						</select>
				      </div>
				    </div>
				  </div>
				<div class="form-group" style="margin-bottom:5px; display:block;" id="dc1">
				    <div class="input-group">
						<input type="text" class="form-control" placeholder="최대 할인금액" data-toggle="tooltip" data-placement="left" title="최대 할인금액" name="dc_money2">  
						<div class="input-group-addon">원</div>
					</div>
				</div>
				<div class="form-group" style="margin-bottom:0px; display:block;" id="dc2">
				    <div class="input-group">
						<input type="text" class="form-control" placeholder="할인가능 구매금액" data-toggle="tooltip" data-placement="left" title="할인가능 구매금액" name="dc_money3"> 
						<div class="input-group-addon">원</div>
					</div>
				</div>
			</td>
		</tr>
		<tr style="border-bottom:1px solid #DDDDDD;">
			<td class="table_Hline">쿠폰기간</td>
			<td class="table_line">
				<div>
					<%@ include file="callender.jsp" %>
				</div>			
			</td>
		</tr>
	</table>
	<script>
		function dc_select(e){
			 var select = coupon_create.dc.selectedIndex;
			if(select==0){
				document.getElementById('dc1').style.display="block";
			}else if(select==1){
				document.getElementById('dc1').style.display="none";
			}
		}
		
		$(function () {
			  $('[data-toggle="tooltip"]').tooltip()
			})
	</script>
</body>
</html>