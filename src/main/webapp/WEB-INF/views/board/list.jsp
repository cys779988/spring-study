<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>study</title>
    <!-- <link rel="stylesheet" href="/css/board.css"> -->
</head>
<body>
<div class="container">
	<div id="header">
		<c:import url="../common/header.jsp"></c:import>
	</div>

    	<div class="row">
	    	<div class="col">
		        <div class="search">
		            <input name="keyword" type="text" class="form-control" placeholder="검색어를 입력해주세요">
		        </div>
			</div>
			<div class="col">
		        <button id="search-btn" class="btn btn-primary mb-3">검색</button>
		    </div>
		</div>
			<div style="float: right;">
		        <button class="btn btn-primary mb-3" id="add-btn">글쓰기</button>
		    </div>

    <table class="table">
        <thead>
        <tr>
            <th class="one wide">번호</th>
            <th class="ten wide">글제목</th>
            <th class="two wide">작성자</th>
            <th class="three wide">작성일</th>
        </tr>
        </thead>

        <tbody id="boardList">
        <!-- CONTENTS !-->
        <%-- <c:forEach var="board" items="${boardList}">
        <tr>
            <td>
                <span>${board.id}</span>
            </td>
            <td>
                <a href="post/${board.id}">
                    <span>${board.title}</span>
                </a>
            </td>
            <td>
                <span>${board.writer}</span>
            </td>
            <td>
                <span>${board.createdDate}</span>
            </td>
        </tr>
        </c:forEach> --%>
        </tbody>
    </table>

	    <div id="page" class="position-relative start-50">
	    <%-- <c:forEach var="pageNum" items="${pageList}">
		    <span>
		        <a href="?page=${pageNum}">[${pageNum}]</a>
		    </span>
	    </c:forEach> --%>
	    </div>
	<div id="footer">
		<c:import url="../common/footer.jsp"></c:import>
	</div>
</div>
<script>
	window.addEventListener('DOMContentLoaded', (e) => {
		e.preventDefault();
		getBoard();
	});
	
	document.getElementById("search-btn").addEventListener("click", (e) => {
		getBoard(1);
	});
	
	document.getElementById("add-btn").addEventListener("click", (e) => {
		e.preventDefault();
		location.href = "/board/add";
	})
	
	function paging(e){
		getBoard(e.dataset.page);
	}
	
	function getBoard(page){
		page === undefined ? page = 1 : '';
		var keyword = $("input[name = keyword]").val();
		$.ajax({
			url : "/api/board/get?page="+ page +"&keyword="+keyword,
			method : "get",
			dataType : "text",
			success : function(result) {
				$('#boardList').empty();
				$('#page').empty();
				result = JSON.parse(result);
				
				var boardList = '';
				result.boardList.forEach((board)=> {
					boardList += '<tr><td>' + board.id + '</td>';
					boardList += '<td>' + '<a href="post/'+ board.id + '">' + board.title + '</a> </td>';
					boardList += '<td>' + board.writer + '</td>';
					boardList += '<td>' + board.createDate + '</td></tr>';
				});
				$('#boardList').append(boardList);
				
				var pageList = '';
				result.pageList.forEach((page)=> {
					if(page!=null){
						pageList += '<span> <a id= "paging" data-page="' + page + '" onclick="paging(this)">' + page + '</a></span>';
					}
				});
				
				$('#page').append(pageList);
				/* document.getElementById("paging").addEventListener("click", paging); */
			}
		});
	}
	
</script>
</body>
</html>