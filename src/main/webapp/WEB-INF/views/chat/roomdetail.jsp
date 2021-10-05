<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  .chat {
    height: 700px;
    overflow: auto;
  }
  .chat::-webkit-scrollbar {
    width: 10px;
  }
  .chat::-webkit-scrollbar-thumb {
    background-color: #2f3542;
  }
  .chat::-webkit-scrollbar-track {
    background-color: grey;
  }
</style>
</head>
<body>
	<div class="container">
		<div id="header">
			<c:import url="../common/header.jsp"></c:import>
		</div>
		<div>
			<input type="hidden" value="${roomId}" name="roomId"> 
		</div>
		<div class="input-group">
			<div class="input-group-prepend">
				<label class="input-group-text">내용</label>
			</div>
			<input type="text" class="form-control" name="message">
			<div class="input-group-append">
				<button class="btn btn-primary" type="button" id="sendMessage">보내기</button>
			</div>
		</div>
		<div class="chat" >
		<ul class="list-group" id="items">
       	</ul>
       	</div>
	</div>
<script src="/webjars/sockjs-client/1.1.2/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/2.3.3-1/stomp.min.js"></script>
<script>

	var sock = new SockJS("/ws-stomp");
	var ws = Stomp.over(sock);
	var messages = [];
	var roomId = document.getElementsByName('roomId')[0].value;
	window.addEventListener('DOMContentLoaded', (e) => {
		e.preventDefault();
	});
	
	
	document.getElementById('sendMessage').addEventListener('keyup', (e) => {
		if(e.keyCode === 13){
			sendMessage();
		}
	});
	
	document.getElementById('sendMessage').addEventListener('click', (e) => {
		sendMessage();
	});
	
	function sendMessage() {
		var message = document.getElementsByName('message')[0].value;
		ws.send("/pub/chat/message"
				, {}
				, JSON.stringify({
					type:'TALK'
					, roomId: roomId
					, sender: localStorage.getItem('wschat.sender')
					, message: message
					}
				)
		);
		document.getElementsByName('message')[0].value = '';
	}
	
	function recvMessage(recv) {
		messages.unshift({
			"type" : recv.type,
			"sender" : recv.type == 'ENTER' ? '[알림]' : recv.sender,
			"message" : recv.message
		});
		chatUpdate(recv);
	}
	ws.connect({}, function(frame) {
		ws.subscribe("/sub/chat/room/"+ roomId, function(message) {
			var recv = JSON.parse(message.body);
			recvMessage(recv);
		});
		
		ws.send("/pub/chat/message"
				, {}
				, JSON.stringify({
					type:'ENTER'
					, roomId: roomId
					, sender: localStorage.getItem('wschat.sender')
					}
				)
		);
		
	}, function(error) {
		alert(error);
	})
	
	function chatUpdate(messages){
		console.log(messages);
		var items = document.getElementById('items');
		var li = document.createElement('li');
		li.className = 'list-group-item';
		li.append(messages.sender + ' : ' +  messages.message);
		items.appendChild(li);
		var chatList = document.getElementsByClassName('chat')[0];
		chatList.scrollTop = chatList.scrollHeight;
	}
	
</script>
</body>
</html>