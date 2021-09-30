<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div id="header">
			<c:import url="../common/header.jsp"></c:import>
		</div>
		<div class="row">
			<div class="col-md-12">
				<h2>채팅방 List</h2>
			</div>
		</div>
		<div class="input-group">
			<div class="input-group-prepend">
				<label class="input-group-text">방제목</label>
			</div>
			<input type="text" class="form-control" name="room_name">
			<div class="input-group-append">
                <button class="btn btn-primary" type="button" id="create-btn">채팅방 개설</button>
            </div>
		</div>
		<ul class="list-group" id="items">
            <li class="list-group-item list-group-item-action">
            </li>
        </ul>
	</div>
<script src="/webjars/axios/0.17.1/dist/axios.min.js"></script>
<script src="/webjars/sockjs-client/1.1.2/sockjs.min.js"></script>
<script>
	
	window.addEventListener('DOMContentLoaded', (e) => {
		e.preventDefault();
		getList();
	});
	
	function getList(){
		$.ajax({
			url : '/chat/rooms',
			method : 'GET',
			success : function(result){
				console.log(result);
				var items = document.getElementById('items');
				result.forEach(data => {
					var li = document.createElement('li');
					var a = document.createElement('span');
					li.className = 'list-group-item list-group-item-action';
					a.innerText = data.name;
					li.appendChild(a);
					items.appendChild(li);
					a.addEventListener('click', e => {
						enterRoom(data.roomId)
					});
				});
			}
		})
	}
	
	document.getElementById('create-btn').addEventListener('click', e => {
		var inputData = document.getElementsByName('room_name')[0].value;
		if(!inputData){
			alert('방 제목을 입력해 주세요');
			return false;
		} else {
			var params = new URLSearchParams();
            params.append("name", inputData);
            axios.post('/chat/room', params)
            .then( response => {
                    alert(response.data.name+"방 개설에 성공하였습니다.")
                    inputData = '';
                    getList();
                }
            )
            .catch( response => { alert("채팅방 개설에 실패하였습니다."); } );
		}
		
	})
	
	function enterRoom(roomId) {
		var sender = prompt('대화명을 입력해 주세요.');
		if(sender){
	        localStorage.setItem('wschat.sender',sender);
	        localStorage.setItem('wschat.roomId',roomId);
	        location.href="/chat/room/enter/"+roomId;
		}
	}
</script>
</body>
</html>