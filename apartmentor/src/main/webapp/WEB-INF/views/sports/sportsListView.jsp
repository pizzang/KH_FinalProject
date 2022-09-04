<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이용내역 페이지</title>
<style>
   .content{
        background-color: rgb(240, 238, 233);
      color: black;
      width: 1200px;
      margin: auto;
      margin-top: 30px;
    }
    
    #reserveList-img{
      display : flex;
      justify-content: center;
   }
    
    .btn-div{
      display : flex;
      flex-direction: row;
      justify-content: space-around;
   }
   
   #pagingArea {
      width:fit-content; margin:auto;
   }
    
</style>
</head>
<body>

   <jsp:include page="../common/header.jsp" />

   <div class="content">
    
      <div id="reserveList-img">
         <label><img width="790px" height="300px" src="resources/img/main/aptm2.jpg"></label>
      </div>
       
      <br>
         
      <div class="btn-div">
         <a href="golf.sp" class="btn btn-lg btn-outline-secondary">실내 골프 연습장</a>
         <a href="miniGym.sp" class="btn btn-lg btn-outline-secondary">미니 GYM</a>
         <a href="sportsOptionView.sp?currentPage=1&category=ALL" class="query btn btn-lg btn-secondary">이용내역</a>
      </div>
                   
      <br><br>
      
      <table id="" class="table table-hover" align="center">
                <thead>
                    <tr style="width: 70px; height: 30px; text-align: center; font-weight: bolder;">
                     <th>
                     <select name="category" id="category" onchange="selectCategory();" style="width: 70px; height: 30px; text-align: center; font-weight: bolder;">
                        <option value="ALL">전체</option>
                        <option value="GF">골프</option>
                        <option value="MG">미니짐</option>
                     </select>
                  </th>
                        <th>예약자</th>
                        <th>신청일</th>
                        <th>신청시간</th>
                        <th>좌석번호</th>
                        <th>취소</th>
                    </tr>
                </thead>
                <tbody>
                      <c:forEach var="s" items="${list}">
                         <tr style="width: 70px; height: 30px; text-align: center;">
                            <td>
                               <c:choose>
                                  <c:when test="${s.facility == 'MG' }">
                                                                                  미니짐
                                  </c:when>
                              <c:otherwise>
                                 	골프
                              </c:otherwise>                            
                               </c:choose>
                            </td>
                            <td>${s.userName }</td>
                            <td>${s.startDay }</td>
                            <td>${s.startDate }</td>
                            <td>
                               <c:choose>
                                  <c:when test="${s.seatNo == 0}">
                                     	없음
                                  </c:when>
                                  <c:otherwise>
                                     ${s.seatNo }번
                                  </c:otherwise>
                               </c:choose>
                            </td>
                            <td><button value="${s.reserveNo }" onclick="deleteReserveSports(this.value);" >취소</button></td>
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
      // 카테고리별 정렬해주는 스크립트
      function selectCategory(){
         var category = $("#category option:selected").val();
         location.href='sportsOptionView.sp?currentPage=1&category=' + category;
      }
         
      // 취소버튼 누르면 삭제해주는 스크립트
      function deleteReserveSports(click_value){
         swal({
              title: "예약취소",
              text: "예약을 취소하실건가요?",
              icon: "warning",
              dangerMode: true,
              buttons: true,
            })
            .then(function(willDelete){
              if (willDelete) {
                 $.ajax({
                    url : "deleteReserveSports.sp",
                    data : {
                          reserveNo : click_value
                    },
                    success : function(){
                       swal("예약이 취소되었습니다!", {
                           icon: "success",
                         }).then(function(){
                            location.href="sportsOptionView.sp?currentPage=1&category=ALL&userNo=${loginUser.getUserNo()}";
                           });
                    },
                    error : function(){
                       console.log("실패");
                    }
               })
              } 
            });
      }
      
         
         
         
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
                     <li class="page-item"><a class="page-link" href="sportsList.sp?cpage=${ pi.currentPage - 1 }">이전</a></li>
                  </c:when>
                  <c:otherwise>
                     <li class="page-item"><a class="page-link" href="sportsOptionView.sp?cpage=${ pi.currentPage - 1 }&category=${category}">이전</a></li>
                  </c:otherwise>
               </c:choose>
            </c:otherwise>                   
         </c:choose>
         
		<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
			<c:choose>
                   	<c:when test="${p ne pi.currentPage}">
					<c:choose>
						<c:when test="${empty category}">
							<li class="page-item"><a class="page-link" href="sportsList.sp?cpage=${p}">${p}</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" href="sportsOptionView.sp?cpage=${p}&category=${category}">${p}</a></li>
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
                     <li class="page-item"><a class="page-link" href="sportsList.sp?cpage=${ pi.currentPage + 1 }">다음</a></li>
                  </c:when>
                  <c:otherwise>
                     <li class="page-item"><a class="page-link" href="sportsOptionView.sp?cpage=${ pi.currentPage + 1 }&category=${category}">다음</a></li>
                  </c:otherwise>
               </c:choose>
            </c:otherwise>
         </c:choose>
         </ul>
      </div>


   






   <br><br><br><br><br>
   </div>


<jsp:include page="../common/footer.jsp" />
</body>
</html>