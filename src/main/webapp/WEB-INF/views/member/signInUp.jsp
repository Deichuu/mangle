<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 
<html lang="ko">
<head>


	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
	
	
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poor+Story&family=Yeon+Sung&display=swap" rel="stylesheet">
	
	
	<!-- datepicker -->
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	
	<style> @import url('https://fonts.googleapis.com/css2?family=Poor+Story&family=Yeon+Sung&display=swap'); </style>
	<style>
	
	
	body {
	height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	background-color: #d19c97;
	font-family: 'Poor Story', cursive;
	overflow-y: hidden;
	margin: auto;
	}
	.blue {
	color: #416893;
	}
	.grey {
	color: gray;
	}
	#container {
	border-radius: 2%;
	width: 800px;
	box-shadow: 1px 1px 20px 3px #00000059;
	display: flex;
	flex-direction: row;
	position: relative;
	overflow: hidden;
	min-height: 550px;
	background-color: whitesmoke;
	}
	.overlay_container {
	position: absolute;
	top: 0;
	left: 50%;
	width: 50%;
	height: 100%;
	overflow: hidden;
	transition: transform 0.6s ease-in-out;
	z-index: 100;
	}
	.overlay {
	background-color: #decfe9;
	color: 21100f;
	position: relative;
	left: -100%;
	height: 100%;
	width: 200%;
	transform: translateX(0);
	transition: transform 0.6s ease-in-out;
	}
	.overlay_panel {
	position: absolute;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	text-align: center;
	top: 0;
	height: 100%;
	width: 50%;
	transform: translateX(0);
	transition: transform 0.6s ease-in-out;
	}
	.overlay_left {
	transform: translateY(50%);
	left: 0;
	}
	.overlay_right {
	right: 0;
	transform: translateX(0);
	}
	.overlay_button {
	color: whitesmoke;
	border: 1px solid whitesmoke;
	padding: 10px;
	transition: all 0.1s;
	width: 100px;
	font-size: 1rem;
	border-radius: 5px;
	background-color: #416893;
	}
	.overlay_button:hover {
	color: white;
	cursor: pointer;
	}
	.overlay_button:active {
	transform: scale(1.1);
	}
	.overlay_button:focus {
	outline: none;
	}
	.overlay_panel p {
	margin: 0px 0px 40px 0px;
	}
	.form_container {
	position: absolute;
	top: 0;
	height: 100%;
	transition: all 0.5s ease-in-out;
	}
	.sign_in {
	background-color: whitesmoke;
	width: 400px;
	display: flex;
	flex-direction: column;
	align-items: center;
	border-radius: 2% 0% 0% 2%;
	text-align: center;
	color: whitesmoke;
	justify-content: center;
	z-index: 2;
	}
	.sign_up {
	background-color: whitesmoke;
	width: 400px;
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 0% 2% 2% 0%;
	text-align: center;
	opacity: 0;
	z-index: 1;
	}
	form {
	display: flex;
	flex-direction: column;
	min-width: 80%;
	}
	.rs_icons i {
	background-color: white;
	padding: 10px;
	width: 20px;
	border-radius: 50%;
	border: solid 1px lightgrey;
	margin: 5px;
	color: #416893;
	transition: all 0.1s;
	}
	.rs_icons i:hover {
	border: solid 1px grey;
	}
	h1 {
	font-size: 2rem;
	}
	.hello {
	font-size: 2rem;
	margin: 20px 0px 0px 0px !important;
	color: #416893;
	}
	.welcome {
	font-size: 2rem;
	margin: 20px 0px 0px 0px !important;
	}
	input[type="text"],
	input[type="password"] {
	height: 30px;
	padding: 0px 0px 0px 40px !important;
	width: 300px;
	color: grey;
	}
	.submit {
	justify-content: center;
	display: flex;
	}
	.submit input {
	background-color: #416893;
	color: whitesmoke;
	border: 0px;
	padding: 10px;
	transition: all 0.1s;
	}
	.submit input:hover {
	color: white;
	cursor: pointer;
	}
	.submit:active {
	transform: scale(1.1);
	}
	.submit:focus {
	outline: none;
	}
	input[type="submit"] {
	width: fit-content;
	font-size: 1rem;
	border-radius: 5px;
	}
	.icon {
	position: relative;
	padding-bottom: 1rem;
	}
	.remember h5 {
	margin: 0px;
	}
	.user i {
	position: absolute;
	left: 15px;
	top: 11px;
	}
	.email i {
	position: absolute;
	left: 15px;
	top: 11px;
	}
	.phone i {
	position: absolute;
	left: 15px;
	top: 11px;
	}
	.password i {
	position: absolute;
	left: 17px;
	top: 11px;
	}
	.show {
	left: 310px !important;
	}
	.show:hover {
	cursor: pointer;
	}
	.show:active {
	transform: scale(1.1);
	}
	.signature {
	font-size: 0.75rem;
	position: relative;
	color: whitesmoke;
	}
	footer {
	position: fixed;
	bottom: 0px;
	background-color: black;
	width: 100%;
	text-align: center;
	margin-bottom: 0px;
	z-index: 999;
	}
	footer a {
	color: whitesmoke;
	}
	footer span {
	margin-bottom: 0px;
	}
	.remember {
	display: flex;
	flex-direction: row;
	align-items: center;
	}
	.center {
	text-align: center;
	width: 100%;
	height: 100px;
	color: whitesmoke;
	background-color: #416893;
	}
	.logout {
	text-decoration: none;
	color: whitesmoke;
	padding-bottom: 10px;
	}
	.logout:hover {
	color:gray;
	}
	.logout:active {
	transform: scale(1.1);
	}
	.error {
	width: 350px;
	display: flex;
	align-self: center;
	justify-content: center;
	}
	.error .blue {
	margin:0px;
	}
	h6.grey {
	margin: 1rem;
	}
	#signInMobile {
	display: none;
	}
	/* Responsive Styles */
	/* Ipad 1024x768 */
	@media all and (max-width: 1024px) and (max-height: 768px) {
	body {
	align-items: inherit;
	}
	#container {
	width: 100%;
	border-radius: 0px;
	}
	.sign_in, .sign_up{
	width:50%;
	}
	.email i, .password i, .user i , .phone i {
	left: 45px;
	}
	.show {
	left: 335px !important;
	}
	}
	/* Ipad Vertical 768x1024 */
	@media all and (max-width: 768px) and (max-height: 1024px) {
	body {
	align-items: inherit;
	}
	#container {
	width: 100%;
	border-radius: 0px;
	}
	.sign_in, .sign_up{
	width:50%;
	}
	.email i, .password i, .user i , .phone i {
	left: 15px;
	}
	.show {
	left: 310px !important;
	}
	}
	/* Most of the Phones in Vertical */
	@media all and (max-width: 414px) and (max-height: 823px) {
	body {
	align-items: inherit;
	overflow-y: inherit;
	}
	#container {
	width: 100%;
	border-radius: 0px;
	}
	.sign_in, .sign_up{
	width:100%;
	}
	.email i, .password i, .user i , .phone i {
	right: auto;
	}
	.show {
	margin-left: 85% !important;
	left: 0px !important;
	}
	.overlay_container {
	left: 0;
	width: 100%;
	}
	input[type="text"], input[type="password"] {
	width: 85%;
	}
	#signInMobile {
	display: inline-block;
	margin-top: 1rem;
	}
	#container.right-panel-active .sign_in {
	transform: translateX(0%)!important;
	}
	#container.right-panel-active .sign_up {
	transform: translateX(0%)!important;
	/* opacity: 0!important;
	z-index: 1 !important; */
	}
	#container.mobile .overlay_container{
	transform: translateX(100%)!important;
	}
	}
	/* Most of the Phones in Horizontal */
	@media all and (max-width: 823px) and (max-height: 414px) {
	body {
	align-items: inherit;
	overflow-y: inherit;
	}
	#container {
	width: 100%;
	border-radius: 0px;
	}
	.sign_in, .sign_up{
	width:100%;
	}
	.email i, .password i, .user i , .phone i {
	right: 0px !important;
	margin-right: 85%!important;
	left: 0px !important;
	}
	.show {
	margin-left: 85% !important;
	left: 0px !important;
	}
	.overlay_container {
	left: 0;
	width: 100%;
	}
	.overlay_panel {
	height: 100vh;
	}
	input[type="text"], input[type="password"] {
	width: 85%;
	}
	#signInMobile {
		display: inline-block;
		margin-top: 1rem;
	}
	#container.right-panel-active .sign_in {
		transform: translateX(0%)!important;
	}
	#container.right-panel-active .sign_up {
		transform: translateX(0%)!important;
	}
	#container.mobile .overlay_container{
	transform: translateX(100%)!important;
	}
	}
	/* Animation Styles */
	#container.right-panel-active .overlay {
		transform: translateX(50%);
	}
	#container.right-panel-active .overlay_container {
		transform: translateX(-100%);
	}
	#container.right-panel-active .sign_in {
		transform: translateX(100%);
	}
	#container.right-panel-active .sign_up {
		transform: translateX(100%);
		opacity: 1;
		z-index: 2;
		animation: show 0.6s;
	}
	@keyframes show {
		0%,
		49.9940% {
			opacity: 1;
			z-index: 1;
		}
		50%,
		100% {
			opacity: 1;
			z-index: 2;
		}
	}
	#container.right-panel-active .overlay_left {
		transform: translateX(0);
	}
	#container.right-panel-active .overlay_right {
		transform: translateX(20%);
	}
	#email_lock {
		display : none;
		color: red;
	}
	#mobile_lock {
		display : none;
		color: red;
	}
	</style>
	
	<link rel="icon" href="${contextPath }/resources/img/favicon.png">
	
	<meta charset="UTF-8">
	<title> 로그인 / 회원가입</title>
