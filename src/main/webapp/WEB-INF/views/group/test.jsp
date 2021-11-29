<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="menu01-2">
	<div class="mb10 mt10 ">
		<div class="title_circle">과정기수명 : <span id="crseInfo"></span></div>
		<div class="title_message">자동분배시 기존에 설정된 분임정보가 삭제됩니다. 수동으로 분임을
			변경하거나, 교수자 및 분임실 정보를 변경한 경우 저장 버튼을 클릭해야합니다.</div>
	</div>
	<table class="vertical mb16 tal">
		<caption class="hidden">표설명</caption>
		<colgroup>
			<col style="width: 11%">
			<col style="width: 39%">
			<col style="width: 11%">
			<col style="width: 39%">
		</colgroup>
		<tbody>
			<tr>
				<th>분배조건</th>
				<td colspan="3">
					<c:forEach begin="0" end="4" step="1" var="i" varStatus="cnt">
						<select name="autoDivideClass" class="select w100">
							<option value="">선택</option>
							<option value="ogdpInstCd">소속기관</option>
							<option value="workInstNm">근무기관</option>
							<!-- <option value="sexCd">성별</option>
							<option value="rsgstNo">나이</option>
							<option value="jbgdCd">직급</option>
							<option value="postNo">지역</option>
							<option value="mbrNm">이름</option>
							<option value="eduTrgetrClCd">교육생구분</option>
							<option value="tnNo">연수번호</option>
							<option value="chrgSubjNm">과목</option> -->
						</select>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<th>분배방법</th>
				<td colspan="3" class="clearfix">
					<label><input type="radio" id="divMth" name="divMth" value="1" checked>순차</label>
					<label><input type="radio" id="divMth" name="divMth" value="0">교차</label>
					<div class="flr">
						<a href="#" id="autoDivide-btn" class="btn btn_blue">자동분배</a>
					</div>
				</td>
			</tr>
		</tbody>
	</table>

	<div class="dip_bl mt30 mb20">
		<div class="tar">
			<button class="btn btn_blue" id="reset-btn">초기화</button>
			<button class="btn btn_blue" id="stdnt-regist-btn">저장</button>
		</div>
		<div class="grid_wrap_02">
			<!-- table top text -->
			<div class="dip_bl mb10 clearfix">
				<span class="lists">미배정인원 <span id="unassignCnt"></span> / 총<span id="totCnt"></span></span>
			</div>
			<div id="grid1"></div>
		</div>
		<div class="dip_inb wauto m10">
			<button class="btn btn_gray_line w80 right_arrow dip_bl mb10"
				id="assign-btn">배정</button>
			<button class="btn btn_gray_line w80 left_arrow dip_bl"
				id="unassign-btn">미배정</button>
		</div>
		<div class="grid_wrap_02">
			<div class="dip_bl mb10 clearfix">
				<select id="divtaskNo" name="divtaskNo"class="select wauto">
				</select>
				<span class="lists">배정인원<span id="assignCnt"></span></span>
			</div>
			<div id="grid2"></div>
		</div>
	</div>
	<div class="dip_bl mt30 mb20" style="margin-top: 100px;">
		<div class="mb10 clearfix">
			<div class="title_basic fll">교수자 및 분임실 설정</div>
			<div class="flr">
				<a href="#" class="btn btn_blue">저장</a>
				<a href="#" class="btn btn_blue">삭제</a>
			</div>
		</div>
		<div id="grid3"></div>
	</div>



