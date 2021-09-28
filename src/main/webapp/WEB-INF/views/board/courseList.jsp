<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">

<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.js"></script>

<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/v3.3.0/tui-pagination.css" />
<script type="text/javascript" src="https://uicdn.toast.com/tui.pagination/v3.3.0/tui-pagination.js"></script>

<script src="https://uicdn.toast.com/grid/v4.17.0/tui-grid.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/grid/v4.17.0/tui-grid.css" />
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

		el.addEventListener('focusout', e => {
			var gridData = grid.getRow(props.rowKey);
			gridData.col4 = e.target.value;
			grid.dataManager.push('UPDATE', gridData);
		})
		
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
	
	class YnEditor {
	    constructor(props) {
	    var gridData = grid.getRow(props.rowKey);
	    var el = document.createElement('select');
	    var options = ["Y", "N"];
	    options.forEach(val => {
			var option = document.createElement("option");
	    	option.text = val;
	    	option.value = val;
		    if(gridData.type==val) {
		    	option.selected = 1;
		    }  
		    el.add(option, null);
	    })
	    
		el.addEventListener('focusout', e => {
			var gridData = grid.getRow(props.rowKey);
			gridData.type = e.target.value;
			grid.dataManager.push('UPDATE', gridData);
		})
		
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
	
	class Col1SelectEditor {
	    constructor(props) {
	    var gridData = grid.getRow(props.rowKey);
	    var el = document.createElement('select');
	    var options = ["기본역량", "전문역량", "기본소양", "역량/전문"];
	    options.forEach(val => {
			var option = document.createElement("option");
	    	option.text = val;
	    	option.value = val;
		    if(gridData.col1==val) {
		    	option.selected = 1;
		    }  
		    el.add(option, null);
	    })
	    
		el.addEventListener('focusout', e => {
			var gridData = grid.getRow(props.rowKey);
			gridData.col1 = e.target.value;
			grid.dataManager.push('UPDATE', gridData);
		})
		
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
	
	class Col2SelectEditor {
	    constructor(props) {
	    var gridData = grid.getRow(props.rowKey);
	    var el = document.createElement('select');
	    var options = ["일반과목", "선택과목", "분반", "분임활동"];
	    options.forEach(val => {
			var option = document.createElement("option");
	    	option.text = val;
	    	option.value = val;
		    if(gridData.col2==val) {
		    	option.selected = 1;
		    }  
		    el.add(option, null);
	    })
	    
		el.addEventListener('focusout', e => {
			var gridData = grid.getRow(props.rowKey);
			gridData.col2 = e.target.value;
			grid.dataManager.push('UPDATE', gridData);
		})
		
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
	
	class Col3SelectEditor {
	    constructor(props) {
	    var gridData = grid.getRow(props.rowKey);
	    var el = document.createElement('select');
	    var options = ["집합교육", "원격교육"];
	    options.forEach(val => {
			var option = document.createElement("option");
	    	option.text = val;
	    	option.value = val;
		    if(gridData.col3==val) {
		    	option.selected = 1;
		    }  
		    el.add(option, null);
	    })
	    
		el.addEventListener('focusout', e => {
			var gridData = grid.getRow(props.rowKey);
			gridData.col3 = e.target.value;
			grid.dataManager.push('UPDATE', gridData);
		})
		
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
        hiddenInput.type = 'checkbox';

        label.appendChild(hiddenInput);

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
			
			
		});

		var label = addLecturer(lecturer);
		
		function addLecturer(lecturer){
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
			return label;
		}
		
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
        rowHeaders: ['checkbox'
          /* {
            type: 'checkbox',
            header: `
            <label for="all-checkbox" class="checkbox">
              <input type="checkbox" id="all-checkbox" class="hidden-input" name="_checked" />
            </label>
          `,
            renderer: {
              type: CheckboxRenderer
            }
          } */
        ],
        pageOptions: {
            perPage: 5
		},
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
            	type: YnEditor
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
            	type: Col1SelectEditor
            }
          },
          {
            header: '운영형태',
            name: 'col2',
            width: '100',
            editor: {
            	type: Col2SelectEditor
            }
          },
          {
            header: '교육방법',
            name: 'col3',
            width: '100',
            editor: {
            	type: Col3SelectEditor
            }
          },
          {
            header: '시수',
            name: 'col4',
            width: '50',
            editor: {
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
    
    document.getElementById('regist-btn').addEventListener('click', () => {
		grid.getCheckedRowKeys().forEach(rowKey => {
			var rowData = grid.getRow(rowKey);
			grid.appendRow(rowData);
			//grid.request('createData');
			/* $.ajax({
				url : '/api/course/post',
				method : 'post',
				data : JSON.stringify(rowData),
				contentType : "application/json",
				success : function(result){
					alert('저장완료');
				}
			}) */
		});
	})
	
	document.getElementById('modify-btn').addEventListener('click', () => {
		
		var rows = grid.getModifiedRows();
		$.ajax({
			url : '/api/course/put',
			method : 'put',
			data : JSON.stringify(rows.updatedRows),
			contentType : "application/json",
			success : function(result){
				console.log(result);
				alert('저장 완료');
			}
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
	
</script>
</body>
</html>