</head>
<body>


<div id="container">
	<div class="form_container sign_in">
		<form action="${contextPath }/login" method="POST">
			<h1 class="grey">로그인</h1>
			<h6 class="grey">이메일과 비밀번호를 넣어주세요</h6>
			     <fieldset>
                            	<h6 class="text-muted"><c:out value="${error }"/></h6>
				 </fieldset>	
			<div class="email icon">
				<input type="text" id="username" name="username" placeholder="이메일을 입력하세요" required>
				<i class="fa fa-envelope fa-sm" aria-hidden="true"></i>
			</div>
			<div class="password icon">
				<input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
				<i class="fas fa-key" aria-hidden="true"></i>
			</div>
			<div class="remember grey">
				<input type="checkbox" id="remember" name="remember">
				<h6>자동 로그인</h6>
				<a style="margin-left: auto;" href="${contextPath }/member/searchEP">비밀번호 찾기</a>
			</div>
			<div class="submit">
				<button id="signin" name="signin" type="submit" class="overlay_button">Log In</button>
			</div>
			<sec:csrfInput/>
		</form>
	</div>
	<div class="form_container sign_up">
		<form action="${contextPath }/member/registerMember" method="POST" id="suFrm">
			<h1 class="grey">회원가입</h1>
			<h6 class="grey">아래의 창을 채우세요</h6>
			<div class="email icon">
				<input type="text" id="userEmail" name="userEmail" placeholder="아이디로 쓸 이메일 주소를 입력하세요" required style="width: 80%;">
				<br>
				<button type="button" id="email_auth_btn" class="email_auth_btn">인증번호 전송</button>
				<i class="fa fa-envelope fa-sm" aria-hidden="true"></i>
				<br><span id="email_lock" size="2">이미 사용된 이메일입니다.</span>
			</div>
			
			<div class="key icon">
				<i class="fa fa-key fa-sm" aria-hidden="true"></i>
				<input type="text" id="email_auth_key" name="email_auth_key" placeholder="이메일로 전송된 인증번호를 입력하세요" required style="width: 80%;">
			</div>
			<div class="key icon">
				<i class="fa fa-calendar fa-sm" aria-hidden="true"></i>
				<input type="text" id="userBirth" name="userBirth" placeholder="생년월일을 선택해주세요" required style="width: 80%;">
			</div>
			<div class="phone icon">
				<input type="number" id="userMobile" name="userMobile" placeholder="-을 제외한 11자리 핸드폰 번호를 입력하세요" required style="width: 80%;">
				<i class="fa fa-phone fa-sm" aria-hidden="true"></i>
				<br><span id="mobile_lock" size = "2">이미 사용된 핸드폰 번호입니다.</span>
			</div>
			<div class="user icon">
				<input type="text" id="userName" name="userName" placeholder="이름을 입력하세요" required style="width: 80%;">
				<i class="fa fa-user fa-sm" aria-hidden="true"></i>
			</div>
			<div class="password icon">
				<input class="pw" type="password" id="userPW" name="userPW" placeholder="영어 대소문자, 숫자,!@#$%^*포함 7~12글자까지 가능합니다." required style="width: 80%;">
				<i class="fas fa-key" aria-hidden="true"></i>
			</div>
			<div class="password icon">
				<input class="pw" type="password" id="_userPW" placeholder="다시 한번 비밀번호를 입력하세요" required style="width: 80%;">
				<i class="fas fa-key" aria-hidden="true"></i>
				<br>
				<font id = "checkPw" size = "2"></font>
			</div>
			<div class="submit">
				<button id="signup" name="signup" type="button" class="overlay_button">Sign Up</button>
			</div>
			<sec:csrfInput/>
		</form>
	</div>
		<div class="overlay_container">
		<div class="overlay">
		<div class="overlay_panel overlay_left">
		<h1>돌아오신것을 환영합니다!</h1>
		<p>로그인 페이지는 이쪽입니다.</p>
		<button id="signIn" type="button" class="overlay_button">로그인</button>
		</div>
		<div class="overlay_panel overlay_right">
		<h1>환영합니다, 새로운 고객님!</h1>
		<p>회원가입 페이지는 이쪽입니다.</p>
		<button id="signUpMove" type="button" class="overlay_button">회원가입</button>
		<button id="signInMobile" type="button" class="overlay_button">로그인</button>
		</div>
		</div>
	</div>
