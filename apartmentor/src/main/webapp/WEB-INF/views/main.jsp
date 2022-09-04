<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>메인</title>
    <style>
        #imgSlide{
            width: 1200px;
            height: 400px;
        }
        div[id^=content]{
            width: 500px;
            height: 300px;
        }
        div[id^=contentWrap]{
            width: 1200px;
            height: 300px;
            display: flex;
            flex-direction: row;
            justify-content: center;
        }
        
        .table{
        text-align: center;
        font-size: 12px;
        }
        .a1 {
        	margin-top: 3px;
        	margin-right: 5px;
        	float: right;
        	padding: 5px;
        	font-weight: bold;
        }
        .a1 a {
            text-decoration: none;
        	color: gray; 
        }
        .a1 a:hover {
            text-decoration: none;
            color:rgb(0,88,155);
        }
        .td1{ width: 100px}
        .td2{ width: 300px}
        .td3{ width: 100px}
        .title{
        	float: left; 
        	text-align:center;
        	margin-left: 5px; 
        	margin-top: 3px;
        	font-size: 25px;
        }
        #boardTr:hover, #noticeTr:hover{
        cursor:pointer;
        background-color: #E2E2E2;
        }
        #content1, #content3{margin-right: 35px;}
        #content2, #content4{margin-left: 35px;}
        

	    .mainImg{
	        width : 1200px; 
	        height : 400px;     
	    }
	    
	    #weather0{
	    	color: gray; 
	    	padding:5px;
	    	padding-left: 67%}
	    #weather1{
	    	font-size:50px; 
	    	font-weight: bold;
	    	padding: 15px;
	    	padding-right: 27%;
	    	padding-left: 33%;
	    }
	    .weatherImg1{
	    	height: 50px;
	    	text-align: center;
	    }
	    #weather2{
	    display: flex;
	    flex-direction: row;}
	    #weather2 div{
	    	height: 100px;
	    	width: 33.33%;
	    	padding: 5px;
	    	text-align: center;
	    	font-size: 20px;
	    }
	    #weather2 img {
	    	width: 20px;
	    	height: 20px;
	    }
	    #weather2_1{
	    	float: left;
	    }
	    #weather2_2{
	    	border-left: 2px gray solid; 
	    	border-right: 2px gray solid;
		}
		#weather2_3{
			float: right;
		}
		
		#weather3{
			margin-top: 40px;
			float: right;
		}
		.visitCar{
			font-size: 16px;
		}
		
		/* Calender Css */
		/* 달력전체 */
		.sec_cal { 
		    width: 360px;
		    font-family: "NotoSansR";
		    margin-left: 25px;
		}
		
		.sec_cal .cal_nav {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    font-weight: 700;
		    font-size: 48px;
		    line-height: 78px;
		}
		
		.sec_cal .cal_nav .year-month {
		    width: 300px;
		    text-align: center;
		    line-height: 1;
		}
		
		.sec_cal .cal_nav .nav {
		    display: flex;
		    border: 1px solid #333333;
		    border-radius: 5px;
		}
		
		.sec_cal .cal_nav .go-prev,
		.sec_cal .cal_nav .go-next {
		    display: block;
		    width: 50px;
		    height: 78px;
		    font-size: 0;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		}
		
		.sec_cal .cal_nav .go-prev::before,
		.sec_cal .cal_nav .go-next::before {
		    content: "";
		    display: block;
		    width: 20px;
		    height: 20px;
		    border: 3px solid #000;
		    border-width: 3px 3px 0 0;
		    transition: border 0.1s;
		}
		
		.sec_cal .cal_nav .go-prev:hover::before,
		.sec_cal .cal_nav .go-next:hover::before {
		    border-color: #ed2a61;
		}
		
		.sec_cal .cal_nav .go-prev::before {
		    transform: rotate(-135deg);
		}
		
		.sec_cal .cal_nav .go-next::before {
		    transform: rotate(45deg);
		}
		
		.sec_cal .cal_wrap {
		    padding-top: 40px;
		    position: relative;
		    margin: 0 auto;
		}
		
		.sec_cal .cal_wrap .days {
		    display: flex;
		    margin-bottom: 20px;
		    padding-bottom: 20px;
		    border-bottom: 1px solid #ddd;
		}
		
		.sec_cal .cal_wrap::after {
		    top: 368px;
		}
		
		.sec_cal .cal_wrap .day {
		    display:flex;
		    align-items: center;
		    justify-content: center;
		    width: calc(100% / 7);
		    text-align: left;
		    color: #999;
		    font-size: 12px;
		    text-align: center;
		    border-radius:5px
		}
		
		.current.today {background: rgb(242 242 242);}
		
		.sec_cal .cal_wrap .dates {
		    display: flex;
		    flex-flow: wrap;
		    height: 290px;
		}
		
		.sec_cal .cal_wrap .day:nth-child(7n -1) {
		    color: #3c6ffa;
		}
		
		.sec_cal .cal_wrap .day:nth-child(7n) {
		    color: #ed2a61;
		}
		
		.sec_cal .cal_wrap .day.disable {
		    color: #ddd;
		}
		
		/* 일정 관련 */
		.title {
			width: 500px;
			text-align: left;
		}
		
		.done {
			background-color : #f0eee9;
			border-radius : 50%;
			line-height:35px;
			height : 35px;
			width : 35px;
			margin : 0 auto;
		}
		
		.now {
			background-color : red;
			color : white;
			border-radius : 50%;
			line-height:35px;
			height : 35px;
			width : 35px;
			margin : 0 auto;
		}
		
		.yet {
			background-color : #00589b;
			color : white;
			border-radius : 50%;
			line-height:35px;
			height : 35px;
			width : 35px;
			margin : 0 auto;
		}
		
		.scrollBar {
			height: 300px; 
			overflow: auto; 
			overflow-x:hidden; 
			margin-top: 100px;"
		}
		
		#scheduleTable td {
			text-align : center;
 			vertical-align : middle;
		}
		
		.scrollBar::-webkit-scrollbar {
		    width: 10px;  /* 스크롤바의 너비 */
		}
		
		.scrollBar::-webkit-scrollbar-thumb {
		    height: 30%; /* 스크롤바의 길이 */
		    background: #00589b; /* 스크롤바의 색상 */
		    
		    border-radius: 10px;
		}
		
		.scrollBar::-webkit-scrollbar-track {
		    background: #f0eee9;  /*스크롤바 뒷 배경 색상*/
		}
        
    </style>    
