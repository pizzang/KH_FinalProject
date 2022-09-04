<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방문 예약 확인</title>
<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- Bootstrap 라이브러리 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
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

#visitList {
	width: 800px;
}

#visitList th, td {
	text-align: center;
}

#visitList th:nth-child(1) {
	width: 100px;
}

#visitList th:nth-child(2) {
	width: 120px;
}

#visitList th:nth-child(3) {
	width: 120px;
}

#visitList th:nth-child(4) {
	width: 150px;
}


#visitList>tbody>tr:hover {
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

<div class="visitContent">

	<h1>방문 예약 확인</h1>
	
	<br>
	<br>

	<table id="visitList" class="table table-hover" align="center" >
		<thead>
			<tr>
				<th>
					<select name="visitCategory" id="visitCategory" style="width: 70px; height: 30px; text-align: center; font-weight: bolder;">
						<option value="전체">전체</option>
						<option value="가스">가스</option>
						<option value="난방">난방</option>
						<option value="소독">소독</option>
						<option value="수도">수도</option>
						<option value="전기">전기</option>
					</select>
				</th>
				<th>동·호수</th>
				<th>
					<select name="statusCategory" id="statusCategory" style="width: 100px; height: 30px; text-align: center; font-weight: bolder;">
						<option value="전체">예약 전체</option>
						<option value="대기">예약 대기</option>
						<option value="취소대기">취소 대기</option>
						<option value="승인">예약 승인</option>
						<option value="취소">예약 취소</option>
					</select>
				</th>
				<th>신청일</th>
				</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty list}">
					<c:forEach var="v" items="${list}">
						 <tr onclick="location.href='detail.visit?vno=${v.visitNo}'">
							<td>${v.visitValue}</td>
							<td>${v.aptNo}</td>
							<td>${v.visitStatusValue}</td>
							<td>${v.createDate}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<td colspan="4">예약 내역이 없습니다</td>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	
	<script>
		$(function(){
			$('#visitCategory').change(function(){
				var category = $("#visitCategory option:selected").val();
				location.href='categoryList.visit?currentPage=1&category=' + category;
			})
		})
	</script>
	
	<c:if test="${not empty category}">
		<script>
			$(function(){
				$("#visitList option[value=${category}]").attr("selected", true);  
			})
	    </script>
	</c:if>
	
	
	<script>
		$(function(){
			$('#statusCategory').change(function(){
				var statusCategory = $("#statusCategory option:selected").val();
				location.href='statusList.visit?currentPage=1&statusCategory=' + statusCategory;
			})
		})
	</script>
		<c:if test="${not empty statusCategory}">
		<script>
			$(function(){
				$("#visitList option[value=${statusCategory}]").attr("selected", true);  
			})
	    </script>
	</c:if>

		
	
	<div id="pagingArea">
		<ul class="pagination">
			<c:choose>
					<c:when test="${ pi.currentPage eq 1 }">
						<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${empty category and empty statusCategory}">
								<li class="page-item"><a class="page-link" href="list.visit?cpage=${ pi.currentPage - 1 }">이전</a></li>
							</c:when>
							<c:when test="${not empty statusCategory}">
								<li class="page-item"><a class="page-link" href="statusList.visit?cpage=${ pi.currentPage - 1 }&statusCategory=${statusCategory}">이전</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="categoryList.visit?cpage=${ pi.currentPage - 1 }&category=${category}">이전</a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:choose>
							<c:when test="${p ne pi.currentPage}">
								<c:choose>
									<c:when test="${empty category and empty statusCategory}">
										<li class="page-item"><a class="page-link" href="list.visit?cpage=${p}">${p}</a></li>
									</c:when>
									<c:when test="${not empty statusCategory}">
										<li class="page-item"><a class="page-link" href="statusList.visit?cpage=${p}&statusCategory=${statusCategory}">${p}</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item"><a class="page-link" href="categoryList.visit?cpage=${p}&category=${category}">${p}</a></li>
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
							<c:when test="${empty category and empty statusCategory}">
								<li class="page-item"><a class="page-link" href="list.visit?cpage=${ pi.currentPage + 1 }">다음</a></li>
							</c:when>
							<c:when test="${not empty statusCategory}">
								<li class="page-item"><a class="page-link" href="statusList.visit?cpage=${ pi.currentPage + 1 }&statusCategory=${statusCategory}">다음</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="categoryList.visit?cpage=${ pi.currentPage + 1 }&category=${category}">다음</a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
    	</ul>	
	</div>



</div>

<jsp:include page="../common/footer.jsp"/>

</body>
</html>