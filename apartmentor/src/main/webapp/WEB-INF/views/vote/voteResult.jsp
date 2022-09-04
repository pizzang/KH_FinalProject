<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표결과</title>
<style>
    .wrap{
        width:1200px; margin:auto; 
    }

    #voteItemList tr{
        border: 1px solid gray;
    }
    #voteItemList{
        width: 600px;
    }

</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
    <br>
    <br>
    <div class="wrap">
        <div style="margin-left:250px; margin-bottom:none;">
            <c:if test="${v.status == 'Y'}">
                <span style="color:blue; margin: 0%; font-size: 25px;">[진행중]</span>
            </c:if>
            <c:if test="${v.status == 'N'}">
                <span style="color:gray; margin: 0%; font-size: 25px;">[완료]</span>
            </c:if>
            <c:if test="${v.status == 'W'}">
                <span style="color:red; margin: 0%; font-size: 25px;">[예정]</span>
            </c:if>
            <h1 style="line-height: 1;">${v.voteTitle}</h1>
        <br>
        </div>
        <div style="margin-left:250px">

            총 투표자 : ${totalCount}명<br>
            투표기한 : ${v.voteStart} ~ ${v.voteEnd}
            <span style="margin-left:275px;"><button type="button" style="margin-bottom: 4px;" id="backBtn" class="btn btn-outline-info" onclick="location.href='list.vote'">목록</button></span>

            <table id="voteItemList">
                <c:forEach var="vi" items="${vi}">
                    <c:set var="totalCount" value="${totalCount}"/>
                    <c:set var="itemCount" value="${vi.itemCount}"/>
                    <fmt:parseNumber var="ratio" value="${itemCount/totalCount*100}" integerOnly="true" />
                    <tr>
                        <td width="1%;" align="center">
                            <c:if test="${vi.changeName != 'null'}">
                                <img src="${vi.changeName}" width="80px;" height="80px;" alt="">
                            </c:if>
                        </td>
                        <td width="30%" height="75px" style="font-size: 20px;" align="center">
                                ${vi.itemName}
                        </td>
                            <td>
                            <table width="${ratio}%">
                                <tr>
                                    <td bgcolor="#00589b" height="20" style="color:white; font-size:20px;">${ratio}%</td>
                                </tr>
                            </table>
                            </td>
                        <td width="10%" align="center">${vi.itemCount}표</td>
                    </tr>	
                </c:forEach>
            </table>
            <br>
            <div style="margin-left:25%;">
                <button type="submit" class="btn submit" id="reVote">다시 투표하기</button>
                <c:if test="${loginUser.userId eq 'admin'}">
                    <button type="button" class="btn btn-outline-info" id="deleteVote" onclick="location.href='delete.vote?voteNo=${v.voteNo}'">투표삭제</button>
                </c:if>
            </div>
        </div>
         <jsp:include page="../common/footer.jsp"/>
    </div>

    <script>
            $('#reVote').click(function(){
                location.href = 're.vote?voteNo=${v.voteNo}&userNo=${loginUser.userNo}'
            });

        $(function(){
            if("${v.status}" != 'Y'){
                $('#reVote').attr('disabled', true);
            }
        })
    </script>

</body>
</html>