<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표 등록</title>
<style>
    .wrap{
        width:1200px; margin:auto;
    }

</style>
</head>

<body>
    <jsp:include page="../common/header.jsp" />
    <form action="insert.vote" method="post" enctype="multipart/form-data">
        <div class="wrap">
            <div style="margin-left:200px">
                <br><br>
                <h1>투표 등록</h1>
                <br><br>

                투표 제목<br>
                <input type="text" size="60" name="voteTitle" placeholder="투표 제목을 입력하세요." required>
                <div class="addItems">
                    <br>
                    항목 입력 <br>
                    <input type="text" size="50" name="itemName" placeholder="항목을 입력하세요." required>
                    <input type="file" name="upfile">
                    <br>
                    <input type="text" size="50" name="itemName" placeholder="항목을 입력하세요." required>
                    <input type="file" name="upfile">
                    <br>
                </div>
                <br>
                
                <input type="button" class="btn btn-info" id="btnAdd" value="항목추가"><br>
                <hr>
                투표시작일 <input type="date" id="voteStart" name="voteStart" min="" required> <br>
                투표마감일 <input type="date" id="voteEnd" name="voteEnd" min="" required> <br>

                복수선택 가능여부 <input type="checkbox" id="voteType" name="voteType" value="0" id=""> <br>

                <button class="btn submit" type="submit">등록</button> <button type="button" id="backBtn" class="btn btn-outline-info" onclick="location.href='list.vote'">취소</button>
            </div>

            
        </div>  
    </form> 

    <script>
        $(function() {                
                 $('#btnAdd').click (function () {                                        
                     $('.addItems').append (                        
                         '<input type="text" size="50" name="itemName" placeholder="항목을 입력하세요." required>  <input type="file" name="upfile"> <input type="button" value="항목제거" class="btn btn-outline-info btnRemove"> <br>'                    
                     ); // end append                            
                     $('.btnRemove').on('click', function () { 
                         $(this).prev().prev().remove(); // remove the textbox
                         $(this).prev().remove(); // remove the textbox
                         $(this).next().remove(); // remove the <br>
                         $(this).remove(); // remove the button
                     });
                 }); // end click 
                 
        }); // end ready   
        
        $('#voteStart').click(function(){
                        var date = new Date();
                        var year = date.getFullYear();
                        var month = ("0" + (1 + date.getMonth())).slice(-2);
                        var day = ("0" + date.getDate()).slice(-2);

                        var today =  year + '-' + month  + '-' + day;
                        $('#voteStart').attr('min', today);
        })  // 시작일 선택시 오늘날짜를 기준으로 이전날짜는 선택불가
        
        $('#voteEnd').click(function(){
            $('#voteEnd').attr('min', $('#voteStart').val());
        })  // 마감일 선택시 시작일기준으로 이전날짜는 선택불가
                
        $('#voteType').click(function(){
            if($(this).is(":checked")){
                $('#voteType').val('1');
            } else {
                $('#voteType').val('0');

            }
        });
     </script>

</body>
</html>