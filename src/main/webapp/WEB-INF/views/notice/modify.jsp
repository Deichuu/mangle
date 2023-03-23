<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="../include/header.jsp" %>

<!-- Contact Start -->
<div class="container-fluid pt-5">
    <div class="text-center mb-4">
        <h2 class="section-title px-5"><span class="px-2">공지사항 수정페이지<br></span></h2>
    </div>
    <div class="row px-xl-5">
        <div class="col-lg-12 mb-5">
            <div class="contact-form">
              <div id="success"></div>  
              
	            <form role="form" id="frmModify" method="post" name="frmModify">
	           		<sec:csrfInput/>                
	                <div class="form-group">
				<label>번호</label>
				<input class="form-control" name="noticeNo" value='<c:out value="${notice.noticeNo}"/>'
					readonly="readonly" />
				</div>
				<div class="form-group">
					<label>제목</label>
						<input class="form-control" name="noticeTitle" value='<c:out value="${notice.noticeTitle}"/>'
								/>
				</div>
				<div class="form-group">
					<label>글내용</label>
						<textarea class="form-control" rows="3" name="noticeContent"
						><c:out value="${notice.noticeContent}"/></textarea>
				</div>
				<div class="form-group">
						<label>작성자</label>
						<input class="form-control" name="noticeWriter" value='<c:out value="${notice.noticeWriter}"/>'
						readonly="readonly"/>
				</div>
				
	             <div style="text-align:center;">
		             <button type="button" class="btn btn-primary py-2 px-4" id="btnModify" data-oper="modify">수정</button>
		             <button class="btn btn-primary py-2 px-4" type="button" id="delButton" data-oper="remove">삭제</button>
					 <button type="button" class="btn btn-primary py-2 px-4" id="btnList" data-oper="list">취소</button>
				</div>
			
				<input type='hidden' name='pageNum' value='${createDTO.pagingDTO.pageNum}'> 
	            <input type='hidden' name='rowPerPage' value='${createDTO.pagingDTO.rowPerPage}'>
	            <input type='hidden' name='scope' value='${createDTO.pagingDTO.scope }'>
	            <input type='hidden' name='keyword' value='${createDTO.pagingDTO.keyword}'>
 			  </form>
            </div>
        </div>
    </div>
</div>
<!-- Contact End -->

<script>

//form의 수정/목록 이벤트처리
var frmModify = $("#frmModify");

var csrfHeaderName = "${_csrf.headerName}";
var csrfToken = "${_csrf.token}";

$(document).ajaxSend(function(e,xhr, options){
   xhr.setRequestHeader(csrfHeaderName, csrfToken);
});

//수정버튼
 $("#btnModify").on("click", function(){
     frmModify.attr("action", "${contextPath}/notice/modify");
     frmModify.attr("method", "post");
     alert("수정되었습니다.");
     frmModify.submit() ; //요청 전송
 });

 //취소버튼
 $("#btnList").on("click", function(){
	 var operation = $(this).data("oper");
	
		var pageNumInput = $("input[name='pageNum']").clone() ;
	    var rowPerPage = $("input[name='rowPerPage']").clone() ;
	    var scopeInput = $("input[name='scope']").clone() ;
	    var keywordInput = $("input[name='keyword']").clone() ;
	    
	    frmModify.empty();
	    
		frmModify.attr("action","${contextPath}/notice/list").attr("method","get");
		
		frmModify.append(pageNumInput);
		frmModify.append(rowPerPage) ;
		frmModify.append(scopeInput) ;
		frmModify.append(keywordInput) ;
	 
	 	frmModify.submit() ; //요청 전송
 });

/* //삭제버튼 
 $("#delButton").on("click",function(e){
	confirm("삭제하시겠습니까?")
	frmModify.attr("action","${contextPath}/notice/delete").attr("method","post");	
	frmModify.submit();
 }); */
 
 
//게시물 삭제 하기
$("#delButton").on("click", function(){
	frmModify.attr("action", "${contextPath}/notice/delete");
	frmModify.attr("method", "post");
	frmModify.submit();
});
 
 
</script>
<%@ include file="../include/footer.jsp" %>