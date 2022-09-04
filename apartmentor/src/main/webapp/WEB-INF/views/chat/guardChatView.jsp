<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리실 채팅</title>
<style>
	.content-area{
		width:1200px;
		height:1000px;
		margin: auto;
	}
	#chatTitleBtn{
		margin-left:220px;
	}
	.chat-area{
		width: 600px;
		height:600px; 
		margin-left:230px;
		float:left;
		overflow:auto;
		border:1px solid black;
		padding:5px;
	}
	
	.userchat-area {
		position: relative;
		width: 200px;
		padding: 7px;
		background: #FFFFFF;
		-webkit-border-radius: 21px;
		-moz-border-radius: 21px;
		border-radius: 21px;
		border: #6DB6C8 solid 4px;
		font-size:14px;
		margin-bottom: 10px;
		margin-left: 20px; 
	}
	
	.userchat-area:after {
		content: '';
		position: absolute;
		border-style: solid;
		border-width: 12px 23px 12px 0;
		border-color: transparent #FFFFFF;
		display: block;
		width: 0;
		z-index: 1;
		left: -23px;
		top: 21px;
	}
	
	.userchat-area:before {
		content: '';
		position: absolute;
		border-style: solid;
		border-width: 15px 26px 15px 0;
		border-color: transparent #6DB6C8;
		display: block;
		width: 0;
		z-index: 0;
		left: -30px;
		top: 18px;
	}
	
	.mychat-area {
		position: relative;
		width: 200px;
		padding: 7px;
		background: #FFFFFF;
		border: #6DB6C8 solid 4px;
		-webkit-border-radius: 10px;
		-moz-border-radius: 10px;
		border-radius: 21px;
		font-size:14px;
		margin-bottom: 10px;
		margin-left: 350px; 
	}

	.mychat-area:after {
		content: '';
		position: absolute;
		border-style: solid;
		border-width: 12px 0 12px 22px;
		border-color: transparent #6DB6C8;
		display: block;
		width: 0;
		z-index: 1;
		right: -23px;
		top: 21px;
	}
	
	.onlineCheck{
		width: 200px;
		float:left;
		height:600px; 
		margin-left:10px;
	}
	
	#chatInput{
		width: 500px;
		margin-left:230px;
		margin-top:10px;
		height:50px; 
	}
	
	#chatBtn{
		width: 90px;
		height:40px;
	}
	
	.circle{
        border-radius: 50%;
        width: 10px;
        height: 10px;
        background-color : grey;
        float:left;
        margin-top : 5px;
        margin-right : 7px;
        margin-left : 10px;
	}
	
	.chatSendDate{
		font-size:17px;
		margin-top : 7px;
		margin-bottom : 7px;
	}
	.online-area{
		margin-left : 5px;
		margin-bottom : 5px;
		font-size : 20px;
	}
	
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	
	<br>
	<br>
	
	<div class="content-area">
	
		<div align="center" style="margin-right:600px;">
			<h1>채팅</h1> 
		</div>
		<br><br><br>
		<div class="btn-group btn-group-lg" id="chatTitleBtn">
					<button type="button" class="btn" onclick="location.href='chatForm.ch'">주민채팅방</button>
			    	<button type="button" class="btn btn-primary" disabled >관리실 채팅방</button>
		</div>
		<br><br>
		
		<div class="chat-area"></div>
		
		<div>
			<input type="text" id="chatInput" name="chatContent">
			<button class="btn btn-primary" id="chatBtn" onclick="addGuardChat();">전송</button>
		</div>
		
		
	</div>
	
	<script>
	
	// 채팅 리스트 조회 기능 호출
	$(function(){
		selectGuardChatList();
		
		// 스크롤바 아래로 내리기
		$('.chat-area').scrollTop($('.chat-area')[0].scrollHeight);
		
	})
		
	// 관리실채팅 조회 ajax
	function selectGuardChatList(){
		console.log('1초마다 실행');
		var loginUserName = '${loginUser.userName}';
		$.ajax({
			url : 'selectGuardChatList.ch',
			data : { userNo : ${loginUser.userNo} },
			success : function(list){
				let value = '';
				 for(let i in list){
					 // 자신이 쓴 채팅일 경우 
					 if(loginUserName == list[i].chatWriter) {
						 value += "<div class='mychat-area'>"
						 		+ "<div>" + list[i].chatWriter + "</div>"
						 		+ "<div>" + list[i].chatContent + "</div>"
						 		+ "<div>" + list[i].chatSendTime + "</div>"
						 		+ "</div>";
					 } else {
						 value += "<div class='userchat-area'>"
						 		+ "<div>" + list[i].chatWriter + "</div>"
						 		+ "<div>" + list[i].chatContent + "</div>"
						 		+ "<div>" + list[i].chatSendTime + "</div>"
						 		+ "</div>";
					 }
					 $('.chat-area').html(value);
					// 스크롤바 아래로 내리기
					$('.chat-area').scrollTop($('.chat-area')[0].scrollHeight);
				 }
			}, error : function(){
				console.log('비동기요청 실패!');
			}
		})
	}
	
	// 1초마다 관리실채팅 조회 ajax 실행해주는 setInterval
	setInterval(function gList(){
		selectGuardChatList();
	},1000);
	
	// 채팅 작성용 ajax
	function addGuardChat(){
		
		if($('#chatInput').val().trim() != '') {
			// 사용자가 입력했을 경우에만 댓글 작성해주는 ajax
			$.ajax({
				url:'guardChatInsert.ch',
				data:{
						userNo : '${loginUser.userNo}',
						chatContent : $('#chatInput').val(),
						chatWriter : '${loginUser.userName}'
					 },
				success:function(result){
					if(result == 'success'){
						$('#chatInput').val('');
						
					}else{
						swal('오잉?',"다시 작성해주세요!", 'warning');
					}
					
				}, error:function(){
					swal('뭥미?', "비동기 요청 실패!", 'warning');
				}
			});
			
		}	
		else { // 사용자가 빈 문자열을 입력했을 경우 알러창 띄워주기
			swal('알림', "입력 후 작성해주세요!", 'warning');
		}
	}
	
	
	
	</script>
	
	
	<jsp:include page="../common/footer.jsp"/>

</body>
</html>