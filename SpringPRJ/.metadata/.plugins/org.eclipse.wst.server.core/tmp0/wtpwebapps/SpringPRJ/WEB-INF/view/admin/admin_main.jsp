<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>트럭왔냠 전체 관리자</title>

<!-- Bootstrap -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap.css">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
</head>
<body>
	<%@include file="admin_top.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col-lg-9 col-md-12">
				<div class="row">
					<div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
						<div class="thumbnail">
							<img src="<%=request.getContextPath()%>/resources/img/admin/400X200.gif" alt="Thumbnail Image 1"
								class="img-responsive">
							<div class="caption">
								<h3>Heading</h3>
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
								<hr>
								<p class="text-center">
									<a href="#" class="btn btn-success" role="button">For Sale</a>
								</p>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
						<div class="thumbnail">
							<img src="<%=request.getContextPath()%>/resources/img/admin/400X200.gif" alt="Thumbnail Image 1"
								class="img-responsive">
							<div class="caption">
								<h3>Heading</h3>
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
								<hr>
								<p class="text-center">
									<a href="#" class="btn btn-info" role="button">For Rent</a>
								</p>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-md-4 col-sm-6 hidden-sm hidden-xs">
						<div class="thumbnail">
							<img src="<%=request.getContextPath()%>/resources/img/admin/400X200.gif" alt="Thumbnail Image 1"
								class="img-responsive">
							<div class="caption">
								<h3>Heading</h3>
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
								<hr>
								<p class="text-center">
									<a href="#" class="btn btn-success" role="button">For Sale</a>
								</p>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
						<div class="thumbnail">
							<img src="<%=request.getContextPath()%>/resources/img/admin/400X200.gif" alt="Thumbnail Image 1"
								class="img-responsive">
							<div class="caption">
								<h3>Heading</h3>
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
								<hr>
								<p class="text-center">
									<a href="#" class="btn btn-info" role="button">For Rent</a>
								</p>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-md-4 col-sm-6 col-xs-6">
						<div class="thumbnail">
							<img src="<%=request.getContextPath()%>/resources/img/admin/400X200.gif" alt="Thumbnail Image 1"
								class="img-responsive">
							<div class="caption">
								<h3>Heading</h3>
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
								<hr>
								<p class="text-center">
									<a href="#" class="btn btn-primary btn-success" role="button">For
										Sale</a>
								</p>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-md-4 hidden-sm hidden-xs">
						<div class="thumbnail">
							<img src="<%=request.getContextPath()%>/resources/img/admin/400X200.gif" alt="Thumbnail Image 1"
								class="img-responsive">
							<div class="caption">
								<h3>Heading</h3>
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
								<hr>
								<p class="text-center">
									<a href="#" class="btn btn-info" role="button">For Rent</a>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-3 col-md-6 col-md-offset-3 col-lg-offset-0">
				<div class="well">
					<h3 class="text-center">Find Your Home</h3>
					<form class="form-horizontal">
						<div class="form-group">
							<label for="location1" class="control-label">Location</label> <select
								class="form-control" name="" id="location1">
								<option value="">Any</option>
								<option value="">1</option>
								<option value="">2</option>
							</select>
						</div>
						<div class="form-group">
							<label for="type1" class="control-label">Type</label> <select
								class="form-control" name="" id="type1">
								<option value="">Any</option>
								<option value="">1</option>
								<option value="">2</option>
							</select>
						</div>
						<div class="form-group">
							<label for="pricefrom" class="control-label">Price From</label>
							<div class="input-group">
								<div class="input-group-addon">$</div>
								<input type="text" class="form-control" id="pricefrom">
							</div>
						</div>
						<div class="form-group">
							<label for="priceto" class="control-label">Price To</label>
							<div class="input-group">
								<div class="input-group-addon">$</div>
								<input type="text" class="form-control" id="priceto">
							</div>
						</div>
						<p class="text-center">
							<a href="#" class="btn btn-danger" role="button">Search </a>
						</p>
					</form>
				</div>
				<hr>
				<h3 class="text-center">Agents</h3>
				<div class="media-object-default">
					<div class="media">
						<div class="media-left">
							<a href="#"> <img class="media-object img-rounded"
								src="<%=request.getContextPath()%>/resources/img/admin/64X64.gif" alt="placeholder image">
							</a>
						</div>
						<div class="media-body">
							<h4 class="media-heading">John Doe</h4>
							<abbr title="Phone">P:</abbr> (123) 456-7890 <a href="mailto:#">first.last@example.com</a>
						</div>
					</div>
					<div class="media">
						<div class="media-left">
							<a href="#"> <img class="media-object img-rounded"
								src="<%=request.getContextPath()%>/resources/img/admin/64X64.gif" alt="placeholder image">
							</a>
						</div>
						<div class="media-body">
							<h4 class="media-heading">Linda Smith</h4>
							<abbr title="Phone">P:</abbr> (123) 456-7890 <a href="mailto:#">first.last@example.com</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<hr>
	<footer class="text-center">
		<%@include file="admin_bottom.jsp"%>
	</footer>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/admin/jquery-1.11.2.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
</body>
</html>