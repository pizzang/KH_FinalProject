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
		height: 60px;
	}
	.writer-area{
		height: 60px;
	}
	.boardcontent-area{
		height: 600px;
	}
	.upfile-area{
		height: 120px;
		
	}
	.boarea span:first-child {
		font-size: 20px;
		font-weight: bold;
	}
	.boarea span:last-child {
		margin-left:30px;
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
	.updateBtn{
		text-align:right;
		width: 700px;
		margin: auto;
	}
	.category{
		font-size: 20px;
		font-weight: bold;
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
		
		<form id="updateForm" method="post" action="update.bo" enctype="multipart/form-data">
			<input type="hidden" name="boardNo" value="${ b.boardNo }">
			<div class="text-area">
				<div class="title-area boarea">
					<span>제목</span>
					<span>
						<input type="text" id="title" value="${ b.boardTitle }" name="boardTitle" required>
					</span>
				</div>
				<hr>
				<div class="writer-area boarea">
					<span>작성자</span>
					<span>
						<input type="text" id="writer" value="${ b.boardWriter }" name="boardWriter" readonly>
					</span>
				</div>
				<div>
					<span class="category">카테고리 :</span>
					<select name="boardCategory" id="condition">
						<option>[일반]</option>
						<option>[맘]</option>
						<option>[건의]</option>
						<option>[판매]</option>
						<option>[정보]</option>
					</select>
				</div>		
				<hr>
				<div class="boardcontent-area">
					<jsp:include page="summerNote.jsp"/>
				</div>
				<br><br><br><br><br><br>	
				<hr>	
				<div class="upfile-area boarea">
					<span>첨부파일:</span>
					<span>
                        <c:if test="${ not empty b.changeName }">
	                        <a href="${ b.changeName }" download="${ b.originName }">${ b.originName }</a>
                         	<input type="hidden" name="originName" value="${ b.originName }">
                         	<input type="hidden" name="changeName" value="${ b.changeName }">
                       	</c:if>	
                       	<br><br>
						<input type="file" id="upfile" name="reupfile">
					</span>
				</div>	
			</div>
			<div class="updateBtn">
				<button type="submit" class="btn btn-primary">수정하기</button>
				<button type="reset" class="btn">다시쓰기</button>
			</div>
		</form>
		<hr>
		<br>
		<div class="listBtn">
			<button class="btn btn-primary" onclick="location.href='list.bo'">목록으로</button>
		</div>
	</div>
	
	<script>
		$(function(){
			console.log('${b.boardCategory}');
			console.log($('#condition').val());
			
			$('#condition').val('${b.boardCategory}').attr('selected', true);
				
			
		})
	</script>
	
	
	<jsp:include page="../common/footer.jsp"/>
	
</body>
</html>