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
	
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poor+Story&family=Yeon+Sung&display=swap" rel="stylesheet">
	
	
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
	}
	.blue {
	color: #416893;
	}
	.grey {
		color: gray;
	}
	.sign_in {
		background-color: whitesmoke;
		width: 600px;
		height: 100%;
		display: flex;
		flex-direction: column;
		align-items: center;
		border-radius: 2% 2% 2% 2%;
		text-align: center;
		color: whitesmoke;
		justify-content: center;
	}
	form {
		display: flex;
		flex-direction: column;
		min-width: 90%;
	}
	input{
		width: 450px;
		
	}
	h1 {
		font-size: 2rem;
	}
	</style>
	
	
	<meta charset="UTF-8">
	<title> 이메일 / 비밀번호 찾기</title>
</head>
<body>

<div id="container">
	<div class="form_container sign_in">
			<h1 class="grey">아이디 / 비밀번호 찾기</h1>
			<h6 class="grey">마지막으로 기억나는 이메일을 넣어주세요.</h6>
			<div>
				<input type="text" id="userEmail" name="userEmail" placeholder="이메일을 입력하세요" required>
			</div>
			<br>
			<div>
				<button id="checkStart" type="button">이메일 확인</button><br><a href="${contextPath }/shop/index">홈으로 돌아가기</a>
			</div>
			<sec:csrfInput/>
	</div>
</div>



<script src="https://kit.fontawesome.com/6a59a3f016.js" crossorigin="anonymous"></script>



<script type="text/javascript">

	var csrfHeaderName = "${_csrf.headerName}";
	var csrfToken = "${_csrf.token}";
	var strAlert = '오류발생!';	
	var userEmail = '';
	
		$('#checkStart').on("click", function(){
			var userEmail = $('#userEmail').val();
		
			$.ajax({
				type : "POST",
				url : "${contextPath}/member/emailCheck",
				data : {userEmail : userEmail},
				success: function(cnt){
					if(cnt == "y"){
						strAlert = "이메일이 확인되지 않았습니다. 다른 이메일을 넣어주세요.";
						alert(strAlert);
					}else{
						strAlert = "이메일로 임시 비밀번호를 전송했습니다. 이메일을 확인해주세요.";
						alert(strAlert);
						$.ajax({
							type : "POST",
							url : "${contextPath}/member/resetPw",
							data : {userEmail : userEmail},
							success: function(){
								alert("이메일 전송 성공");
								location.href = "${contextPath}/login";	
							},
						});
						
					}
				},
				error: function(data){
				}
			});
			
			
		});
		
	
	$(document).ajaxSend(function(e,xhr, options){
		   xhr.setRequestHeader(csrfHeaderName, csrfToken);
		});
	

</script>
</body>
</html>