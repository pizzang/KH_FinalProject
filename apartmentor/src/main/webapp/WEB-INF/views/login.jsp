<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    
    <!-- JavaScript -->
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
	
	<!-- CSS -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
	<!-- Default theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>
	<!-- Semantic UI theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/semantic.min.css"/>
	
   	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <title>Document</title>
    <style>
    
        	@font-face {
		    font-family: 'InfinitySans-RegularA1';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/InfinitySans-RegularA1.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
    
    	div{
            /*  border: 1px solid red;  */
            font-family: 'InfinitySans-RegularA1';
            
        }
        .loginWrap{
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 500px;
            height: 410px;
            margin: auto;
            margin-top: 100px;
        }
        .formWrap{
            margin: 5px;
            padding: 20px;
            width: 300px;
            height: 230px;
        }
        #loginid,#loginpwd{
            height: 30px;
            width: 250px;
            font-size: 7px;
            margin-bottom: 10px;
        }
        #logo{
            color: rgb(0,88,155);
            font-size: 50px
        }
        #loginbtn{
            border: none;
            width: 250px;
            height: 30px;
            background-color: rgb(0,88,155);
            color: white;
            font-weight: bold;
            font-size: 20px;
            cursor: pointer;
        }
        #loginbtn:hover{
            opacity:0.8;
        }
        #modalbtn, #modalbtn button{
            font-size: 5px;
            background: none;
            border: none;
            cursor: pointer;
            color: gray;
        }
        #modalbtn button:hover{
            color: black;
        }

        .modal-body input{
            margin-top: 7.5px;
            height: 20px;
            width: 100%;
            font-size: 20px;
            border: none;
        }
        .modal-body input:focus {outline:none;}
        .modal-body b{
            font-size: 20px;
            margin-bottom: 30px;
            margin-top: 30px;
        }
        
        .modal-body p{
            font-size: 7px;
            color: grey;
            margin-bottom: 7px;
        }
        .modal-input{
            height: 40px; 
            border: solid gray 2px;
        }
        .submit{
            background-color: rgb(0,88,155);    
            color: white;        
        }
        #p1red{
	        font-size: 5px;
	        color: red;
        }
        .modal-header, .modal-body, .modal-footer{
        	padding: 8px;
        }

    </style>
    <link >
