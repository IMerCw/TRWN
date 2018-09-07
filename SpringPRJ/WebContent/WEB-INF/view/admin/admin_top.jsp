<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap.css">
	
<nav class="navbar navbar-inverse" style="border-radius:0;">
	<div class="container-fluid" style="background-color:#161616;">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div
			style="width: 350px; height: 25px; border-radius: 0 0 10px 10px; background-color: #333333; margin: 0 auto; color: #fefefe; padding-right: 10px; padding-left: 15px; padding-top: 2px;">
			<p align="center" style="font-size: 12px;">
				<span style="color: #cccccc;">관리자 접속일시 : 2018.09.01 18:29</span>
				&nbsp;&nbsp;&nbsp;<input type="button" value="로그아웃"
					onClick="location.href='#'"
					style="border: #333333 1px solid; background-color: #454545; width: 70px; height: 21px;" />
			</p>
		</div>
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#myInverseNavbar2">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<strong> <a class="navbar-brand" href="<%=request.getContextPath() %>/admin/admin_main.do">트럭왔냠
					관리자</a></strong>
		</div>
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="myInverseNavbar2">
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#"
					class="dropdown-toggle" data-toggle="dropdown" role="button"
					aria-expanded="false">회원관리 <span class="caret"></span></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="<%=request.getContextPath() %>/admin/user/user_list.do">회원정보관리</a></li>
						<li class="divider"></li>
						<li><a href="#">정지/탈퇴관리</a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">푸드트럭관리
						<span class="caret"></span>
				</a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="<%=request.getContextPath() %>/admin/ft/ft_list.do">푸드트럭리스트</a></li>
						<li class="divider"></li>
						<li><a href="#">정지/탈퇴관리</a></li>
					</ul></li>
				<li><a href="<%=request.getContextPath() %>/admin/board/board_list.do">게시판관리</a></li>
				<li><a href="<%=request.getContextPath() %>/admin/board_p/board_p_list.do">게시물관리</a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">쿠폰관리
						<span class="caret"></span>
				</a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="<%=request.getContextPath()%>/admin/coupon/coupon_main.do?cmd=coupon_list">쿠폰만들기/리스트</a></li>
						<li class="divider"></li>
						<li><a href="<%=request.getContextPath()%>/admin/coupon/coupon_main.do?cmd=coupon_issue_list">쿠폰발급/조회</a></li>
					</ul></li>
				<li><a href="<%=request.getContextPath()%>/admin/order/order_main.do?cmd=order_list">결제관리</a></li>
				<li><a href="<%=request.getContextPath()%>/admin/banner/banner_main.do?cmd=banner_list">배너/팝업관리</a></li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid -->
</nav>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/admin/jquery-1.11.2.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
