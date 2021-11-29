<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Course Regist</title>
<style>
#cy {
	position: absolute;
	width: 1600px;
	height: 700px;
	display: block;
}

h1 {
	opacity: 0.5;
	font-size: 1em;
	font-weight: bold;
}

.tippy-popper {
	transition: none !important;
}
</style>
</head>
<body class="sb-nav-fixed">
	<c:import url="../common/header.jsp"></c:import>
	<div id="layoutSidenav">
	<c:import url="../common/nav.jsp"></c:import>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
				<h2>Course Regist</h2>
					<div class="mb-3 mt-3">
						<ul class="nav nav-tabs" id="myTab">
						  <li class="nav-item">
						    <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#basic">기본정보</button>
						  </li>
						  <li class="nav-item">
						    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#detail">상세정보</button>
						  </li>
						</ul>
					</div>
					<div class="tab-content">
						 <div class="tab-pane fade show active" id="basic">
							<form name="form" id="form" role="form" method="post">
								<div class="mb-3">
									<input type="text" class="form-control" name="title" id="title" placeholder="제목">
								    <div>
								    	<p id="titleError"></p>
								    </div>
								</div>
								<div class="mb-3">
									<label for="category" class="form-label">분류</label>
									<select class="form-control" name="category" id="category">
										<option value="1">스터디</option>
										<option value="2">모임</option>
									</select>
									<br>
								    <div>
								    	<p id="typeError"></p>
								    </div>
								</div>
								<div class="row g-3">
									<div class="col-auto">
										<input type="number" class="form-control" name="divclsNo" id="divclsNo" placeholder="분반">
									</div>
									<div class="col-auto">
										<input type="text" class="form-control" name="maxNum" id="maxNum" placeholder="최대인원">
									</div>
								    <div>
								    	<p id="maxNumError"></p>
								    </div>
								</div>
								<div class="mb-3">
									<textarea class="form-control" rows="5" name="content" id="content" placeholder="내용"></textarea>
									<div>
								    	<p id="contentError"></p>
								    </div>
								</div>
							</form>
						</div>
						<div class="tab-pane fade show active" id="detail">
							<div style="height: 700px;">
						    	<div class="border border-dark" id="cy"></div>
							</div>
						    <div>
								<div class="row g-3 mt-3">
									<div class="col-auto">
										<input type="text" class="form-control" id="addName1" placeholder="Node Name" maxlength="10">
									</div>
									<div class="col-auto">
										<input type="text" class="form-control" id="addContent1" placeholder="Node Content" maxlength="20">
									</div>
								    <div class="col-auto">
								      <button class="btn btn-outline-dark" id="sipNode-add-btn">노드추가</button>
								      <button class="btn btn-outline-dark" id="drawOn-btn">그리기모드 on</button>
								      <button class="btn btn-outline-dark" id="drawOff-btn">그리기모드 off</button>
								    </div>
								</div>
						    </div>
						    <div id="myModal" class="modal" tabindex="-1">
						    	<div class="modal-dialog">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h5 class="modal-title">MindMap</h5>
								        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								      </div>
								      <div class="modal-body">
								      	<div class="mb-3 mt-3">
											<ul class="nav nav-tabs">
											  <li class="nav-item">
											    <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#modifyTab">수정</button>
											  </li>
											  <li class="nav-item">
											    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#registTab">등록</button>
											  </li>
											</ul>
										</div>
										<div class="tab-content">
											<div class="tab-pane fade show active" id="modifyTab">
												<div class="clearfix mb10">
						                            <button type="button" class="btn btn-secondary" id="modifyNode-btn">저장</button>
	       											<button type="button" class="btn btn-primary" id="deleteNode-btn">삭제</button>
						                        </div>
						                        <form id="modifyForm">
						                        	<input type="hidden" id="id">
							                        <table class="vertical mb16 tal">
							                            <colgroup>
							                                <col style="width:30%">
							                                <col style="width:70%">
							                            </colgroup>
							                            <tbody>
							                                <tr>
							                                    <th>name</th>
							                                    <td colspan="3">
							                                        <input type="text" class="form-control" id="nodeId" maxlength="10">
							                                    </td>
							                                </tr>
							                                <tr>
							                                    <th>content</th>
							                                    <td colspan="3">
							                                        <input type="text" class="form-control" id="nodeContent" maxlength="20">
							                                    </td>
							                                </tr>
							                            </tbody>
							                        </table>
						                        </form>
											</div>
											<div class="tab-pane fade" id="registTab">
												<div class="clearfix mb10">
						                            <button type="button" class="btn btn-secondary" id="addNode-btn">저장</button>
						                        </div>
						                        <form id="addForm">
							                        <input type="hidden" id="id">
							                        <table class="vertical mb16 tal">
							                            <colgroup>
							                                <col style="width:30%">
							                                <col style="width:70%">
							                            </colgroup>
							                            <tbody>
							                                <tr>
							                                    <th>name</th>
							                                    <td colspan="3">
							                                        <input type="text" class="form-control" id="addId" maxlength="10">
							                                    </td>
							                                </tr>
							                                <tr>
							                                    <th>content</th>
							                                    <td colspan="3">
							                                        <input type="text" class="form-control" id="addContent" maxlength="20">
							                                    </td>
							                                </tr>
							                            </tbody>
							                        </table>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="mb-3 mt-3">
						<button class="btn btn-primary mb-3" id="add-btn">등록</button>
						<button class="btn btn-primary mb-3" id="list-btn">목록</button>
					</div>
				</div>
				</div>
			</main>
			<c:import url="../common/footer.jsp"></c:import>
		</div>
	</div>
