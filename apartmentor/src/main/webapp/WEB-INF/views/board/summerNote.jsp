<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>썸머노트</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- 서머노트 css -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<!-- popper.js -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<!-- 서머노트 js -->
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
</head>
<body>
	<textarea id="summernote" name="boardContent" required>${ b.boardContent }</textarea>
    
    <script>
	    $(document).ready(function() {
	    	//여기 아래 부분
	    	$('#summernote').summernote({
	    		  height: 600,                 // 에디터 높이
	    		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
	    		  lang: "ko-KR",					// 한글 설정
	    		  placeholder: '내용을 작성해주세요.',
	              disableResizeEditor: true,	// 크기 조절 기능 삭제
	              toolbar: [
			                ['fontname', ['fontname']],
			                ['fontsize', ['fontsize']],
			                ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			                ['color', ['forecolor','color']],
			                ['table', ['table']],
			                ['para', ['ul', 'ol', 'paragraph']],
			                ['height', ['height']],
			                ['insert',['picture','link','video']],
			                ['view', ['fullscreen', 'help']]
			               ],
	            fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
	            fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
	    	});
	    });
    </script>
</body>
</html>