</head>
<jsp:include page="common/header.jsp"/>
<body>
    <div class="mainWrap">
        <div class="mainImg">
	        <img class="mainImg" src="./resources/img/main/aptm2.jpg">
    	</div>

        <hr>

        <div id="contentWrap1">
            <div id="content1">
            	<div class="title">
            	공지사항
            	</div>
            	<div class="a1">
            	<a href="list.notice">더보기 + </a>
            	</div>
	           	<table class="table">
	           		<tr>
	           			<th>카테고리</th>
	           			<th>제목</th>
	           			<th>게시일</th>
	           		</tr>
	           		<c:choose>
	           			<c:when test="${empty nList}">
	           				<tr>
	           					<td colspan="3">게시물이 존재하지 않습니다!</td>
	           				</tr>
	           			</c:when>
	           			<c:otherwise>
	           			
	           				<c:forEach var="n" items="${nList}" begin="0" end="4">
			           			<tr onclick="location.href='detail.notice?nno=' + ${n.noticeNo}" class="td" id="noticeTr">
			           				<td class="td1">${n.noticeCategoryValue}</td>
			           				<td class="td2">${n.noticeTitle}</td>
			           				<td class="td3">${n.createDate}</td>
			           			</tr>
		           			</c:forEach>
	           			</c:otherwise>
	           		</c:choose>
	           	</table>
            </div>
            <div id="content2" onload="weather()">            	
            </div>
        </div>
        <script>
        $(function(){
            weather();
         })
        function weather() {
        	let today = new Date();

        	let year = today.getFullYear();
        	let month = ('0' + (today.getMonth() + 1)).slice(-2);
        	let day = ('0' + today.getDate()).slice(-2);

        	let dateString = year +  month  + day;

        	let hours = ('0' + today.getHours()).slice(-2)-1; 

        	let timeString = hours +  "00" ;

        	$.ajax({
        		type:"get",
        		url:"https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=Cxg6AeR%2BimSFoU9%2BWZ6JAPNCCMlkuC5%2FLqSiaCg7a5w7ra6MXu%2B2sg6ijMvlcGoNTbQLkKTlMvW7LmzJ41GJIA%3D%3D&pageNo=1&numOfRows=10"
        			+"&dataType=json"
        			+"&nx=55&ny=127"
        			+"&base_date=" + dateString 
        			+"&base_time=" + timeString,
        		data :{},
        		success:function(data){
        			/* console.log(data); */
        			const itemArr = data.response.body.items.item;
        			let date1 = itemArr[1].baseDate;
        			let date2 = date1.substr(4, 2);
        			let date3 = date1.substr(6, 2);
        			
        			let REH = itemArr[1].obsrValue;
        			let RN1 = itemArr[2].obsrValue;
        			let T1H = itemArr[3].obsrValue;
        			let WSD = itemArr[7].obsrValue;
					let value = "";
        			value += '<div id="weather0" class="a1">'
        					  	+ date2 + "월" + date3 + "일 " + hours + ":00 기준 "
        				   + '</div>'
           				   + '<div id="weather1">'
           				   		+ T1H + "℃" + '<img class="weatherImg1" src="./resources/img/main/high_Temperature.png">'
           				   + '</div>'
           				   + '<div id="weather2">'
	           				   + '<div id="weather2_1">'
		           			  		+ '<img src="./resources/img/main/humidity.png">' + '습도'
		           			   + '<br><br>'
		           			   		+ REH + "%"
	           				   + '</div>'
	           				   + '<div id="weather2_2">'
	           				   		+ '<img src="./resources/img/main/wind.png">' + '풍속'
	           				   + '<br><br>'
	           				   		+ WSD + "m/s"
	           			       + '</div>'
	           			       + '<div id="weather2_3">'
	           				   		+ '<img src="./resources/img/main/raindrops.png">' + '1시간 강수량'
	           				   + '<br><br>'
	           				   		+ RN1 + "mm"
	           				   + '</div>'
           			       + '</div>'
           			       + '<div id="weather3" class="a1">'
           				   		+ '<a href="https://www.weather.go.kr/w/index.do" target="_blank">기상청 바로가기</a>'
           				   + '</div>';
           				$('#content2').html(value);
        		},
				error:{}	        			
        	})
		}
        </script>
        <br>
        <div id="contentWrap2">
            <div id="content3">
	        	<div class="title">
	            	자유 게시판
	           	</div>
	           	<div class="a1">
            		<a href="list.bo">더보기 + </a>
            	</div>
	           	<table class="table">
	           		<tr>
	           			<th>카테고리</th>
	           			<th>제목</th>
	           			<th>게시일</th>
	           		</tr>
	           		<c:choose>
	           			<c:when test="${empty bList}">
	           				<tr>
	           					<td colspan="3">게시물이 존재하지 않습니다!</td>
	           				</tr>
	           			</c:when>
	           			<c:otherwise>
	           				<c:forEach var="b" items="${bList}" begin="0" end="4">
			           			<tr onclick="location.href='detail.bo?bno=${b.boardNo}'" class="td" id="boardTr">
			           				<td class="td1">${b.boardCategory}</td>
			           				<td class="td2">${b.boardTitle}</td>
			           				<td class="td3">${fn:substring(b.createDate,0,10)}</td>
			           			</tr>
		           			</c:forEach>
	           			</c:otherwise>
	           		</c:choose>
	           	</table>
            </div>
            <div id="content4">
                
                <form action="visit.car" method="post">
                    <input type="hidden" name="userNo" value="${loginUser.userNo}">
					<div class="title">
						방문차량 등록
					</div>
					<div class="a1">
						<a href="regoCar.rg" class="remainCoupon"></a>
						</div>
                    <table class="table visitCar" >
                        <tr>
                            <td>방문일</td>
                            <td><input type="date" id="visitCarDate" name="visitCarDate" min=""><br></td>
                        </tr>
                        <tr>
                            <td>차량번호</td>
                            <td><input type="text" name="carNo" placeholder="ex)12가5678"></td>
                        </tr>
                        <tr>
                            <td>방문 목적</td>
                            <td><input type="text" name="purpose" placeholder="ex)친척 방문"></td>
                        </tr>
                        <tr>
                            <td>비상 연락처</td>
                            <td><input type="text" name="visitCarPhone" placeholder="ex)010-1234-5678"></td>
                        </tr>
                    </table>
					<div style="margin-left:150px;">
						<button class="btn submit" id="submitVisitCar" type="submit">방문 예약 등록</button>
					</div>
                    <script>
                    $('#visitCarDate').click(function(){
                        var date = new Date();
                        var year = date.getFullYear();
                        var month = ("0" + (1 + date.getMonth())).slice(-2);
                        var day = ("0" + date.getDate()).slice(-2);

                        var today =  year + '-' + month  + '-' + day;
                        $('#visitCarDate').attr('min', today);
                    })  // 방문일 선택시 오늘날짜를 기준으로 이전날짜는 선택불가

					$(function(){
						var couponRemain = 10 - '${couponUsage}';
						$('.remainCoupon').html("이번달 남은 주차쿠폰 : " + couponRemain);
						if(couponRemain == 0){
							$('#submitVisitCar').attr("disabled", true);
						}
					})
                    </script>

                </form>
            </div>
        </div>
		<br>
		
		<!-- 유리 -->
		  
	 	<div id="contentWrap" style="height: 500px; margin-top: 20px;">
	 	    <div id="content5" style="height: 500px">
					<div class="sec_cal">
					  <div class="cal_nav">
					    <a href="javascript:;" class="nav-btn go-prev">prev</a>
					    <div class="year-month"></div>
					    <a href="javascript:;" class="nav-btn go-next">next</a>
					  </div>
					  <div class="cal_wrap">
					    <div class="days">
					      <div class="day">MON</div>
					      <div class="day">TUE</div>
					      <div class="day">WED</div>
					      <div class="day">THU</div>
					      <div class="day">FRI</div>
					      <div class="day">SAT</div>
					      <div class="day">SUN</div>
					    </div>
					    <div class="dates"></div>
					  </div>
					</div>
			</div>	
	

			<script>
			$(document).ready(function() {
			    calendarInit();
			});
			/*
			    달력 렌더링 할 때 필요한 정보 목록 
	
			    현재 월(초기값 : 현재 시간)
			    금월 마지막일 날짜와 요일
			    전월 마지막일 날짜와 요일
			*/
	
			function calendarInit() {
	
			    // 날짜 정보 가져오기
			    var date = new Date(); // 현재 날짜(로컬 기준) 가져오기
			    var utc = date.getTime() + (date.getTimezoneOffset() * 60 * 1000); // uct 표준시 도출
			    var kstGap = 9 * 60 * 60 * 1000; // 한국 kst 기준시간 더하기
			    var today = new Date(utc + kstGap); // 한국 시간으로 date 객체 만들기(오늘)
			  
			    var thisMonth = new Date(today.getFullYear(), today.getMonth(), today.getDate());
			    // 달력에서 표기하는 날짜 객체
			  
			    
			    var currentYear = thisMonth.getFullYear(); // 달력에서 표기하는 연
			    var currentMonth = thisMonth.getMonth(); // 달력에서 표기하는 월
			    var currentDate = thisMonth.getDate(); // 달력에서 표기하는 일
	
			    // kst 기준 현재시간
			    // console.log(thisMonth);
	
			    // 캘린더 렌더링
			    renderCalender(thisMonth);
	
			    function renderCalender(thisMonth) {
	
			        // 렌더링을 위한 데이터 정리
			        currentYear = thisMonth.getFullYear();
			        currentMonth = thisMonth.getMonth();
			        currentDate = thisMonth.getDate();
	
			        // 이전 달의 마지막 날 날짜와 요일 구하기
			        var startDay = new Date(currentYear, currentMonth, 0);
			        var prevDate = startDay.getDate();
			        var prevDay = startDay.getDay();
	
			        // 이번 달의 마지막날 날짜와 요일 구하기
			        var endDay = new Date(currentYear, currentMonth + 1, 0);
			        var nextDate = endDay.getDate();
			        var nextDay = endDay.getDay();
	
			        // console.log(prevDate, prevDay, nextDate, nextDay);
	
			        // 현재 월 표기
			        $('.year-month').text(currentYear + '.' + (currentMonth + 1));
	
			        // 렌더링 html 요소 생성
			        calendar = document.querySelector('.dates')
			        calendar.innerHTML = '';
			        
			        // 지난달
			        for (var i = prevDate - prevDay + 1; i <= prevDate; i++) {
			            calendar.innerHTML = calendar.innerHTML + '<div class="day prev disable">' + i + '</div>'
			        }
			        // 이번달
			        for (var i = 1; i <= nextDate; i++) {
			            calendar.innerHTML = calendar.innerHTML + '<div class="day current">' + i + '</div>'
			        }
			        // 다음달
			        for (var i = 1; i <= (7 - nextDay == 7 ? 0 : 7 - nextDay); i++) {
			            calendar.innerHTML = calendar.innerHTML + '<div class="day next disable">' + i + '</div>'
			        }
	
			        // 오늘 날짜 표기
			        if (today.getMonth() == currentMonth) {
			            todayDate = today.getDate();
			            var currentMonthDate = document.querySelectorAll('.dates .current');
			            currentMonthDate[todayDate -1].classList.add('today');
			        }
			       
			    }
	
			    // 이전달로 이동
			    $('.go-prev').on('click', function() {
			        thisMonth = new Date(currentYear, currentMonth - 1, 1);
			        renderCalender(thisMonth);
			    });
	
			    // 다음달로 이동
			    $('.go-next').on('click', function() {
			        thisMonth = new Date(currentYear, currentMonth + 1, 1);
			        renderCalender(thisMonth); 
			    });
			}
			
			
			</script>
        
            <div id="content6" class="scrollBar">
				<div class="title">
					${loginUser.aptNo}의 이번 달 일정 안내
				</div>
				
				<table id="scheduleTable" class="table">
					<tbody class="schedule">
					
					<c:forEach var="vL" items="${visitList}">
						<form class="visitStatus" action="" method="post">
						<input type="hidden" name="email" value="${loginUser.email}">
						<input type="hidden" name="vno" value="${vL.visitNo}">
							<tr class="tr" style="cursor: pointer;" data-toggle="modal" data-target="#myModal"
									 data-id="${loginUser.aptNo}님의 ${vL.visitDate} ${vL.visitTime}에  ${vL.visitValue} 일정이 있습니다.">
								<th>
									<div name="status">
										${fn:substring(vL.visitDate, 8, 10)}
									</div>
								</th>
								<td>
									${vL.visitTime}
								</td>
								<td>
									${vL.visitValue}
								</td>
							</tr>
						</form>
					</c:forEach>
					
					<c:forEach var="rL" items="${reserveList}">
						<c:choose>
							<c:when test="${rL.facilityValue ne '독서실'}">
								<tr>
									<th>
										<div name="status">
											${fn:substring(rL.startDay, 8, 10)}
										</div>
									</th>
									<td>
										${rL.startDate}
										<c:if test="${not empty rL.endDate}">
										~ ${rL.endDate}
										</c:if>
									</td>
									<td>
										${rL.facilityValue}
									</td>
								</tr>
							</c:when>
							<c:when test="${rL.facilityValue eq '독서실'}" >
							<tr>
									<th>
										<div name="status">
											${fn:substring(rL.startDay, 6, 8)}
										</div>
									</th>
									<td>
										${rL.startDate}
										<c:if test="${not empty rL.endDate}">
										~ ${rL.endDate}
										</c:if>
									</td>
									<td>
										${rL.facilityValue}
									</td>
								</tr>
							</c:when>
						</c:choose>
					</c:forEach>
					
					<c:forEach var="nL" items="${noticeList}">
						<c:if test="${nL.noticeStartDate ne null}">
							<tr style="cursor: pointer;" onclick="location.href='detail.notice?nno=${nL.noticeNo}'">
								<th>
									<div name="status">
										${fn:substring(nL.noticeEndDate, 8, 10)}
									</div>
								</th>
								<td>
									${fn:substring(nL.noticeStartDate, 0, 10)} ~ ${fn:substring(nL.noticeEndDate, 0, 10)}
								</td>
								<td>
									${nL.noticeCalender}
								</td>
							</tr>
						</c:if>
					</c:forEach>
					
					</tbody>
				</table>
                
            </div>
    	</div>
    	
    	<script>
    		$(".tr").click(function(){
    			var data = $(this).data('id');
    			$('#modalContent').html(data);
    		});
    	</script>
    	
    	<script>
    	
    	date = Number(new Date().getDate());

		
		  $(function(){
			    var rows = document.getElementById("scheduleTable").getElementsByTagName("tr");
				
			    // tr만큼 루프돌면서 컬럼값 접근
			    for( var r=0; r < rows.length; r++ ){
			    	if($('div[name=status]').eq(r).text() < date) {
						$('div[name=status]').eq(r).addClass('done');
			    	}
			    };
			    	
			    for( var r=0; r < rows.length; r++ ){	
			    	if($('div[name=status]').eq(r).text() == date) {
						$('div[name=status]').eq(r).addClass('now');
					}
			    };
			    	
			    for( var r=0; r < rows.length; r++ ){	
			    	if($('div[name=status]').eq(r).text() > date) {
						$('div[name=status]').eq(r).addClass('yet');
			    	}
			    };
			 
			 
			  });
    		
    	</script>
    	
    	<!-- 모달 -->
    	<!-- The Modal -->
		  <div class="modal" id="myModal">
		    <div class="modal-dialog">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h4 class="modal-title">방문 예약</h4>
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        
		        <!-- Modal body -->
		        <div class="modal-body">
		          <p id="modalContent"></p>
		          <p>취소 신청의 경우, 관리자 승인 시 메일로 알려드립니다</p>
		        </div>
		        
		        <!-- Modal footer -->
		        <div class="modal-footer">
		          <button type="button" class="btn btn-info" data-dismiss="modal">닫기</button>
		          <button type="button" class="btn btn-danger" data-dismiss="modal" id="cancelBtn">취소 신청</button>
		        </div>
		        
		      </div>
		    </div>
		  </div>
		  
		  <script>
		  $(function(){

				$('#cancelBtn').click(function(){
					const form = $('.visitStatus');
					form.attr('action', 'cancelStatus.visit');
					form.submit();
				})
				
		  })
		  </script>
    	
        <!-- 끝 -->
    
    
    

</body>
<jsp:include page="common/footer.jsp"/>
</html>