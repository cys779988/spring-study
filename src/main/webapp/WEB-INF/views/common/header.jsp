<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" href="/css/common.css"/>
<style>
#session{
    color: rgba(255,255,255,.55);
}
</style>
<div id="sidebar-wrapper">
	    <ul class="sidebar-nav">
			<li class="sidebar-brand">
	        <a href="#">STUDY.COM</a>
			</li>
			<li><a href="/board/">Board</a></li>
			<li><a href="/board/courseList">Course</a></li>
			<li><a href="/chat/room">Chat</a></li>
	    </ul>
</div>
<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
  <div class="collapse navbar-collapse" id="navbarsExample03">
    <ul class="navbar-nav mr-auto">
		<c:if test="${sessionScope != null}">
			<li class="nav-item">
				<a href="/user/logout"><span id="session">로그아웃</span></a>
			</li>
		</c:if>
	</ul>
    <form class="form-inline my-2 my-md-0">
    </form>
  </div>
	<div class="row">
    	<div class="col">
	    <span id="session">${sessionScope.user.name}  ${sessionScope.user.email}</span>
		</div>
    </div>
</nav>

