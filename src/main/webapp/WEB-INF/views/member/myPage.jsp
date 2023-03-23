<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 

<%@ include file="../include/header.jsp" %>


    <!-- 내정보 시작 -->
    <form>
    <div class="container-fluid pt-5">
        <div class="text-center mb-4">
            <h2 class="section-title px-5"><span class="px-2">내 정보<br></span></h2>
        </div>
        <div class="row px-xl-5">
            <div class="col-lg-12 mb-5">
                <div class="contact-form">
                  <div id="success"></div>                    
                    <div class="form-group">
						<label>내 계정</label>
							<input class="form-control" name="userEmail" value='<c:out value="${myPage.userEmail}"/>'
								readonly="readonly" />
					</div>
                   <div class="form-group">
						<label>비밀번호</label>
							<input class="form-control" type="password" name="password" value='<c:out value="${myPage.userPW}"/>' 
							readonly="readonly"
							/>&nbsp;<button class="btn btn-primary py-1 px-2" type="button" id="mdfPw">변경</button>
					</div>
					<div class="form-group">
						<label>이름</label>
							<input class="form-control" name="userName" value='<c:out value="${myPage.userName}"/>'
									readonly="readonly"/>
					</div>
                    <div class="form-group">
						<label>휴대폰번호</label>
							<input class="form-control" name="mobile" value='<c:out value="${myPage.userMobile}"/>'
							readonly="readonly"
								 />&nbsp;<button class="btn btn-primary py-1 px-2" type="button" id="mdfMobile">변경</button>
					</div>
					<div class="form-group">
						<label>생일</label>
						<input class="form-control" name="birthday" 
							value="<fmt:formatDate value="${myPage.userBirth}" pattern="yyyy/MM/dd"/>"													
							readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>가입일</label>
						<input class="form-control" name="registerDay" 
						value="<fmt:formatDate value="${myPage.userRegdate}" pattern="yyyy/MM/dd"/>"						
						readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>보유쿠폰</label>
						<input class="form-control" name="coupon" value='<c:out value="${myPage.userCoupon}"/>'
						readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>보유포인트</label>
							<input class="form-control" name="point" value='<c:out value="${myPage.userPoint}"/>'
									readonly="readonly"/>
					</div>
					
				       <button style="text-align:center;" class="btn btn-primary py-2 px-4" type="button" id="retireBtn"
                       >회원탈퇴</button>
                    
                </div>
            </div>
        </div>
        
    </div>
    
    		
    </form>
    <!-- 내 정보 끝  -->
    
 <!-- 모달 시작(비번 변경) -->

<div class="modal fade" id="pwModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">비밀번호 변경</h1><!-- 
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id=updatePw>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">기존비밀번호</label>
            <input type="password" class="form-control" id="oldPw" name="oldPw" placeholder="기존비밀번호를 입력해주세요.">

          </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">새 비밀번호</label>
            <input type="password" class="form-control pw" id="userPW" name="userPW" placeholder="영어 대소문자, 숫자,!@#$%^*포함 7~12글자까지 가능합니다.">
          </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">새 비밀번호 재입력</label>
            <input type="password" class="form-control pw" id="newPw2" placeholder="새 비밀번호를 한번 더 입력해주세요.">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" id="pwCancel" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" id="pwMdf" class="btn btn-primary">변경</button>
      </div>
    </div>
  </div>
</div>
<!-- 모달 끝(비번 변경) -->


<script>
//비밀번호 변경 버튼 클릭 시 모달 창 띄움
$("#mdfPw").on("click", function(){
	$("#pwModal").modal("show") ;
});

//변경안하고 취소 
$("#pwCancel").on("click",function(){
	$("#pwModal").modal("hide");
	$("#oldPw").val(""); //기존비번
	$("#userPW").val(""); //새비번
	$("#newPw2").val("");
});


//비밀번호 변경하기
$("#pwMdf").on("click", function(){
		
	 var userEmail="${myPage.userEmail}";
     var userPW = $('#oldPw').val();
	      
	      $.ajax({
	         type : "POST",
	         url : "${contextPath}/member/checkPw",
	         data : {
	        	 	userPW : userPW,
	        	 	userEmail : userEmail
	        	 	},
	         success: function(result){
	            console.log(result);
	            if(result == 'n'){
	                 alert("기존 비밀번호와 일치하지 않습니다.");
	                 return false;  
	            }else{
	       			 $.ajax({
		     			type: "post",
		     			url: "${contextPath}/member/myPw",
		     			data: {
		     				userPW : $('#userPW').val(), 
		     				userEmail : userEmail
		     			},
		     			success: function(result){
		     				if(result=="y"){
		     					alert("비밀번호 변경 완료");	
		     				}
		     					
		     			} 

	     			});//ajax-end		
	            }
	         },
	         error: function(data){
	         }
	      }); //ajax-end
	
 
	

	$("#pwModal").modal("hide");
});

function checkTwoPW() {
	var oldPw="${myPage.userPW}";
	var userPW=$("#userPW").val();
	var newPw2=$("#newPw2").val();
	
	if(oldPw==""){
		alert("현재 비밀번호를 입력하세요.");
		return false;
	}
	if(userPW==""){
		alert("변경할 비밀번호를 입력해주세요.");
		return false;
	}
	if(newPw2==""){
		alert("한 번 더 입력해주세요.");
		return false;
	}
	if(userPW!=newPw2){
		alert("변경할 비밀번호가 일치하지 않습니다.");
		return
		false;
	}
	console.log(userPW==newPw2);
	return true;		
}

