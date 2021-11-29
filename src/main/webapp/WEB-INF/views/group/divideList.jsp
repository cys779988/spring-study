<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<!--IE 호환성-->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!--viewport-->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1, maximum-scal=1, user-scalable=no">
</head>
<body class="sb-nav-fixed">
	<c:import url="../common/header.jsp"></c:import>
	<div id="layoutSidenav">
	<c:import url="../common/nav.jsp"></c:import>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
				    <form action="">
					</form>
					<div id="tabs" class="tabs tabs02">
						<!-- tab-->
						<ul class="clearfix">
							<li class="ui-state-active"><a href="#1" id="menu01">분반설정</a></li>
        					<li><a href="#2" id="menu02">분임설정</a></li>
						</ul>
						<div id="viewPage">
						</div> 
					</div>
				</div>
				<!-- footer -->
			</main>
			<c:import url="../common/footer.jsp"></c:import>
		</div>
	</div>
<script>

window.addEventListener('DOMContentLoaded', e => {
	viewPageLoad();
});

document.getElementById('search_btn').addEventListener('click', e => {
	
	window.open('', "popup", "resizable=yes,toolbar=yes,menubar=yes,location=yes");
	document.forms.searchForm.submit();
	
})

class TextEditor{
	constructor(props){
		this.el = createEle_text(props);
	}
	getElement(){
		return this.el;
	}
 	getValue(){
		return this.el.value;
	}
	mounted(){
		this.el.select();
	}
}

class ButtonRenderer {
    constructor(props) {
    	let name = props.columnInfo.__storage__.header == '전임강사' ? '테스트버튼2' : '12345'; 
    	let func = function(props){
    		window.open('', "popup", "resizable=yes,toolbar=yes,menubar=yes,location=yes");
    	}
		this.el = createEle_textbtn(props, name, func);
    }
    getElement() {
      return this.el;
    }
}

class NumRenderer {
    constructor(props) {
		this.el = createEle_num(props);
    }
    getElement() {
      return this.el;
    }
}

const column = [
    {
      header: '번호',
      name: 'num',
      renderer : {
	        type : NumRenderer
	  }
    },
    {
      header: '이름',
      name: 'name'
    },
    {
      header: 'email',
      name: 'email'
    }
];

function updateText(target, data){
	target.empty();
	target.append(data);
}

function viewPageLoad(){
	let menu = document.getElementById('menu').value;
	if(menu==1){
		$("#viewPage").load("selectDivClassView.do");
	} else{
		$("#viewPage").load("selectDivTaskView.do");
	}
}


$('#menu01').click(function () {
	$('#menu01, #menu02').parent().removeClass('ui-state-active');
	$('#menu01').parent().addClass('ui-state-active');
	$("#viewPage").load("selectDivClassView.do");
});
$('#menu02').click(function () {
	$('#menu01, #menu02').parent().removeClass('ui-state-active');
	$('#menu02').parent().addClass('ui-state-active');
	$("#viewPage").load("selectDivTaskView.do");
});

</script>
</body>
</html>