<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>열람실 메인</title>
<!-- 제발 무사히 푸쉬 되어주길... -->
<!-- timepicker 관련 -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<!-- <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script> -->
<!-- jQuery 관련 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- sweetalter 관련 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<style>
    /* Skydiver : rgb(0,88,155)	/ Cloud Dander : rgb(240, 238, 233) */
    
    #h1 {
    	width: 1200px;
    	height: 60px;
    	text-align: center;
    	padding: 15px;
    	margin-top: 20px;
    }
    .h1Btn {
    	border: none;
    	background-color: white;
    	font-size: 50px;
    }
    .h1Btn:hover {
    	color: rgb(0,88,155);
    	font-weight: 1000;
    }
/* ---------- 좌석 선택 영역 관련 CSS ---------- */ 
    .content {
        background-color:rgb(240, 238, 233); /* Cloud Dancer */
        box-shadow: 1px 1px 5px lightgrey; /* x y blur color */
        
    	width: 1000px;
    	height: 620px;
        padding: 30px 80px 30px 80px; /* T R B L */
        margin-top: 40px; /* 여백 */
        
        margin-left: 100px;
        /* margin-left: 100px; */ /* left: 33%;로 하게되면 모달화면 띄울 때 반투명검은색 화면이 되어서 클릭이 안됨. 왜? */
    }
    
    #seatTable { /* td값 가운데 정렬 */
    	text-align: center;
    }

    .seat-area-L {
        padding-right: 140px;
        float: left;
    }
    .seat-area-R {
    	padding-top: 70px;
        padding-bottom: 70px;
        float: left;
    }
    
    .tdDiv {
    	height: 70px;
    	width: 70px;
    	border-radius: 15px;
    	background-color: rgb(240, 238, 233);
    	box-shadow: 1px 1px 5px lightgrey; /* x y blur color */
    	border: solid 1px lightgrey;
    	cursor: pointer;
    }
    
    .tdDiv:hover {
    	background: lightgrey;
    }
    
    #waiting {
    	float: right;
    	margin-top: -580px;
    }
    
    #waitingTable button {
    	height: 50px;
    	width: 50px;
    	
    	border-radius: 15px;
    }
/* ---------- 모달 관련 CSS ---------- */  
    .ui-timepicker-container { /* Timepicker appears behind the modal */
     	z-index:1151 !important; 
	}
	
	.mySeat button { /* 모달 내부 타임테이블 예약 가능 자리 */
		height: 20px;
		width: 45px;
		
		border-radius: 5px;
	}
	
	.modal-footer > .btnSkydiver {
		background-color: rgb(0,88,155);
		color: white;
	}
</style>
<body>

<jsp:include page="../common/header.jsp" />
	
<!-- 부트스트랩 관련 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!-- <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>  -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

