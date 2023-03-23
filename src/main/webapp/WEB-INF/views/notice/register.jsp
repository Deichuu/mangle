<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="contextPath" value="<%=request.getContextPath() %>"/>

<%@ include file="../include/header.jsp" %>


 <div class="text-center col-lg-12">
            <h2 class="section-title col-lg-12"><span class="px-2">게시글 등록</span></h2>
        </div>

<!-- Contact Start -->
    <div class="container-fluid pt-5">
        <div class="row px-xl-5">
            <div class="col-lg-12 mb-5">
                <div class="contact-form">
                    <div id="success"></div>
                   	  <form role="form" name="registerForm" id="registerForm" novalidate="novalidate" action="${contextPath }/notice/register" method="post">
                   	  <div class="form-group">
                         <input class="form-control" placeholder="글제목 입력" name="noticeTitle" required="required">
                     	</div>
                    	<div class="form-group">
                            <textarea class="form-control" id="noticeContent" name="noticeContent" placeholder="내용입력" style="height:300px;"
                                required="required"></textarea> 
                            <p class="help-block text-danger"></p>
                        </div>
                        <div class="form-group">
                            <input class="form-control" id="noticeWriter" name="noticeWriter" placeholder="mangle" value="mangle" readonly="readonly"/>
                            <p class="help-block text-danger"></p>
                        </div>
                        <div style="text-align: center">
                            <button class="btn btn-primary py-2 px-4" type="button" id="sendMessageButton">등록</button>
                            <button class="btn btn-primary py-2 px-4" type="button" id="cancleButton" onclick="location.href='${contextPath}/notice/list'">취소</button>
                        </div>
                   	  </form>
                   </div>
                </div>
            </div>
        </div>
    <!-- Contact End -->
    
    
 <script type="text/javascript">
 
 var csrfHeaderName = "${_csrf.headerName}";
 var csrfToken = "${_csrf.token}";

 $(document).ajaxSend(function(e,xhr, options){
    xhr.setRequestHeader(csrfHeaderName, csrfToken);
 });
 
 
 
 $("#sendMessageButton").on("click",function(e){
	 var noticeTitle = registerForm.noticeTitle.value;
	 var noticeContent =registerForm.noticeContent.value;
	 var noticeWriter = registerForm.noticeWriter.value;
	 console.log(noticeTitle);
	 console.log(noticeContent);
	 console.log(noticeWriter);
	 $.ajax({
	      url: '${contextPath}/notice/register',
	      data: {noticeTitle: noticeTitle, noticeContent: noticeContent, noticeWriter :noticeWriter},
	      dataType:'text',
	      type: 'post',
	      success: function(result){
	    	  alert("새글이 등록되었습니다.");
	    	  window.location.href='${contextPath}/notice/list';
	      }
	   });   //.ajax
 });
 
 
 </script>   
    
<%@ include file="../include/footer.jsp" %>