<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 작성 페이지</title>

<style>
	.content-area{
		width:1200px;
		height:1300px;
		margin: auto;
	}
	.text-area{
		width: 700px;
		margin: auto;
	}
	.title-area {
		height: 80px;
	}
	.title-area input{
		width: 300px;
		height: 40px;
	}
	.subTitle{
		font-size: 20px;
		font-weight: bold;
	}
	
	
</style>	
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	<br>
	<br>

	<div class="content-area">
	
		<div align="center" style="margin-right:600px;">
			<h1>자유게시판</h1> 
		</div>
		<hr>
		<br>
		<div class="text-area">
			<form action="insert.bo" method="post" enctype="multipart/form-data">
				<input type="hidden" name="userNo" value="${loginUser.userNo}">
				<input type="hidden" name="boardWriter" value="${loginUser.userName}">
				<div class="selectCategory">
					<span class="subTitle">카테고리 : </span>
					<select name="boardCategory" id="condition">
						<option value="general">[일반]</option>
						<option value="mom">[맘]</option>
						<option value="suggest">[건의]</option>
						<option value="sell">[판매]</option>
						<option value="infor">[정보]</option>
					</select>
				</div>
				<div class="title-area boarea">
					<span class="subTitle">제목  : </span>
					<input type='text' name="boardTitle" required>
				</div>
				<hr>
				<div class="boardcontent-area">
					<div class="subTitle">내용  : </div>
					
					<jsp:include page="summerNote.jsp"/>
					
				</div>	
				<hr>	
				<div class="upfile-area boarea">
					<span class="subTitle">첨부파일 :</span>
					<input type="file" class="form-control-file border" name="upfile">
				</div>
				<br>	
				<div align="right">
                    <button type="submit" class="btn btn-primary">등록하기</button>
                    <button type="reset" class="btn btn-danger" onclick="history.back();">취소하기</button>
                </div>
			</form>
			<hr>
		</div>

	</div>
	
	<jsp:include page="../common/footer.jsp"/>

</body>
</html>