<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 

<%@ include file="../include/header.jsp" %>

    <!-- Contact Start -->
    <div class="container-fluid pt-5">
        <div class="text-center mb-4">
            <h2 class="section-title px-5"><span class="px-2">event 수정페이지<br></span></h2>
        </div>
        <div class="row px-xl-5">
            <div class="col-lg-12 mb-5">
                <div class="contact-form">
                  <div id="success"></div>  
                  
                <form role="form" id="frmModify" name="frmModify" >                
                    <div class="form-group">
						<label>번호</label>
							<input class="form-control" name="eventNo" id="eventNo" value='<c:out value="${oneEvent.eventNo}"/>'
								readonly="readonly" />
					</div>
					<div class="form-group">
						<label>제목</label>
							<input class="form-control" name="eventTitle" id="eventTitle" value='<c:out value="${oneEvent.eventTitle}"/>'/>
									
					</div>
					<div class="form-group">
						<label>글내용</label>
							<textarea class="form-control" rows="3" name="eventContent" id="eventContent"
							><c:out value="${oneEvent.eventContent}"/></textarea>
					</div>
                        
                        <div style="text-align:center;">
	                        <button type="button" class="btn btn-primary py-2 px-4" id="btnModify">수정</button>
							<button type="button" class="btn btn-primary py-2 px-4" id="btnList">취소</button>
							<button type="button" class="btn btn-primary py-2 px-4" id="btnFlag">종료이벤트처리</button>
						</div>
						
	                <input type='hidden' name='pageNum' value='${pagingDTO.pageNum}'> 
					<input type='hidden' name='rowPerPage' value='${pagingDTO.rowPerPage}'>
					<sec:csrfInput/>
				  </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Contact End -->

	<script>
	//form의 수정/목록 이벤트처리
	var frmModify = $("#frmModify");
	

	$("#btnModify").on("click", function(){
		frmModify.attr("action", "${contextPath}/event/modify");
		frmModify.attr("method", "post");
		frmModify.submit() ; //요청 전송 
	});
	$("#btnList").on("click", function(){
		frmModify.attr("action","${contextPath}/event/list").attr("method","get");
		frmModify.submit() ; //요청 전송
	});
	$("#btnFlag").on("click", function () {
		frmModify.attr("action","${contextPath}/event/end").attr("method","post");
		frmModify.submit() ; //요청 전송
	});
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfToken = "${_csrf.token}";

	$(document).ajaxSend(function(e,xhr, options){
	   xhr.setRequestHeader(csrfHeaderName, csrfToken);
	});
	
	</script>



<%@ include file="../include/footer.jsp" %>