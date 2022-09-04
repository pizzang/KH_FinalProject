<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리실 채팅방</title>
<style>
	.content-area{
		width:1200px;
		height:1000px;
		margin: auto;
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
	.onlineCheck{
		width: 200px;
		float:left;
		height:600px; 
		margin-left:20px;
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
	.userList {
		text-decoration: none;
		color : rgb(0,88,155);
		font-size : 25px;
	}
	.userList:hover{
		text-decoration: none;
		color : rgb(0,88,155);
		font-size : 27px;
		font-weight : bold;
		cursor : pointer;
	}
	.online-area{
		margin-left : 10px;
		margin-bottom : 10px;
	}
	
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	<br>
	<br>
	
	<div class="content-area">
	
		<div align="center" style="margin-right:600px;">
			<h1>관리실채팅</h1> 
		</div>
		<br><br><br>
	
		<div class="chat-area"></div>
	
		<div class="onlineCheck">
			<h4>회원목록</h4>
			<br>
			<c:forEach var='m' items="${MemberList}">
				<div class="online-area">
					<a class="userList" id="${m.userNo}" onclick="selectGuardChatList(${m.userNo});">${m.aptNo} ${m.userName}</a>
				</div>
			</c:forEach>
		</div>	
	
		<div>
			<input type="text" id="chatInput" name="chatContent">
			<button class="btn btn-primary" id="chatBtn" onclick="addGuardChat();">전송</button>
		</div>
	
	
	</div>
	
	<script>
	
	// 전역변수
	var userNo = '';
	
	
	// 회원간의 채팅 리스트 조회 ajax
	function selectGuardChatList(uNo){
		// 채팅 작성 시 필요한 uNo를 전역변수에 대입하여 사용할 것이다. 
		userNo = uNo;
		
		// 클릭시 사용자 이름 진하게 표시		
		$('.userList').css('font-weight','normal');
		$('#'+userNo).css('font-weight','bold');
		
		// 1초마다 ajax로 채팅내역조회하는 셋인터벌
		var interval = setInterval(function() {
			var loginUserName = '${loginUser.userName}';
			$.ajax({
				url : 'selectGuardChatList.ch',
				data : { userNo : uNo },
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
			
			// 다른 사용자 클릭 시 기존의 인터벌 끄기 & 채팅창 비워주기
			$('.userList').click(function(){
				clearInterval(interval);
				$('.chat-area').html('');
			})
			
		}, 1000);
	}
	
	
	// 관리실 채팅 작성용 ajax
	
	function addGuardChat(){
		
		if($('#chatInput').val().trim() != '') {
			// 사용자가 입력했을 경우에만 댓글 작성해주는 ajax
			$.ajax({
				url:'guardChatInsert.ch',
				data:{
						userNo : userNo,
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