</div>



<script src="https://kit.fontawesome.com/6a59a3f016.js" crossorigin="anonymous"></script>



<script type="text/javascript">

	var csrfHeaderName = "${_csrf.headerName}";
	var csrfToken = "${_csrf.token}";
	
	
	const signUpButton = document.getElementById('signUpMove');
	
	const signInButton = document.getElementById('signIn');
	
	const signInButtonMobile = document.getElementById('signInMobile');
	
	const container = document.getElementById('container');
	
	signUpButton.addEventListener('click', () => {
		container.classList.add("right-panel-active");
	});
	
	signInButton.addEventListener('click', () => {
		container.classList.remove("right-panel-active");
	});
	
	signInButtonMobile.addEventListener('click', () => {
		container.classList.add("mobile");
	});
	
	var regEmailStr =/^[A-Za-z0-9_-]+@[A-Za-z0-9]+(\.[A-Za-z0-9]{2,3}){1,2}$/;
	var regPWStr = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$\%\^\*]).{8,}/;
	var regPhoneStr = /^(01[0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})/;
	var isPwSame = false;
	let pass1 = "";
	let pass2 = "";
	
	$('.pw').change(function(){
		pass1 = $("#userPW").val();
		pass2 = $("#_userPW").val();
		
		if (pass1 != "" || pass2 != ""){
			if (pass1 == pass2){
				$("#checkPw").html('비밀번호가 일치합니다');
				$("#checkPw").attr('color','green');
				isPwSame = true;
			} else {
				$("#checkPw").html('비밀번호가 맞지 않습니다');
				$("#checkPw").attr('color','red');
				isPwSame = false;
			}
		}
	
	});
	
		
		
	var email_auth_cd = '';

	$("#signup").on("click", function () {
		var email_auth_key = $("#email_auth_key").val();
		
		if($('#userEmail').val() == ""){
			alert("이메일을 입력해주세요.");
			return;
		}
		
		var userMobile = $('#userMobile').val();
		
		if(userMobile == ""){
			alert("핸드폰 번호를 입력해주세요.");
			return;
		}
		
		if(!regPhoneStr.test(userMobile)){
			alert("핸드폰 번호의 형식이 아닙니다. 다시 입력하세요.");
			return;
		}
		
		if($('#userName').val() == ""){
			alert("이름을 입력해주세요.");
			return;
		}
		var userPW = $('#userPW').val();
		
		if(userPW == ""){
			alert("비밀번호를 입력해주세요.");
			return;
		}
		pass1 = $("#userPW").val();
		pass2 = $("#_userPW").val();
		
		if(pass1 != pass2){
			alert("비밀번호가 같지 않습니다.");
			return;
		}
		
		if(!regPWStr.test(userPW)){
			alert("비밀번호 형식이 틀립니다.");
			return;
		}	
		
 		if(email_auth_cd == email_auth_key){
			$.ajax({
			type: "post",
			url: "${contextPath }/member/registerMember",
			data: $("#suFrm").serialize(),
			success : function (data) {
				if(data == 'y'){
					alert("가입해주셔서 감사합니다! 회원가입 기념으로 바로 쓸수 있는 2000포인트를 지급해드렸습니다.");
				}
			}
		});
		}else{
			alert("인증번호와 맞지 않습니다.");
		} 
		

	});
	
		

		
		$(".email_auth_btn").click(function(){     	 
			var userEmail = $('#userEmail').val();
			alert(userEmail);
			if(userEmail == ''){
				alert("이메일을 입력해주세요.");
				return;
			}
			
			if (!regEmailStr.test(userEmail)){
				alert("이메일 형식이 아닙니다. 이메일 형식으로 작성해주세요.");
				return;
			}
			
			$.ajax({
				type : "POST",
				url : "${contextPath}/member/emailAuth",
				data : {userEmail : userEmail},
				success: function(data){
					alert("인증번호가 발송되었습니다.");
					email_auth_cd = data;
				},
				error: function(data){
					alert("메일 발송에 실패했습니다.");
				}
			}); 
		});
		
		$('#userEmail').focusout(function(){
			var userEmail = $('#userEmail').val();
		
			$.ajax({
				type : "POST",
				url : "${contextPath}/member/emailCheck",
				data : {userEmail : userEmail},
				success: function(cnt){
					if(cnt == "n"){
						$("#email_lock").css("display","inline-block");
					}
				},
				error: function(data){
				}
			});
		});
		
		
		$('#userMobile').focusout(function(){
			var userMobile = $('#userMobile').val();
			$.ajax({
				type : "POST",
				url : "${contextPath}/member/mobileCheck",
				data : {userMobile : userMobile},
				success: function(cnt){
					if(cnt == 'n'){
						$("#mobile_lock").css("display","inline-block");
					}
				},
				error: function(data){
				}
			}); 
		});

	
	
	//datepicker
	$(function() {
		//input을 datepicker로 선언
		$("#userBirth").datepicker({
			dateFormat: 'yy/mm/dd' //달력 날짜 형태
			,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
			,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
			,changeYear: true //option값 년 선택 가능
			,changeMonth: true //option값  월 선택 가능                
			//,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
			//,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
			//,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
			//,buttonText: "선택" //버튼 호버 텍스트              
			,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
			,yearRange: 'c-100:c+0' //년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시
			,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
			,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
			,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
			,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
			,minDate: "-100Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
			,maxDate: "+100y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
		});                    
		
		//초기값을 placeholder가 나오게 하기
		$('#userBirth').datepicker();
		
		//초기값을 오늘 날짜로 설정
		//$('#userBirth').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
		
	});
	
	
	$(document).ajaxSend(function(e,xhr, options){
		   xhr.setRequestHeader(csrfHeaderName, csrfToken);
		});
	

</script>
</body>
</html>