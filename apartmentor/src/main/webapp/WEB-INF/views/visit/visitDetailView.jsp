<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방문 예약 상세페이지</title>
</head>
<body>
<style>
	.visitContent {
		width: 1200px;
		height: 800px;
		margin: auto;
	}

    h1 {
        text-align: left;
        margin-left: 80px;
    }


    .visitDetailContent {
        background-color: #f0eee9;
    }
    
    .visitStyle {
    	background-color: white;
    	border-top: 1px solid grey;
    	border-bottom : 1px solid grey;
    	padding-top: 30px;
    	padding-bottom: 30px;
    }
    
    #visitDetail {
    	margin-left: 100px;
    }
    
    #visitDetail th {
    	width: 100px;
    	text-align: center;
    	font-size: 18px;
    	color: #4d4d4d;
    }

</style>

</head>
<body>

<jsp:include page="../common/header.jsp"/>
<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>


<br>
<br>

<div class="visitContent">

	<h1>방문 예약 관리</h1>
	

	<br>
	<br>
	
	<div class="visitDetailContent">
	
	<br>
	<br>
	
	<div class="visitStyle">
	<form id="visitStatus" action="" method="post">
		<input type="hidden" name="vno" value="${v.visitNo}">
		<input type="hidden" name="visitEmail" value="${v.visitEmail}">
		<input type="hidden" name="aptNo" value="${v.aptNo}">
		<input type="hidden" name="visitValue" value="${v.visitValue}">
		<input type="hidden" name="visitDate" value="${v.visitDate}">
		<input type="hidden" name="visitTime" value="${v.visitTime}">
		<table id="visitDetail">
			<tr>
				<th>예약 종류</th>
				<td>&nbsp;&nbsp;</td>
				<td>${v.visitValue}</td>
			</tr>
			<tr style="height: 40px">
				<th>신청 날짜</th>
				<td>&nbsp;&nbsp;</td>
				<td>${v.createDate}</td>
			</tr>
			<tr style="height: 40px">
				<th>신청 호수</th>
				<td>&nbsp;&nbsp;</td>
				<td>${v.aptNo}</td>
			</tr>
			<tr style="height: 40px">
				<th>예약 날짜</th>
				<td>&nbsp;&nbsp;</td>
				<td>${v.visitDate}</td>
			</tr>
			<tr style="height: 60px">
				<th>예약 시간</th>
				<td>&nbsp;&nbsp;</td>
				<td>${v.visitTime}</td>
				<td>
					<button type="button" class="btn btn-outline-info" data-toggle="modal" data-target="#myModal" style="width:100px;">
						  예약 현황
					</button>
				</td>
			</tr>
			<tr>
				<th style="vertical-align: top;">참고 사항</th>
				<td>&nbsp;&nbsp;</td>
				<td colspan="6">
					<p style="white-space: pre-line;">${v.visitContent}</p>
				</td>
			</tr>
		</table>
	</form>	
	</div>
	
		<div style="margin-left: 150px; margin-top: 40px;">
			<button type="button" class="btn btn-outline-info" id="backBtn" onclick="history.back()">돌아가기</button>
		<c:choose>
			<c:when test="${v.visitStatus eq 'C'}">
				<button type="button" class="btn btn-info" id="cancelBtn">취소승인</button>
			</c:when>
			<c:otherwise>
				<button type="button" class="btn btn-info" id="okBtn">예약승인</button>
				<button type="button" class="btn btn-info" id="noBtn">예약취소</button>&nbsp;&nbsp;&nbsp;
			</c:otherwise>
		</c:choose>
		</div>
	
	<script>
		$(function(){

			$('#okBtn').click(function(){
				const form = $('#visitStatus');
				form.attr('action', 'okReserve.visit');
				form.submit();
			})
			
			$('#noBtn').click(function(){
				const form = $('#visitStatus');
				form.attr('action', 'noReserve.visit');
				form.submit();
			})
			
			$('#cancelBtn').click(function(){
				const form = $('#visitStatus');
				form.attr('action', 'cancelReserve.visit');
				form.submit();
			})
			
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
	$(".btn btn-outline-info").click(function(){
		var data = $(this).data('id');
	    $("#contents.body-contents").val(data);
	    $("#text-contents.body-contents").html(data);
	});
	
	$(function(){
		// 예약된 날짜와 시간 호출
		selectAllVisitReserve()
	})
	
	function selectAllVisitReserve(){
		$.ajax({
			url : 'selectAll.visit',
			success : function(Allreserve){
					let list = '';
					
					list += '<p style="font-weight:bolder; font-size:18px; margin-top:5px; margin-bottom:5px; color:#00589b">가스 예약 현황</p>';
					for(let i in Allreserve) {
						if(Allreserve[i].visitCategory == 1 && Allreserve[i].visitDate != null) {
							list += Allreserve[i].aptNo + ' : ' + Allreserve[i].visitDate + '&nbsp;' + Allreserve[i].visitTime + '<br>';
						} 
					}
					
					list + '<p style="font-weight:bolder; font-size:18px; margin-top:5px; margin-bottom:5px; color:#00589b">난방 예약 현황</p>';
					for(let i in Allreserve) {
						if(Allreserve[i].visitCategory == 2 && Allreserve[i].visitDate != null) {
							list += Allreserve[i].aptNo + ' : ' + Allreserve[i].visitDate + '&nbsp;' + Allreserve[i].visitTime + '<br>';
						} 
					}
					
					list += '<p style="font-weight:bolder; font-size:18px; margin-top:5px; margin-bottom:5px; color:#00589b">소독 예약 현황</p>';
					for(let i in Allreserve) {
						if(Allreserve[i].visitCategory == 3 && Allreserve[i].visitDate != null) {
							list += Allreserve[i].aptNo + ' : ' + Allreserve[i].visitDate + '&nbsp;' + Allreserve[i].visitTime + '<br>';
						} 
					}
					
					list += '<p style="font-weight:bolder; font-size:18px; margin-top:5px; margin-bottom:5px; color:#00589b">수도 예약 현황</p>';
					for(let i in Allreserve) {
						if(Allreserve[i].visitCategory == 4 && Allreserve[i].visitDate != null) {
							list += Allreserve[i].aptNo + ' : ' + Allreserve[i].visitDate + '&nbsp;' + Allreserve[i].visitTime + '<br>';
						} 
					}
					
					list += '<p style="font-weight:bolder; font-size:18px; margin-top:5px; margin-bottom:5px; color:#00589b">전기 예약 현황</p>';
					for(let i in Allreserve) {
						if(Allreserve[i].visitCategory == 5 && Allreserve[i].visitDate != null) {
							list += Allreserve[i].aptNo + ' : ' + Allreserve[i].visitDate + '&nbsp;' + Allreserve[i].visitTime + '<br>';
						} 
					}
					
					$('.modal-body').html(list);
			},
			error : function(){
				console.log('예약 시간 조회 실패');
			}
		});
	}
	
	</script>
	
		<br>
		<br>

	</div>

<br>
<br>

</div>

<br>
<br>

<jsp:include page="../common/footer.jsp"/>

</body>
</html>