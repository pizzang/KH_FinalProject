<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방문 예약</title>
<style>
.visitContent {
	width: 1200px;
	margin: auto;
}

h1 {
	text-align: left;
	margin-left: 80px;
}

.visitEnrollContent {
	background-color: #f0eee9;
}

#visitEnrollForm {
	margin-left: 100px;
}

#visitEnrollForm th {
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

	<div class="visitContent">

		<h1>방문 예약하기</h1>

		<div style="margin-left: 80px;">
			예약 승인 시, 이메일로 일정을 보내 드립니다.<br> 예약은 09:00부터 18:00까지, 10분 단위로만 예약
			가능합니다. <br> 시간 확인을 통해 가능한 시간대인지 꼭 확인해주세요.
		</div>

		<br> <br>

		<div class="visitEnrollContent">

			<br> <br>

			<form id="visitEnrollForm" method="post" action="insert.visit">
				<input type="hidden" name="userNo" value="${ loginUser.userNo }">
				<input type="hidden" name="email" value="${ loginUser.email }">
				<table>
					<tr style="height: 60px">
						<th>예약 종류</th>
						<td>&nbsp;&nbsp;</td>
						<td>
							<select name="visitCategory" id="category"
								style="width: 70px; height: 30px; text-align: center; font-weight: bolder;">
									<c:forEach var="c" items="${visitCategory}">
										<option value="${c.visitCategory}">${c.visitValue}</option>
									</c:forEach>
							</select>
						</td>
					</tr>
					<tr style="height: 40px">
						<th>예약 날짜</th>
						<td>&nbsp;&nbsp;</td>
						<td><input type="text" id="datepicker" name="visitDate" required readonly /></td>
						<td>
							<button type="button" class="btn btn-outline-info"
								data-toggle="modal" data-target="#myModal" style="width: 100px;">예약 현황</button>
						</td>
					</tr>
					<tr style="height: 60px">
						<th>예약 시간</th>
						<td>&nbsp;&nbsp;</td>
						<td style="width: 220px"><input type="text" id="timepicker" name="visitTime" required readonly/></td>
						<td>
							<button type="button" class="btn btn-info" style="width: 100px;" onclick="check()">
								시간 확인
							</button>
						</td>
					</tr>
					<tr>
						<th>참고 사항</th>
						<td>&nbsp;&nbsp;</td>
						<td colspan="6"><textarea name="visitContent" a wrap="hard" rows="20" 
								cols="80" style="resize: none;" placeholder="참고사항을 입력해주세요"></textarea>
						</td>
					</tr>
				</table>

				<div style="margin-left: 300px; margin-top: 20px;">
							<button type="button" class="btn btn-outline-info" id="backBtn" onclick="location.href='main.do'">돌아가기</button>
							<button type="submit" class="btn btn-info" id="submitBtn" disabled>등록</button>
							<button type="reset" class="btn btn-outline-info" id="resetBtn">초기화</button>
				</div>

			</form>

			<script>
				// 모달 관련
				$(".btn btn-outline-info").click(function(){
					var data = $(this).data('id');
				    $("#contents.body-contents").val(data);
				    $("#text-contents.body-contents").html(data);
				});
				

				
				
				
				// datepicker 관련
				$(function(){
			        $('#datepicker').datepicker({
			        	showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
			        	buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif", //버튼 이미지 경로
			        	buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다.
			        	changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
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
			        	monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'], // 월의 한글 형식.
			     	});
				})
				
				
				$(function() {
					$('#timepicker').timepicker({
					    timeFormat: 'HH:mm', // 시간 형식
					    interval: 10, // 몇 분 단위
					    minTime: '9', // 시작 시간
					    maxTime: '6:00pm', // 끝나는 시간
					    startTime: '9:00', // 시작 시간
					    dynamic: true, // 선택 한 뒤 항목 정렬 
					    dropdown: true, // 밑으로 보여지게
					    scrollbar: true // 스크롤바
					});
					
				
				})
				
			</script>


			<!-- The Modal -->
			<div class="modal" id="myModal">
				<div class="modal-dialog">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">예약 현황</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body">


						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" class="btn btn-outline-info"
								data-dismiss="modal">닫기</button>
						</div>

					</div>
				</div>
			</div>

			<br><br>

		<script>
			$(function(){
				// 예약된 날짜와 시간 호출
				selectVisitReserve()
			})
			
			
			function selectVisitReserve(){
				$.ajax({
					url : 'select.visit',
					data : {userNo : ${loginUser.userNo}},
					success : function(reserve){
							let list = '';
							
							list += '<p style="font-weight:bolder; font-size:18px; margin-top:5px; margin-bottom:5px; color:#00589b">가스 예약 현황</p>';
							for(let i in reserve) {
								if(reserve[i].visitCategory == 1 && reserve[i].visitDate != null) {
									list += reserve[i].visitDate + '&nbsp;' + reserve[i].visitTime + '<br>';
								} 
							}
							
							list += '<p style="font-weight:bolder; font-size:18px; margin-top:5px; margin-bottom:5px; color:#00589b">난방 예약 현황</p>';
							for(let i in reserve) {
								if(reserve[i].visitCategory == 2 && reserve[i].visitDate != null) {
									list += reserve[i].visitDate + '&nbsp;' + reserve[i].visitTime + '<br>';
								}
							}
		
							list += '<p style="font-weight:bolder; font-size:18px; margin-top:5px; margin-bottom:5px; color:#00589b">소독 예약 현황</p>';
							for(let i in reserve) {
								if(reserve[i].visitCategory == 3 && reserve[i].visitDate != null) {
									list += reserve[i].visitDate + '&nbsp;' + reserve[i].visitTime + '<br>';
								} 
							}
							
							list += '<p style="font-weight:bolder; font-size:18px; margin-top:5px; margin-bottom:5px; color:#00589b">수도 예약 현황</p>';
							for(let i in reserve) {
								if(reserve[i].visitCategory == 4 && reserve[i].visitDate != null) {
									list += reserve[i].visitDate + '&nbsp;' + reserve[i].visitTime + '<br>';
								}
							}
							
							list += '<p style="font-weight:bolder; font-size:18px; margin-top:5px; margin-bottom:5px; color:#00589b">전기 예약 현황</p>';
							for(let i in reserve) {
								if(reserve[i].visitCategory == 5 && reserve[i].visitDate != null) {
									list += reserve[i].visitDate + '&nbsp;' + reserve[i].visitTime + '<br>';
								}
							}
							
							$('.modal-body').html(list);
					},
					error : function(){
						console.log('예약 시간 조회 실패');
					}
				});
			}
			
			
			
			
			function check(){
				
				if($("#datepicker").val() == "" || $("#timepicker").val() == ""){
					swal({
						title : "날짜와 시간 모두 정해주셔야 합니다!",
					    	icon  : "error",
					    	closeOnClickOutside : false
					})
				}
				else{
	               
					$.ajax({
						url : 'check.visit',
						data : {
								userNo : ${loginUser.userNo},
								visitDate : $("#datepicker").val(),
							    visitTime : $("#timepicker").val(),
								visitCategory : $("#category").val()
								},
						success : function(result){
								if(result != null) {
									$("#submitBtn").attr("disabled", true);
									swal({
		 									title : "예약이 이미 찼습니다.",
		 							    	icon  : "error",
		 							    	closeOnClickOutside : false
		 							})
								} else {
									
									$("#submitBtn").attr("disabled", false);
									swal({
	 									title : "예약이 가능합니다.",
	 							    	icon  : "success",
	 							    	closeOnClickOutside : false
	 							})
								}
						},
						error : function(){
							console.log("예약 가능 조회 실패");
						}
					});	
				}
				
			}
			
				
			
		</script>


		</div>

		<br><br>

	</div>

	<br>
	<br>

	<jsp:include page="../common/footer.jsp" />



</body>
</html>