<div class="mainWrap">
	<h1 id="h1">STUDY ROOM</h1>
	<script>
		function hideModal(){
			$('#reserveInfo').modal('hide'); // 예약 정보
			$('#myModal').modal('hide'); // 예약 
			$('#updateModal').modal('hide'); // 예약 수정
		}
	</script>
	
	<c:choose>
	<c:when test="${ !empty loginUser.userId }">
	<div class="content">
		<div id="seatTable">
			<div class="seat-area-L">
				<table id="seatTable1" style="height: 560px; width: 70px;">
					<c:forEach var="i" begin="101" end="108">
						<tr><td id=${ i }><div id="${ i }a" class="tdDiv"><br>${ i }</div></td></tr>
					</c:forEach>
					<script type="text/javascript">
						function markSeat(){
							$.ajax({
								url: 'seatView.st',
								data: {
									userNo : ${loginUser.userNo}
								},
								type: 'post',
								dataType: 'json',
								success: function(list){
									
									var date = new Date();
		                            var hours = date.getHours();
		                            
									for(var i=0; i<list.length; i++){
										
										// 현재시간이 예약시간 사이일 경우
										if(list[i].startDate <= hours && hours < list[i].endDate){
											$('#' + list[i].seatNo).css('height', '70px').css('width', '70px').css('border-radius', '15px');
			                            	
			                            	if(${loginUser.userNo} == list[i].userNo){ // 내가 예약
			                            		$('#'+list[i].seatNo).css('background', 'rgb(245, 223, 77)').css('color', 'black').text('이용중'); // yellow
			                            		$('#'+list[i].seatNo).css('box-shadow', '1px 1px 5px lightgrey');
			                            	}
			                            	else{
			                            		$('#'+list[i].seatNo).css('background', 'darkgrey').css('color', 'black').text('이용중');
			                            		$('#'+list[i].seatNo).css('box-shadow', '1px 1px 5px lightgrey');
			                            	}
										}
									}
								}, error: function(){
									console.log('tlqkdhodksehlsmsep');
								}
							});
						}
						markSeat();
					</script>
				</table>          
			</div><!-- seat-area-L -->
       
			<div class="seat-area-R">
				<table id="seatTable2" style="height: 420px; width: 70px;">
					<c:forEach var="i" begin="109" end="114">
						<tr><td id=${ i }><div id="${ i }a" class="tdDiv"><br>${ i }</div></td></tr>
					</c:forEach>
					<script>markSeat();</script>
				</table>            
			</div><!-- seat-area-R -->
			
			<div class="seat-area-L" style="padding-top: 70px; padding-bottom: 70px">
				<table id="seatTable3" style="height: 420px; width: 70px;">
					<c:forEach var="i" begin="115" end="120">
						<tr><td id=${ i }><div id="${ i }a" class="tdDiv"><br>${ i }</div></td></tr>
					</c:forEach>
					<script>markSeat();</script>
				</table>          
			</div><!-- seat-area-L -->
			
			<div class="seat-area-R">
				<table id="seatTable4" style="height: 420px; width: 70px;">
					<c:forEach var="i" begin="121" end="126">
						<tr><td id=${ i }><div id="${ i }a" class="tdDiv"><br>${ i }</div></td></tr>
					</c:forEach>
					<script>markSeat();</script>			
				</table>            
			</div><!-- seat-area-R -->
			
			<div class="seat-area-L" style="padding-top: 70px; padding-bottom: 70px;">
				<table id="seatTable5" style="height: 420px; width: 70px;">
					<c:forEach var="i" begin="127" end="132">
						<tr><td id=${ i }><div id="${ i }a" class="tdDiv"><br>${ i }</div></td></tr>
					</c:forEach>
					<script>markSeat();</script>
				</table>          
			</div><!-- seat-area-L -->
			
<!-- 좌석 클릭 show 모달 -->    
            <script>
                $(function(){
                	$('#seatTable tr').on({'click' : function(){
               			$('#myModal').modal('show');
               			console.log('클릭한 좌석 번호1 : ' + ($('#seatNo').text().substr(0,3)));
                   	}})
               	});
            </script>
        </div><!-- seatTable -->
        