</div>
<script>

	window.grid1 = createGrid_scroll('grid1', '', column1, 150);
	
	window.grid2 = createGrid_scroll('grid2', '', column1, 150);
	
	window.grid3 = createGrid_scroll('grid3', '', column2);

	// grid1,2,3 정보 조회
	function getData(data) {
		$.ajax({
			url : 'selectDivTaskList.do', 
			method : 'POST',
			data : data,
			contentType : 'application/json',
			success : function(result) {
				window.divTaskData = JSON.parse(JSON.stringify([...result.assignment.concat(...result.unassignment)]));
				window.updatedData = new Map();
				let taskCnt = result.crseInfo.divtaskCnt;
				updateText($('#crseInfo'), result.crseInfo.crseNm + ' 제' + result.crseInfo.crseGnrtn + '기 분임');
				
				// grid1 Data insert
				grid1.resetData(result.unassignment);
				updateText($('#unassignCnt'), result.unassignment.length + '명');
				updateText($('#totCnt'), divClassData.length + '명');
				
				$('#divtaskNo').empty();
				for(var count = 1; count <= taskCnt; count++){                
	                var option = $("<option class='taskNo' value=" + count + ">"+count+"분임</option>");
	                $('#divtaskNo').append(option);
	            }
				
				// grid2 Data insert
				let selectTask = document.getElementsByName('divtaskNo')[0].value;
				let grid2_data = [];
				result.assignment.forEach(data => {
					if(data.divtaskNo == selectTask) {
						grid2_data.push(data);
					}
				})
				grid2.resetData(grid2_data);
				updateText($('#assignCnt'), grid2_data.length + '명');
				
				// grid3 Data insert
				let grid3_data = [];
				
				for(let j = 0; j<taskCnt; j++){
					if(j<result.profsrList.length && j+1==result.profsrList[j].divtaskNo){
						grid3_data.push(result.profsrList[j]);
					} else {
						grid3_data.push({"divtaskNo" : j+1});
					}
				}
				
				grid3.resetData(grid3_data);
				
			},
			error : function(req, status, err) {
				console.log(req);
				console.log(status);
				console.log(err);
			}
		});
	}

	document.getElementById('assign-btn').addEventListener('click', e => {
		e.preventDefault();
		const checked = grid1.getCheckedRows();
		if(checked.length < 1) {
			alert('배정할 수강생을 선택해주세요.');
			return;
		}
		checked.forEach(rowData => {
			let {cuiId, crseId, crseYear, crseGnrtnId, mbrNm, mbrId, ogdpInstCd, workInstNm, jbgdCd, chrgSubjNm} = rowData;
			let appendData = {};
			let divtaskNo = document.getElementById('divtaskNo').value*=1;
			appendData.cuiId = cuiId;
			appendData.crseId = crseId;
			appendData.crseYear = crseYear;
			appendData.crseGnrtnId = crseGnrtnId;
			appendData.divtaskNo = divtaskNo;
			appendData.mbrNm = mbrNm;
			appendData.mbrId = mbrId;
			appendData.ogdpInstCd = ogdpInstCd;
			appendData.workInstNm = workInstNm;
			appendData.jbgdCd = jbgdCd;
			appendData.chrgSubjNm = chrgSubjNm;
			
			divTaskData.forEach(data => {
				if(data.mbrId == mbrId) {
					data.divtaskNo = appendData.divtaskNo;
				}
			})
			updatedData.set(appendData.mbrId,appendData);
			grid2.appendRow(appendData);
		});
		
		grid1.removeCheckedRows();
		grid2.uncheckAll();
	})
	
	document.getElementById('unassign-btn').addEventListener('click', e => {
		e.preventDefault();
		const checked = grid2.getCheckedRows();
		if(checked.length < 1) {
			alert('미배정할 수강생을 선택해주세요.');
			return;
		}
		checked.forEach(rowData => {
			let {cuiId, crseId, crseYear, crseGnrtnId, mbrNm, mbrId, ogdpInstCd, workInstNm, jbgdCd, chrgSubjNm} = rowData;
			let appendData = {};
			appendData.cuiId = cuiId;
			appendData.crseId = crseId;
			appendData.crseYear = crseYear;
			appendData.crseGnrtnId = crseGnrtnId;
			appendData.divtaskNo = 0;
			appendData.mbrNm = mbrNm;
			appendData.mbrId = mbrId;
			appendData.ogdpInstCd = ogdpInstCd;
			appendData.workInstNm = workInstNm;
			appendData.jbgdCd = jbgdCd;
			appendData.chrgSubjNm = chrgSubjNm;
			
			divTaskData.forEach(data => {
				if(data.mbrId == mbrId) {
					data.divtaskNo = 0;
				}
			})
			updatedData.set(appendData.mbrId,appendData);
			grid1.appendRow(appendData);
		});

		grid2.removeCheckedRows();
		grid1.uncheckAll();
	})
	
	document.getElementById('autoDivide-btn').addEventListener('click', e => {
		e.preventDefault();
		let autoDivide = [];
		document.getElementsByName('autoDivideClass').forEach(data => {
			if(data.value!=='') 
				autoDivide.push(data.value);
		})
		let data = {};
		data.divCase = 'divtaskNo';
		data.divCnd = autoDivide;
		data.gridData = this.divTaskData;
		data.divMth = $('input:radio[name=divMth]:checked').val()*1;
		data.divtask = document.getElementsByClassName('taskNo').length*1;
		$.ajax({
			url : "updateAutoDivide.do",
			method : "POST",
			data : JSON.stringify(data),
			contentType : 'application/json',
			success : function(result){
				getData(getCrseData());
			}
		})
	})
	
	document.getElementById('reset-btn').addEventListener('click', e => {
		e.preventDefault();
		$.ajax({
			url : 'updateResetDivTask.do',
			type : 'POST',
			data : getCrseData(),
			contentType :'application/json',
			success : function(result) {
				getData(getCrseData());
				alert('초기화가 완료되었습니다.')
			},
			error : function(request,status,error){
				console.log(request);
				console.log(status);
				console.log(error);
			}
		})
	})
	
	document.getElementById('divtaskNo').addEventListener('change', e => {
		let selectTask = e.target.value;
		let gridData = [];
		if(divTaskData){
			divTaskData.forEach(data => {
				if(data.divtaskNo == selectTask) {
					gridData.push(data);
				}
			})
			let span = document.createElement('span');
			span.append();
			updateText($('#assignCnt'), gridData.length + '명');
			grid2.resetData(gridData);
		}
	})
	
	document.getElementById('stdnt-regist-btn').addEventListener('click', e => {
		e.preventDefault();
		
		let param = [];
		updatedData.forEach(data => {
			param.push(data);
		})
		$.ajax({
			url : 'updateDivTask.do',
			type : 'POST',
			data : JSON.stringify(param),
			contentType :'application/json',
			success : function(result) {
				getData(getCrseData());
				alert('저장이 완료되었습니다.')
			},
			error : function(request,status,error){
				console.log(request);
				console.log(status);
				console.log(error);
			}
		})
	})

</script>