<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userSeq = CmmUtil.nvl((String)session.getAttribute("userSeq"));
	String userAuth = CmmUtil.nvl((String)session.getAttribute("userAuth"));
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>트럭왔냠 관리자 페이지 - 삭제 예정</title>
	<style>
	    body {
	    	margin: 0 auto;
	    	width:50%;
	        font-family: "Lato", sans-serif;
	    }
	    a {
	        text-decoration: none;
	        color:black;
	    }
	    #logo_main {
	        margin: 0 auto;
	        width: 200px;
	
	    }
	    #container {
	        margin: 0 auto;
	        width: 70%;
	        overflow:hidden;
	        margin-top:100px;
	    }
	
	    #container h1 {
	        font-size : 30px;
	        
	    }
	
	    #truck_in{
	        border : 3px solid gray;
	        border-radius: 5px;
	        height: 160px;
	        width: 35%;
	        float : left;
	        text-align:center;
	    }
	
	     #truck_out{
	
	        border : 3px solid gray;
	        border-radius: 5px;
	        height: 160px;
	        width: 35%;
	        float : right;
	        text-align:center;
	    }
	
	
	    /*스마트폰*/
	    @media screen and (max-width: 767px) {
	        body {
	            margin: 0 auto;
	            width:80%;
	            font-family: "Lato", sans-serif;
	        
	        }
	        p {
	            font-size:12px;
	        }
	        #container h1{
	            font-size: 22px;
	        }
	        #truck_in {
	            width: 40%;
	            height:60%;
	        }
	        #truck_out {
	            width: 40%;
	            height:60%;
	        }
	
	    }
	    /*태블릿PC*/
	    @media screen and (min-width: 768px) and (max-width: 1024px) {
	        #truck_in {
	            width: 30%;
	        }
	        #truck_out {
	            width: 30%;
	        }
	        body {
	            margin: 0 auto;
	            width:80%;
	            font-family: "Lato", sans-serif;
	        
	        }
	    }
	</style>


	<script>
	    function changeBg(x) {
	        
	        var btn;
	        if (x == 'in') {
	            btn = document.getElementById('truck_in');
	            btn.style.backgroundColor = 'Tomato';
	        }
	        else {
	            btn = document.getElementById('truck_out');   
	            btn.style.backgroundColor = 'SlateBlue';
	        }
	        
	    }
	    function changeBg_out(x) {
	    
	
	
	        var btn;
	        if (x == 'in') {
	            btn = document.getElementById('truck_in');
	        }
	        else {
	            btn = document.getElementById('truck_out');
	        }
	        btn.style.backgroundColor = 'white';
	
	    }
	</script>

</head>
<body>
	<form action="/seller/out/out_info.do">
		<input type="hidden" value="<%=userSeq%>" name="userSeq"/>
		<input type="hidden" value="<%=userAuth%>" name="userAuth"/>
		<table style="height: 100%; width: 100%">
			<tr height="7%" bgcolor="#333333">
				<td>
	
				</td>
			</tr>
			<tr bgcolor="">
				<td>
					<div class="container">
						<div id="logo_main"> <img src="/resources/img/consumer/logo.png" width="100%"/></div>
				
					    <div id="container">
					        <a href="/seller/inMain.do">
					            <div id="truck_in" onmouseover="changeBg('in')" onmouseout="changeBg_out('in')">
					                <h1>IN</h1>
					                <hr width="80%"/>
					                <p>푸드트럭 안</p>
					            </div>
					        </a>
					        <button type="submit">
					            <div id="truck_out"  onmouseover="changeBg('out')" onmouseout="changeBg_out('out')">
					                <h1>OUT</h1>
					                <hr width="80%"/>
					                <p>푸드트럭 밖</p>
					            </div>
					        </button>
					    </div>
				
				
					</div>
	
				</td>
			</tr>
			<tr height="7%" bgcolor="#333333">
				<td>
					<%@ include file="/WEB-INF/view/seller/bottom.jsp" %>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>