<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<style>
	.content-area{
		width:1200px;
		height:800px;
		margin: auto;
	}
	
	#boardList {
		width:800px;
	}
	#boardList th,td {
		text-align:center;
	}
	#boardList th:nth-child(1) {
		width:100px;
	}
	#boardList th:nth-child(2) {
		width:350px;
	}
	#boardList th:nth-child(3) {
		width:120px;
	}
	#boardList th:nth-child(4) {
		width:80px;
	}
	#boardList th:nth-child(5) {
		width:150px;
	}
	#boardList>tbody>tr:hover {cursor:pointer;}
	#search{
		text-align:right;
		padding-right:210px;  
	}
	#pagingArea {width:fit-content; margin:auto;}
	
	#reloadBtn{
		text-align:right;
		padding-right: 220px;
		
	}
	#reloadBtn button {
		font-size: 12px;
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
		<div id="reloadBtn">
			<button type="button" class="btn btn-primary" onclick="location.href='list.bo'" >초기화</button>
		</div>
		<br>
		
		<br><br>
		<!-- 제목으로 키워드 검색 -->
		<form id="searchForm" action="search.bo" method="get" align="center">
			<input type="hidden" name="currentPage" value="1">
			<div id="search">
				<c:if test="${empty keyword}">
					<input type="text" name="keyword" placeholder="제목으로 검색" id="searchText">
					<button id="searchBtn" class="btn btn-primary">검색</button>
				</c:if>
				<c:if test="${!empty keyword}">
					<input type="text" name="keyword" value="${keyword}" id="searchText">
					<button id="searchBtn" class="btn btn-primary">검색</button>
				</c:if>
			</div>
		</form>
		<br>
		
		<table id="boardList" class="table table-hover" align="center" >
			<thead>
				<tr>
					<th>
						<select name="condition" id="condition">
							<option value="all">[전체]</option>
							<option value="general">[일반]</option>
							<option value="mom">[맘]</option>
							<option value="suggest">[건의]</option>
							<option value="sell">[판매]</option>
							<option value="infor">[정보]</option>
						</select>
					</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>게시일</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${ empty oList }">
					<c:forEach var="b" items="${list}">
						<tr onclick="location.href='detail.bo?bno=${b.boardNo}'">
							<td>${b.boardCategory}</td>
							<td>${b.boardTitle}</td>
							<td>${b.boardWriter}</td>
							<td>${b.count}</td>
	                  		<td>${b.createDate}</td>
	                  	</tr>	
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach var="o" items="${oList}">
						<tr onclick="location.href='detail.bo?bno=${o.boardNo}'">
							<td>${o.boardCategory}</td>
							<td>${o.boardTitle}</td>
							<td>${o.boardWriter}</td>
							<td>${o.count}</td>
	                  		<td>${o.createDate}</td>
	                  	</tr>	
					</c:forEach>
				</c:otherwise>
			</c:choose>
				
				
			</tbody>
		</table>
		<br>
		<br>
		
		<c:if test="${ not empty loginUser }">
			<div align="center" style="margin-left:650px;">
				<button type="button" class="btn btn-primary" onclick="location.href='enrollForm.bo'">글쓰기</button>
			</div>
		</c:if>
		
		<div id="pagingArea">
			<ul class="pagination">                
                
				<c:choose>
					<c:when test="${ pi.currentPage eq 1 }">
						<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${empty keyword and empty option}">
								<li class="page-item"><a class="page-link" href="list.bo?cpage=${ pi.currentPage - 1 }">이전</a></li>
							</c:when>
							<c:when test="${empty keyword and not empty option}">
								<li class="page-item"><a class="page-link" href="option.bo?cpage=${ pi.currentPage - 1 }&option=${option}">이전</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="search.bo?cpage=${ pi.currentPage - 1 }&keyword=${keyword}">이전</a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:choose>
	                     	<c:when test="${p ne pi.currentPage}">
								<c:choose>
									<c:when test="${empty keyword and empty option}">
										<li class="page-item"><a class="page-link" href="list.bo?cpage=${p}">${p}</a></li>
									</c:when>
									<c:when test="${empty keyword and not empty option}">
										<li class="page-item"><a class="page-link" href="option.bo?cpage=${p}&option=${option}">${p}</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item"><a class="page-link" href="search.bo?cpage=${p}&keyword=${keyword}">${p}</a></li>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${empty keyword and empty option}">
										<li class="page-item active"><a class="page-link" href="list.bo?cpage=${p}">${p}</a></li>
									</c:when>
									<c:when test="${empty keyword and not empty option}">
										<li class="page-item active"><a class="page-link" href="option.bo?cpage=${p}&option=${option}">${p}</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item active"><a class="page-link" href="search.bo?cpage=${p}&keyword=${keyword}">${p}</a></li>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>	
						
					</c:forEach>
					
				<c:choose>
					<c:when test="${ pi.currentPage eq pi.maxPage }">
					 	<li class="page-item disabled"><a class="page-link" href="#">다음</a></li>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${empty keyword and empty option}">
								<li class="page-item"><a class="page-link" href="list.bo?cpage=${ pi.currentPage + 1 }">다음</a></li>
							</c:when>
							<c:when test="${empty keyword and not empty option}">
								<li class="page-item"><a class="page-link" href="option.bo?cpage=${ pi.currentPage + 1 }&option=${option}">다음</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="search.bo?cpage=${ pi.currentPage + 1 }&keyword=${keyword}">다음</a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
                    
			</ul>                
		</div>
		
	</div>
	<c:if test="${not empty option}">
		<script>
			$(function(){
				$('option[value=${option}]').attr('selected',true);
				
			})
		</script>
	</c:if>
	
	<script>
		$(function(){
			
			$('#condition').change(function(){
				var option = $("#condition option:selected").val();
				location.href='option.bo?currentPage=1&option=' + option;
			})	
		})
			
	</script>
	
	
	
	<jsp:include page="../common/footer.jsp"/>
	
</body>
</html>