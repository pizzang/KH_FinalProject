<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>체육시설 예약</title>

<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
<style>
    .content{
        background-color: rgb(240, 238, 233);
		color: black;
		width: 1200px;
		margin: auto;
		margin-top: 30px;
    }
    
   	.btn-div{
		display : flex;
		flex-direction: row;
		justify-content: space-around;
	}
	
	.reserve_golf{
		text-align: center;
		font-size: 22px;
		width: 300px;
		height: 50px;
	}
	
	#golf-img{
		display : flex;
		justify-content: center;
	}
	
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	<div class="content">
	
		<div id="golf-img">
			<label><img width="790px" height="300px" src="resources/img/sports/golf.png"></label>
		</div>
	
		<br>
		
		<div class="btn-div">
			<a href="golf.sp" class="query btn btn-lg btn-secondary">실내 골프 연습장</a>
			<a href="miniGym.sp" class="btn btn-lg btn-outline-secondary">미니 GYM</a>
			<a href="sportsOptionView.sp?currentPage=1&category=ALL" class="btn btn-lg btn-outline-secondary">이용내역</a>
		</div>
		
		<br><br>
		<div align="center" style="width: 1200px; height: 80px; border: 2px solid pink; padding: 10px;">
			<label>예약 날짜 <input class="reserve_golf" id="datepicker" name="date" type="text" placeholder="날짜 선택" readonly required></label>
			<label>예약 시간 <input class="reserve_golf" id="timepicker" name="time" type="text" placeholder="시간 선택" readonly required></label>
			<label><button class="btn btn-primary" id="btn" onclick="selectGolfSeatList();">검색하기</button></label>
		</div>
		<br><br>
		
		
		<table id="golf_seat" class="table" align="center">
			<thead>
				<tr>
					<th colspan="5">
						<h1 align="center">실내 골프 연습장 좌석 안내</h1><br>
					</th>
				</tr>
			</thead>
			<tbody id="reserve_golf" style="display:none;">
   				<tr>
    				<td align="center">
    					<img src="https://cdn.golfmagazinekorea.com/news/photo/202108/2530_3998_403.jpg" alt="" width="100%" height="200">1번자리
    				</td>
    				<td align="center">
    					<img src="https://cdn.golfmagazinekorea.com/news/photo/202108/2530_3998_403.jpg" alt="" width="100%" height="200">2번자리
    				</td >
    				<td align="center">
    					<img src="https://cdn.golfmagazinekorea.com/news/photo/202108/2530_3998_403.jpg" alt="" width="100%" height="200">3번자리
    				</td>
    				<td align="center">
    					<img src="https://cdn.golfmagazinekorea.com/news/photo/202108/2530_3998_403.jpg" alt="" width="100%" height="200">4번자리
    				</td>
    				<td align="center">
    					<img src="https://cdn.golfmagazinekorea.com/news/photo/202108/2530_3998_403.jpg" alt="" width="100%" height="200">5번자리
    				</td>
   				</tr>
   				<tr id="reserve_golf_btn">
   					<td align="center" class="reserve_golf_btn">
   						<button class='btn btn-lg btn-outline-secondary' value="1" id="seat_1" onclick="addReserveGolf(this.value);">예약하기</button>
					</td>
					<td align="center" class="reserve_golf_btn">
						<button class='btn btn-lg btn-outline-secondary' value="2" id="seat_2" onclick="addReserveGolf(this.value);">예약하기</button>
					</td>
					<td align="center" class="reserve_golf_btn">
						<button class='btn btn-lg btn-outline-secondary' value="3" id="seat_3" onclick="addReserveGolf(this.value);">예약하기</button>
					</td>
					<td align="center" class="reserve_golf_btn">
						<button class='btn btn-lg btn-outline-secondary' value="4" id="seat_4" onclick="addReserveGolf(this.value);">예약하기</button>
					</td>
					<td align="center" class="reserve_golf_btn">
						<button class='btn btn-lg btn-outline-secondary' value="5" id="seat_5" onclick="addReserveGolf(this.value);">예약하기</button>
					</td>
   	   			 <tr>
			</tbody>
		</table>

