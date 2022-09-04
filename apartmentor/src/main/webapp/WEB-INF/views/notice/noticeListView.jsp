<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- Bootstrap 라이브러리 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<style>

.noticeContent {
	width: 1200px;
	height: 800px;
	margin: auto;
}

h1 {
    text-align: left;
    margin-left: 80px;
}

#noticeList {
	width: 800px;
}

#noticeList th, td {
	text-align: center;
}

#noticeList th:nth-child(1) {
	width: 100px;
}

#noticeList th:nth-child(2) {
	width: 120px;
}

#noticeList th:nth-child(3) {
	width: 120px;
}

#noticeList th:nth-child(4) {
	width: 150px;
}


#noticeList>tbody>tr:hover {
	cursor: pointer;
}

#search {
	text-align: right;
	padding-right: 210px;
}

#pagingArea {
	width: fit-content;
	margin: auto;
}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<br>
<br>

<div class="noticeContent">

	<h1>공지사항</h1>
	
	<br>
	<br>
	
	<c:if test="${loginUser.userName eq '관리자'}">
		<div align="right" style="margin-right:200px; margin-bottom: 10px;">
			<button type="button" class="btn btn-info" onclick="location.href='enrollForm.notice'">글쓰기</button>
		</div>
	</c:if>
	
	
	<table id="noticeList" class="table table-hover" align="center" >			
		<thead>
			<tr>
				<th>
					<select name="noticeCategory" id="noticeCategory" style="width: 70px; height: 30px; text-align: center; font-weight: bolder;">
						<option value="전체">[전체]</option>
						<option value="공지">[공지]</option>
						<option value="알림">[알림]</option>
						<option value="행사">[행사]</option>
					</select>
				</th>
				<th style="width: 300px;">제목</th>
				<th>작성자</th>
				<th>게시일</th>
				</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty list}">
					<c:forEach var="n" items="${list}">
						<tr onclick="location.href='detail.notice?nno=${n.noticeNo}'">
							<td>${n.noticeCategoryValue}</td>
							<td>${n.noticeTitle}</td>
							<td>${n.userName}</td>
							<td>${n.createDate}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="4">공지사항이 없습니다</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>

		<c:if test="${not empty category}">
		<script>
			$(function(){
				$("#noticeList option[value=${category}]").attr("selected", true);  
			})
	    </script>
	</c:if>
	
	<script>
		$(function(){
			$('#noticeCategory').change(function(){
				var category = $("#noticeCategory option:selected").val();
				location.href='categoryList.notice?currentPage=1&category=' + category;
			})
		})
	</script>


	<div id="pagingArea">
		<ul class="pagination">
			<c:choose>
					<c:when test="${ pi.currentPage eq 1 }">
						<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${empty condition and empty category}">
								<li class="page-item"><a class="page-link" href="list.notice?cpage=${ pi.currentPage - 1 }">이전</a></li>
							</c:when>
							<c:when test="${not empty condition}">
								<li class="page-item"><a class="page-link" href="search.notice?cpage=${ pi.currentPage - 1 }&condition=${condition}&keyword=${keyword}">이전</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="categoryList.notice?cpage=${ pi.currentPage - 1 }&category=${category}">이전</a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:choose>
							<c:when test="${p ne pi.currentPage}">
								<c:choose>
									<c:when test="${empty condition and empty category}">
										<li class="page-item"><a class="page-link" href="list.notice?cpage=${p}">${p}</a></li>
									</c:when>
									<c:when test="${not empty condition}">
										<li class="page-item"><a class="page-link" href="search.notice?cpage=${p}&condition=${condition}&keyword=${keyword}">${p}</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item"><a class="page-link" href="categoryList.notice?cpage=${p}&category=${category}">${p}</a></li>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
									<div class="page-item active"><a class="page-link">${p}</a></div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
				<c:choose>
					<c:when test="${ pi.currentPage eq pi.maxPage }">
					 	<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${empty condition and empty category}">
								<li class="page-item"><a class="page-link" href="list.notice?cpage=${ pi.currentPage + 1 }">다음</a></li>
							</c:when>
							<c:when test="${not empty condition}">
								<li class="page-item"><a class="page-link" href="search.notice?cpage=${ pi.currentPage + 1 }&condition=${condition}&keyword=${keyword}">다음</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="categoryList.notice?cpage=${ pi.currentPage + 1 }&category=${category}">다음</a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
    	</ul>	
	</div>
	
	 <div id="search-area" align= "center">
     	<form action="search.notice" method="get">
        	<input type="hidden" name="currentPage" value="1">
                <select name="condition">
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                </select>
           <input type="text" name="keyword" value="${ keyword }">
           <button type="submit" class="btn btn-info">검색</button>
        </form>
    </div>
    
            
    <c:if test="${ not empty condition }">
	    <script>
	    	$(function(){
				$("#search-area option[value=${condition}]").attr("selected", true);        		
	        })
		</script>
	</c:if>

<jsp:include page="../common/footer.jsp"/>

</body>
</html>