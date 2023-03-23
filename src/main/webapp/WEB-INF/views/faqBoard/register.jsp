<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 

<%@ include file="../include/header.jsp" %>

    <!-- Contact Start -->
    <div class="container-fluid pt-5">
        <div class="text-center mb-4">
            <h2 class="section-title px-5"><span class="px-2">FAQ 작성페이지</span></h2>
        </div>
        <div class="row px-xl-5">
            <div class="col-lg-12 mb-5">
                <div class="contact-form">
                    <div id="success"></div>
                    <form name="sentMessage" id="registerForm" novalidate="novalidate" method="post" action="${contextPath }/faqBoard/register">
                    <div class="form-group">
						  <sec:csrfInput/>
						  <select class="form-control" id="select" name="boardCate">
						    <option value="1">주문/결제</option>
						    <option value="2">배송</option>
						    <option value="3">취소/환불</option>
						    <option value="4">반품/교환</option>
						  </select>
						</div>
                        <div class="control-group">
                            <input type="text" class="form-control" name="faqWriter" id="faqWriter" placeholder="mangle" 
                                 value="mangle" readonly="readonly"/>
                            <p class="help-block text-danger"></p>
                        </div>
                        <div class="control-group">
                            <input type="text" class="form-control" name="faqTitle" id="faqTitle" placeholder="제목"
                                required="required" data-validation-required-message="제목은 반드시 입력해주세요." />
                            <p class="help-block text-danger"></p>
                        </div>
                        <div class="control-group">
                            <textarea class="form-control" rows="6" name="faqContent" id="faqContent" placeholder="내용입력"
                                required="required"
                                data-validation-required-message="내용은 반드시 입력해주세요."></textarea>
                            <p class="help-block text-danger"></p>
                        </div>
                        <div style="text-align:center;">
                            <button type="button" class="btn btn-primary py-2 px-4"  id="sendMessageBtn"
                            >작성</button>
                            <button class="btn btn-primary py-2 px-4" type="button" 
                            onclick="location.href='${contextPath}/faqBoard/list'"
                            >취소</button>
                        </div>
                        <sec:csrfInput/>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Contact End -->

<script>
	var registerForm=$("#registerForm");
//제목,작성자,내용이 있어야 등록되는 함수. 입력갑 유무 함수 -- 그냥 밑에 버튼으로 처리해도 될듯 
// function writeAble(){}


$("#sendMessageBtn").on("click",function(){
	
	var faqTitle=document.getElementById("faqTitle").value;
	var faqContent=document.getElementById("faqContent").value;
	var faqWriter=document.getElementById("faqWriter").value;
	
	if( (faqTitle.length==0 )||(faqContent=="") ||(faqWriter.length==0 )){
		alert("모두 입력하세요.");
	}else{
		registerForm.submit();
	}
});

</script>



<%@ include file="../include/footer.jsp" %>