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
        <h2 class="section-title px-5"><span class="px-2">공지사항<br> <small>조회수: <c:out value="${notice.noticeViewCnt}"/></small></span></h2>
    </div>
    <div class="row px-xl-5">
        <div class="col-lg-12 mb-5">
            <div class="contact-form">
                <div id="success"></div>
                <form name="frmModify" id="frmModify">
                <div class="form-group">
				<label>번호</label>
					<input class="form-control" name="noticeNo" value='<c:out value="${notice.noticeNo}"/>'
						readonly="readonly" />
				</div>
				<div class="form-group">
					<label>제목</label>
						<input class="form-control" name="noticeTitle" value='<c:out value="${notice.noticeTitle}"/>'
								readonly="readonly"/>
				</div>
				<div class="form-group">
					<label>글내용</label>
						<textarea class="form-control" rows="3" name="noticeContent"
						readonly="readonly"><c:out value="${notice.noticeContent}"/></textarea>
				</div>
				<div class="form-group">
						<label>작성자</label>
						<input class="form-control" name="noticeWriter" value='<c:out value="${notice.noticeWriter}"/>'
						readonly="readonly"/>
				</div>
               <div style="text-align:center;">
               <sec:authorize access="hasAnyAuthority('ADMIN')" >
                   <button class="btn btn-primary py-2 px-4 noticeDetail" type="button" id="btnmod" data-oper="mod">수정</button>
               </sec:authorize>
                   <button class="btn btn-primary py-2 px-4 noticeDetail" type="button" id="btnlist" data-oper="list">목록</button>
               </div>
              
               		<input type="hidden" name='noticeNo' id='noticeNo' value='<c:out value="${notice.noticeNo }"/>'>
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
    
<script type="text/javascript">
var frmModify = $("#frmModify");
//목록으로
$(".noticeDetail").on("click", function(){
	 var operation = $(this).data("oper");
	 
	 if(operation == "list"){ //게시물 목록 화면 요청
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
	 }else{
		 frmModify.attr("action","${contextPath}/notice/modify").attr("method","get");
	 }
  		frmModify.submit() ; //요청 전송
});

	
	
</script>

<%@ include file="../include/footer.jsp" %>