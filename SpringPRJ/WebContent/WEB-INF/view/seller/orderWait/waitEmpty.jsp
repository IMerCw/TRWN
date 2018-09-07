<%@page import="poly.dto.seller.SELLER_WaitDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>

<% List<SELLER_WaitDTO> wList = (List<SELLER_WaitDTO>)request.getAttribute("wList"); %>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>board</title>
	<%@ include file="/WEB-INF/view/seller/topCssScript.jsp" %>
	
	<script type="text/javascript">
		//window.setTimeout('window.location.reload()',3000);
	</script>
	
	<style>

	/*스마트폰 320~425 에서는 메뉴가 일렬로 나열됩니다. */
	@media screen and (min-width: 320px) and (max-width: 770px) {
		/* 대기열이 없습니다 오류 수정해야합니다. */
	}
	
	body table #test td #container{
		background-color:blue;
	}
	
	
	</style>
	


</head>
<body>
	<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="#444">
			<td style="padding:0">
				<%@ include file="/WEB-INF/view/seller/top.jsp" %>
			</td>
		</tr>
		<tr bgcolor="" id="test">
			<td>
				 <div class="container" style="height:100%;">
					<div id="newWaitList">
						<div style="height:10%;" class="col-sm-12">
							<div class="col-sm-6" style="margin-top:3%;"><span style="border:1px solid black; border-radius:5px 5px 5px 5px;">&nbsp;&nbsp;조리중인 주문 &nbsp;&nbsp;</span></div>
							<div class="col-sm-6" style="text-align:right; margin-top:3%;"><span style="border:1px solid black; border-radius:5px 5px 5px 5px;">&nbsp;&nbsp; 대기열 : 0 &nbsp;&nbsp; </span></div>			
						</div>
						<div class="col-sm-12" style="padding:0;">
							<div class="col-sm-8" style="background-color:#D5D5D5; height:70%;" id="waitFirst">
								<div style="background-color:white; margin-top:10%; height:20%; text-align:center;" >
									대기열이 없습니다.
								</div>
								<div style="background-color:white; margin-top:10%; height:50%; text-align:center;">메뉴 이름  : 수량 </div>
							</div>
							<div class="col-sm-4" style="height:70%;">
								<div style="height:80%;" id="waitSecond">
									대기열이 없습니다.
								</div>
								<!-- <div style="border:1px solid black; text-align:center; height:10%;">소요시간 : 10분</div> -->
							</div>
						</div>
					</div>
						<button type="button" class="btn btn-secondary col-sm-12" onclick="JavaScript:waitComplete();" style="height:15%; font-size:400%; margin-top:1%; ">완료</button>
					</div>
				<!-- <section>
						<div class="box">
							<div class="content">
								<h2 class="align-center">Get in Touch</h2>
								<hr />
								<form action="#" method="post">
									<div class="field half first">
										<label for="name">Name</label>
										<input name="name" id="name" type="text" placeholder="Name">
									</div>
									<div class="field half">
										<label for="email">Email</label>
										<input name="email" id="email" type="email" placeholder="Email">
									</div>
									<div class="field">
										<label for="dept">Department</label>
										<div class="select-wrapper">
											<select name="dept" id="dept">
												<option value="">- Category -</option>
												<option value="1">Manufacturing</option>
												<option value="1">Shipping</option>
												<option value="1">Administration</option>
												<option value="1">Human Resources</option>
											</select>
										</div>
									</div>
									<div class="field">
										<label for="message">Message</label>
										<textarea name="message" id="message" rows="6" placeholder="Message"></textarea>
									</div>
									<ul class="actions align-center">
										<li><input value="Send Message" class="button special" type="submit"></li>
									</ul>
								</form>
							</div>
						</div>
					</section> -->
					
					
					
			</td>
		</tr>
		<tr height="7%" style="background-color:#444">
			<td >
				<%@ include file="/WEB-INF/view/seller/bottom.jsp" %>
			
			</td>
		</tr>
	</table>
	

</body>
</html>