<%-- 지금 시간 기준으로 이용중, 이용불가 표시 --%>        
        <div id="waiting">
			<button onclick="showReserveInfo();" style="width: 110px; height: 30px; border-radius:5px; 
					background: rgb(240, 238, 233); border: solid 1px darkgrey; color: grey; box-shadow: 1px 1px 3px lightgrey">예약 확인</button>
			<br><br>
			<table id="waitingTable">
				<tr width="50px">
					<td>이용중</td>
					<td><button style="background: darkgrey;" disabled /></td>
				</tr>
				<tr>
					<td>이용가능</td>
					<td><button style="background: rgb(240, 238, 233);" disabled /></td>
				</tr>
			</table>
		</div>
		<!-- 예약정보 조회 모달 : The Modal -->
		<div class="modal" id="reserveInfo">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
		
					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">${loginUser.userName}님의 독서실 예약 정보</h4>
						<button type="button" class="close" data-dismiss="modal" onclick="hideModal();">&times;</button>
					</div>
					
					<!-- Modal body -->
					<div class="modal-body" id="reserveInfo-body">
						<div id="rsvBody"></div>
					</div>
					<script>
						$.ajax({
							url: 'reservedInfo.st',
							data : {
								userNo : ${loginUser.userNo}
							},
							type: 'post',
							dataType: 'json',
							success: function(r){
								
								var reserved = document.getElementById('rsvBody');
								
								if(r != null){
									reserved.innerHTML += r.startDay + ' / ' 
									                    + '좌석번호 : ' + r.seatNo + '번 / ' 
									                    + r.startDate + ':00 - ' 
									                    + r.endDate + ':00 ';
									$(document).ready(function() {
										
										var date = new Date();
			                            var hours = date.getHours();
										
			                            if(hours < r.endDate){
			                            	$('#rsvBody').append('<button type="button" onclick="deleteReserve();hideModal();">취소</button>');
			                            }
			                            else{
			                            	$('#rsvBody').append('<button type="button" onclick="deleteReserve();hideModal();" disabled>취소</button>');
			                            }
									    
									})
								}
								else{
									reserved.innerHTML += '예약된 정보가 없습니다';
								}
								
							}, error: function(){
								console.log('에휴 니가 안되는 건 내 잘못이겠지..')
							}
						})
					</script>
					
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="btn btn-outline-secondary" data-dismiss="modal" onclick="hideModal();">닫기</button>
					</div>
			
				</div><!-- modal-content -->
			</div>
		</div><!-- modal -->
		<script>
			function showReserveInfo(){
				$('#reserveInfo').modal('show');
			}
			
			function deleteReserve(){
				$.ajax({
					url: 'deleteReserve.st',
					data: {
						userNo: ${loginUser.userNo}
					},
					success: function(){
						swal({
							title : '예약이 취소되었습니다',
							text : '',
							icon : 'success',
							closeOnClickOutside : false,
							closeOnEsc : false,
							buttons : {
								doLogin : {
									text : '확인',
									value : true,
									className : 'btn'
								}
							}
						}).then((result) => { 
							if(result){
								location.href='seatView.st';
							}
						})
						
						$('#myStudyInfo').modal('hide');
					}, error: function(){
						console.log('에효 니가 안되는 건 내 잘못이겠지');
					}
				})
			}
		</script>

        <!-- The Modal -->
            <div class="modal" id="myModal" data-bs-keyboard="false" data-bs-backdrop="static">
            <!-- <div id="myModal" class="modal hide fade in" data-keyboard="false" data-backdrop="static"> -->
                <div class="modal-dialog modal-dialog-centered"> <!-- modal-dialog-centered 모달창 중앙으로 -->
                    <div class="modal-content">
                
                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title" id="seatNo">
                                <script>
                                    $('td').click(function(event) {
                                        var rNum = $(this).attr('id'); // 클릭한 테이블의 번호

                                        var seatNo = document.getElementById('seatNo');
                                        seatNo.innerHTML = rNum + '번 좌석을 선택하셨습니다.';
                                    });
                                </script>
                            </h4>
                            <button type="button" class="close" onclick="reload();">&times;</button>
                        </div>
                        
                        <!-- Modal body -->
                        <div class="modal-body" id="modal-body">
                            <script>
	                            var date = new Date();
	                            var year = date.getFullYear();
	                            var month = date.getMonth() + 1;
	                            var day = date.getDate();
	                            var hours = date.getHours();
	                            var minutes = date.getMinutes();
	                            
	                            var currentTime = document.getElementById('modal-body');
	                            currentTime.innerHTML = year + '년 ' + month + '월 ' + day + '일 &nbsp;' + hours + '시 ' + minutes + '분';
                            
	                            /* $('#modal-body').css('text-align', 'center'); */	
	                        </script>

	                            <div class="mySeat">
	                            	<table>
	                            		<tr>
	                            			<td>예약중</td>
	                            			<td><button style="background: grey;" disabled /></td>
	                            			<td>MY</td>
	                            			<td><button style="background: rgb(245, 223, 77);" disabled /></td>
	                            		</tr>
	                            	</table>
	                            </div>
