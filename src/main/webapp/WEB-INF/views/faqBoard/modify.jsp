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
            <h2 class="section-title px-5"><span class="px-2">FAQ 수정페이지<br></span></h2>
        </div>
        <div class="row px-xl-5">
            <div class="col-lg-12 mb-5">
                <div class="contact-form">
                  <div id="success"></div>  
                  
                <form role="form" id="frmModify" name="frmBoard" >
                <sec:csrfInput/>         
                    <div class="form-group">
						<label>번호</label>
							<input class="form-control" name="faqNo" value='<c:out value="${faqBoard.faqNo}"/>'
								readonly="readonly" />
					</div>
					<div class="form-group">
						<label>제목</label>
							<input class="form-control" name="faqTitle" value='<c:out value="${faqBoard.faqTitle}"/>'
									/>
					</div>
					<div class="form-group">
						<label>글내용</label>
							<%-- <textarea>와 </textarea>는 사이에 공백이 없어야
							데이터베이스 저장 시에 필요 없는 공백이 포함되지 않음 --%>
							<textarea class="form-control" rows="3" name="faqContent"
							><c:out value="${faqBoard.faqContent}"/></textarea>
					</div>
					<div class="form-group">
							<label>작성자</label>
							<input class="form-control" name="faqWriter" value='<c:out value="${faqBoard.faqWriter}"/>'
							readonly="readonly"/>
					</div>
             
                        
                        <div style="text-align:center;">
	                        <button type="button" class="btn btn-primary py-2 px-4" id="btnModify" data-oper="modify">수정</button>
							<button type="button" class="btn btn-primary py-2 px-4" id="btnList" data-oper="list">취소</button>
						</div>
							<input type='hidden' name='pageNum' value='${pagingDTO.pageNum}'>
							<input type='hidden' name='rowPerPage' value='${pagingDTO.rowPerPage}'>
							<input type='hidden' name='scope' value='${pagingDTO.scope}'>
							<input type='hidden' name='keyword' value='${pagingDTO.keyword}'>
							
							<sec:csrfInput/>
				  </form>
         
                </div>
            </div>
        </div>
    </div>
    <!-- Contact End -->

	<script>
	
	var frmModify = $("#frmModify");
	//수정
   $("#btnModify").on("click", function(){
	  frmModify.attr("action", "${contextPath}/faqBoard/modify");
      frmModify.attr("method", "post");
      frmModify.submit() ; //요청 전송
   });
	
	//취소(목록으로 돌아가기)
   $("#btnList").on("click", function(){
  	var pageNumInput = $("input[name='pageNum']").clone(); 
  	var rowPerPageInput = $("input[name='rowPerPage']").clone(); 
  	var scopeInput = $("input[name='scope']").clone();
  	var keywordInput = $("input[name='keyword']").clone();
  	
   	 frmModify.empty();
     frmModify.attr("action","${contextPath}/faqBoard/list").attr("method","get");
     frmModify.append(pageNumInput); //추가
     frmModify.append(rowPerPageInput); //추가
     frmModify.append(scopeInput); 
     frmModify.append(keywordInput); 
     
     frmModify.submit() ; //요청 전송
   });

   var csrfHeaderName = "${_csrf.headerName}";
   var csrfToken = "${_csrf.token}";

   $(document).ajaxSend(function(e,xhr, options){
      xhr.setRequestHeader(csrfHeaderName, csrfToken);
   });
	</script>



<%@ include file="../include/footer.jsp" %>