<script src="<c:url value='/js/common.js'/>" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.10/lodash.js"></script>
<script src="https://unpkg.com/layout-base/layout-base.js"></script>
<script src="https://unpkg.com/cose-base/cose-base.js"></script>
<script src="<c:url value='/js/cytoscape/cytoscape.js'/>"></script>
<script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.min.js"></script>
<script src="https://unpkg.com/tippy.js@6/dist/tippy-bundle.umd.js"></script>
<script src="<c:url value='/js/cytoscape/cytoscape-popper.js'/>"></script>
<script src="<c:url value='/js/cytoscape/cytoscape-edgehandles.js'/>"></script>
<script src="<c:url value='/js/cytoscape/cytoscape-cose-bilkent.js'/>"></script>
<%-- <script src="<c:url value='/js/cytoscape/cytoscape-tippy.js'/>"></script> --%>
<script>
	const myModal = new bootstrap.Modal(document.getElementById('myModal'), {
	  keyboard: false
	})
	
	document.addEventListener('DOMContentLoaded', function(){
		let data = {
		 	nodes: [],
		  	edges: []
		};
		window.cy_for_rank, window.pageRank, window.cy, window.eh, window.tippyEl = [];
	    
		let main = {
			"data" : {
				"id" : "Main",
				"name" : "Main",
				"content" : "Main"
			}
		};
		
		data.nodes.push(main);
		
		cy = cytoscape({
	          container: document.getElementById('cy'),
				elements : data,
				style: [
	        		{
	        		selector: 'node',
	        		elements: data.nodes,
	        		style: {
	        			'content': 'data(name)',
	        	        'text-valign': 'center',
	        	        'color': 'white',
	        	        'text-outline-width': 2,
	        	        'text-outline-color': '#888',
	        	        'background-color': '#888',
	        	        'font-size' : 7
	                }
	            	},
		            {
		              selector: 'edge',
		              elements: data.edges,
		              style: {
		                'curve-style': 'bezier',
		                'target-arrow-shape': 'triangle'
		              }
		            },
		            {
		              selector: '.eh-handle',
		              style: {
		                'background-color': 'red',
		                'width': 12,
		                'height': 12,
		                'shape': 'ellipse',
		                'overlay-opacity': 0,
		                'border-width': 12, // makes the handle easier to hit
		                'border-opacity': 0
		              }
		            },
		
		            {
		              selector: '.eh-hover',
		              style: {
		                'background-color': 'red'
		              }
		            },
		
		            {
		              selector: '.eh-source',
		              style: {
		                'border-width': 2,
		                'border-color': 'red'
		              }
		            },
		
		            {
		              selector: '.eh-target',
		              style: {
		                'border-width': 2,
		                'border-color': 'red'
		              }
		            },
		
		            {
		              selector: '.eh-preview, .eh-ghost-edge',
		              style: {
		                'background-color': 'red',
		                'line-color': 'red',
		                'target-arrow-color': 'red',
		                'source-arrow-color': 'red'
		              }
		            },
		
		            {
		              selector: '.eh-ghost-edge.eh-preview-active',
		              style: {
		                'opacity': 0
		              }
		            }
		          ]
		});
		document.querySelector('#detail').classList.remove('show', 'active');
		
		cy.nodes().forEach(node => {
		    	makeTippy(node, node.data().content);
		});
		eh = cy.edgehandles({
			snap: false
		});
		cy.userZoomingEnabled(false);
		window.cyLayout = function cyLayout(){
			let layout = cy.layout({
		        name: 'cose-bilkent',
				nodeOverlap: 20,
		        refresh: 20,
				randomize: false,
		        gravityRangeCompound: 1.5,
		        fit: true,
		        tile: true
			});
			layout.run();
		};
		
		
		cy.on('ehcomplete', (event, sourceNode, targetNode, addedEdge) => {
			let { position } = event;
			console.log(event);
			console.log(sourceNode);
			console.log(targetNode);
			console.log(addedEdge);
		});
			
		cy.on('tap', 'node', e => {
			var node = e.target;
			document.getElementById('id').value = node.id();
			myModal.show();
			document.getElementById('nodeId').value = e.target._private.data.name;
			document.getElementById('nodeContent').value = e.target._private.data.content;
		});
		
		cy.on('tap', 'edge', e => {
			console.log(e.target);
			let check = confirm("Edge를 삭제하시겠습니까?");
			if(check){
				cy.remove(e.target);
			}
		});
	});
	

	let resizeTimer;

	window.addEventListener('resize', function () {
	    this.clearTimeout(resizeTimer);
	    resizeTimer = this.setTimeout(function(){
	        cy.fit();
	    },200);
	});
	
	var makeTippy = function(ele, text){
		var ref = ele.popperRef();
		console.log(ele);
		// Since tippy constructor requires DOM element/elements, create a placeholder
		var domEle = document.querySelector('#cy');

		var tip = tippy( domEle, {
			getReferenceClientRect: ref.getBoundingClientRect,
			content: function() {
				var div = document.createElement('div');
				div.className = 'tippy';
				div.innerHTML = text;
				return div;
			},
			arrow: true,
			placement: 'bottom',
			hideOnClick: false,
			sticky: 'reference',
			interactive: true,
			trigger: 'mouseenter',
			appendTo: 'parent'	
		});
		tip.id = ele.id();
		tippyEl.push(tip);
		return tip;
	};

	document.getElementById('list-btn').addEventListener('click',(e) => {
		e.preventDefault();
		location.href = "<c:url value='/course/'/>";
	})

	document.getElementById('add-btn').addEventListener("click", (e)=> {
		e.preventDefault();
		const param = $("#form").serializeObject();
		param.node = []
		param.edge = []
	    
	    cy.nodes().forEach(e=> {
	    	let data = { "data" : e._private.data }
		  	param.node.push(data);
	    })
	    cy.edges().forEach(e=> {
	    	let data = { "data" : e._private.data }
		  	param.edge.push(data);
	    })
		$.ajax({
			url : "<c:url value='/api/course/'/>",
			method : "post",
			data : JSON.stringify(param),
			contentType : "application/json",
			success : function(result) {
				console.log(result);
				location.href = "<c:url value='/course/'/>";
			},
			error : function(result){
				$('p').empty();
				var messages = JSON.parse(result.responseText);
				
				messages.forEach(error => {
					$('#'+Object.getOwnPropertyNames(error)+'Error').append(Object.values(error));
				});
				let firstTabEl = document.querySelector('#myTab button[data-bs-target="#basic"]')
			    let firstTab = new bootstrap.Tab(firstTabEl);
			    
			    firstTab.show();
			}
		});
	})
	
	document.getElementById('modifyNode-btn').addEventListener('click', e => {
		let id = document.getElementById('id').value;
		let nodeId = document.getElementById('nodeId').value;
		let content = document.getElementById('nodeContent').value;
		let node = cy.$('#' + id);
		node.data('name', nodeId)
		.data('content', content);
		
		tippyEl.find(data => {if(data.id === id) return true})
				.popper._tippy.setContent(content);
		document.getElementById('modifyForm').reset();
		myModal.hide();
	});
    
	document.getElementById('addNode-btn').addEventListener('click', e => {
		var node = cy.add({
			group: 'nodes',
			data: {name: document.getElementById('addId').value, content : document.getElementById('addContent').value}
		});
		
		cy.add({
			group: 'edges',
			data: {target: node.id(), source: document.getElementById('id').value}
		})

      	cyLayout();
		makeTippy(node, node.data().content);
		document.getElementById('addForm').reset();
		myModal.hide();
	});

    document.getElementById('deleteNode-btn').addEventListener('click', e => {
		let id = document.getElementById('id').value;
		cy.remove(cy.$('#' + id));
		tippyEl.find(data => {if(data.id === id) return true}).destroy();
		myModal.hide();
	});
	document.querySelector('#drawOn-btn').addEventListener('click', function() {
		eh.enableDrawMode();
	});

	document.querySelector('#drawOff-btn').addEventListener('click', function() {
		eh.disableDrawMode();
	});

	document.querySelector('#sipNode-add-btn').addEventListener('click', function() {
		if(!document.getElementById('addName1').value){
			alert('Node Name을 입력해주세요.')
			return false;
		}
		let node = cy.add({
			group: 'nodes',
			data: {name: document.getElementById('addName1').value, content : document.getElementById('addContent1').value}
		});
		cyLayout();
		makeTippy(node, node.data().content);
	});

    let tabEl = document.querySelector('button[data-bs-target="#detail"]')
    tabEl.addEventListener('shown.bs.tab', function (e) {
    	e.preventDefault();
    })
    tabEl.addEventListener('hidden.bs.tab', function (e) {
    	e.preventDefault();
    })
</script>
</body>
</html>
