<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세조회</title>
<style>
	.content-area{
		width:1200px;
		height:1500px;
		margin: auto;
	}
	.text-area{
		width: 700px;
		margin: auto;
	}
	.title-area {
		height: 80px;
	}
	.writer-area{
		height: 60px;
	}
	.boardcontent-area{
		height: auto;
	}
	.upfile-area{
		height: 50px;
		text-align:right;
	}
	.boarea span:first-child {
		font-size: 20px;
		font-weight: bold;
	}
	.boarea span:last-child {
		margin-left:30px;
	}
	.reply-area{
		width: 700px;
		margin: auto;
		text-align:right;
	}
	.btn-area{
		text-align:right;
	}
	.btn-area button{
		margin-right: 10px;
	}
	.listBtn{
		width: 700px;
		margin: auto;
		text-align:center;
	}
</style>
</head>
<body>
	
	<jsp:include page="../common/header.jsp"/>
	
	<div class="content-area">
		<br>
		<br>
		<div align="center" style="margin-right:600px;">
			<h1>자유게시판</h1> 
		</div>
		<hr>
		<br>
		<div class="text-area">
			<div class="title-area boarea">
				<span>제목</span>
				<span>${b.boardTitle}</span>
			</div>
			<hr>
			<div class="writer-area boarea">
				<span>작성자</span>
				<span>${b.boardWriter}</span>	
			</div>
			<hr>
			<div class="boardcontent-area">
				<span>${b.boardContent}</span>
			</div>	
			<hr>	
			<div class="upfile-area boarea">
				<span>첨부파일</span>
				<span>
					<c:choose>
						<c:when test="${not empty b.originName}">
		               		<a href="${ b.changeName }" download="${ b.originName }">${ b.originName }</a>
						</c:when>
						<c:otherwise>
							첨부파일이 없습니다.
						</c:otherwise>
					</c:choose>
				</span>
			</div>	
			<hr>
			<c:if test="${loginUser.userNo == b.userNo}">
				<form action="" method="post" id="postForm">
					<input type="hidden" value="${ b.boardNo }" name="bno">
            		<input type="hidden" value="${ b.changeName }" name="filePath">
            		
					<div class="btn-area">
						<button class="btn btn-primary" onclick="postFormSubmit(1)">수정</button>
						<button class="btn btn-danger" onclick="postFormSubmit(2)">삭제</button>
					<br><br>
					</div>
				</form>
			</c:if>
		</div>
		<div align="center" style="margin-right:600px;">
			<h2>댓글</h2> 
		</div>
		<hr>
		<div class="text-area">
			<div id="replyList"></div>
		</div>
		<hr>
		<div class="reply-area">
			<c:choose>
				<c:when test="${ empty loginUser }">
					<textarea class="form-control" readonly cols="55" rows="2" style="resize:none; width:100%;">로그인 후 이용가능합니다.</textarea>
				</c:when>
				<c:otherwise>
					<textarea class="form-control" id="content" cols="55" rows="2" style="resize:none; width:100%; margin-bottom:5px;"></textarea>
					<button class="btn btn-primary" onclick="addReply();">댓글작성</button>
				</c:otherwise>
	       	</c:choose>
		</div>
		<br>
		<div class="listBtn">
			<button class="btn btn-primary" onclick="location.href='list.bo'">목록으로</button>
		</div>
	</div>
	
	<script>
	
	// 게시글 삭제 
	function postFormSubmit(num){
		if(num == 1){ // 수정하기 버튼 클릭 시 
			$('#postForm').attr('action', "updateForm.bo").submit();						
		}	
		else{ // 삭제하기 버튼 클릭 시
			if(confirm('정말로 삭제하시겠습니까?')){
				$('#postForm').attr('action', "delete.bo").submit();						
			}
		}
	}
	
	
	
	
	// 스크립트 영역 도달 시 댓글 조회 기능 호출
	$(function(){
		selectReplyList();
		
	});
	
	// 댓글 조회 기능
	function selectReplyList(){
		
		var loginUserNo = ${loginUser.userNo};
		$.ajax({
			url : 'replyList.bo',
			data : {bno : ${b.boardNo} },
			success : function(list){
				let value='';
				// 댓글이 없는 경우 
				if(list.length == 0){
					value += "<div>댓글이 없는 게시물입니다.</div>";					
				}
					for(let i in list){
						value += "<div>"
							   + "<span>" + list[i].replyWriter + "</span>"
							   + "<span>" + list[i].replyContent + "</span>"
							   + "<span class='createDate'>" + list[i].createDate + "</span>";
							   
						// 자신의 댓글에만 삭제 버튼 부여 & 자신의 댓글 판별을 위해 replyNo를 input type hidden으로 값 넘겨주자. 		   
						if(loginUserNo == list[i].userNo) { 
						 	value += "<button class='btn btn-primary' onclick='deleteReply("+list[i].replyNo+");'>삭제</button>"; 
						}
							value += "<hr>" 
								   + "</div>";
					}
					
				$('#replyList').html(value);
				$('#replyList span').attr('style', "margin-right:50px;");
				$('#replyList button').attr('style', "float: right;");
				$('.createDate').attr('style', "float: right;");
				
			}, error : function(){
				console.log('비동기요청 실패!');
			}
		});
	}
	
	// 댓글 작성 기능
	function addReply(){
		if($('#content').val().trim() != '') {
			// 사용자가 입력했을 경우에만 댓글 작성해주는 ajax
			$.ajax({
				url:'replyInsert.bo',
				data:{
						refBno : ${b.boardNo},
						replyContent : $('#content').val(),
						replyWriter : "${loginUser.userName}",
						userNo : "${loginUser.userNo}"
					 },
				success:function(result){
					if(result == 'success'){
						selectReplyList();
						$('#content').val('');
					}else{
						swal('오잉?',"다시 작성해주세요!", 'warning');
					}
					
				}, error:function(){
					swal('뭥미?', "댓글 작성 비동기 요청 실패!", 'warning');
				}
			});
			
		}
		else { // 사용자가 빈 문자열을 입력했을 경우 알러창 띄워주기
			swal('알림', "입력 후 작성해주세요!", 'warning');
		}
	}
	
	// 댓글 삭제 기능
	function deleteReply(rNo){
		// DB의 값과 비교할 댓글 번호와 회원번호 넘겨주기
		$.ajax({
			url:'replyDelete.bo',
			data:{
					replyNo : rNo
				 },
			success:function(result){
				if(result == 'success'){
					swal('알림', "삭제 성공!", 'warning');
					selectReplyList();
				}
			}, error:function(){
				swal('뭥미?', "댓글 삭제 비동기 요청 실패!", 'warning');
			}
		});
		
	}
	
	</script>
	
	<jsp:include page="../common/footer.jsp"/>
	
	
</body>
</html>