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
<title>게시판 만들기</title>
</head>
<body>
	<table width="100%">
		<tr style="border-top:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD;">
			<td width="25%" class="table_Hline">게시판 이름</td>
			<td class="table_line"><input type="text" class="form-control" name="board_name"></td>
		</tr>
		<tr style="border-bottom:1px solid #DDDDDD;">
			<td class="table_Hline">읽기권한</td>
			<td class="table_line">
				<select class="form-control" name="read">
					<option value="0">일반회원</option>
					<option value="1">사업자회원</option>
					<option value="9">관리자</option>
				</select>
			</td>
		</tr>
		<tr style="border-bottom:1px solid #DDDDDD;">
			<td class="table_Hline">쓰기권한</td>
			<td class="table_line">
				<select class="form-control" name="write">
					<option value="0">일반회원</option>
					<option value="1">사업자회원</option>
					<option value="9">관리자</option>
				</select>
			</td>
		</tr>
		<tr style="border-bottom:1px solid #DDDDDD;">
			<td class="table_Hline">댓글권한</td>
			<td class="table_line">
				<select class="form-control" name="reple">
					<option value="0">일반회원</option>
					<option value="1">사업자회원</option>
					<option value="9">관리자</option>
				</select>
			</td>
		</tr>
		<tr style="border-bottom:1px solid #DDDDDD;">
			<td class="table_Hline">노출여부</td>
			<td class="table_line">
				<select class="form-control" name="exp_yn">
					<option value="1">노출</option>
					<option value="-1">비노출</option>
				</select>
			</td>
		</tr>
	</table>
</body>
</html>