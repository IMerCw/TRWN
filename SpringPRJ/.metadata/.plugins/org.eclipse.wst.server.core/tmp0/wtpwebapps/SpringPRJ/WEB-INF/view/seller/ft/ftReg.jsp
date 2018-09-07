<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<!-- Bootstrap -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/bootstrap.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/ft_info.css">
	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	    <![endif]-->

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>board</title>
	<%@ include file="/WEB-INF/view/seller/topCssScript.jsp" %>
</head>
<body>
	<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="#333333">
			<td>
				<%@ include file="/WEB-INF/view/seller/topBody.jsp" %>
			
			</td>
		</tr>
		<tr bgcolor="">
			<td>
		
			<!-- 판매자 푸드트럭관리 -->
			<div class="container">
				<!-- 푸드트럭이미지 & 푸드트럭 소개 -->
				<div id="leftContents" style="height:auto;">
					<!-- 트럭이미지 -->
					<div class="truckImg button">
						&lt; 푸드트럭 이미지 &gt;
					</div>
					<!-- 트럭 이름 -->
					<div style="font-size:24px; line-height:46px; height:52px; font-weight:bold;">
						예)트럭이름
					</div>
					<!-- 배달/케이터/주문예약 가능 불가능 설정 -->
					<div class="truckDelivery" style="margin-top:5px; margin-bottom:5px;">
						예)배달/케이터링/주문예약 
					</div>
					<div style="margin-top:10px;">
						<div style="text-align:center; margin-left:8px; margin-right:8px; margin-bottom:3px; padding-top:3px; padding-bottom:6px; border:1px solid #cccccc;">
							<b style="font-size:12px;">영업일 / 시간</b><br><span style="font-size:12px;">예)월요일~토요링[주6일]</span><br><span style="font-size:12px;">예)09:00~18:00</span>
						</div> 
						<div style="float:left; width:47%; text-align:center; margin-left:8px; margin-right:2px; margin-bottom:3px; padding-top:3px; padding-bottom:6px; border:1px solid #cccccc;">
							<b style="font-size:12px;">가입일</b><br><span style="font-size:12px;">예)2018.07.27</span>
						</div>
						<div style="float:right; width:47%; text-align:center; margin-left:2px; margin-right:8px; margin-bottom:3px; padding-top:3px; padding-bottom:6px; border:1px solid #cccccc;">
							<b style="font-size:12px;">푸드트럭 상태</b><br>
							<span style="font-size:12px;">
								예)정상
							</span>
						</div> 
						<div style="float:left; width:47%; text-align:center; margin-left:8px; margin-right:2px; margin-bottom:3px; padding-top:3px; padding-bottom:6px; border:1px solid #cccccc;">
							<b style="font-size:12px;">사업자이름</b><br><span style="font-size:12px;">예)송진수</span>
						</div>
						<div style="float:right; width:47%; text-align:center; margin-left:2px; margin-right:8px; margin-bottom:3px; padding-top:3px; padding-bottom:6px; border:1px solid #cccccc;">
							<b style="font-size:12px;">사업자번호</b><br><span style="font-size:12px;">예)000-000-000000</span>
						</div> 
						<div style="float:left; width:47%; text-align:center; margin-left:8px; margin-right:2px; margin-bottom:3px; padding-top:3px; padding-bottom:6px; border:1px solid #cccccc;">
							<b style="font-size:12px;">푸드트럭번호</b><br><span style="font-size:12px;">예)0</span>
						</div>
						<div style="float:right; width:47%; text-align:center; margin-left:2px; margin-right:8px; margin-bottom:3px; padding-top:3px; padding-bottom:6px; border:1px solid #cccccc;">
							<b style="font-size:12px;">회원번호</b><br><span style="font-size:12px;">예)0</span>
						</div> 
					</div>
					<div style="clear:both;"></div>
					
				</div>
		
				<!------------------ 오른쪽 ------------------>
				<div id="rightContents">
				
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
					
					<h3>푸드트럭 정보수정</h3>
					    <div style="border-bottom:1px solid #444444; margin-top:15px;"></div>
						<div style="margin-top:15px; margin-bottom:25px;">
							<form action="/seller/ft/ftRegProc.do" method="post"  name="ftReg" enctype="multipart/form-data">
								<table width="100%">
									<tr style="border-top:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD;">
										<td width="28%" class="table_Hline">푸드트럭 이미지</td>
										<td class="table_line"><input type="file" value="이미지 파일 아이디" name="fileId" id="fileId"></td>
										<!-- input type="file" 이라고 꼭 저어줘야 함 -->
									</tr>
									<tr style="border-bottom:1px solid #DDDDDD;">
										<td class="table_Hline">푸드트럭 이름</td>
										<td class="table_line">
											<input type="text" name="ftName" value="푸드트럭 이름" class="form-control">
										</td>
									</tr>
									<tr style="border-bottom:1px solid #DDDDDD;">
										<td class="table_Hline">푸드트럭 소개</td>
										<td class="table_line">
											<textarea name="ftIntro" class="form-control" style="height:80px;">푸드트럭 소개</textarea>
										</td>
									</tr>
									<tr style="border-bottom:1px solid #DDDDDD;">
										<td class="table_Hline">사업자 이름</td>
										<td class="table_line">
										<input type="text" name="selName" value="사업자 이름" class="form-control">
						
										</td>
									</tr>
									<tr style="border-bottom:1px solid #DDDDDD;">
										<td class="table_Hline">사업자 번호</td>
										<td class="table_line">
										<input type="text" name="selNo" value="000-000-000000" class="form-control">
						
										</td>
									</tr>
									<tr style="border-bottom:1px solid #DDDDDD;">
										<td class="table_Hline">푸드트럭 서비스</td>
										<td class="table_line">
											<div class="checkbox">
												<%-- <%
												boolean delivery=false, order=false, catering=false;
												for(int i=0; i<func_array.length; i++){ 
													if(func_array[i].equals("배달"))delivery=true;
													if(func_array[i].equals("주문예약"))order=true;
													if(func_array[i].equals("케이터링"))catering=true;
												}%> --%>
												<label><input type="checkbox" name="delivery"  value="배달">배달</label>&nbsp;&nbsp;
												<label><input type="checkbox" name="order"  value="주문예약">주문예약</label>&nbsp;&nbsp;
												<label><input type="checkbox" name="catering" value="케이터링">케이터링</label>
											</div>
										</td>
									</tr>
									<tr style="border-bottom:1px solid #DDDDDD;">
										<td class="table_Hline">영업일</td>
										<td class="table_line">
											<select class="form-control" name="ft_bday">
												<option value="월요일 ~ 금요일 [주 5일-평일]" >월요일 ~ 금요일 [주 5일-평일]</option>
												<option value="월요일 ~ 토요일 [주 6일]" >월요일 ~ 토요일 [주 6일]</option>
												<option value="금요일 ~ 일요일 [주 3일]" >금요일 ~ 일요일 [주 3일]</option>
												<option value="토요일 ~ 일요일 [주 2일-주말]" >토요일 ~ 일요일 [주 2일-주말]</option>
												<option value="월요일 ~ 일요일 [매일]" >월요일 ~ 일요일 [매일]</option>
											</select>
										</td>
									</tr>
									<tr style="border-bottom:1px solid #DDDDDD;">
										<td class="table_Hline">영업시간</td>
										<td class="table_line">
											<div class="form-group">
									            <div style="float:left; width:50%; padding-left:15px; padding-right:15px; border-right:1px solid #cccccc;">
									               <p>OPEN</p>
									               <input class="form-control" name="ft_open_time" type="time" value="open">
									            </div>
									            <div style="float:right; width:50%; padding-left:15px; padding-right:15px;">
									               <p>CLOSE</p>
									               <input class="form-control" name="ft_close_time" type="time" value="close">
									         	</div>
									         </div>
										</td>
									</tr>
									<tr style="border-bottom:1px solid #DDDDDD;">
										<td class="table_Hline">푸드트럭 상태</td>
										<td class="table_line">
											<select class="form-control" name="ftStatus">
												<option value="0" >정상</option>
											</select>
										</td>
									</tr>
								</table>
								<div style="margin-top:10px; text-align:center;">
									<button type="button" class="btn btn-default" style="width:80px;" onClick="javascript:history.back();">취소</button>
									<button type="submit" class="btn btn-primary" style="width:80px;" >저장</button>
								</div>
								<!-- hidden -->
								<input type="hidden" name="userSeq" value="<%=userSeq%>"/>
								
								</form>
							</div>
					<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
					<script src="<%=request.getContextPath()%>/resources/js/jquery-1.11.2.min.js"></script> 
					<!-- Include all compiled plugins (below), or include individual files as needed --> 
					<script src="<%=request.getContextPath()%>/resources/js/bootstrap.min.js"></script>
					
					
						
				</div>
			</div>
		<hr>
			</td>
		</tr>
		<tr height="7%" bgcolor="#333333">
			<td>
				<%@ include file="/WEB-INF/view/seller/bottom.jsp" %>
			
			</td>
		</tr>
	</table>
	

</body>
</html>