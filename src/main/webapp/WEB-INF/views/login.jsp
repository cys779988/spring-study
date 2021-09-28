<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
</head>
<body>
	<h1>로그인</h1>
	<hr>

	<form action="/user/login" method="post">
		<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>

		<input type="text" name="username" placeholder="이메일 입력해주세요"> <input
			type="password" name="password" placeholder="비밀번호">
		<button type="submit">로그인</button>
		<a href="/oauth2/authorization/naver" class="btn btn-secondary active"
			role="button"> Naver Login </a>
	</form>
</body>
</html>