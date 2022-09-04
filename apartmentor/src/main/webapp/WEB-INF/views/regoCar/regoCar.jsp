<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차량등록</title>
<style>
    .content{
        background-color: rgb(240, 238, 233);
		color: black;
		width: 1200px;
		margin: auto;
		margin-top: 30px;
    }
    
    .regoCar-title, .visitCar-List{
    	padding-left: 19em;
    }
     
    .regoCar-title2, .regoCar-title3{
    	display : flex;
		flex-direction: row;
    	padding-left: 19em;
    }
    .regoCar-title2>h6{
    	padding-top: 15px;
    	padding-left: 1em;
    }
    
     #regoCar-phone{
		padding-left: 3em;
	}
	
	.regoCar-dlt-btn, .visitCar-dlt-btn{
		cursor: pointer;
	}
    
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
	<div class="content">
	
		<br><br><br>
		
		<h1 align="center">${ loginUser.getAptNo() }</h1>
		
		<br><br><br>
		
		<div class="regoCar-title">
			<h2>주차차량 등록</h2>
		</div>
		
		<br>
		
		<div align="center">
			<label>차량번호 : <input id="carNo" name="carNo" type="text" placeholder="ex)123가1234"></label>
			<label id="regoCar-phone">연락처 : <input id="carPhone" name="carPhone" type="text" placeholder="ex)010-1234-5678"></label>
			<label><button onclick="regoCar();">등록하기</button></label>
		</div>
		
		<br><br>
		
		<div class="regoCar-title2">
			<h2>주차등록현황</h2><h6>(3대 이상부터 1대당 5만원의 관리비가 부가됩니다.)</h6>
		</div>
		
		<div style="margin:auto; width:700px;">
			<table class="table table-hover" id="regoCar-List" align="center">
				<thead>
					<tr style="width: 70px; height: 30px; text-align: center; font-weight: bolder;">
						<th>No.</th>
						<th>차량번호</th>
						<th>연락처</th>
						<th>승인현황</th>
						<th>등록 취소</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
		</div>
		
		<br><br>
		<div class="regoCar-title3">
			<h2>방문차량현황</h2>
		</div>
		
		<div style="margin:auto; width:700px;">
			<table class="table table-hover" id="visitCar-List" align="center">
				<thead>
					<tr style="width: 70px; height: 30px; text-align: center; font-weight: bolder;">
						<th>방문일</th>
						<th>차량번호</th>
						<th>연락처</th>
						<th>방문목적</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
		</div>


		<script>
	    	$(function(){
	    		selectRegoCarList();
	    		selectVisitCarList();
	    	})
		
			// 차량등록
			function regoCar(){
				if($("#carNo").val() == "" || $("#carPhone").val() == ""){
					swal({
						title : "차량번호랑, 연락처를 적어주세요!",
					    	icon  : "error",
					    	closeOnClickOutside : false
					})
				}
				else{
					$.ajax({
						url : "insertRegoCar.rg",
						data : {
							carNo : $("#carNo").val(),
							carPhone : $("#carPhone").val(),
							userNo : ${ loginUser.getUserNo()}
						},
						success : function(){
	 						swal({
								title : "등록이 완료 되었습니다.",
								text : "관리자에게 승인요청하겠습니다.",
							    	icon  : "success",
							    	closeOnClickOutside : false
							}).then(function(){
									$("#carNo").val("");
									$("#carPhone").val("");
									selectRegoCarList();
								});
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
	    	
	    	// 방문차량 취소
	        $(document).on("click",".regoCar-dlt-btn", function deleteRegoCar(){
	        	
	        	//console.log($(this).parents("tr").find("td:eq(1)").text());
	        	 $.ajax({
	        		url : "deleteRegoCar.rg",
	        		data : {
	        			carNo : $(this).parents("tr").find("td:eq(1)").text()
	        		},
	        		type : "post",
	        		success : function(result){
	        			
 	        			// result값에 따라서 성공했으면 성공메시지 띄우기
	        			if(result > 0 ){
	 						swal({
								title : "등록취소가 완료 되었습니다.",
								text : "차량 등록을 삭제했습니다.",
							    	icon  : "success",
							    	closeOnClickOutside : false
							}).then(function(){
									selectRegoCarList();
								});
	        			} 
	        			
	        		},
	        		error : function(){
 						swal({
							title : "오류입니다. 관리자에게 문의하세요",
						    	icon  : "error",
						    	closeOnClickOutside : false
						});
	        		}
	        	}); 
	        	
	        });
			
			// 차량 등록 취소
	        $(document).on("click",".visitCar-dlt-btn", function deleteVisitCar(){
	        	
	        	 $.ajax({
	        		url : "deleteVisitCar.car",
	        		data : {
	        			visitCarDate : $(this).parents("tr").find("td:eq(0)").text(),
	        			carNo : $(this).parents("tr").find("td:eq(1)").text()
	        		},
	        		type : "post",
	        		success : function(result){
	        			
 	        			// result값에 따라서 성공했으면 성공메시지 띄우기
	        			if(result > 0 ){
	 						swal({
								title : "방문차량 취소가 완료 되었습니다.",
								text : "방문차량 등록을 삭제했습니다.",
							    	icon  : "success",
							    	closeOnClickOutside : false
							}).then(function(){
									selectVisitCarList();
								});
	        			} 
	        			
	        		},
	        		error : function(){
 						swal({
							title : "오류입니다. 관리자에게 문의하세요",
						    	icon  : "error",
						    	closeOnClickOutside : false
						});
	        		}
	        	}); 
	        	
	        });
			
			// 방문주차 차량리스트 
			function selectVisitCarList(){
	    		$.ajax({
	    			url : 'selectVisitCarList.car', 
	    			data : {
	    				// aptNo로 주기 
						aptNo : '${ loginUser.getAptNo() }'		
	    			},
	    			success : function(list){
	    				let value = '';
	    				if(list.length == 0){
	    					value += '<tr style="width: 70px; height: 30px; text-align: center;">'
	    						   + '<td colspan="5">등록된 차량이 없습니다.</td>'
								   + '</tr>'
	    				}
	    				else{
		    				for(let i = 0; i < list.length; i++){
		    					value += '<tr style="width: 70px; height: 30px; text-align: center;">'
		    						   + '<td>' + list[i].visitCarDate + '</td>'
									   + '<td>' + list[i].carNo + '</td>'
									   + '<td>' + list[i].visitCarPhone + '</td>'
									   + '<td>' + list[i].purpose + '</td>'
		                		  	   + "<td>" + "<a class='visitCar-dlt-btn' align='center' style='width: 50px'>취소 요청</a>" + "</td>"
									   + '</tr>'
		    				}
	    				}
	    				$('#visitCar-List tbody').html(value);
	    			},
	    			error : function(){
 						swal({
							title : "오류입니다. 관리자에게 문의하세요",
						    	icon  : "error",
						    	closeOnClickOutside : false
						});
	    			}
	    		})
	    	} 
			
			// 이용자 방문차량리스트 
			function selectRegoCarList(){
	    		$.ajax({
	    			url : 'selectRegoCarList.rg', 
	    			data : {
	    				// aptNo로 주기 
						aptNo : '${ loginUser.getAptNo() }'		
	    			},
	    			success : function(list){
	    				let value = '';
	    				if(list.length == 0){
	    					value += '<tr style="width: 70px; height: 30px; text-align: center;">'
	    						   + '<td colspan="5">등록된 차량이 없습니다.</td>'
								   + '</tr>'
	    				}
	    				else{
		    				for(let i = 0; i < list.length; i++){
		    					if(list[i].status == 'W'){
		    						list[i].status = '승인대기중';
		    					}
		    					if(list[i].status == 'Y'){
		    						list[i].status = '승인완료';
		    					}
		    					value += '<tr style="width: 70px; height: 30px; text-align: center;">'
		    						   + '<td>' + [i+1] + '</td>'
									   + '<td>' + list[i].carNo + '</td>'
									   + '<td>' + list[i].carPhone + '</td>'
									   + '<td>' + list[i].status + '</td>'
		                		  	   + "<td>" + "<a class='regoCar-dlt-btn' align='center' style='width: 50px'>취소 요청</a>" + "</td>"
									   + '</tr>'
		    				}
	    				}
	    				$('#regoCar-List tbody').html(value);
	    			},
	    			error : function(){
 						swal({
							title : "오류입니다. 관리자에게 문의하세요",
						    	icon  : "error",
						    	closeOnClickOutside : false
						});
	    			}
	    		})
	    	}
			
			
		</script>



	<br><br><br><br><br><br>
	</div>
	
	<jsp:include page="../common/footer.jsp" />
</body>
</html>