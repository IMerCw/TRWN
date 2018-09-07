<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
	@charset "utf-8";
/* CSS Document */

/* ---------- FONTAWESOME ---------- */
/* ---------- http://fortawesome.github.com/Font-Awesome/ ---------- */
/* ---------- http://weloveiconfonts.com/ ---------- */

@import url(http://weloveiconfonts.com/api/?family=fontawesome);

/* ---------- ERIC MEYER'S RESET CSS ---------- */
/* ---------- http://meyerweb.com/eric/tools/css/reset/ ---------- */

@import url(http://meyerweb.com/eric/tools/css/reset/reset.css);

/* ---------- FONTAWESOME ---------- */

[class*="fontawesome-"]:before {
  font-family: 'FontAwesome', sans-serif;
}

/* ---------- GENERAL ---------- */

body {
	background-color: #393937;
	font-family: Arial, sans-serif;
	font-size: 14px;
	line-height: 1.5em;
}

input {
	font-size: 1em;
	line-height: 1.5em;
	margin: 0;
	padding: 0;
	-webkit-appearance: none;
}

/* ---------- LOGIN ---------- */

#login {
	margin: 50px auto;
	width: 242px;
}

#login span {
	color: #676767;
	display: block;
	height: 48px;
	line-height: 48px;
	position: absolute;
	text-align: center;
	width: 36px;
}

#login input {
	border: none;
	height: 48px;
	outline: none;
}

#login input[type="text"] {
	background-color: #dedede;
	border-top: 1px solid #000;
	border-right: 1px solid #000;
	border-left: 1px solid #000;
	border-radius: 5px 5px 0 0;
	-moz-border-radius: 5px 5px 0 0;
	-webkit-border-radius: 5px 5px 0 0;
	color: #363636;
	padding-left: 36px;
	width: 204px;
}

#login input[type="password"] {
	background-color: #dedede;
	border-top: 1px solid #828282;
	border-right: 1px solid #000;
	border-bottom: 1px solid #000;
	border-left: 1px solid #000;
	border-radius: 0 0 5px 5px;
	-moz-border-radius: 0 0 5px 5px;
	-webkit-border-radius: 0 0 5px 5px;
	color: #363636;
	margin-bottom: 20px;
	padding-left: 36px;
	width: 204px;
}

#login input[type="submit"] {
	background-color: #e14d4d;
	border: 1px solid #391515;
	border-radius: 5px;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	color: #fff;
	font-weight: bold;
	line-height: 48px;
	text-align: center;
	text-transform: uppercase;
	width: 240px;
}

#login input[type="submit"]:hover {
	background-color: #f15958;
}
</style>
<html>
<head>

	<meta charset="utf-8">

	<title>Login_03</title>

	<!--[if lt IE 9]>
		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->

</head>

<body>

	<div id="login">

		<form action="javascript:void(0);" method="post">

			<span class="fontawesome-user"></span><input type="text" required value="Username" onBlur="if(this.value=='')this.value='Username'" onFocus="if(this.value=='Username')this.value='' "> <!-- JS because of IE support; better: placeholder="Username" -->
			<span class="fontawesome-lock"></span><input type="password" required value="Password" onBlur="if(this.value=='')this.value='Password'" onFocus="if(this.value=='Password')this.value='' "> <!-- JS because of IE support; better: placeholder="Password" -->
			<input type="submit" value="Login">

		</form>

	</div> <!-- end login -->

</body>	
</html>