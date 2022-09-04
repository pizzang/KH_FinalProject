<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 방문차량</title>
<style>
    .content{
        background-color: rgb(240, 238, 233);
		color: black;
		width: 1200px;
		margin: auto;
		margin-top: 30px;
    }
    
    .cate-div{
		display : flex;
		flex-direction: row;
		justify-content: space-around;
	}
	
	.visitCar-dlt-btn{
		cursor: pointer;
	}
	
   #pagingArea {
      width:fit-content; margin:auto;
   }
</style>
</head>
<body>

	
	<jsp:include page="../common/header.jsp" />
	
	<div class="content">
	
		<br><br><br>
		
		<h1 align="center">주차장 관리</h1>
		
		<br><br><br>
		
		<div class="cate-div">
			<h4><a href="adminRegoCar.rg?currentPage=1&category=ALL" style="color: black">입주민 주차등록 현황</a></h4>
			<h4><a href="adminVisitCar.car"><u>방문차량 등록 현황</u></a></h4>
		</div>
		
		<br><br><br>

		<table class="table table-hover" id="VisitCar-List" align="center">
			<thead>
				<tr style="width: 70px; height: 30px; text-align: center; font-weight: bolder;">
					<th>동/호수</th>
					<th>차량번호</th>
					<th>연락처</th>
					<th>방문목적</th>
					<th>방문일</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="s" items="${list}" varStatus="status">
                     <tr style="width: 70px; height: 30px; text-align: center;">
                        <td>${s.aptNo }</td>
                        <td>${s.carNo }</td>
                        <td>${s.visitCarPhone }</td>
                        <td>${s.purpose }</td>
                        <td>${s.visitCarDate }</td>
                        <td>
                        	<a class='visitCar-dlt-btn' align='center' style='width: 50px'>삭제</a>	
                        </td>
                     </tr>
                  </c:forEach>
			</tbody>
		</table>





		<script>
			// 차량 등록 취소
		    $(document).on("click",".visitCar-dlt-btn", function deleteVisitCar(){
		    	//console.log($(this).parents("tr").find("td:eq(2)").text());
		    	$.ajax({
		    		url : "deleteVisitCar.car",
		    		data : {
		    			visitCarDate : $(this).parents("tr").find("td:eq(4)").text(),
		    			carNo : $(this).parents("tr").find("td:eq(1)").text()
		    		},
		    		type : "post",
		    		success : function(result){
		    			
		     			// result값에 따라서 성공했으면 성공메시지 띄우기
		    			if(result > 0 ){
								swal({
								title : "방문차량 삭제가 완료 되었습니다.",
								text : "방문차량을 삭제했습니다.",
							    	icon  : "success",
							    	closeOnClickOutside : false
							}).then(function(){
									location.reload();
								});
		    			} 
		    			
		    		},
		    		error : function(){
							swal({
							title : "오류입니다. 관리자에게 문의하세요",
						    	icon  : "error",
						    	closeOnClickOutside : false
						});
		    		}
		    	}); 
		    });
		</script>

		<div id="pagingArea">
         <ul class="pagination">
                
         <c:choose>
            <c:when test="${ pi.currentPage eq 1 }">
               <li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
            </c:when>
            <c:otherwise>
               <c:choose>
                  <c:when test="${empty category}">
                     <li class="page-item"><a class="page-link" href="adminVisitCar.car?cpage=${ pi.currentPage - 1 }">이전</a></li>
                  </c:when>
               </c:choose>
            </c:otherwise>                   
         </c:choose>
         
		<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
			<c:choose>
                   	<c:when test="${p ne pi.currentPage}">
					<c:choose>
						<c:when test="${empty category}">
							<li class="page-item"><a class="page-link" href="adminVisitCar.car?cpage=${p}">${p}</a></li>
						</c:when>
					</c:choose>
				</c:when>
				<c:otherwise>
					<li class="page-item active"><a class="page-link">${p}</a></li>
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
                     <li class="page-item"><a class="page-link" href="adminVisitCar.car?cpage=${ pi.currentPage + 1 }">다음</a></li>
                  </c:when>
               </c:choose>
            </c:otherwise>
         </c:choose>
         </ul>
      </div>











	<br><br><br>
	</div>
	<jsp:include page="../common/footer.jsp" />

</body>
</html>