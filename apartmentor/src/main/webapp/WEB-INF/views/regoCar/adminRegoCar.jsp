<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 주차등록</title>
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
	
	.regoCar-dlt-btn, .regoCar-app-btn{
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
			<h4><a href="adminRegoCar.rg?currentPage=1&category=ALL"><u>입주민 주차등록 현황</u></a></h4>
			<h4><a href="adminVisitCar.car" style="color: black">방문차량 등록 현황</a></h4>
		</div>
		
		<br><br><br>
		
        <select name="category" id="category" onchange="selectCategory();" style="width: 120px; height: 30px; text-align: center; font-weight: bolder;">
          <option value="ALL">전체</option>
          <option value="WW">승인대기중</option>
          <option value="YY">승인완료</option>
        </select>
		
		<table class="table table-hover" id="regoCar-List" align="center">
			<thead>
				<tr style="width: 70px; height: 30px; text-align: center; font-weight: bolder;">
					<th>동/호수</th>
					<th>차량번호</th>
					<th>연락처</th>
					<th>승인현황</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="s" items="${list}" varStatus="status">
                     <tr style="width: 70px; height: 30px; text-align: center;">
                        <td>${s.aptNo }</td>
                        <td>${s.carNo }</td>
                        <td>${s.carPhone }</td>
                        <td>
                           <c:choose>
                              <c:when test="${s.status == 'W' }">
                                 <a class='regoCar-app-btn' align='center' style='width: 50px'>승인대기중</a>                                           
                              </c:when>
                           <c:otherwise>
                                                                       승인완료
                           </c:otherwise>                            
                           </c:choose>
                        </td>
                        <td>
                        	<a class='regoCar-dlt-btn' align='center' style='width: 50px'>삭제</a>	
                        </td>
                     </tr>
                  </c:forEach>
			</tbody>
		</table>
	
   <c:if test="${not empty category}">
      <script>
         $(function(){
            $('option[value=${category}]').attr('selected',true);
         })
      </script>
   </c:if>

	<script>
		// 카테고리별 리스트
	    function selectCategory(){
	        var category = $("#category option:selected").val();
	        location.href='adminRegoCar.rg?currentPage=1&category=' + category;
	     }
	
		// 승인완료 버튼 구현하기 
		 $(document).on("click",".regoCar-app-btn", function appRegoCar(){
	    	 $.ajax({
	    		url : "appRegoCar.rg",
	    		data : {
	    			carNo : $(this).parents("tr").find("td:eq(1)").text()
	    		},
	    		type : "post",
	    		success : function(result){
	     			// result값에 따라서 성공했으면 성공메시지 띄우기
	    			if(result > 0 ){
							swal({
							title : "승인완료 되었습니다.",
							text : "차량 등록 승인했습니다.",
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
	
		// 차량 등록 취소
	    $(document).on("click",".regoCar-dlt-btn", function deleteRegoCar(){
	    	
	    	 $.ajax({
	    		url : "deleteRegoCar.rg",
	    		data : {
	    			carNo : $(this).parents("tr").find("td:eq(1)").text()
	    		},
	    		type : "post",
	    		success : function(result){
	    			
	     			// result값에 따라서 성공했으면 성공메시지 띄우기
	    			if(result > 0 ){
							swal({
							title : "등록취소가 완료 되었습니다.",
							text : "차량 등록을 삭제했습니다.",
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
								<li class="page-item"><a class="page-link" href="adminRegoCar.rg?cpage=${ pi.currentPage - 1 }">이전</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="adminRegoCar.rg?cpage=${ pi.currentPage - 1 }&category=${category}">이전</a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:choose>
	                     	<c:when test="${p ne pi.currentPage}">
								<c:choose>
									<c:when test="${empty category}">
										<li class="page-item"><a class="page-link" href="adminRegoCar.rg?cpage=${p}">${p}</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item"><a class="page-link" href="adminRegoCar.rg?cpage=${p}&category=${category}">${p}</a></li>
									</c:otherwise>
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
								<li class="page-item"><a class="page-link" href="adminRegoCar.rg?cpage=${ pi.currentPage + 1 }">다음</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="adminRegoCar.rg?cpage=${ pi.currentPage + 1 }&category=${category}">다음</a></li>
							</c:otherwise>
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