</head>
<body>
	<c:if test="${not empty alertMsg1}">
		<script>
			swal('오류', "${alertMsg1}", 'warning');
		</script>
		<c:remove var="alertMsg1"/>
	</c:if>	
	<c:if test="${not empty alertMsg2}">
		<script>
			swal('성공!', "${alertMsg2}", 'success');
		</script>	
		<c:remove var="alertMsg2"/>
	</c:if>	
	
    <div  class="loginWrap">
        <h2 id="logo">APARTMENTOR</h2>
        <br>
        <div class="formWrap border" align="center">
            <form action="login.me" method="post">
                <input type="text" id="loginid" name="userId" placeholder="아이디">
                <br>
                <input type="password" id="loginpwd" name="userPwd"placeholder="비밀번호">
                <br>
                <c:if test="${not empty noLogin}">
               		<p id="p1red">아이디, 비밀번호를 확인해주세요.</p>
                </c:if>
                <button id="loginbtn">LOGIN</button>
                <br><br><br>
            </form>    
            <div id="modalbtn">
                <button data-toggle="modal" data-target="#myModal1" class="modal1">
                   	 회원가입
                </button> 
                / 
                <button data-toggle="modal" data-target="#myModal2">
                   	아이디 찾기
                </button> 
                / 
                <button  data-toggle="modal" data-target="#myModal3">
                   	 비밀번호 찾기
                </button>
           	</div>
        </div>
    </div>  
      
    <!-- 회원가입 모달 -->
    <div class="modal" id="myModal1">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Head -->
                <div class="modal-header">
                    <h2>회원가입</h2>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <!-- Body -->
                <form action="insert.me" method="post">
                    <div class="modal-body">
                        <b>아이디 : </b>
                        <div class="modal-input">
                        	<input type="hidden" value="" id="xxxx">
                            <input type="text" id="addId" name="userId" placeholder="ex)user111" oninput="checkId();" required>
                        </div>
                        <p id="p1">영문 대 소문자, 숫자 조합 4글자 이상 8글자 이하로 사용하세요.</p>

                        <b>비밀번호 : </b>
                        <div class="modal-input">
                            <input type="password" id="addPwd" name="userPwd" placeholder="ex)asd123!@#" oninput="checkPwd();" required >
                        </div>
                        <p id="p2">6~10자 영문 대 소문자, 숫자, 특수문자(!,@,#,$)를 사용하세요.</p>
                        
                        <b>비밀번호 확인 : </b>
                        <div class="modal-input">
                            <input type="password" id="rePwd1" placeholder="ex)asd123!@#" oninput="ReconfirmPwd1()" required>
                        </div>
                        <p id="p3">비밀번호를 일치하게 입력해주세요.</p>
                        
                        <b>이름 : </b>
                        <div class="modal-input">
                        	<input type="text" id="addName" name="userName" placeholder="ex)홍길동" oninput="checkName()" required>
                        </div>
                        <p id="p4">한글이름으로 입력하세요.</p>

                        <b>생년월일 : </b>
                        <div class="modal-input">
                        	<input type="text" id="addBirthday" name="birthday" placeholder="ex)901201" oninput="checkBirth()" required>
                        </div>
                        <p id="p5">6자리 숫자로 입력하세요.</p>

                        <b>휴대폰 : </b>
                        <div class="modal-input">
                        	<input type="text" id="addPhone" name="phone" placeholder="ex)01012345678" oninput="checkPhone()" required>
                        </div>
                        <p id="p6">-을 제외한 11자리 숫자로 입력하세요.</p>

                        <b>이메일 : </b>
                        <div class="modal-input">
                        	<input type="text" id="addEmail" name="email" placeholder="ex)apartmento@naver.com" oninput="checkEmail()" required>
                        </div>
                        <p id="p7">예시와 같은 형식으로 입력하세요.</p>
                        
                        <b>동 </b>
                        <div class="modal-input">
                        	<input type="text" id="addAptNo1" name="aptNo1" placeholder="ex)1~9" oninput="checkAptNo1()" required>
                        </div>
                        <p id="p8-1">숫자만 입력해 주세요.</p>
                        <b>호수 : </b>
                        <div class="modal-input">
                        	<input type="text" id="addAptNo2" name="aptNo2" placeholder="ex)1001" oninput="checkAptNo2()" required>
                        </div>
                        <p id="p8-2">숫자만 입력해 주세요.</p>
                    </div>
                    
                    <!-- Footer -->
                    <div class="modal-footer">
                       <p style="font-size:12px">잘못된 정보 입력시 회원가입에 불이익이 발생할 수 있습니다.</p>
                        <button type="submit" id="insertMember" class="btn submit" disabled>가입신청</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- 아이디 찾기 모달 -->
    <div class="modal" id="myModal2">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Head -->
                <div class="modal-header">
                    <h2>아이디 찾기</h2>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Body -->
	            <div class="modal-body">
	                <b>이름 : </b>
	                <div class="modal-input">
	                	<input type="text" id="nameId" placeholder="ex)홍길동" required oninput="findId1()">
	                </div>
	                <p id="p11">한글이름으로 입력하세요.</p>
	                
                    <b>이메일 : </b>
                    <div class="modal-input">
                    	<input type="text" id="emailId" placeholder="ex)apartmento@naver.com" required oninput="findId2()" >
                    </div>
                    <p id="p12">예시와 같은 형식으로 입력하세요.</p>
	
	                <b>생년월일 : </b>
	                <div class="modal-input">
	                	<input type="text" id="birthdayId" placeholder="ex)901201" required oninput="findId3()">
	                </div>
	                <p id="p13">6자리 숫자로 입력하세요.</p>
	
                   <b>동 </b>
                   <div class="modal-input">
                 		<input type="text" id="aptNo1Id" name="aptNo1" placeholder="ex)1~9" required oninput="findId4_1()">
                   </div>
                   <p id="p14-1">숫자만 입력해 주세요.</p>
                   <b>호수 : </b>
                   <div class="modal-input">
                   		<input type="text" id="aptNo2Id" name="aptNo2" placeholder="ex)1001" required oninput="findId4_2()">
                   </div>
                   <p id="p14-2">숫자만 입력해 주세요.</p>
	               <br>
	            </div>
	            
	            <!-- Footer -->
	            <div class="modal-footer">
	                <button class="btn submit" id="selectId"onclick="selectId1()">찾기</button>
	            </div>
            </div>
        </div>
    </div>

    <!-- 비밀번호 찾기 모달 -->
    <div class="modal" id="myModal3">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Head -->
                <div class="modal-header">
                    <h2>비밀번호 찾기</h2>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
				<div id="updatePwd">
	                <!-- Body -->
					<div class="modal-body" id="pwdBody">
						<b>아이디 : </b>
						<div class="modal-input">
							<input type="text" id="idPwd" placeholder="ex)user01" required oninput="findPwd2()">
						</div>
						<p id="p15">아이디를 입력하세요</p>
					    <b>이름 : </b>
					    <div class="modal-input">
					    	<input type="text" id="namePwd" placeholder="ex)홍길동" required oninput="findPwd1()">
					    </div>
					    <p id="p16">한글이름으로 입력하세요.</p>
					
					    <b>생년월일 : </b>
					    <div class="modal-input">
					    	<input type="text" id="birthdayPwd"placeholder="ex)901201" required oninput="findPwd3()">
					    </div>
					    <p id="p17">6자리 숫자로 입력하세요.</p>
					
					    <b>동 </b>
                        <div class="modal-input">
                        	<input type="text" id="pwdAptNo1" placeholder="ex)1~9"  required oninput="findPwd4_1()">
                        </div>
                        <p id="p18-1">숫자만 입력해 주세요.</p>
                        <b>호수 : </b>
                        <div class="modal-input">
                        	<input type="text" id="pwdAptNo2" placeholder="ex)1001" required oninput="findPwd4_2()">
                        </div>
                        <p id="p18-2">숫자만 입력해 주세요.</p>
					</div>
	
					<!-- Footer -->
					<div class="modal-footer" id="pwdFooter">
					    <button  class="btn submit"  onclick="findPwd()">찾기</button>
					</div>
				</div>
        	</div>
    	</div>
	</div>
    
    <script>
	let add1;
	let add2;
	let add3;
	let add4;
	let add5;
	let add6;
	let add7;
	let add8;
	let add9;
	/* 회원 가입 */
	
	/* 중복체크,유효성검사  */
	function checkId() {
		let p1 = $('#p1');
		let addId = $('#addId').val();
		$.ajax({
			url : 'checkId.me',
			async: false,
			data : {
				userId : addId
			},
			success : function(result) {
				if(result == 0){
					p1.attr('style','color:red;');
					p1.text('중복되는 아이디입니다');
					add1 = 'N';
					checkBtn1();
				}
				else {
					 let regExpId = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{4,8}$/;
					 if(!regExpId.test(addId)){ // 조건에 안맞음
						 p1.attr('style','color:red;');
						 p1.text('영문 대 소문자, 숫자 조합 4글자 이상 8글자 이하로 사용하세요.');
						 add1 = 'N'
						 checkBtn1();
					 } 
					 else { //조건맞음
						p1.attr('style','color:#32CD32;');
						p1.text('멋진 아이디네요!');
						add1 = 'Y'
						checkBtn1();
					 }
				}
			},
			error : function(result){
				console.log('실패');
				swal('오류', "일치하는 정보가 없습니다", 'warning');
			}
		})
	}
	

	
	/* 비밀번호 유효성 검사 */
	function checkPwd() {
		let p2 = $('#p2');
		let addPwd = $('#addPwd').val();
		let regExpPwd = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$])[a-zA-Z0-9!@#$]{6,10}$/;
		if(!regExpPwd.test(addPwd)){
			 p2.attr('style','color:red;');
			 p2.text('6~10자 영문 대 소문자, 숫자, 특수문자(!,@,#,$)를 사용하세요.')
			 add2 = 'N'
			 checkBtn1();
		}
		else {
			p2.attr('style','color:#32CD32;');
			p2.text('사용가능한 비밀번호 입니다.')
			add2 = 'Y'
			checkBtn1();
		}
	}
	
 	/* 비밀번호 중복 체크 */
	function ReconfirmPwd1() {
		let addPwd = $('#addPwd').val(); 
		let rePwd1 = $('#rePwd1').val();
		let p3 = $('#p3');
		if(addPwd != rePwd1){
			p3.attr('style','color:red;');
			p3.text('비밀번호를 일치하게 입력해주세요.')
			add3 = 'N'
			checkBtn1();
		}
		else {
			p3.attr('style','color:#32CD32;');
			p3.text('비밀번호가 일치합니다.')
			add3 = 'Y'
			checkBtn1();
		} 
	}
 	
 	/* 이름 체크 형식 */
 	function checkName() {
		let addName = $('#addName').val(); 
		let p4 = $('#p4');
		let regExpName = /^[가-힣]{2,}$/;
		if(!regExpName.test(addName)){
			p4.attr('style','color:red;');
			p4.text('올바른 형식의 이름을 입력하세요.(한글만 입력 가능)')
			add4 = 'N'
			checkBtn1();
		}
		else {
			p4.attr('style','color:#32CD32;');
			p4.text('멋진 이름이네요!');	 
			add4 = 'Y'
			checkBtn1();
		}
	}
 	
 	/* 생년월일 체크 형식*/
 	function checkBirth() {
 		let addBirthday = $('#addBirthday').val();
 		let p5 = $('#p5');
 		let regExpBirth = /^\d{2}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
 		if (!regExpBirth.test(addBirthday)) {
 			p5.attr('style','color:red;');
			p5.text('6자리 숫자로 입력하세요.')
			add5 = 'N'
			checkBtn1();
		} else {
			p5.attr('style','color:#32CD32;');
			p5.text('올바른  형식 입니다.');	
			add5 = 'Y'
			checkBtn1();
		}
	}
 	
 	/* 휴대폰 체크 형식 */
 	function checkPhone() {
 		let addPhone = $('#addPhone').val();
 		let p6 = $('#p6');
 		let regExpPhone = /^[\d]{11}$/;
 		if(!regExpPhone.test(addPhone)){
 			p6.attr('style','color:red;');
			p6.text('-을 제외한 11자리 숫자로 입력하세요.')
			add6 = 'N'
			checkBtn1();
		} 
 		else {
			p6.attr('style','color:#32CD32;');
			p6.text('올바른  형식 입니다.');	
			add6 = 'Y'
			checkBtn1();
		}
	}
 	
 	/* 이메일 체크 형식  */
 	function checkEmail() {
 		let addEmail = $('#addEmail').val();
 		let p7 = $('#p7');
 		let regExpEmail =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
 		
 		if(!regExpEmail.test(addEmail)){
 			p7.attr('style','color:red;');
			p7.text('올바른 형식의 이메일이 아닙니다.')
			add7 = 'N'
			checkBtn1();
		} 
 		else {
			p7.attr('style','color:#32CD32;');
			p7.text('올바른  형식 입니다.');	
			add7 = 'Y'
			checkBtn1();
		}
	}
 	
 	/* 동,호수 체크 형식  */
 	function checkAptNo1() {
 		let addAptNo1 = $('#addAptNo1').val();
 		let p8 = $('#p8-1');
 		let regExpAptNo =  /^\d{1}$/;
 		if(!regExpAptNo.test(addAptNo1)){
 			p8.attr('style','color:red;');
			p8.text('예시를 참고하여 입력해주세요.(숫자만 입력)')
			add8 = 'N'
			checkBtn1();
		} 
 		else {
			p8.attr('style','color:#32CD32;');
			p8.text('올바른  형식 입니다.');	
			add8 = 'Y'
			checkBtn1();
		}
	}
 	function checkAptNo2() {
 		let addAptNo2 = $('#addAptNo2').val();
 		let p8 = $('#p8-2');
 		let regExpAptNo =  /^\d{3,4}$/;
 		if(!regExpAptNo.test(addAptNo2)){
 			p8.attr('style','color:red;');
			p8.text('예시를 참고하여 입력해주세요.(숫자만 입력)')
			add9 = 'N'
			checkBtn1();
		} 
 		else {
			p8.attr('style','color:#32CD32;');
			p8.text('올바른  형식 입니다.');	
			add9 = 'Y'
			checkBtn1();
		}
	}
 	function checkBtn1(){
 		if(add1 == 'Y' && add2 == 'Y' && add3 == 'Y' && add4  == 'Y' && add5 == 'Y' && add6 == 'Y' && add7 == 'Y' && add8 == 'Y' && add9 == 'Y' ){
			$('#insertMember').attr('disabled',false);
		} else {
			console.log('add1 ' + add1);console.log('add2 ' + add2);console.log('add3 ' + add3);console.log('add4 ' + add4);console.log('add5 ' + add5);
			console.log('add6 ' + add6);console.log('add7 ' + add7);console.log('add8 ' + add8);console.log('add9 ' + add9);
			$('#insertMember').attr('disabled',true);
		}
 	}
 	
	/* 아이디 찾기 */

    /* 아이디 찾기 이름  */
    function findId1() {
 		let nameId = $('#nameId').val();
 		let p11 = $('#p11');
 		let regExpName = /^[가-힣]{2,}$/;
 		if (!regExpName.test(nameId)) {
 			p11.attr('style','color:red;');
 			p11.text('한글이름으로 입력하세요.');
 			$('#selectId').attr('disabled',true);
		} else {
			p11.attr('style','color:#32CD32;');
			p11.text('올바른  형식 입니다.');	
			$('#selectId').attr('disabled',false);
		}
	}
	
    /* 아이디 찾기 이메일  */
    function findId2() {
    	let emailId = $('#emailId').val();
    	let regExpEmail =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    	let p12 = $('#p12');
    	
    	if (!regExpEmail.test(emailId)) {
 			p12.attr('style','color:red;');
 			p12.text('예시와 같은 형식으로 입력하세요.');
 			$('#selectId').attr('disabled',true);
		} else {
			p12.attr('style','color:#32CD32;');
			p12.text('올바른  형식 입니다.');	
			$('#selectId').attr('disabled',false);
		}
    }
    
    /* 아이디 찾기 생년월일  */
    function findId3() {
    	let birthdayId = $('#birthdayId').val();
    	let p13 = $('#p13');
    	let regExpBirth = /^\d{2}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
    	
 		if (!regExpBirth.test(birthdayId)) {
 			p13.attr('style','color:red;');
 			p13.text('6자리 숫자로 입력하세요.') ;
 			$('#selectId').attr('disabled',true);
		} else {
			p13.attr('style','color:#32CD32;');
			p13.text('올바른  형식 입니다.');	
			$('#selectId').attr('disabled',false);
		}
    }
    
    /* 아이디 찾기 동  */
    function findId4_1() {
    	let aptNo1Id = $('#aptNo1Id').val();
 		let p141 = $('#p14-1');
 		let regExpAptNo =  /^\d{1}$/;
 		
 		if (!regExpAptNo.test(aptNo1Id)) {
 			p141.attr('style','color:red;');
 			p141.text('숫자만 입력해 주세요.');
 			$('#selectId').attr('disabled',true);
		} else {
			p141.attr('style','color:#32CD32;');
			p141.text('올바른  형식 입니다.');	
			$('#selectId').attr('disabled',false);
		}
    }
    
    /* 아이디 찾기 호  */
    function findId4_2() {
 		let aptNo2Id = $('#aptNo2Id').val();
 		let p142 = $('#p14-2');
 		let regExpAptNo =  /^\d{3,4}$/;;
 		
 		if (!regExpAptNo.test(aptNo2Id)) {
 			p142.attr('style','color:red;');
 			p142.text('숫자만 입력해 주세요.');
 			$('#selectId').attr('disabled',true);
		} else {
			p142.attr('style','color:#32CD32;');
			p142.text('올바른  형식 입니다.');	
			$('#selectId').attr('disabled',false);
		}
    }
    
 	/* 아이디 찾기 버튼 ajax */
    function selectId1() {
    	$.ajax({
    		url : 'selectId.me',
    		data : {
    			name : $('#nameId').val(),
    			email : $('#emailId').val(),
    			birthday : $('#birthdayId').val(),
    			aptNo1 : $('#aptNo1Id').val(),
    			aptNo2 : $('#aptNo2Id').val()
    		},
    		success : function(result){
    			if(result == null){
    				swal('오류', '일치하는 정보가 없습니다', 'warning');    	
    			} 
    			else { 
    				swal('성공!', '회원님의 아이디는 ' + result.userId + ' 입니다.', 'success');    	
    			}	
    		},
			error:function(){
				console.log('실패');
				swal('오류', "일치하는 정보가 없습니다", 'warning');
			}	
    	})
	}
 	
    /* 비밀번호 찾기 */
    /* 비밀번호 찾기 아이디  */
    function findPwd2() {
    	let idPwd = $('#idPwd').val();	
    	let p15 = $('#p15');
    	let regExpId = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{4,8}$/;
		if(!regExpId.test(idPwd)){ // 조건에 안맞음
			p15.attr('style','color:red;');
			p15.text('영문 대 소문자, 숫자 조합 4글자 이상 8글자 이하로 사용하세요.');
		} else {
			p15.attr('style','color:#32CD32;');
			p15.text('올바른 아이디 입니다.');
		}
    }
    
    
    /* 비밀번호 찾기 이름  */
    function findPwd1() {
 		let namePwd = $('#namePwd').val();
 		let p16 = $('#p16');
 		let regExpName = /^[가-힣]{2,}$/;

 		if (!regExpName.test(namePwd)) {
 			p16.attr('style','color:red;');
 			p16.text('한글이름으로 입력하세요.')
		} else {
			p16.attr('style','color:#32CD32;');
			p16.text('올바른  형식 입니다.');	
		}
	}
	

    
    /* 비밀번호 찾기 생년월일  */
    function findPwd3() {
    	let birthdayPwd = $('#birthdayPwd').val();
    	let p17 = $('#p17');
    	let regExpBirth = /^\d{2}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
    	
 		if (!regExpBirth.test(birthdayPwd)) {
 			p17.attr('style','color:red;');
 			p17.text('6자리 숫자로 입력하세요.') 
		} else {
			p17.attr('style','color:#32CD32;');
			p17.text('올바른  형식 입니다.');	
		}
    }
    
    /* 비밀번호 찾기 동  */
    function findPwd4_1() {
    	let aptNo1Pwd = $('#pwdAptNo1').val();
 		let p181 = $('#p18-1');
 		let regExpAptNo =  /^\d{1}$/;
 		
 		if (!regExpAptNo.test(aptNo1Pwd)) {
 			p181.attr('style','color:red;');
 			p181.text('숫자만 입력해 주세요.')
		} else {
			p181.attr('style','color:#32CD32;');
			p181.text('올바른  형식 입니다.');	
		}
    }
    
    /* 비밀번호 찾기 호  */
    function findPwd4_2() {
 		let aptNo2Pwd = $('#pwdAptNo2').val();
 		let p182 = $('#p18-2');
 		let regExpAptNo =  /^\d{3,4}$/;;
 		
 		if (!regExpAptNo.test(aptNo2Pwd)) {
 			p182.attr('style','color:red;');
 			p182.text('숫자만 입력해 주세요.')
		} else {
			p182.attr('style','color:#32CD32;');
			p182.text('올바른  형식 입니다.');	
		}
    }
    
    
    /* 비밀번호 변경 모달 */
    function findPwd() {
    	$.ajax({
    		url : 'findPwd.me',
    		data : {
    			id : $('#idPwd').val(),
    			name : $('#namePwd').val(),
    			birthday : $('#birthdayPwd').val(),
    			aptNo1 : $('#pwdAptNo1').val(),
    			aptNo2 : $('#pwdAptNo2').val()
    		},
    		success : function(result){
    			if(result == null){
    				swal('오류', '일치하는 정보가 없습니다', 'warning');    				
    			} 
    			else { 
    				$('#updatePwd *').remove();
    				let yPwd = '<form action="update.pw" method="post">'
    						  + '<input type="hidden" name="pwdId"  id="asdasd">' /* pwdId */
    						  + '<div class="modal-body" id="pwdBody">'
    						  + '<b>' + '비밀번호' +'</b>'
    						  + '<div class="modal-input">' 
    						  + '<input type="password" id="updatePwd1" name="newPwd" placeholder="ex)asd123!@#" oninput="checkPwd2()" required>'
    						  + '</div>'
    						  + '<p id="p9">' + '6~10자 영문 대 소문자, 숫자, 특수문자(!,@,#,$)를 사용하세요.' + '</p>'
    						  + '<b>' + '비밀번호 확인' +'</b>'
    						  + '<div class="modal-input">' 
    						  + '<input type="password" id="reUpdatePwd" name="checkPwd" placeholder="ex)asd123!@#" oninput="rePwd2()" required>'
    						  + '</div>'
    						  + '<p id="p10">' + '비밀번호를 일치하게 입력해주세요.' + '</p>'
    						  + '</div>'
    						  + '<div class="modal-footer" id="pwdFooter">'
    						  + '<button type="submit" class="btn submit" id="btn1">' + '변경' + '</button>'
    					      + '</div>'
    					      + '</form>'
    				$('#updatePwd').html(yPwd);
    				$('#asdasd').val(result.userId)	      
    			}	
    		},
			error:function(){
				console.log('실패')
				swal('오류', "일치하는 정보가 없습니다", 'warning');
			}		
    	})
	}
 	
	/* 비밀번호변경 유효성 검사 */
	function checkPwd2() {
		let p9 = $('#p9');
		let updatePwd = $('#updatePwd1').val();
		let regExpPwd = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$])[a-zA-Z0-9!@#$]{6,10}$/;
		if(!regExpPwd.test(updatePwd)){
			 p9.attr('style','color:red;');
			 p9.text('6~10자 영문 대 소문자, 숫자, 특수문자(!,@,#,$)를 사용하세요.')
		}
		else {
			p9.attr('style','color:#32CD32;');
			p9.text('사용가능한 비밀번호 입니다.')
		}
	}
 	/* 비밀번호변경 중복 체크 */
	function rePwd2() {
		let updatePwd = $('#updatePwd1').val(); 
		let reUpdatePwd = $('#reUpdatePwd').val();
		let p10 = $('#p10');
		if(updatePwd != reUpdatePwd){
			p10.attr('style','color:red;');
			p10.text('비밀번호를 일치하게 입력해주세요.')
		}
		else {
			p10.attr('style','color:#32CD32;');
			p10.text('비밀번호가 일치합니다.')
		} 
	}

 	
 	

</script>

</body>
</html>