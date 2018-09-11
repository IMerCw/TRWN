<%@page import="java.util.ArrayList"%>
<%@page import="poly.dto.seller.SELLER_WaitDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>

<% List<SELLER_WaitDTO> wList = (List<SELLER_WaitDTO>)request.getAttribute("wList"); %>
<% List menuView = (ArrayList)request.getAttribute("menuView"); %>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>board</title>
	<%@ include file="/WEB-INF/view/seller/topCssScript.jsp" %>

	<script type="text/javascript">
	window.setTimeout('window.location.reload()',30000);
	
	function waitComplete(){
		
		$.ajax({
			
			
			url: "/seller/orderWait/waitComplete.do",
			method : "post",
			data : {
				"waitSeq" : <%=wList.get(0).getWaitSeq()%>,
				"ftSeq" : <%=wList.get(0).getFtSeq()%>
			},
			dataType: "text",
			success: function(data){
				$('#newWaitList').html(data);
				
				/* console.log(data);
				var waitFirst ="";
					waitFirst += "<div style='background-color:white; margin-top:10% height:20%; text-align:center;'>";
					waitFirst += "wait No. " + data[0].waitSeq +"<br/>";
					waitFirst += "order No." + data[0].ordSeq +"<br/>";
					waitFirst += "order Hp." + data[0].userHp ;
					waitFirst += "</div>";
					
					console.log(waitFirst);
					console.log(data.length);
					var dataLength = data.length;
					console.log("data size : " + dataLength);
				var waitSecond ="";
					
					for(int i=1; i < dataLength; i++){
						waitSecond += "<div style='background-color:white; border:1px solid black; margin-top:15%; height:15%;' >";	
						waitSecond += "order No. " + data[i].ordSeq +"<br/>";
						waitSecond += "order Hp. " + data[i].userHp;
						waitSecond += "</div>";
					}
					console.log(waitSecond);
					$('#waitFirst').html(waitFirst);
					$('#waitSecond').html(waitSecond);  */
					
				location.reload();
			}
		});
		alert("test");
	}
	
	</script>


</head>
<body>
	<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="#444">
			<td style="padding:0;">
				<%@ include file="/WEB-INF/view/seller/top.jsp" %>
			</td>
		</tr>
		<tr bgcolor="">
			<td>
				<div class="container" style="height:100%;">
				<%if(wList.isEmpty() == false){ %>
					<div id="newWaitList">
						<div style="height:10%;" class="col-sm-12">
							<div class="col-sm-6" style="margin-top:3%;"><span style="border:1px solid black; border-radius:5px 5px 5px 5px;">&nbsp;&nbsp;조리중인 주문 &nbsp;&nbsp;</span></div>
							<div class="col-sm-6" style="text-align:right; margin-top:3%;"><span style="border:1px solid black; border-radius:5px 5px 5px 5px;">&nbsp;&nbsp; 대기열 : <%=wList.size()%> &nbsp;&nbsp; </span></div>			
						</div>
						<div class="col-sm-12" style="padding:0;">
							<div class="col-sm-8" style="background-color:#D5D5D5; height:70%;" id="waitFirst">
								<div style="background-color:white; margin-top:10%; height:20%; text-align:center;" >
									wait No. <%=wList.get(0).getWaitSeq()%><br/>
									order No. <%=wList.get(0).getOrdSeq()%><br/>
									order Hp. <%=wList.get(0).getUserHp()%>	
								</div>
								<div style="background-color:white; margin-top:10%; height:50%; text-align:center;">
									<div class="col-sm-12">
									<div class="col-sm-6" style="font-size:100%">메뉴 이름</div> 
									<div class="col-sm-6" style="font-size:100%">수량</div> 
									</div>
									<%for(int i=0; i < menuView.size(); i++){ %>
										<div class="col-sm-12">
											<div class="col-sm-6"><b style="font-size:250%"><%=menuView.get(i).toString().split(":")[0]%></b></div>
											<div class="col-sm-6"><b style="font-size:250%"><%=menuView.get(i).toString().split(":")[1]%></b></div>
											
										</div>
									<%} %>
								</div>
							</div>
							<div class="col-sm-4" style="height:70%;">
								<div style="height:80%;" id="waitSecond">
								
									<%if(wList.size() <5){ %>
										<%for (int i=1; i<wList.size(); i++){ %>
											<div style="background-color:white; border:1px solid black; margin-top:15%; height:15%;" >
											order No. <%=wList.get(i).getOrdSeq()%><br/>
											order Hp. <%=wList.get(i).getUserHp() %>
											</div>
										<%} %>
									<%}else{ %>
										<%for (int i=1; i< 5; i++){ %>
											<div style="background-color:white; border:1px solid black; margin-top:15%; height:15%;" >
											order No. <%=wList.get(i).getOrdSeq()%><br/>
											order Hp. <%=wList.get(i).getUserHp() %>
											</div>
										<%} %>
									<%} %>
							
									
								</div>
								<!-- <div style="border:1px solid black; text-align:center; height:10%;">소요시간 : 10분</div> -->
								
							</div>
						</div>
					</div>
						
						<button type="button" class="btn btn-secondary col-sm-12" onclick="JavaScript:waitComplete();" style="height:15%; font-size:400%; margin-top:1%; ">완료</button>
					</div>
					<%}%>
			</td>
		</tr>
		<tr height="7%" style="background-color:#444">
			<td>
				<%@ include file="/WEB-INF/view/seller/bottom.jsp" %>
			
			</td>
		</tr>
	</table>
	

</body>
</html>