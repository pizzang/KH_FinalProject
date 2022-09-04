<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>
<style>
.noticeContent {
	width: 1200px;
	margin: auto;
}

h1 {
	text-align: left;
	margin-left: 80px;
}

.noticeEnrollContent {
	background-color: #f0eee9;
}

#noticeEnrollForm {
	margin-left: 100px;
}

#noticeEnrollForm th {
	width: 100px;
	text-align: center;
}
</style>

</head>
<body>

	<jsp:include page="../common/header.jsp" />
	<!-- jQuery 라이브러리 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- datepicker 라이브러리 -->
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!-- timepicker 라이브러리 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>

	<br>
	<br>

	<div class="noticeContent">

		<h1>공지사항 작성 페이지</h1>

		<br> <br>

		<div class="noticeEnrollContent">

			<br><br>

			<form id="noticeEnrollForm" method="post" action="insert.notice" enctype="multipart/form-data">
				<input type="hidden" name="userNo" value="${ loginUser.userNo }">
				<table>
					<tr style="height: 35px">
						<th>말머리</th>
						<td>
							<select name="noticeCategory" id="category" style="width: 70px; height: 30px; text-align: center; font-weight: bolder;">
									<option value="공지">[공지]</option>
									<option value="알림">[알림]</option>
									<option value="행사">[행사]</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
							<input type="text" name="noticeTitle" placeholde="제목을 입력해주세요" required>
						</td>
					</tr>
					<tr>
						<th>일정 종류</th>
						<td>
							<input type="text" name="noticeCalender" placeholde="일정 종류를 입력해주세요">
						</td>
					</tr>
					<tr>
						<th>일정 날짜</th>
						<td style="width: 210px;"><input type="text" id="datepicker" name="noticeStartDate" /></td>
						<td style="font-weight: bolder;">&nbsp;~&nbsp;</td>
						<td><input type="text" id="datepicker2" name="noticeEndDate" /></td>
					</tr>
					 <tr>
                        <th><label for="upfile">첨부파일</label></th>
                        <td colspan="3"><input type="file" id="upfile" class="form-control-file border" name="upfile"></td>
                    </tr>
					<tr>
						<th>내용 입력</th>
						<td colspan="6"><textarea name="noticeContent" a wrap="hard" rows="20" 
								cols="80" style="resize: none;" placeholder="내용을 입력해주세요" required></textarea>
						</td>
					</tr>
				</table>
				
				<div style="margin-left: 300px; margin-top: 20px;">
					<button type="button" class="btn btn-outline-info" id="backBtn" onclick="history.back()">돌아가기</button>
					<button type="submit" class="btn btn-info" id="submitBtn">등록</button>
					<button type="reset" class="btn btn-outline-info" id="resetBtn">초기화</button>&nbsp;&nbsp;&nbsp;
				</div>

			<br><br>

			</form>

			<script>
				// datepicker 관련
				$(function(){
			        $('#datepicker').datepicker({
			        	showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
			        	buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif", //버튼 이미지 경로
			        	buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다.
			        	changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
			        	changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
			        	minDate: 0, // 이전날짜 선택불가능
			        	nextText: '다음 달', // next 아이콘의 툴팁.
			        	prevText: '이전 달', // prev 아이콘의 툴팁.
			        	showButtonPanel: true, // 캘린더 하단에 버튼 패널을 표시한다. 
			        	currentText: '오늘 날짜' , // 오늘 날짜로 이동하는 버튼 패널
			        	closeText: '닫기',  // 닫기 버튼 패널
			        	dateFormat: "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.
			        	showAnim: "slide", //애니메이션을 적용한다.
			        	showMonthAfterYear: true , // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
			        	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], // 요일의 한글 형식.
			        	monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
			     	});
				})
				
				$(function(){
			        $('#datepicker2').datepicker({
			        	showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
			        	buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif", //버튼 이미지 경로
			        	buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다.
			        	changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
			        	changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
			        	minDate: 0, // 이전날짜 선택불가능
			        	nextText: '다음 달', // next 아이콘의 툴팁.
			        	prevText: '이전 달', // prev 아이콘의 툴팁.
			        	showButtonPanel: true, // 캘린더 하단에 버튼 패널을 표시한다. 
			        	currentText: '오늘 날짜' , // 오늘 날짜로 이동하는 버튼 패널
			        	closeText: '닫기',  // 닫기 버튼 패널
			        	dateFormat: "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.
			        	showAnim: "slide", //애니메이션을 적용한다.
			        	showMonthAfterYear: true , // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
			        	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], // 요일의 한글 형식.
			        	monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
			     	});
				})
				
			</script>
	
		</div>

		<br><br>

	</div>

	<br>
	<br>

	<jsp:include page="../common/footer.jsp" />

</body>
</html>