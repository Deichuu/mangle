<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 

<%@ include file="../include/header.jsp" %>

<!--     Page Header Start
    <div class="container-fluid bg-secondary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
            <h1 class="font-weight-semi-bold text-uppercase mb-3">FAQ</h1>
            <div class="d-inline-flex">
                <p class="m-0"><a href="">Home</a></p>
                <p class="m-0 px-2">-</p>
                <p class="m-0">FAQ</p>
            </div>
        </div>
    </div>
    Page Header End -->


    <!-- Contact Start -->
    <form>
    <div class="container-fluid pt-5">
        <div class="text-center mb-4">
            <h2 class="section-title px-5"><span class="px-2">FAQ 상세페이지<br> <small>조회수: <c:out value="${faqBoard.faqViewCnt}"/></small></h4></span></h2>
        </div>
        <div class="row px-xl-5">
            <div class="col-lg-12 mb-5">
                <div class="contact-form">
                  <div id="success"></div>                    
                    <div class="form-group">
						<label>번호</label>
							<input class="form-control" name="faqNo" value='<c:out value="${faqBoard.faqNo}"/>'
								readonly="readonly" />
					</div>
                    <div class="form-group">
						<label>분류</label>
						<c:if test="${faqBoard.boardCate==1}">
							<input class="form-control" name="boardCate" 
								value='주문/결제' readonly="readonly" />
						</c:if>
						<c:if test="${faqBoard.boardCate==2}">
							<input class="form-control" name="boardCate" 
								value='배송' readonly="readonly" />
						</c:if>
							<c:if test="${faqBoard.boardCate==3}">
							<input class="form-control" name="boardCate" 
								value='취소/환불' readonly="readonly" />
						</c:if>
							<c:if test="${faqBoard.boardCate==4}">
							<input class="form-control" name="boardCate" 
									value='반품/교환' readonly="readonly" />
						</c:if>
					
					</div>
					<div class="form-group">
						<label>작성자</label>
						<input class="form-control" name="faqWriter" value='<c:out value="${faqBoard.faqWriter}"/>'
						readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>제목</label>
							<input class="form-control" name="faqTitle" value='<c:out value="${faqBoard.faqTitle}"/>'
									readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>글내용</label>
							<%-- <textarea>와 </textarea>는 사이에 공백이 없어야
							데이터베이스 저장 시에 필요 없는 공백이 포함되지 않음 --%>
							<textarea class="form-control" rows="3" name="faqContent"
							readonly="readonly"><c:out value="${faqBoard.faqContent}"/></textarea>
					</div>

                    
                    
                        <div style="text-align:center;">
                        <sec:authorize access="hasAnyAuthority('ADMIN')" >
                            <button class="btn btn-primary py-2 px-4" type="button" id="modifyBtn"
                            >수정</button>
                            <button class="btn btn-primary py-2 px-4" type="button" id="deleteBtn"
                            >삭제</button>
                        </sec:authorize>
                            <button class="btn btn-primary py-2 px-4" type="button" id="listBtn"
                            >목록</button>
                        </div>
                    
                </div>
            </div>
        </div>
        
    </div>
    
    		
    </form>
    <!-- Contact End -->
    
    <form id="frmSend"><!-- 폼을 추가(list.jsp와 동일한 아이디의 form) -->
		<input type='hidden' name='faqNo'  value='<c:out value="${faqBoard.faqNo}"/>'>
		<input type='hidden' name='pageNum' value='${pagingDTO.pageNum}'>
		<input type='hidden' name='rowPerPage' value='${pagingDTO.rowPerPage}'>
		
			<sec:csrfInput/>
	</form>
	

	<script>
	var frmSend=$("#frmSend");
	
	
	//게시물 수정 페이지로 이동
	$("#modifyBtn").on("click", function(){
// 		location.href='${contextPath}/board/modify?faqNo=<c:out value="${faqBoard.faqNo}"/>';
		frmSend.attr("action", "${contextPath}/faqBoard/modify");
		frmSend.attr("method", "get");
		frmSend.submit();
	});
	
	//게시물 삭제 하기
	$("#deleteBtn").on("click", function(){
		frmSend.attr("action", "${contextPath}/faqBoard/delete");
		frmSend.attr("method", "post");
		frmSend.submit();
	});
	//게시물 목록 페이지로 이동
	$("#listBtn").on("click", function(){
// 		location.href="${contextPath}/board/list";
		frmSend.attr("action", "${contextPath}/faqBoard/list");
		frmSend.attr("method", "get");
		frmSend.submit();
	});
	</script>



<%@ include file="../include/footer.jsp" %>