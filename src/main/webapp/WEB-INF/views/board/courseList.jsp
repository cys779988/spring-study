<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/5.4.0/css/ui.jqgrid-bootstrap-ui.min.css" integrity="sha512-G7dtwBhVfBZwXaN5Z+AvU9LLcTp6vNXO1rpGh0zLz+ARigIay4FGAulk8OEhRKbxXXiLfuBAJczcCvFtmdL1Kg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/5.4.0/css/ui.jqgrid-bootstrap.min.css" integrity="sha512-HCcnuzTn52TrDhR4H2B16MqQzZHIxcLkbK9AILndt7Xze/1dVNZnH4NCWpzb4BrN+VjO9639gSU4BKXh+eH3jA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tui-grid/4.17.0/tui-grid.css" integrity="sha512-fmbhEy+nVsZj/tywb2BI9dTVaAeriir9yFmGpbTLETEKN7ie09PpR0dSIqv/TaQyClCizGwxVaXxOJTnXam/vg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/tui-grid/4.17.0/tui-grid.js" integrity="sha512-HNyYgSg75wwopyvmiEmIVhfu32hxZyN5rdwJ5MDZ0d0eTrSRYbt/NpYqpWPpvlapu2ylQA3ElRQ52Vq3IYzOSg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.delete-img{
	width: 15px;
}
</style>
</head>
<body>
<div class='container'>
  <div class="btn-wrapper">
        <button id="regist-btn">추가</button>
        <button id="modify-btn">저장</button>
        <button id="delete-btn">삭제</button>
      </div>
   <div id="grid"></div>