<!-- 예약 가능 시간표 영역 -->
                            <table id="timeTable" class="table table-bordered" style="width:300px; height:40px" align="center">
                                <tr>
                                    <c:forEach var="i" begin="0" end="5">
                                    	<td id=${ i }>0${i}:00</td>
                                   		<script>
                                    		function timeTable(){
                                    			$('td').click(function(event) {
			                                        var clickNo = $(this).attr('id'); // 클릭한 테이블의 번호
			                                        
			                                        var date = new Date();
						                            var hours = date.getHours();

						                            if(${i} <= hours){ // i : 0,1,2,3,4,5
														for(var i = 0; i <= hours; i++){
															$('#'+i).css('text-decoration', 'line-through');
														}
													}
						                            
						                            $.ajax({
						                            	url: 'timeTable.st',
						                            	data: {
						                            		seatNo : clickNo
						                            	}, 
						                            	type: 'post',
						                            	dataType: 'json',
						                            	success: function(sList){
						                                    
					                            			var cno = clickNo; // 클릭한 테이블의 번호
					                                        
					                                        for(var j=0; j<sList.length; j++){
						                            			if(cno == sList[j].seatNo){
						                            				for(var k = sList[j].startDate; k < sList[j].endDate; k++){
							                            				if(${loginUser.userNo} == sList[j].userNo){
							                            					$('#'+k).css('background', 'rgb(245,223,77)'); // yellow
								                            			}
							                            				else{
							                            					$('#'+k).css('background', 'grey');
							                            				}
							                            			}
						                            			}
						                            			else if(cno != sList[j].seatNo){
						                            				for(var k = sList[j].startDate; k < sList[j].endDate; k++){
						                            					$('#'+k).css('background', 'white');
						                            				}
						                            			}
						                            		}
						                            		
						                            	}, error: function(){
						                            		console.log('외않되');
						                            	}
						                            })
			                                    });
                                    		}	
                                   			timeTable();
										</script>	
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <c:forEach var="i" begin="6" end="11">
                                        <c:choose>
                                            <c:when test="${ i le 9}">
                                                <td id=${ i }>0${i}:00</td>
                                            </c:when>
                                            <c:otherwise>
                                                <td id=${ i }>${i}:00</td>
                                            </c:otherwise>
                                        </c:choose>
                                        <script>timeTable();</script>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <c:forEach var="i" begin="12" end="17">
                                        <td id=${ i }>${i}:00</td>
                                        <script>timeTable();</script>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <c:forEach var="i" begin="18" end="23">
                                        <td id=${ i }>${i}:00</td>
                                        <script>timeTable();</script>
                                    </c:forEach>
                                </tr> 
                            </table>
<%-- 타임피커 부분 --%>	
                           	<label for="time">시간 선택 <br>
							<input type="text" id="timepickerStartTime" class="time" placeholder="시간 선택" readonly> -
							<input type="text" id="timepickerEndTime" class="time" placeholder="시간 선택" readonly>
                            </label>
                            
                            <script type="text/javascript">
                            
	                            $(function() {
	                        	    $('#timepickerStartTime').timepicker({
	                        	    	timeFormat: 'HH:mm p',
	                        	        interval: 60,
	                        	        minTime: '00',
	                        	        maxTime: '23:00',
	                        	        defaultTime: '00',
	                        	        startTime: '00:00',
	                        	        dynamic: false,
	                        	        dropdown: true,
	                        	        scrollbar: true    
	                        	    });
	                        	    
	                        	    $('#timepickerEndTime').timepicker({
	                        	    	timeFormat: 'HH:mm p',
	                        	        interval: 60,
	                        	        minTime: '00',
	                        	        maxTime: '23:00',
	                        	        defaultTime: '00',
	                        	        startTime: '00:00',
	                        	        dynamic: false,
	                        	        dropdown: true,
	                        	        scrollbar: true    
	                        	    });
	                        	});
	                        </script>
                        </div><!-- Modal body -->
