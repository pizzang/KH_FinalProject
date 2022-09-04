<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미니GYM 예약</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
<style>
    .content{
        background-color: rgb(240, 238, 233);
      color: black;
      width: 1200px;
      margin: auto;
      margin-top: 30px;
      height: 100vh;
    }
    
   	.btn-div{
		display : flex;
		flex-direction: row;
		justify-content: space-around;
	}
	
	.reserve_miniGym{
		text-align: center;
		font-size: 22px;
		width: 300px;
		height: 50px;
	}

   	#miniGym-img{
		display : flex;
		justify-content: center;
	}

	.reserve-div{
		display: flex;
	}
    
    .reserve-div>div{
    	width : 600px;
    	height : 400px;
    }
    
    .reserve-div div:first-child{
    	display: flex;
   		justify-content: space-around;
    	align-items: flex-start;
    }
    
    .reserve-div__col{
    	display:flex;
    	align-items: center;
    }
    .reserve-div__outer{
    	display: flex;
    	flex-direction: column;
    }
    
    .reserve-div__time{
    	margin-top: 100px;
    	display : flex;
    	flex-direction : row;
   		flex-wrap: wrap;
    	align-itmes: center;
    	justify-content: center;
    }
    .btn2{
    	margin: 0px 10px;
    	width : 200px;
    	height : 55px;
    	margin-bottom: 10px;
    	color : red;
    }
    
    #reserve-info{
    	
  	 	position: relative;
    	top: 15px;
    }
    
    #reserve-date{
 	    position: relative;
    	top: 15px;
    }
    
    #btn{
    	position: relative;
    	top: 330px;
    }
</style>
</head>
<body>

   <jsp:include page="../common/header.jsp" />

	<div class="content">
	 
		<div id="miniGym-img">
			<label><img width="790px" height="300px" src="resources/img/sports/miniGym.png"></label>
		</div>
		 
		<br>
		   
		<div class="btn-div">
			<a href="golf.sp" class="btn btn-lg btn-outline-secondary">실내 골프 연습장</a>
			<a href="miniGym.sp" class="query btn btn-lg btn-secondary">미니 GYM</a>
			<a href="sportsOptionView.sp?currentPage=1&category=ALL" class="btn btn-lg btn-outline-secondary">이용내역</a>
		</div>
		             
		<br><br>
       
       
		<div class="reserve-div" style="width: 100%; height: 80px; padding: 10px;">
			<div class="reserve-div__col" style = "border: 1px solid black;">
				<label id="reserve-date">예약 날짜 <input class="reserve_miniGym" id="datepicker" name="date" type="text" placeholder="날짜 선택" readonly required></label>
				<label><button class="btn btn-lg btn-primary" id="btn" onclick="selectMiniGymTimeList();">검색하기</button></label>
			</div>
			<div class="reserve-div__outer" style="border: 1px solid black;">
				<div id="reserve-info"><h1>예약시간</h1></div>
				<div class="reserve-div__time" id="reserve_miniGym" style="display:none;" >
					<button class="btn2 btn-lg btn-outline-dark" id="time_1" value="08:00" onclick="addReserveMiniGym(this.value);">08:00 ~ 11:00</button>
					<button class="btn2 btn-lg btn-outline-dark" id="time_2" value="11:00" onclick="addReserveMiniGym(this.value);">11:00 ~ 14:00</button>
					<button class="btn2 btn-lg btn-outline-dark" id="time_3" value="14:00" onclick="addReserveMiniGym(this.value);">14:00 ~ 17:00</button>
					<button class="btn2 btn-lg btn-outline-dark" id="time_4" value="17:00" onclick="addReserveMiniGym(this.value);">17:00 ~ 20:00</button>
				</div>
			</div>
		</div>
      
   
   
   		<script type="text/javascript">
   			
   			// 버튼 속성 값 줘서 시간 예약하게 하는 코드
	    	function addReserveMiniGym(click_value){
			//console.log(click_value);
  			$.ajax({
    				url : "reserveMiniGym.sp",
    				data : {
    					startDay : $("#datepicker").val(),
    					startDate : click_value,
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
 								title : "하루 한타임(3시간)만 예약이 가능합니다.",
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
   		
   			// 날짜를 검색하여 시간안내 버튼들이 나오게 하는 코드
   			function selectMiniGymTimeList(){
   				
   				if($("#datepicker").val() == ""){
					swal({
						title : "날짜를 정해주세요!",
					    	icon  : "error",
					    	closeOnClickOutside : false
					})
				}
   				else {
	    			$.ajax({
	    				url : "miniGymTimeList.sp",
	    				data : {
	    					startDay : $("#datepicker").val()
	    				},
	 					success : function(r){
	 						//console.log(r);
							// 예약버튼들을 다 보이게 display=flex으로 바꿈!
	 						var reserve_miniGym = document.getElementById("reserve_miniGym");
	 						reserve_miniGym.style.display='flex';
	 						
	 						// 검색후 또 검색을 했을때를 위해 다시 text에 원래대로 넣고, disabled 속성과 스타일을 지워준다.
	 						for(let i = 1; i <= 4; i++){
		 						$('#time_' + [i]).attr("disabled",false);
		 						$('#time_' + [i]).removeAttr("style")
	 						}
	 						
	   			 			// 검색하여 디비에서 받아온 데이터로 startDate가 조건문이랑 일치하면 중간선을 긋고, disabled 시킴
	   			 			for(let i in r){
	 				 			switch(r[i].startDate){
	 				 				case "08:00" :
										$("#time_" + [1]).attr("disabled","true");
										$("#time_" + [1]).css("background-color","#cccccc");
										$("#time_" + [1]).css("color","black");
										$("#time_" + [1]).css("text-decoration","line-through");
									break;
	 				 				case "11:00" :
										$("#time_" + [2]).attr("disabled","true");
										$("#time_" + [2]).css("background-color","#cccccc");
										$("#time_" + [2]).css("color","black");
										$("#time_" + [2]).css("text-decoration","line-through");
									break;
	 				 				case "14:00" :
										$("#time_" + [3]).attr("disabled","true");
										$("#time_" + [3]).css("background-color","#cccccc");
										$("#time_" + [3]).css("color","black");
										$("#time_" + [3]).css("text-decoration","line-through");			
	 				 				break;
	 				 				case "17:00" :
										$("#time_" + [4]).attr("disabled","true");
										$("#time_" + [4]).css("background-color","#cccccc");
										$("#time_" + [4]).css("color","black");
										$("#time_" + [4]).css("text-decoration","line-through");
	 				 				break;
	 				 			}
	   			 			} 
	 					},
	 					error : function(){
	 						swal({
									title : "오류입니다. 관리자한테 문의하세요",
								    	icon  : "error",
								    	closeOnClickOutside : false
								})
	 					}
	    			})
   				}
   			}
   		</script>
   
  
		<script type="text/javascript">
		// datepicker 부트스트랩 스크립트
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
		</script>   
   
   </div>
<br><br><br>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>