</div>
<script type="text/javascript" src="/js/common.js" ></script> 
<script>
	var lecturer = [
		{
		'id' : '123123',
		'name' : '홍길동',
		'yn' : 'y'
	},
	{
		'id' : '123456',
		'name' : '이순신',
		'yn' : 'n'
	},
	{
		'id' : '456413',
		'name' : '김유신',
		'yn' : 'y'
	}];
	
	/* var gridData = [
	    {
	        "id": 549731,
	        "div": "원격",
	        "name": "테스트 교과",
	        "type": "Y",
	        "playTime": "0분",
			"col1":"기본소양",
			"col2":"일반과목",	        
			"col3":"원격교육",
			"col4":"15",
			"col5":"",
	        "rowKey": 0,
	        "sortKey": 0,
	        "uniqueKey": "@dataKey1631523591361-0",
	        "_disabledPriority": {},
	        "rowSpanMap": {},
	        "_relationListItemMap": {}
	    },
	    {
	        "id": 549732,
	        "div": "집합",
	        "name": "테스트 교과1",
	        "type": "Y",
	        "playTime": "0분",
			"col1":"기본소양",
			"col2":"일반과목",	        
			"col3":"원격교육",
			"col4":"15",
			"col5":"",
	        "rowKey": 1,
	        "sortKey": 0,
	        "uniqueKey": "@dataKey1631523591361-0",
	        "_disabledPriority": {},
	        "rowSpanMap": {},
	        "_relationListItemMap": {}
	    }
	]; */

	class TextEditor {
	    constructor(props) {
	      const el = document.createElement('input');
	      const { maxLength } = props.columnInfo.editor.options;

	      el.type = 'text';
	      el.maxLength = maxLength;
	      el.value = String(props.value);

	      this.el = el;
	    }

	    getElement() {
	      return this.el;
	    }

	    getValue() {
	      return this.el.value;
	    }

	    mounted() {
	      this.el.select();
	    }
	}
	
    class RowNumberRenderer {
      constructor(props) {
        const el = document.createElement('span');
        el.innerHTML = props.rowKey;
        this.el = el;
      }

      getElement() {
        return this.el;
      }

      render(props) {
        this.el.innerHTML = props.rowKey;
      }
    }

    class CheckboxRenderer {
      constructor(props) {
        const { grid, rowKey } = props;

        const label = document.createElement('label');
        label.className = 'checkbox';
        label.setAttribute('for', String(rowKey));

        const hiddenInput = document.createElement('input');
        hiddenInput.className = 'hidden-input';
        hiddenInput.id = String(rowKey);

        const customInput = document.createElement('span');
        customInput.className = 'custom-input';

        label.appendChild(hiddenInput);
        label.appendChild(customInput);

        hiddenInput.type = 'checkbox';
        hiddenInput.addEventListener('change', function() {
          if (hiddenInput.checked) {
            grid.check(rowKey);
          } else {
            grid.uncheck(rowKey);
          }
        });

        this.el = label;
      }

      getElement() {
        return this.el;
      }
	
      render(props) {
        const hiddenInput = this.el.querySelector('.hidden-input');
        const checked = Boolean(props.value);

        hiddenInput.checked = checked;
      }
    }
    
    class WorkRenderer {
        constructor(props) {
		const { grid, rowKey } = props;
		const button = document.createElement('input');
		button.type = 'button';
		button.className = 'display-btn';
		button.setAttribute('for', String(rowKey));
		button.value = '추가';
		button.addEventListener('click', function() {
			popUp(grid.getRow(rowKey).id, '테스트팝업');
		});

		const label = document.createElement('label');
		label.appendChild(button);
		lecturer.forEach( (val) => {
			const span1 = document.createElement('span');
			span1.innerHTML= '[주]';
			const radiobox1 = document.createElement('input');
			radiobox1.type = 'radio';
			radiobox1.id = 'lecturer-input-y';
			radiobox1.name = rowKey + '-' + val.id;
			radiobox1.setAttribute('for', val.id);
			radiobox1.value= 'Y';
			
			const span2 = document.createElement('span');
			span2.innerHTML= '[보]';
			const radiobox2 = document.createElement('input');
			radiobox2.type = 'radio';
			radiobox2.id = 'lecturer-input-n';
			radiobox2.name = rowKey + '-' + val.id;
			radiobox2.setAttribute('for', val.id);
			radiobox2.value= 'N';
			
			val.yn === 'y' ? radiobox1.checked = 1 : radiobox2.checked = 1
			
			const img = document.createElement('img');
			img.src = '/image/delete.png';
			img.className = 'delete-img';
			img.id = 'delete-img';
			
			img.addEventListener('click', function() {
				deleteItem(grid.getRow(rowKey).id);
			});
			
			const a = document.createElement('a');
			a.href = '/api/course/get/'+val.id;
			a.text = val.name;
			
			const br = document.createElement('br');
			label.appendChild(br);
			label.appendChild(a);
			label.appendChild(img);
			label.appendChild(span1);
			label.appendChild(radiobox1);
			label.appendChild(span2);
			label.appendChild(radiobox2);
		})
		this.el = label;
        }

        getElement() {
          return this.el;
        }
	}
    
    class ButtonRenderer {
        constructor(props) {
		const { grid, rowKey } = props;
		const button = document.createElement('input');
		button.type = "button"
		button.className = 'display-btn';
		button.setAttribute('for', String(rowKey));
		button.value = '미리보기설정';
		button.addEventListener('click', function() {
			popUp(grid.getRow(rowKey).id, '테스트팝업');
		});

		const text = document.createElement('span');
		text.innerHTML = props.value;
		const label = document.createElement('label');
		label.appendChild(text);
		label.appendChild(button);
		this.el = label;
		
        this.render(props);
        }

        getElement() {
          return this.el;
        }
  	
        render(props) {
        }
	}
    
	const dataSource = {
		api: {
			readData: { url: '/api/course/get', method: 'GET' },
			createData: { url: '/api/course/post', method: 'POST' },
			modifyData: { url: '/api/course/put', method: 'PUT' }
		},
		contentType: 'application/json'
	};
	
    var grid = new tui.Grid({
        el: document.getElementById('grid'),
        data : dataSource,
        scrollX: false,
        scrollY: false,
        draggable: true,
        rowHeight: 100,
        rowHeaders: [
          {
            type: 'checkbox',
            header: `
            <label for="all-checkbox" class="checkbox">
              <input type="checkbox" id="all-checkbox" class="hidden-input" name="_checked" />
              <span class="custom-input"></span>
            </label>
          `,
            renderer: {
              type: CheckboxRenderer
            }
          }
        ],
        columns: [
          {
            header: '강좌순서',
            name: 'id',
            sortingType: 'desc',
            sortable: true,
            width: '100',
            renderer: {
            	type: RowNumberRenderer
            }
          },
          {
            header: '구분',
            name: 'courseDiv',
            sortingType: 'asc',
            sortable: true,
            width: '100'
          },
          {
            header: '교과명(교과ID/코스웨어ID/사용여부)',
            name: 'name',
            sortingType: 'asc',
            sortable: true,
            width: '250',
            renderer: {
            	type: ButtonRenderer
            }
          },
          {
            header: '신구/개편여부',
            name: 'type',
            filter: 'select',
            width: '110',
            editor: {
            	type: 'select',
            	options: {
            		listItems: [
            			{text: 'Y', value: 'Y'},
            			{text: 'N', value: 'N'},
            		]
            	}
            }
          },
          {
            header: '콘텐츠재생시간',
            name: 'playTime',
            width: '110'
          },
          {
            header: '교과편성',
            name: 'col1',
            width: '100',
            editor: {
            	type: 'select',
            	options: {
            		listItems: [
            			{text: '기본역량', value: '기본역량'},
            			{text: '전문역량', value: '전문역량'},
            			{text: '기본소양', value: '기본소양'},
            			{text: '역량/전문', value: '역량/전문'},
            		]
            	}
            }
          },
          {
            header: '운영형태',
            name: 'col2',
            width: '100',
            editor: {
            	type: 'select',
            	options: {
            		listItems: [
            			{text: '일반과목', value: '일반과목'},
            			{text: '선택과목', value: '선택과목'},
            			{text: '분반', value: '분반'},
            			{text: '분임활동', value: '분임활동'},
            		]
            	}
            }
          },
          {
            header: '교육방법',
            name: 'col3',
            width: '100',
            editor: {
            	type: 'select',
            	options: {
            		listItems: [
            			{text: '원격교육', value: '원격교육'},
            			{text: '집합교육', value: '집합교육'},
            		]
            	}
            }
          },
          {
            header: '시수',
            name: 'col4',
            width: '50',
            editor : {
            	type: TextEditor,
            	options: {
            		maxLength: 3
            	}
            }
          },
          {
            header: '강사',
            name: 'col5',
            renderer: {
            	type: WorkRenderer
            }
          }
        ]
      });

	grid.on('check', function(ev) {
		console.log('check', ev);
	});

	grid.on('uncheck', function(ev) {
		console.log('uncheck', ev);
	});
	
	document.getElementById('regist-btn').addEventListener('click', () => {
		grid.getCheckedRowKeys().forEach(rowKey => {
			var rowData = grid.getRow(rowKey);
			grid.appendRow(rowData);
			$.ajax({
				url : '/api/course/post',
				method : 'post',
				data : JSON.stringify(rowData),
				contentType : "application/json",
				success : function(result){
					alert('저장완료');
				}
			})
		});
			//grid.request('createData');
	})
	
	document.getElementById('modify-btn').addEventListener('click', () => {
		grid.getCheckedRowKeys().forEach(rowKey => {
			var rowData = grid.getRow(rowKey);
			console.log(rowData);
			$.ajax({
				url : '/api/course/put',
				method : 'put',
				data : JSON.stringify(rowData),
				contentType : "application/json",
				success : function(result){
					console.log(result);
					alert('저장 완료');
				}
			})
		})
	})
	
	document.getElementById('delete-btn').addEventListener('click', () => {
		grid.getCheckedRowKeys().forEach(rowKey => {
			var id = grid.getRow(rowKey).id;
			console.log(id);
			$.ajax({
				url : '/api/course/delete/'+ id,
				method : 'delete',
				contentType : "application/json",
				success : function(result){
					grid.removeRow(rowKey);
					alert('삭제 완료');
				}
			})
		})
	})
	
	function deleteItem(val){
		$.ajax({
			url : '',
			method : 'delete',
			data : {'param' : val},
			contentType : "application/json",
			success : function(result){
				
			}
		})
	}
</script>
</body>
</html>