//기존 비번을 입력하는 창에서 나왔을때 동작되도록
$('#oldPw').focusout(function(){
	   checkPW();
});

//기존비번과 일치하는지 체크
function checkPW() {
	   var userEmail="${myPage.userEmail}";
       var userPW = $('#oldPw').val();
	      
	      $.ajax({
	         type : "POST",
	         url : "${contextPath}/member/checkPw",
	         data : {
	        	 	userPW : userPW,
	        	 	userEmail : userEmail
	        	 	},
	         success: function(result){
	            console.log(result);
	            if(result == 'n'){
	                 alert("기존 비밀번호와 일치하지 않습니다.");
	                 return false;  
	            }else{
	            	return true;
	            }
	         },
	         error: function(data){
	         }
	      }); //ajax-end
}

var csrfHeaderName = "${_csrf.headerName}";
var csrfToken = "${_csrf.token}";

$(document).ajaxSend(function(e,xhr, options){
   xhr.setRequestHeader(csrfHeaderName, csrfToken);
});
</script>



<!-- 모달 시작(폰번호 변경) -->
<div class="modal fade" id="mobileModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">휴대폰번호 변경</h1>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        	<span aria-hidden="true">&times;</span>
        	</button>
      </div>
      <div class="modal-body">
        <form id="frmMobile">
          <div class="mb-3">
            <input type="text" class="form-control" id="userMobile" name="userMobile" placeholder="변경할 휴대폰 번호 입력">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" id="mobileCancel" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" id="mobileMdf" class="btn btn-primary">변경</button>
      </div>
    </div>
  </div>
</div>
<!-- 모달 끝(폰번호 변경) -->


<!-- 모달 시작(탈퇴) -->
<div class="modal fade" id="retireModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">회원탈퇴</h1>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
          </button>
      </div>
      <div class="modal-body">
        <form id="frmRetire">
          <div class="mb-3">
          <label for="recipient-name" class="col-form-label">내 계정</label>
            <input type="text" class="form-control" id="userEmail" name="userEmail" 
            value='<c:out value="${myPage.userEmail}"/>' readonly="readonly">
          </div>
           <div class="mb-3">
           <label for="recipient-name" class="col-form-label">비밀번호</label>
            <input type="password" class="form-control" id="byePw" name="userPW" placeholder="기존비밀번호를 입력해야 합니다.">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" id="retireCancel" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" id="byebye" class="btn btn-primary">탈퇴</button>
      </div>
    </div>
  </div>
</div>
<!-- 모달 끝(탈퇴) -->      


<script>

//폰번호 변경 버튼 클릭 시 모달 창 띄움
$("#mdfMobile").on("click", function(){
	$("#mobileModal").modal("show") ;
});

//변경안하고 취소 
$("#mobileCancel").on("click",function(){
	$("#mobileModal").modal("hide") ;
	$("#userMobile").val("");
});

//변경한 값을 적용해서 ajax로 보내기 (폰번호 변경하기)
$("#mobileMdf").on("click", function(){
	var userMobile=$("#userMobile").val();
	var userEmail="${myPage.userEmail}";
	
	$.ajax({
		type: "post",
		url: "${contextPath}/member/myMobile",
		data: {
			userMobile : userMobile, 
			userEmail : userEmail
		},
		success: function(result){
			if(result=="y"){
				alert("휴대폰 번호 변경 완료");
			}
		
		}
	});//ajax-end
	$("#mobileModal").modal("hide");
});


//회원탈퇴 버튼 클릭
$("#retireBtn").on("click", function(){
	$("#retireModal").modal("show") ;
});


//변경안하고 취소 
$("#retireCancel").on("click",function(){
	$("#retireModal").modal("hide") ;
	$("#byePw").val("");
});

//회원탈퇴 하기 #byebye

 $("#byebye").on("click", function(){
 	var userPW=$("#byePw").val(); //input창에 입력한 비번
 	var userEmail="${myPage.userEmail}";
		console.log(userEmail);
		if($("#retirePw").val()==""){
			alert("비밀번호를 입력해주세요");
			$("#retirePw").focus();
			return;
		}
		      
		      $.ajax({
		         type : "POST",
		         url : "${contextPath}/member/checkPw",
		         data : {
		        	 	userPW : userPW,
		        	 	userEmail : userEmail
		        	 	},
		         success: function(result){
		            console.log(result);
		            if(result == 'n'){
		                 alert("기존 비밀번호와 일치하지 않습니다.");
		                 return false;  
		            }else{
		            	if(confirm("정말 탈퇴하시겠어요?")){
			    			$.ajax({
			    				type:"post",
			    				url: "${contextPath}/member/bye",
			    				data : {
			    					userEmail : userEmail,
			    					userPW : userPW
			    				},
			    				success: function(){		    					
			    						alert("탈퇴완료");
			    						location.href="${contextPath}/shop/index"; //탈퇴완료 후 이 링크로 이동. 완!		
			    				}		    				
			    			});
		        		}else{
    						alert("탈퇴를 취소했습니다.");
    					}
		            }
		         },
		         error: function(data){
		         }
		      }); //ajax-end
			
	

	

 });	

var csrfHeaderName = "${_csrf.headerName}";
var csrfToken = "${_csrf.token}";

$(document).ajaxSend(function(e,xhr, options){
   xhr.setRequestHeader(csrfHeaderName, csrfToken);
});


</script> 

<%@ include file="../include/footer.jsp" %>