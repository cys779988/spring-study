<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="menu01-1">
	<div class="mb10 mt10">
		<div class="title_circle">과정기수명 : <span id="crseInfo"></span></div>
		<div class="title_message">분배조건 설정 후 자동분배 시 자동으로 분반 설정됩니다. 단,
			자동부여 이후 분반을 변경하였다면 "저장" 버튼을 눌러주셔야합니다.</div>
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
					<c:forEach begin="0" end="2" step="1" var="i" varStatus="cnt">
						<select name="autoDivideClass" class="select w100">
							<option value="">선택</option>
							<option value="appTime">신청시간</option>
							<option value="name">이름</option>
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
				<select id="divclsNo" name="divclsNo" class="select wauto">
				</select>
				<span class="lists">배정인원<span id="assignCnt"></span></span>
			</div>
			<div id="grid2"></div>
		</div>
	</div>
</div>
<script>

	window.grid1 = createGrid_scroll('grid1', '', column1, 150);
	
	window.grid2 = createGrid_scroll('grid2', '', column1, 150);
	
	// grid1,2 정보 조회
	function getData(param) {
		$.ajax({
			url : 'selectDivClassList.do', 
			method : 'POST',
			data : param,
			contentType : 'application/json',
			success : function(result) {
				window.divClassData = JSON.parse(JSON.stringify([...result.assignment.concat(...result.unassignment)]));
				window.updatedData = new Map();
				let clsCnt = result.crseInfo.divclsCnt;
				updateText($('#crseInfo'), result.crseInfo.crseNm + ' 제' + result.crseInfo.crseGnrtn + '기 분반');
				
				// grid1 Data insert
				grid1.resetData(result.unassignment);
				updateText($('#unassignCnt'), result.unassignment.length + '명');
				updateText($('#totCnt'), divClassData.length + '명');
				
				$('#divclsNo').empty();
				for(var count = 1; count <= clsCnt; count++){                
	                var option = $("<option class='clsNo' value=" + count + ">"+count+"반</option>");
	                $('#divclsNo').append(option);
	            }
				
				
				// grid2 Data insert
				let selectCls = document.getElementsByName('divclsNo')[0].value;
				let grid2_data = [];
				result.assignment.forEach(data => {
					if(data.divclsNo == selectCls) {
						grid2_data.push(data);
					}
				})
				grid2.resetData(grid2_data);
				updateText($('#assignCnt'), grid2_data.length + '명');
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
			let divclsNo = document.getElementById('divclsNo').value*=1;
			appendData.cuiId = cuiId;
			appendData.crseId = crseId;
			appendData.crseYear = crseYear;
			appendData.crseGnrtnId = crseGnrtnId;
			appendData.divclsNo = divclsNo;
			appendData.mbrNm = mbrNm;
			appendData.mbrId = mbrId;
			appendData.ogdpInstCd = ogdpInstCd;
			appendData.workInstNm = workInstNm;
			appendData.jbgdCd = jbgdCd;
			appendData.chrgSubjNm = chrgSubjNm;
			
			divClassData.forEach(data => {
				if(data.mbrId == mbrId) {
					data.divclsNo = appendData.divclsNo;
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
			appendData.divclsNo = 0;
			appendData.mbrNm = mbrNm;
			appendData.mbrId = mbrId;
			appendData.ogdpInstCd = ogdpInstCd;
			appendData.workInstNm = workInstNm;
			appendData.jbgdCd = jbgdCd;
			appendData.chrgSubjNm = chrgSubjNm;
			
			divClassData.forEach(data => {
				if(data.mbrId == mbrId) {
					data.divclsNo = 0;
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
		let param = {};
		param.divCase = 'divclsNo';
		param.divCnd = autoDivide;
		param.gridData = this.divClassData;
		param.divMth = $('input:radio[name=divMth]:checked').val()*1;
		param.divCls = document.getElementsByClassName('clsNo').length*1;
		$.ajax({
			url : "updateAutoDivide.do",
			method : "POST",
			data : JSON.stringify(param),
			contentType : 'application/json',
			success : function(result){
				getData(getCrseData());
			}
		})
	})
	
	document.getElementById('reset-btn').addEventListener('click', e => {
		e.preventDefault();
		$.ajax({
			url : 'updateResetDivClass.do',
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
	
	document.getElementById('divclsNo').addEventListener('change', e => {
		let selectCls = e.target.value;
		let gridData = [];
		if(divClassData){
			divClassData.forEach(data => {
				if(data.divclsNo == selectCls) {
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
			url : 'updateDivClass.do',
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