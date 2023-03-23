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
    <div class="container-fluid pt-5">
        <div class="text-center mb-4">
            <h2 class="section-title px-5"><span class="px-2">이벤트 상세페이지<br> <small>조회수: <c:out value="${oneEvent.eventview}"/></small></h4></span></h2>
        </div>
        <div class="row px-xl-5">
            <div class="col-lg-12 mb-5">
                <div class="contact-form">
                    <div id="success"></div>

					<div class="card" >
						<div class="card-body">
							<h5 class="card-title">번호</h5>
							<p class="card-text"><c:out value="${oneEvent.eventNo}"/></p>
						</div>
					</div>
					<div class="card" >
						<div class="card-body">
							<h5 class="card-title">제목</h5>
							<p class="card-text"><c:out value="${oneEvent.eventTitle}"/></p>
						</div>
					</div>
					<div class="card" >
						<div class="card-body">
							<h5 class="card-title">글내용</h5>
							<p class="card-text"><c:out value="${oneEvent.eventContent}"/></p>
							<div id='bigImageWrapper'></div>
							
						</div>
					</div>
					
					

					<div class="form-group">
							<label>작성자</label>
							<input class="form-control" value="mangle"
							readonly="readonly"/>
					</div>
                   <div style="text-align:center;">
                   <sec:authorize access="hasAnyAuthority('ADMIN')" >
                       <button class="btn btn-primary py-2 px-4" type="button" id="modifyMove"
                       >수정</button>
                   </sec:authorize>
                       <button class="btn btn-primary py-2 px-4" type="submit" id="listMove"
                       >목록</button>
                   </div>
                    
                </div>
                
                <form id="frm">
	                <input type='hidden' name='pageNum' value='${pagingDTO.pageNum}'> 
					<input type='hidden' name='rowPerPage' value='${pagingDTO.rowPerPage}'>
					<input type='hidden' name='eventNo' value='${oneEvent.eventNo}'>
                </form>
            </div>
        </div>
    </div>
    <!-- Contact End -->


<script>
	var frm = $("#frm")
	var bigImageWrapper = $("#bigImageWrapper");
	
	$("#modifyMove").on("click", function () {
		frm.attr("action", "${contextPath}/event/modify");
		frm.attr("method", "get");
		frm.submit();
		
	});
	
	$("#listMove").on("click", function () {
		frm.find("#eventNo").remove();
		frm.attr("action", "${contextPath}/event/list");
		frm.attr("method", "get");
		frm.submit();
	});
	//C:\myupload\2022\12\29
	
	if(!${empty imageFile}){
		//var path = '${imageFile.repoPath}/${imageFile.uploadPath}/${imageFile.uuid}_${imageFile.fileName}';
			var imgInput = '<img alt="파일이 없어요..." src="/myupload/${imageFile.uploadPath}/${imageFile.uuid}_${imageFile.fileName}">';
		bigImageWrapper.append(imgInput);
		
		}
</script>

<%@ include file="../include/footer.jsp" %>