<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주민투표</title>
<style>
    .wrap{
        width:1200px; margin:auto;
    }
    #voteList {
	width: 800px;
    }

    #voteList th, td {
        text-align: center;
    }

    #voteList th:nth-child(1) {
        width: 100px;
    }

    #voteList th:nth-child(2) {
        width: 120px;
    }

    #voteList th:nth-child(3) {
        width: 120px;
    }

    #voteList th:nth-child(4) {
        width: 150px;
    }


    #voteList>tbody>tr:hover {
        cursor: pointer;
    }
    #pagingArea {
	width: fit-content;
	margin: auto;
}
</style>

</head>
<body>
    <jsp:include page="../common/header.jsp" />
    <br>
    <br>
    <div class="wrap">
		<div align="center" style="margin-right:600px;">
			<h1>주민 투표</h1> 
		</div>
        <br>
        <div style="margin-left:77%">
            <c:if test="${loginUser.userId eq 'admin'}">
                <button type="button" class="btn btn-info" align="right" onclick="location.href='enroll.vote'">글쓰기</button>
            </c:if>
        </div>

        <div style="margin-left:19%">
            <select name="voteCategory" id="voteCategory" style="width: 95px; height: 30px; text-align: center; font-weight: bolder; margin-bottom:4px;">
                <option value="전체">[전체]</option>
                <option value="진행중">[진행중]</option>
                <option value="진행예정">[진행예정]</option>
                <option value="진행완료">[진행완료]</option>
            </select>
            
        </div>



        <table id="voteList" class="table table-hover" align="center" >			
            <thead>

                <tr>
                    <th>투표현황</th>
                    <th style="width: 300px;">제목</th>
                    <th style="width: 160px;">투표기한</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty list}">
                        <c:forEach var="v" items="${list}">
                            <tr onclick="location.href='detail.vote?voteNo=${v.voteNo}&userNo=${loginUser.userNo}'">
                                <td>
                                	<c:choose>
                                	<c:when test="${v.status eq 'W'}"> [진행예정] </c:when>
                                	<c:when test="${v.status eq 'Y'}"> [진행중] </c:when>
                                	<c:when test="${v.status eq 'N'}"> [진행완료] </c:when>
                                	</c:choose>
                                	
                                </td>
                                <td>${v.voteTitle}</td>
                                <td>
                                    [${v.voteStart} ~ ${v.voteEnd}]
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4">투표가 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <div id="pagingArea">
            <ul class="pagination">
                <c:choose>
                        <c:when test="${ pi.currentPage eq 1 }">
                            <li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${empty category}">
                                    <li class="page-item"><a class="page-link" href="list.vote?cpage=${ pi.currentPage - 1 }">이전</a></li>
                                </c:when>
                                <c:when test="${not empty keyword}">
                                    <li class="page-item"><a class="page-link" href="search.vote?cpage=${ pi.currentPage - 1 }&keyword=${keyword}">이전</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="categoryList.vote?cpage=${ pi.currentPage - 1 }&category=${category}">이전</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                    
                        <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                            <c:choose>
                                <c:when test="${p ne pi.currentPage}">
                                    <c:choose>
                                        <c:when test="${empty category}">
                                            <li class="page-item"><a class="page-link" href="list.vote?cpage=${p}">${p}</a></li>
                                        </c:when>
                                        <c:when test="${not empty keyword}">
                                            <li class="page-item"><a class="page-link" href="search.vote?cpage=${p}&keyword=${keyword}">${p}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item"><a class="page-link" href="categoryList.vote?cpage=${p}&category=${category}">${p}</a></li>
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
                                <c:when test="${empty category}">
                                    <li class="page-item"><a class="page-link" href="list.vote?cpage=${ pi.currentPage + 1 }">다음</a></li>
                                </c:when>
                                <c:when test="${not empty keyword}">
                                    <li class="page-item"><a class="page-link" href="search.vote?cpage=${ pi.currentPage + 1 }&keyword=${keyword}">다음</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="categoryList.vote?cpage=${ pi.currentPage + 1 }&category=${category}">다음</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
            </ul>	
        </div>

        <div id="search-area" align="center">
            <form action="search.vote" method="get">
               <input type="hidden" name="currentPage" value="1">
              <input type="text" name="keyword" placeholder="제목으로 검색" value="${keyword}">
              <button type="submit" class="btn btn-info">검색</button>
           </form>
       </div>

        
        <c:if test="${not empty category}">
            <script>
                $(function(){
                    $("#voteCategory option[value=${category}]").attr("selected", true);  
                })
            </script>
        </c:if>
        
        <script>
            $(function(){
                $('#voteCategory').change(function(){
                    var category = $("#voteCategory option:selected").val();
                    location.href='categoryList.vote?currentPage=1&category=' + category;
                })
            })
        </script>


    <jsp:include page="../common/footer.jsp"/>


</body>
</html>