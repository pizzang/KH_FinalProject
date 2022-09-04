<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.content-area{
		width:1200px;
		height:800px;
		margin: auto;
	}
	#memberTable{
		width: 800px;
		margin:auto;
		text-align: center;
	}
	thead tr{background-color: #e9ecef}
	tbody tr{height: 30px}
	th{height: 20px;}
	td{height: 20px;}
	
	.th1{width: 100px}
	.th2{width: 200px}
	.th3{width: 190px}
	.th4{width: 200px}
	.th5{width: 110px}
	
	.btn1{
		width: 70%;
		height:100%;
		margin: auto;
		
	}
	table {
	align-content: center;
	align-items: center;
	align-self: center;
	}
	.height50{height: 40%}
	.b1{font-size: 20px}
	#pagingArea {
		width:fit-content; 
		margin:auto;
		display: flex;
		flex-direction: row;
		justify-content: center;
	}
	#search{
		float:right;
		margin-right: 199px;
	}	
	#condition{height: 30px;}
</style>
<jsp:include page="../common/header.jsp"/>
</head>
<body>
	<br><br>
	<div align="center" style="margin-right:632px;">
			<h1>회원 관리</h1> 
	</div>
	<br><br><br>
	
	
	<div class="mainWrap">		
	<form id="searchForm" action="search.me" method="get" >
		<input type="hidden" name="currentPage" value="1">
		<div id="search">
			<select name="condition" id="condition">
				<option value="A">[전체]</option>
				<option value="Y">[일반 회원]</option>
				<option value="W">[승인 대기]</option>
			</select>
			<c:if test="${empty keyword}">
				<input type="text" name="keyword" placeholder="이름으로 검색" id="searchText">
				<button id="searchBtn" class="btn btn-primary">검색</button>
			</c:if>
			<c:if test="${!empty keyword}">
				<input type="text" name="keyword" value="${keyword}" id="searchText">
				<button id="searchBtn" class="btn btn-primary">검색</button>
			</c:if>
		</div>
	</form>
	<br><br>
		<table id="memberTable"class="table table-bordered">
			<thead>
				<tr>
					<th class="th1" rowspan="2"><p class="height50">회원번호</p></th>
					<th class="th2">이름</th>
					<th class="th3">아이디</th>
					<th class="th4">생년월일</th>
					<th class="th5" rowspan="2"><p class="height50">승인 / 정지</p></th>			
				</tr>
				<tr>
					<th>세대번호</th>
					<th>번호</th>
					<th>이메일</th>		
				</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${empty mList and empty sList}">
					<tr> 
						<th colspan="5">등록된 회원이 없습니다! </th>
					</tr> 
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${empty sList}">
							<c:forEach var="m" items="${mList}">
								<tr>
									<td rowspan="2"><br>${m.userNo}</td>
									<td>${m.userName}</td>
									<td>${m.userId}</td>
									<td>${m.birthday}</td>
									<td rowspan="2">
										<c:choose>
											<c:when test="${m.status eq 'W'}">
												<button class="btn btn-primary btn1 modal1" data-toggle="modal" data-target="#myModal5" data-id="${m.userNo}">
											  		<b class="b1">승인</b>
												</button>
											</c:when>
											<c:otherwise>
												<button class="btn btn-danger btn1 modal2" data-toggle="modal" data-target="#myModal6" data-id="${m.userNo}">
											  		<b class="b1">정지</b>
												</button>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr>
									<td>${m.aptNo}</td>
									<td>${m.phone}</td>
									<td>${m.email}</td>					
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach var="s" items="${sList}">
									<tr>
										<td rowspan="2"><br>${s.userNo}</td>
										<td>${s.userName}</td>
										<td>${s.userId}</td>
										<td>${s.birthday}</td>
										<td rowspan="2">
											<c:choose>
												<c:when test="${s.status eq 'W'}">
												<button type="button" class="btn btn-primary btn1 modal1" data-toggle="modal" data-target="#myModal5" data-id="${s.userNo}">
												  <b class="b1">승인</b>
												</button>
												</c:when>
												<c:otherwise>
												<button type="button" class="btn btn-danger btn1 modal2" data-toggle="modal" data-target="#myModal6" data-id="${s.userNo}">
												  <b class="b1">정지</b>
												</button>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
									<tr>
										<td>${s.aptNo}</td>
										<td>${s.phone}</td>
										<td>${s.email}</td>					
									</tr>
								</c:forEach>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>	
			</tbody>
		</table>
		<br>
		<div id="pagingArea">
			<c:choose>
				<c:when test="${empty keyword}">
					<c:choose>
						<c:when test="${ pi.currentPage eq 1 }">
							<div class="page-item disabled"><a class="page-link" href="#">이전</a></div>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${ empty condition}">
									<div class="page-item"><a class="page-link" href="list.me?cpage=${ pi.currentPage - 1 }">이전</a></div>
								</c:when>
								<c:otherwise>
									<div class="page-item"><a class="page-link" href="search.me?cpage=${ pi.currentPage - 1 }&condition=${condition}">이전</a></div>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:choose>
							 <c:when test="${p ne pi.currentPage}">
							 <c:choose>
								<c:when test="${ empty condition}">
									<div class="page-item"><a class="page-link" href="list.me?cpage=${p}">${p}</a></div>
								</c:when>
								<c:otherwise>
									<div class="page-item"><a class="page-link" href="search.me?cpage=${p}&condition=${condition}">${p}</a></div>
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
						 	<div class="page-item disabled"><a class="page-link" href="#">다음</a></div>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${ empty condition}">
									<div class="page-item"><a class="page-link" href="list.me?cpage=${ pi.currentPage + 1 }">다음</a></div>
								</c:when>
								<c:otherwise>
									<div class="page-item"><a class="page-link" href="search.me?cpage=${ pi.currentPage + 1 }&condition=${condition}">다음</a></div>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${ pi.currentPage eq 1 }">
							<div class="page-item disabled"><a class="page-link" href="#">이전</a></div>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${empty condition}">
									<div class="page-item"><a class="page-link" href="list.me?cpage=${ pi.currentPage - 1 }">이전</a></div>
								</c:when>
								<c:otherwise>
									<div class="page-item"><a class="page-link" href="search.me?cpage=${ pi.currentPage - 1 }&condition=${condition}&keyword=${keyword}">이전</a></div>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:choose>
							<c:when test="${p ne pi.currentPage}">
								<c:choose>
									<c:when test="${empty condition}">
										<div class="page-item"><a class="page-link" href="list.me?cpage=${p}">${p}</a></div>
									</c:when>
									<c:otherwise>
										<div class="page-item"><a class="page-link" href="search.me?cpage=${p}&condition=${condition}&keyword=${keyword}">${p}</a></div>
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
						 	<div class="page-item disabled"><a class="page-link" href="#">다음</a></div>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${empty condition}">
									<div class="page-item"><a class="page-link" href="list.me?cpage=${ pi.currentPage + 1 }">다음</a></div>
								</c:when>
								<c:otherwise>
									<div class="page-item"><a class="page-link" href="search.me?cpage=${ pi.currentPage + 1 }&condition=${condition}&keyword=${keyword}">다음</a></div>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	
	<c:if test="${not empty condition}">
        <script>
            $(function(){
                $('option[value=${condition}]').attr('selected',true);

            })
        </script>
    </c:if>

	<!-- 회원 승인 모달 -->
	<div class="modal" id="myModal5">
		<div class="modal-dialog">
	    	<div class="modal-content">
	      		<div class="modal-footer">
	      			<div style="width: 100%; margin-bottom: 30px;" >
	      				<button type="button" class="close" data-dismiss="modal">&times;</button>
	      			</div>
	      			<h4 style="margin-left: 70px; width: 100%; margin-bottom: 30px;">해당 회원을 승인 하시겠습니까?</h4>
	      			<form action="approval.me" method="post">
		      			<input type="hidden" id="userNo1" name="userNo">
				        <button type="submit" class="btn btn-primary">승인</button>
	    		    </form>
	      		</div>
	    	</div>
	  	</div>
	</div>
	
	<!-- 회원 정지 모달 -->
	<div class="modal" id="myModal6">
		<div class="modal-dialog">
	    	<div class="modal-content">
	      		<div class="modal-footer">
	      			<div style="width: 100%; margin-bottom: 30px;" >
	      				<button type="button" class="close" data-dismiss="modal">&times;</button>
	      			</div>
	      			<h4 style="margin-left: 70px; width: 100%; margin-bottom: 30px;">해당 회원을 정지 하시겠습니까?</h4>
	      			<form action="suspension.me" method="post">
		      			<input type="hidden" id="userNo2" name="userNo"> 
				        <button type="submit" class="btn btn-danger">정지</button>
	    		    </form>
	      		</div>
	    	</div>
	  	</div>
	</div>
	
	<script>
	$(".modal1").click(function(){
		var data = $(this).data('id');
		$("#userNo1").val(data);
	});
	$(".modal2").click(function(){
		var data = $(this).data('id');
		$("#userNo2").val(data);
	});
	</script>
	

</body>
<jsp:include page="../common/footer.jsp"/>
</html>