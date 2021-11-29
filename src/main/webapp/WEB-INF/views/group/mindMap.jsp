<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
<style>
body {
	font-family: helvetica neue, helvetica, liberation sans, arial, sans-serif;
	font-size: 14px
}

#cy {
	position: absolute;
	left: 0;
	top: 0;
	bottom: 0;
	right: 0;
	z-index: 1;
}

h1 {
	opacity: 0.5;
	font-size: 1em;
	font-weight: bold;
}

/* makes sticky faster; disable if you want animated tippies */
.tippy-popper {
	transition: none !important;
}

#buttons {
  position: absolute;
  right: 0;
  z-index: 99999;
  margin: 1em;
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
				    <div id="cy"></div>
				
				    <div id="buttons">
				      <input type="text" id="addName1" maxlength="15">
				      <input type="text" id="addContent1" maxlength="15">
				      <button class="btn btn_blue" id="add">노드추가</button>
				      <button class="btn btn_blue" id="regist">저장</button>
				      <button class="btn btn_blue" id="draw-on">그리기모드 on</button>
				      <button class="btn btn_blue" id="draw-off">그리기모드 off</button>
				    </div>
				    <div class="popup_wrap popup_02">
			            <div class="popup_title clearfix">
			                <div class="title_line fll">마인드맵</div>
			                <div class="flr">
			                    <a href="#" class="btn btn_popup_close">닫기</a>
			                </div>
			            </div>
			            <div class="popup_con w800 clearfix">
			                <!-- tab style02-->
			                <div id="tabs" class="tabs tabs02">
			                    <ul class="clearfix">
			                        <li><a href="#04-1">수정</a></li>
			                        <li><a href="#04-2">추가</a></li>
			                    </ul>
			                    <div id="04-1">
			                        <div class="clearfix mb10">
			                            <div class="title_basic fll">마인드맵</div>
			                            <a class="btn btn_blue flr" id="modify_btn" href="#">저장</a>
			                            <a class="btn btn_blue flr" id="delete_btn" href="#">삭제</a>
			                        </div>
			                        <form id="modifyForm">
			                        	<input type="hidden" id="id">
				                        <table class="vertical mb16 tal">
				                            <caption class="hidden">표설명</caption>
				                            <colgroup>
				                                <col style="width:30%">
				                                <col style="width:70%">
				                            </colgroup>
				                            <tbody>
				                                <tr>
				                                    <th>name</th>
				                                    <td colspan="3">
				                                        <!-- text -->
				                                        <input type="text" class="w200" id="nodeId">
				                                    </td>
				                                </tr>
				                                <tr>
				                                    <th>content</th>
				                                    <td colspan="3">
				                                        <!-- text -->
				                                        <input type="text" class="w200" id="content">
				                                    </td>
				                                </tr>
				                            </tbody>
				                        </table>
			                        </form>
			                    </div>
			                    <div id="04-2">
			                     <div class="clearfix mb10">
			                            <div class="title_basic fll">마인드맵</div>
			                            <a class="btn btn_blue flr" id="add_btn" href="#">저장</a>
			                            <a class="btn btn_blue flr" id="delete_btn" href="#">삭제</a>
			                        </div>
			                        <form id="addForm">
				                        <input type="hidden" id="id">
				                        <table class="vertical mb16 tal">
				                            <caption class="hidden">표설명</caption>
				                            <colgroup>
				                                <col style="width:30%">
				                                <col style="width:70%">
				                            </colgroup>
				                            <tbody>
				                                <tr>
				                                    <th>name</th>
				                                    <td colspan="3">
				                                        <!-- text -->
				                                        <input type="text" class="w200" id="addId">
				                                    </td>
				                                </tr>
				                                <tr>
				                                    <th>content</th>
				                                    <td colspan="3">
				                                        <!-- text -->
				                                        <input type="text" class="w200" id="addContent">
				                                    </td>
				                                </tr>
				                            </tbody>
				                        </table>
									</form>
								</div>
			                </div>
			
			                <div class="mt20 mb30 tac">
			                    <a href="#" class="btn btn_popup_close">닫기</a>
			                </div>
			
			            </div>
			        </div>
	    		</div>
			</main>
			<c:import url="../common/footer.jsp"></c:import>
		</div>
    </div>
