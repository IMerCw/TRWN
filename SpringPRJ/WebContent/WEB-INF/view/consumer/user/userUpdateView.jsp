<%@page import="poly.dto.consumer.CONSUMER_UserDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
CONSUMER_UserDTO uDTO = (CONSUMER_UserDTO)request.getAttribute("uDTO");
%>


<html>
<head>
	<title>web</title>
	<%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %>
			
</head>
<body>
	<%@ include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<div class="container">
		<div class="row">
		<form action="/cmmn/user/userUpdateProc.do" method="post">
		
			<table class="table table-striped" style=" border: 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="3" style="background-color: #eeeeee; text-align: center;">회원정보 수정하기</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 20%; text-align:left;">회원번호 :</td>
					<td colspan="2">
						<%=uDTO.getUserSeq() %>
					</td>
				</tr>
				<tr>
					<td >이메일 :</td>
					<td colspan="2" style="text-align:left;" >
						<%=uDTO.getUserEmail() %>
					</td>
				</tr>
				<tr>
					<td >새 비밀번호 :</td>
					<td colspan="2" style="text-align:left;">
						<input type="password" name="userPassword" id="register_userPassword" tabindex="2" class="form-control" placeholder="새 비밀번호" data-msg="비밀번호를" <%-- value="<%=uDTO.getUser_Pwd() %>" --%> >
								
					</td>
				</tr>
				<tr>
					<td >닉네임 :</td>
					<td colspan="2" style="text-align:left;">
						<input type="text" name="nickname" id="nickname" tabindex="3" class="form-control" data-msg="닉네임을" value="<%=uDTO.getUserNick()%>" >
					</td>
				</tr>
				<tr>
					<td >성별 :</td>
					<td colspan="2" style="text-align:left;">
						<%=uDTO.getUserGender() %>
					</td>
				</tr>
				<tr>
					<td >핸드폰번호 :</td>
					<td colspan="2" style="text-align:left;">
						<input type="text" name="phone" id="phone" tabindex="5" class="form-control" data-msg="핸드폰 번호를" value="<%=uDTO.getUserHp() %>" >
							
					</td>
				</tr>
				
				<tr>
					<td colspan="3">
						<div class="col-sm-6 col-sm-offset-3">
							<input type="submit" name="register-submit" class="form-control btn btn-primary" value="수정하기">
						</div>
					</td>
				</tr>
				
			</tbody>
				
		</table>
		<input type="hidden" name="userSeq" value="<%=uDTO.getUserSeq() %>">
	</form>
		</div>
	</div>


</body>
</html>