<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- JavaScript -->
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
	
	<!-- CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
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
        
        #header{  
            background-color: rgb(0,88,155);
            width: 100%;
            height: 50px;
            display: flex;
            flex-direction: row;
            margin: auto;
			position: -webkit-sticky; /* ????????? ???????????? ?????? */
    		position: sticky;
			top: 0px;
			z-index: 2;
        }
        .mainWrap{
        width: 1200px;
        margin: auto;
        min-height: 1000px;
        }
        #menuBar{
            height: 100%;
            width: 200px;
        }
        .main-nav-left:hover .sub-menu{
            height: 100%;
            width: 200px;
            overflow: hidden
        }
        /* ???????????? */
        .sub-menu {
            position: fixed;
            width: 200px;
            height: 100%;
            transition: 0.5s;
        }
        .sub-menu{
            width: 0;
            height: 100%;
            overflow: hidden;
            background-color: rgb(0,88,155);
            transition-duration: 0.3s;
        }
        .sub-menu ul {
            list-style: none;
            padding: 0;
        }
        .sub-menu-list li {
            line-height: 1rem;
            margin-left: 20px;
        }
         #logo{
            width: 230px;
            height: 100%;
            justify-content: center;
            font-weight :bold;
            font-size: 30px;
            margin: auto;
        }
        #logo a{
            margin-left: 110px;
        	color: white;
        	text-decoration: none;
        }
		#memberInfo{
			float: right;
			width: 90px;
		}
		#memberInfo p{ margin: auto;}
        #changeInfor,#logout,#memberInfo{
            float: right;
            margin-right : 7px;
            margin-top: 3px;        	
        	padding: 10px;
        	text-decoration: none;
			padding-right: 0px;
			padding-left: 0px;        	
        }
        #changeInfor button,#logout a, #memberInfo p{        	
        	color: white;
        	text-decoration: none;
        } 
		#changeInfor button{
			background: none;
			border: none;
			padding-top: 0px
		}
		.mb input{
            margin-top: 7.5px;
            height: 20px;
            width: 100%;
            font-size: 20px;
            border: none;
        }
        .mb input:focus {outline:none;}
        .mb b{
            font-size: 20px;
            margin-bottom: 30px;
            margin-top: 30px;
        }
        .mb p{
            font-size: 7px;
            color: grey;
        }
        .modal-input{
            height: 40px; 
            border: solid gray 2px;
        }
        .submit{
            background-color: rgb(0,88,155);    
            color: white;        
        }
         .modal-body p{
         	margin-bottom: 7px;
         }
        .modal-header, .modal-body, .modal-footer{
        	padding: 8px;
        }

        
        
    /* ????????? */    
    input[id="menuicon"] {display:none;}
    input[id="menuicon"] + label {display:block;margin:0px;width:45px; height:35px; position:relative; cursor: pointer; margin-top:5px; margin-left:5px;}
    input[id="menuicon"] + label span {display:block; position:absolute;width:100%;height:5px;  border-radius: 30px; background: #fff; transition:all .35s;}
    input[id="menuicon"] + label span:nth-child(1) {top:0;}
    input[id="menuicon"] + label span:nth-child(2) {top: 50%; transform:translatey(-50%);}
    input[id="menuicon"] + label span:nth-child(3) {bottom:0;}
    input[id="menuicon"]:checked + label {z-index:2;}
    input[id="menuicon"]:checked + label span {background:#fff;}
    input[id="menuicon"]:checked + label span:nth-child(1) {top: 50%; transform:translateY(-50%) rotate(45deg);}
    input[id="menuicon"]:checked + label span:nth-child(2) {opacity: 0;}
    input[id="menuicon"]:checked + label span:nth-child(3) {bottom: 50%; transform:translateY(50%) rotate(-45deg);}
    div[class="sidebar"] {width:13%; height: 100%; background: #f0eee9; position: fixed; top: 0; left: -13%; z-index: 1; transition:all .35s;}
    input[id="menuicon"]:checked + label + div {left:0;}
    .accordion-body{padding: 0;}
    .accordion-content{width: 100%; height: 50px; border-bottom: 1px solid gray; background: #f0eee9}
    .accordion-button{border-bottom: 1px solid gray; background: #f0eee9}
    .accordion-content:hover {background:  rgb(202,194,176); cursor: pointer;}
    .accordion-content {padding-top: 10px;}
    .hr1{margin-bottom: 0; margin-top: 0; height: 1px;}
    .last{border-bottom: 2px solid black;}
    
    </style>
</head>
<body>

	<c:if test="${not empty alertMsg1}">
		<script>
			swal('??????', "${alertMsg1}", 'warning');
		</script>
		<c:remove var="alertMsg1"/>
	</c:if>	
	<c:if test="${not empty alertMsg2}">
		<script>
			swal('??????!', "${alertMsg2}", 'success');
		</script>	
		<c:remove var="alertMsg2"/>
	</c:if>	

    <div id="header">
	    <input type="checkbox" id="menuicon">
	    <label for="menuicon">
	        <span></span>
	        <span></span>
	        <span></span>
	    </label>
	    <div class="sidebar">
	    	<div style="height: 50px;"></div>
	    	<div class="accordion accordion-flush" id="accordionFlushExample">
	        	<div class="accordion-item">
	          		<h2 class="accordion-header" id="flush-headingOne">
	            		<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
	              			?????? ????????????
	            		</button>
	          		</h2>
	          		<div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
	            		<div class="accordion-body">
	            			<div class="accordion-content" onclick="location.href='list.notice'">
			            		<p>&nbsp;&nbsp;&nbsp;&nbsp;????????????<p>
			            	</div>
			            	<div class="accordion-content" onclick="location.href='list.bo'">
			            		<p>&nbsp;&nbsp;&nbsp;&nbsp;?????? ?????????</p>
			            	</div>
			            	<div class="accordion-content" onclick="location.href='list.vote'">
			            		<p>&nbsp;&nbsp;&nbsp;&nbsp;??????</p>
			            	</div>
			            	<div class="accordion-content last" onclick="location.href='chatForm.ch'">
			            		<p>&nbsp;&nbsp;&nbsp;&nbsp;??????</p>
			            	</div>
	            		</div>
	          		</div>
	        	</div>
	       	<div class="accordion-item">
	          	<h2 class="accordion-header" id="flush-headingTwo">
	            	<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
	             		??????
	            	</button>
	          	</h2>
	          	<div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
	            	<div class="accordion-body">
            			<div class="accordion-content" onclick="location.href='seatView.st'">
		            		<p>&nbsp;&nbsp;&nbsp;&nbsp;?????????<p>
		            	</div>
		            	<div class="accordion-content "onclick="location.href='golf.sp'">
		            		<p>&nbsp;&nbsp;&nbsp;&nbsp;????????????</p>
		            	</div>
		            	<c:choose>
                        	<c:when test="${loginUser.userId eq 'admin'}">
				            	<div class="accordion-content last" onclick="location.href='list.visit'">
				            		<p>&nbsp;&nbsp;&nbsp;&nbsp;???????????? ???????????????</p>
			            		</div>
			            	</c:when>
			            	<c:otherwise>
				            	<div class="accordion-content last" onclick="location.href='enrollForm.visit'">
				            		<p>&nbsp;&nbsp;&nbsp;&nbsp;???????????? ?????????</p>
			            		</div>
			            	</c:otherwise>
			            </c:choose>		
					</div>
	          	</div>
	          	<div class="accordion-body">
           			<div class="accordion-content" onclick="location.href='feeView.fe'">
	            		<p>&nbsp;&nbsp;&nbsp;&nbsp;????????? ??????<p>
	            	</div>
	            	<c:choose>
	            		<c:when test="${loginUser.userId eq 'admin'}">
		           			<div class="accordion-content" onclick="location.href='adminRegoCar.rg?cpage=1&category=ALL'">
			            		<p>&nbsp;&nbsp;&nbsp;&nbsp;????????? ????????????<p>
			            	</div>
		            	</c:when>
		            	<c:otherwise>
			            	<div class="accordion-content" onclick="location.href='regoCar.rg'">
			            		<p>&nbsp;&nbsp;&nbsp;&nbsp;????????? ????????????</p>
		            		</div>
			            </c:otherwise>
	            	</c:choose>
	            	<div class="accordion-content" onclick="location.href='map.api'">
	            		<p>&nbsp;&nbsp;&nbsp;&nbsp;?????? ?????? ??????</p>
	            	</div>
	            	<c:if test="${loginUser.userId eq 'admin'}">
		            	<div class="accordion-content" onclick="location.href='list.me'">
		            		<p>&nbsp;&nbsp;&nbsp;&nbsp;????????????</p>
	            		</div>
            		</c:if>
				</div>
	        </div>
      	</div>
	    </div>
        <div id="logo">
        	<a href="main.do" id="logo">APARTMENTOR</a>
        </div>
        <div style="width: 290px;">
	        <div id="logout">
	            <a href="logout.do">????????????</a>
	        </div>
	        <div id="changeInfor">
		        <button data-toggle="modal" data-target="#myModal4" class="modal1">
		           	 ??????????????????
		        </button> 
	        </div>
	        <div id="memberInfo">
	        	<p>${loginUser.userName} ???</p>
	        </div>
    	</div>
    </div>
    <!-- ???????????? ?????? -->
    <div class="modal" id="myModal4">
        <div class="modal-dialog">
            <div class="modal-content">
                <!-- Head -->
                <div class="modal-header">
                    <h2>??????????????????</h2>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <!-- Body -->
                <form action="update.me" method="post">
                    <div class="modal-body mb">
                        <b>????????? : </b>
                        <div class="modal-input">
                            <input type="text" id="addId" name="userId" oninput="checkId();" required readonly  value="${loginUser.userId}">
                        </div>
                        <p id="p1">?????? ??? ?????????, ?????? ?????? 4?????? ?????? 8?????? ????????? ???????????????.</p>

                        <b>???????????? : </b>
                        <div class="modal-input">
                            <input type="password" id="addPwd" name="userPwd" oninput="checkPwd();" required >
                        </div>
                        <p id="p2">6~10??? ?????? ??? ?????????, ??????, ????????????(!,@,#,$)??? ???????????????.</p>
                        
                        <b>???????????? ?????? : </b>
                        <div class="modal-input">
                            <input type="password" id="rePwd1" oninput="ReconfirmPwd1()" required>
                        </div>
                        <p id="p3">??????????????? ???????????? ??????????????????.</p>
                        
                        <b>?????? : </b>
                        <div class="modal-input">
                        	<input type="text" id="addName" name="userName"  oninput="checkName()" required readonly value="${loginUser.userName}">
                        </div>
                        <p id="p4">?????????????????? ???????????????.</p>

                        <b>???????????? : </b>
                        <div class="modal-input">
                        	<input type="text" id="addBirthday" name="birthday"  oninput="checkBirth()" required readonly value="${loginUser.birthday}">
                        </div>
                        <p id="p5">6?????? ????????? ???????????????.</p>

                        <b>????????? : </b>
                        <div class="modal-input">
                        	<input type="text" id="addPhone" name="phone" oninput="checkPhone()" required>
                        </div>
                        <p id="p6">-??? ????????? 11?????? ????????? ???????????????.</p>

                        <b>????????? : </b>
                        <div class="modal-input">
                        	<input type="text" id="addEmail" name="email" oninput="checkEmail()" required>
                        </div>
                        <p id="p7">????????? ?????? ???????????? ???????????????.</p>
                        
                        <b>??? </b>
                        <div class="modal-input">
                        	<input type="text" id="addAptNo1" name="aptNo1" oninput="checkAptNo1()" required readonly value="${loginUser.aptNo}">
                        </div>
                        <p id="p8-1">??????????????? ?????????????????? ??????????????????.</p>
                        <b>?????? : </b>
                        <div class="modal-input">
                        	<input type="text" id="addAptNo2" name="aptNo2" oninput="checkAptNo2()" required readonly value="${loginUser.aptNo}">
                        </div>
                        <p id="p8-2">??????????????? ?????????????????? ??????????????????.</p>
                    </div>
                    
                    <!-- Footer -->
                    <div class="modal-footer">
                       <p style="font-size:12px">????????? ?????? ????????? ??????????????? ???????????? ????????? ??? ????????????.</p>
                        <button type="submit" id="updateMember" class="btn submit" disabled>????????????</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
	<script>
	let up2;
	let up3;
	let up6;
	let up7;
		/* ???????????? ????????? ?????? */
		function checkPwd() {
			let p2 = $('#p2');
			let addPwd = $('#addPwd').val();
			let regExpPwd = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$])[a-zA-Z0-9!@#$]{6,10}$/;
			if(!regExpPwd.test(addPwd)){
				 p2.attr('style','color:red;');
				 p2.text('6~10??? ?????? ??? ?????????, ??????, ????????????(!,@,#,$)??? ???????????????.');
				 up2 = "N";
				 checkBtn2();
				 
			}
			else {
				p2.attr('style','color:#32CD32;');
				p2.text('??????????????? ???????????? ?????????.')
				up2 = "Y";
				checkBtn2();
			}
		}
		
	 	/* ???????????? ?????? ?????? */
		function ReconfirmPwd1() {
			let addPwd = $('#addPwd').val(); 
			let rePwd1 = $('#rePwd1').val();
			let p3 = $('#p3');
			if(addPwd != rePwd1){
				p3.attr('style','color:red;');
				p3.text('??????????????? ???????????? ??????????????????.')
				up3 = "N";
				checkBtn2();
			}
			else {
				p3.attr('style','color:#32CD32;');
				p3.text('??????????????? ???????????????.')
				up3 = "Y";
				checkBtn2();
			} 
		}
		/* ????????? ?????? ?????? */
	 	function checkPhone() {
	 		let addPhone = $('#addPhone').val();
	 		let p6 = $('#p6');
	 		let regExpPhone = /^[\d]{11}$/;
	 		if(!regExpPhone.test(addPhone)){
	 			p6.attr('style','color:red;');
				p6.text('-??? ????????? 11?????? ????????? ???????????????.')
				up6 = "N";
				checkBtn2();
			} 
	 		else {
				p6.attr('style','color:#32CD32;');
				p6.text('?????????  ?????? ?????????.');	
				up6 = "Y";
				checkBtn2();
			}
		}
	 	
	 	/* ????????? ?????? ??????  */
	 	function checkEmail() {
	 		let addEmail = $('#addEmail').val();
	 		let p7 = $('#p7');
	 		let regExpEmail =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	 		
	 		if(!regExpEmail.test(addEmail)){
	 			p7.attr('style','color:red;');
				p7.text('????????? ????????? ???????????? ????????????.')
				up7 = "N";
				checkBtn2();
			} 
	 		else {
				p7.attr('style','color:#32CD32;');
				p7.text('?????????  ?????? ?????????.');	
				up7 = "Y";
				checkBtn2();
			}
		}
	 	function checkBtn2(){
	 		if(up2 == 'Y' && up3 == 'Y' && up6  == 'Y' && up7 == 'Y'){
				$('#updateMember').attr('disabled',false);
			} else {
				$('#updateMember').attr('disabled',true);
			}
	 	}
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	
</body>
</html>