<script>

	
	document.addEventListener('DOMContentLoaded', function(){
		let data = {
		 	nodes: [],
		  	edges: []
		};
		window.cy_for_rank, window.pageRank, window.cy, window.eh;
	    
		function getData() {
			
			return new Promise((resolve, reject) => {
				$.ajax({
					url: "<c:url value='/api/study/mindmap/get'/>",
					type:'GET',
					data: {"id":"12"},
					success : function(result) {
						if(!result) {
							let main = {"data" : {
								"id" : "Main",
								"name" : "Main",
								"content" : "Main"
							}};
							
							data.nodes.push(main);
						} else {
							data.nodes = JSON.parse(result.nodes);
							data.edges = JSON.parse(result.edges);
						}
						
						cy_for_rank = cytoscape({
					    	elements: data
					    });	
						//pageRank = cy_for_rank.elements().pageRank();
						resolve(data);
					},
					error : function(result){
						reject();
					}
				})
			});
		}
		
		getData().then(data => {
			const nodeMaxSize = 1000;
			const nodeMinSize = 5;
			const fontMaxSize = 8;
			const fontMinSize = 5;
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
		        	        'font-size' : 5
		                    //'label': 'data(content)',
		                    /* 'width': function (ele) {
		                        return nodeMaxSize * pageRank.rank('#' + ele.id()) + nodeMinSize;
		                    },
		                    'height': function (ele) {
		                        return nodeMaxSize * pageRank.rank('#' + ele.id()) + nodeMinSize;
		                    },
		                    'font-size': function (ele) {
		                        return fontMaxSize * pageRank.rank('#' + ele.id()) + fontMinSize;
		                    } */
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
			          ],
			          layout: {
			              name: 'cose',
			              idealEdgeLength: 100,
			              nodeOverlap: 20,
			              refresh: 20,
			              fit: true,
			              padding: 30,
			              randomize: false,
			              componentSpacing: 100,
			              nodeRepulsion: 400000,
			              edgeElasticity: 100,
			              nestingFactor: 5,
			              gravity: 80,
			              numIter: 1000,
			              initialTemp: 200,
			              coolingFactor: 0.95,
			              minTemp: 1.0
			            }
			});
			eh = cy.edgehandles({
				snap: false
			});

			document.querySelector('#draw-on').addEventListener('click', function() {
				eh.enableDrawMode();
			});

			document.querySelector('#draw-off').addEventListener('click', function() {
				eh.disableDrawMode();
			});

			/* document.querySelector('#start').addEventListener('click', function() {
				eh.start( cy.$('node:selected') );
				}); */
			document.querySelector('#add').addEventListener('click', function() {
				if(!document.getElementById('addName1').value){
					alert('Node Name을 입력해주세요.')
					return false;
				}
				let t = cy.add({
					group: 'nodes',
					data: {name: document.getElementById('addName1').value, content : document.getElementById('addContent1').value}
				});
		      	const layout = cy.layout({
		              name: 'cose',
		              idealEdgeLength: 100,
		              nodeOverlap: 20,
		              refresh: 20,
		              fit: true,
		              padding: 30,
		              randomize: false,
		              componentSpacing: 100,
		              nodeRepulsion: 400000,
		              edgeElasticity: 100,
		              nestingFactor: 5,
		              gravity: 80,
		              numIter: 1000,
		              initialTemp: 200,
		              coolingFactor: 0.95,
		              minTemp: 1.0
		            })

		      	layout.run();
				var tippy = makeTippy(t, t.data().content);
				tippy.show();
			});
		      
		    document.querySelector('#regist').addEventListener('click', function() {
			    let param = {
			    	id : "12",
			    	nodes : [],
			    	edges : []
				};
			    
			    cy.nodes().forEach(e=> {
			    	let data = { "data" : e._private.data }
				  	param.nodes.push(data);
			    })
			    cy.edges().forEach(e=> {
			    	let data = { "data" : e._private.data }
				  	param.edges.push(data);
			    })
			    console.log(param.nodes);
			    console.log(param.edges);
			    $.ajax({
			    	url : '/re/cu/sm/reg.do',
			    	type : 'POST',
			    	data : JSON.stringify(param),
			    	contentType : 'application/json',
			    	success : function(result) {
			    		location.reload();
			    	}
			    })
			});

		    cy.nodes().forEach(node => {
				var tippy = makeTippy(node, node.data().content);
				tippy.show();
			});
		    
			cy.on('ehcomplete', (event, sourceNode, targetNode, addedEdge) => {
		    	let { position } = event;
		    	console.log(event);
		    	console.log(sourceNode);
		    	console.log(targetNode);
		    	console.log(addedEdge);
		      // ...
		    });
		    	
		    cy.on('tap', 'node', e => {
		    	var node = e.target;
		    	document.getElementById('id').value = node.id();
				$('.popup_overlay').fadeIn();
				$('.popup_02').fadeIn();
				document.getElementById('nodeId').value = e.target._private.data.name;
				document.getElementById('content').value = e.target._private.data.content;
		    });
		    
		    cy.on('tap', 'edge', e => {
		    	console.log(e.target);
		    	let check = confirm("Edge를 삭제하시겠습니까?");
		    	if(check){
					cy.remove(e.target);
		    	}
		    });

		    let resizeTimer;
			window.addEventListener('resize', function () {
			    this.clearTimeout(resizeTimer);
			    resizeTimer = this.setTimeout(function(){
			        cy.fit();
			    },200);
			});
		})
	});
	var makeTippy = function(ele, text){
		var ref = ele.popperRef();

		// Since tippy constructor requires DOM element/elements, create a placeholder
		var dummyDomEle = document.createElement('div');

		var tip = tippy( dummyDomEle, {
			getReferenceClientRect: ref.getBoundingClientRect,
			trigger: 'manual', // mandatory
			// dom element inside the tippy:
			content: function(){ // function can be better for performance
				var div = document.createElement('div');

				div.innerHTML = text;

				return div;
			},
			// your own preferences:
			arrow: true,
			placement: 'bottom',
			hideOnClick: false,
			sticky: "reference",

			// if interactive:
			interactive: true,
			appendTo: document.body // or append dummyDomEle to document.body
		} );

		return tip;
	};

	// tabs
    $(".tabs").tabs({
        active: "0"
    });
    
    $(".popup_overlay, .btn_popup_close").click(function(){
        $('.popup_wrap').fadeOut();
        $('.popup_overlay').fadeOut();
    })
    
	document.getElementById('modify_btn').addEventListener('click', e => {
		let t = cy.$('#'+document.getElementById('id').value)
		t.data('name', document.getElementById('nodeId').value)
		.data('content', document.getElementById('content').value);
		
		var tippy = makeTippy(t, t.data().content);
		tippy.show();
		document.getElementById('modifyForm').reset();
		$('.popup_wrap').fadeOut();
        $('.popup_overlay').fadeOut();
	});
    
	document.getElementById('add_btn').addEventListener('click', e => {
		var t = cy.add({
			group: 'nodes',
			data: {name: document.getElementById('addId').value, content : document.getElementById('addContent').value}
		});
		
		cy.add({
			group: 'edges',
			data: {target: t.id(), source: document.getElementById('id').value}
		})
      	const layout = cy.layout({
            name: 'cose',
            idealEdgeLength: 100,
            nodeOverlap: 20,
            refresh: 20,
            fit: true,
            padding: 30,
            randomize: false,
            componentSpacing: 100,
            nodeRepulsion: 400000,
            edgeElasticity: 100,
            nestingFactor: 5,
            gravity: 80,
            numIter: 1000,
            initialTemp: 200,
            coolingFactor: 0.95,
            minTemp: 1.0
          })

      	layout.run();
		var tippy = makeTippy(t, t.data().content);
		tippy.show();
		document.getElementById('addForm').reset();
		$('.popup_wrap').fadeOut();
        $('.popup_overlay').fadeOut();
	});

    document.getElementById('delete_btn').addEventListener('click', e => {
		let id = cy.getElementById(document.getElementById('id').value);
		cy.remove(id);
		$('.popup_wrap').fadeOut();
        $('.popup_overlay').fadeOut();
	});
</script>
</body>

</html>