<%-- Modal footer --%>
                        <!-- Modal footer -->
                        <div class="modal-footer">
                            <button type="reset" class="btn btn-outline-secondary" onclick="reload();" data-dismiss="modal">취소</button>
                            <button type="button" class="btn btnSkydiver" onclick="submit()" data-dismiss="modal">확인</button>
                        </div>
                        
                        <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
                        
                        <script>
                        	function reload(){
                        		location.reload();
                        	}
                        	
                            function submit(){
                            	var startTime = parseInt($('#timepickerStartTime').val().substr(0,2));  
                                var endTime = parseInt($('#timepickerEndTime').val().substr(0,2)); 
                                var seatNo = $('#seatNo').text().substr(0,3);
                                
                                <%-- 현재 시간부터 예약 가능, 이전 시간 선택시 예약 불가 알럿 --%>
                                var date = new Date();
	                            var hours = date.getHours();
                                    
                                   $.ajax({
   	                            	url: 'seatView.st',
   	                            	data: {
   	                            		seatNo : seatNo,
   	                            		startTime : $('#timepickerStartTime').val().substr(0,2), // 04
                                   		endTime : $('#timepickerEndTime').val().substr(0,2) // 05
   	                            	},
   	                            	type: 'post',
   									dataType: 'json',
   	                            	success: function(list){
   	                            		
   	                            		var reservedTime = 0;
   	                            		for(var i = 0; i < list.length; i++){
   	                            			
   	                            			if(list[i].startDate <= startTime && startTime <= list[i].endDate &&
   	                            			   list[i].startDate <= endTime && endTime <= list[i].endDate){ 
   	                         					reservedTime = 1;
   	                            			}else{
   	                            				reservedTime = 0;
   	                            			}
   	                            		}
   	                            		
   	                            		if((hours > startTime)         || // 지금시간 > 선택한 시간
                                           (startTime > endTime)       || // 시작시간 > 종료시간
                                           ((endTime - startTime) > 3) || // 3시간이상 예약 불가
                                           (startTime == endTime)      || // 시작시간 == 종료시간
                                           (reservedTime == 1)            // 예약된 시간
                                        ){ 
                                          	swal('시간 선택이 잘못되었습니다','지나간 시간은 선택이 불가합니다. 3시간 초과 선택 불가합니다.','warning');
                                          	$('#timepickerStartTime').val(''); // input값 초기화
                                          	$('#timepickerEndTime').val('');
                                            	
                                        }else{
                                        	$.ajax({
                                                url : 'reserveSeat.st',
                                                data : {
                                                	startTime : $('#timepickerStartTime').val().substr(0,2), // 04
                                            		endTime : $('#timepickerEndTime').val().substr(0,2), // 05
                                            		seatNo : $('#seatNo').text().substr(0,3), //"110 번 좌석을 선택하셨습니다."에서 앞에 3개만 읽기
                                            		userNo : ${loginUser.userNo}
                                                },
                                                success : function(rsv){
                                                	
                                                	if(rsv != null){
                                               			swal({
        													title : rsv.createDate,
        													text : rsv.seatNo + '번자리 ' + rsv.startDate+':00' + ' - ' + rsv.endDate+':00' + ' 예약되었습니다.',
        													icon : 'success',
        													closeOnClickOutside : false,
        													closeOnEsc : false,
        													buttons : {
        														doLogin : {
        															text : '확인',
        															value : true,
        															className : 'btn'
        														}
        													}
        												}).then((result) => { 
        													if(result){
        														location.href='seatView.st';
        													}
        												})
                                                       	
                                                       	var tdDivColor = '#' + rsv.seatNo + 'a';
                                                           $(tdDivColor).css('background', 'deeppink').css('height', '70').text('예약한 자리');
                                                           
                                                           $('#myModal').modal('hide');
                                                	}
                                                	else{
                                                		swal({
                                               				title : '예약 실패',
                                               				text : '동시에 예약이 불가합니다.한 번에 한자리만 예약이 가능합니다',
                                               				icon : 'error',
                                               				closeOnClickOutside : false, //알럿창 제외하고 클릭시 창 닫히지 않도록
                                               				closeOnEsc : false,
                                               			})
                                                	}
                                                }, error : function(){
                                                    swal('안됨', '', 'error');
                                                }
                                            })
                                        }//if
   	                            		
   	                            	}, error: function(){
   	                            		console.log('안됩니다요');
   	                            	}
   	                            })
                            }// submit()
                        </script>
                    </div><!-- modal-content -->
                </div><!-- modal-dialog -->
            </div>
    	</div><!-- content -->
    	<br>
	</c:when>
	<c:otherwise>
    	<script>
			swal({
				title : '로그인을 해야 합니다.',
				text : ' ',
				icon : 'warning',
				closeOnClickOutside : false, //알럿창 제외하고 클릭시 창 닫히지 않도록
				closeOnEsc : false,
				buttons : {
					doLogin : {
						text : '로그인',
						value : true,
						className : 'btn'
					}
				}
			}).then((result) => { //value를 result로 받아서 사용
				if(result){
					location.href='login.me';
				}
			})
    	</script>
    </c:otherwise>
	</c:choose>
<%-- 오늘 날짜가 아니면 상태 컬럼 N으로 변경 --%>
	<script>
	    var date = new Date();
	    var year = date.getFullYear();
	    var month = date.getMonth() + 1;
	    var day = date.getDate();
	    var hours = date.getHours();
	   
	    if(month < 10){
        	var today = year+'-'+'0'+month+'-'+'0'+day;
        }
        else{
        	var today = year+'-'+month+'-'+ day;
        }
	    
	    $.ajax({
	    	url: 'updateStatus.st',
	    	data: {
	    		today: today,
	    		hour: hours
	    	},
	    	success: function(data){
	    		console.log(today);
	    	}, error: function(){
	    		console.log('니가 안되는 건 내 잘못이겠지');
	    	}
	    })
	</script>
	
	
	
</div>
</body>
</html>