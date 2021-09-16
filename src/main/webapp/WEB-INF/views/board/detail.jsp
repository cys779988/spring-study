<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
	<div class="container">
		<div id="header">
		<c:import url="../common/header.jsp"></c:import>
		</div>
	    <h2>${boardDto.title}</h2>
	    <p>작성일 : [${boardDto.createdDate}]</p>
	
	    <p>${boardDto.content}</p>
	
	    <div class="row" style="float: right;">
	    	<div class="col">
	            <button class="btn btn-primary mb-3" id="list-btn">목록</button>
			</div>
	    	<div class="col">
	            <button class="btn btn-primary mb-3" id="modify-btn">수정</button>
			</div>
			<div class="col">
		        <button class="btn btn-primary mb-3" id="delete-btn">삭제</button>
	        </div>
	    </div>
    </div>
<script type="text/javascript" src="/js/common.js" ></script> 
<script>
	document.getElementById('list-btn').addEventListener('click',(e) => {
		e.preventDefault();
		location.href = "/board/";
	})

	document.getElementById('modify-btn').addEventListener('click',(e) => {
		e.preventDefault();
		location.href = "edit/${boardDto.id}";
	})
	
	document.getElementById('delete-btn').addEventListener('click',(e) => {
		e.preventDefault();
		
		$.ajax({
			url : "/api/board/${boardDto.id}",
			type : "delete",
			contentType : "application/json",
			dataType : "text",
			success : function(result){
				location.href = result;
			}
		});
	})
	
</script>
</body>
</html>