<br><br><br><br><br><br><br><br><br>
	</div>
	
    <script>
    		// 버튼 속성 값 줘서 좌석 예약하게 하는 쿼리
  	    	function addReserveGolf(click_value){
    			//0onsole.log(click_value);
	  			$.ajax({
	    				url : "reserveGolfSeat.sp",
	    				data : {
	    					startDay : $("#datepicker").val(),
	    					startDate : $("#timepicker").val(),
	    					seatNo : click_value,
	    					userNo : ${loginUser.userNo}
	    				},
	 					success : function(status){
	 						if(status == "success"){
	 							swal({
	 								title : "예약이 완료되었습니다.",
	 							    	icon  : "success",
	 							    	closeOnClickOutside : false
	 							}).then(function(){
	 								location.reload();
	 							});
	 						}
	 						else{
	 							swal({
	 								title : "같은 날, 같은 시간에 예약할 수 없습니다!",
	 							    	icon  : "error",
	 							    	closeOnClickOutside : false
	 							})
	 						}
	 					},
	 					error : function(){
	 						swal({
 								title : "예약실패했습니다.",
 							    	icon  : "error",
 							    	closeOnClickOutside : false
 							})
	 					}
	    			}) 
    		}
    	
    	// 날짜와 시간을 조회하는 버튼 기능(검색하기 버튼 사용했을때)
    	function selectGolfSeatList(){
    		
				if($("#datepicker").val() == "" || $("#timepicker").val() == ""){
					swal({
						title : "날짜랑, 시간을 정해주세요!",
					    	icon  : "error",
					    	closeOnClickOutside : false
					})
				}
				else{
	    			$.ajax({
	    				url : "golfSeatList.sp",
	    				data : {
	    					startDay : $("#datepicker").val(),
	    					startDate : $("#timepicker").val()
	    				},
	 					success : function(r){
							// 예약버튼들을 다 보이게 display=block으로 바꿈!
	 						var reserve_golf = document.getElementById("reserve_golf");
	 						reserve_golf.style.display='block';
	 						
	 						// 검색후 또 검색을 했을때를 위해 다시 예약하기 단어를 넣고, disabled 속성을 지워준다.
	 						for(let i = 1; i <= 5; i++){
		 						$('#seat_' + [i]).text("예약하기");
		 						$('#seat_' + [i]).attr("disabled",false);
		 						$('#seat_' + [i]).removeAttr("style")
	 						}
	 						
	   			 			// 검색하여 디비에서 받아온 데이터로 seatNo가 있으면 예약완료로 바꾸고, disabled 시킴
	   			 			for(let i in r){
	 				 			if(r[i].seatNo == 1){
									$('#seat_1').text("예약완료");
									$('#seat_1').attr("disabled","true");
									$("#seat_1").css("background-color","gray");
									$("#seat_1").css("color","white");
	 				 			}
	 				 			if(r[i].seatNo == 2){
									$('#seat_2').text("예약완료");
									$('#seat_2').attr("disabled","true");
									$("#seat_2").css("background-color","gray");
									$("#seat_2").css("color","white");
	 				 			}
	 				 			if(r[i].seatNo == 3){
									$('#seat_3').text("예약완료");
									$('#seat_3').attr("disabled","true");
									$("#seat_3").css("background-color","gray");
									$("#seat_3").css("color","white");
	 				 			}
	 				 			if(r[i].seatNo == 4){
									$('#seat_4').text("예약완료");
									$('#seat_4').attr("disabled","true");
									$("#seat_4").css("background-color","gray");
									$("#seat_4").css("color","white");
	 				 			}
	 				 			if(r[i].seatNo == 5){
									$('#seat_5').text("예약완료");
									$('#seat_5').attr("disabled","true");
									$("#seat_5").css("background-color","gray");
									$("#seat_5").css("color","white");
	 				 			}
	   			 			}
	 					},
	 					error : function(){
	 						swal({
									title : "오류입니다. 관리자에게 문의하세요",
								    	icon  : "error",
								    	closeOnClickOutside : false
								})
	 					}
	    			})
	    		}
  			}
    </script>	
	

	<script type="text/javascript">
	  $( function() {
	    $( "#datepicker" ).datepicker({
	    	  buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다.
	    	  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
	    	  changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
	    	  minDate: '-0y', // 현재날짜로부터 100년이전까지 년을 표시한다.
	    	  nextText: '다음 달', // next 아이콘의 툴팁.
	    	  prevText: '이전 달', // prev 아이콘의 툴팁.
	    	  numberOfMonths: [1,1], // 한번에 얼마나 많은 월을 표시할것인가. [2,3] 일 경우, 2(행) x 3(열) = 6개의 월을 표시한다.
	    	  stepMonths: 3, // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가. 
	    	  yearRange: 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
	    	  showButtonPanel: true, // 캘린더 하단에 버튼 패널을 표시한다. 
	    	  currentText: '오늘 날짜' , // 오늘 날짜로 이동하는 버튼 패널
	    	  closeText: '닫기',  // 닫기 버튼 패널
	    	  dateFormat: "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.
	    	  showAnim: "slide", //애니메이션을 적용한다.
	    	  showMonthAfterYear: true , // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
	    	  dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식.
	    	  monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
	    });
	  });
	
	$(function() {
	    $('#timepicker').timepicker({
		    timeFormat: 'HH:mm',
		    interval: 120,
		    minTime: '10',
		    maxTime: '18',
		    startTime: '10',
		    dynamic: false,
		    dropdown: true,
		    scrollbar: true    
	    });
	});
	</script>
	
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>



<jsp:include page="../common/footer.jsp" />
</body>
</html>