<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="<%=request.getContextPath() %>"/>


<%@include file="../include/header.jsp" %> 
 
 <!-- Cart Start -->



    
	<!-- Page Header Start --><!-- 
    <div class="container-fluid bg-secondary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 100px">
            <h1 class="font-weight-semi-bold text-uppercase mb-3">1대1 문의 게시판</h1>
        </div>
    </div> -->
    <!-- Page Header End -->
	<div class="container-fluid pt-5 " style="padding-bottom: 50px;">
    	<div class="row px-xl-5">
        <div class="text-center col-lg-12">
            <h2 class="section-title col-lg-12"><span class="px-2">EVENT</span></h2>
        </div>
        </div>
	</div>
	<sec:authorize access="hasAnyAuthority('ADMIN')" >
       	<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="padding-right: 80px">
      	 		<button class="btn btn-primary"  type="button" id="registerMove">등록</button>
       	</div>
       	<br>
	</sec:authorize>
        <div class="col-lg-12 table-responsive mb-5">
            <table class="table table-bordered text-center mb-0">
                <thead class="bg-secondary text-dark">
                    <tr>
                        <th>번호</th>
                        <th colspan="5">제목</th>
                        <th>등록일</th>
                        <th>작성자</th>
                        <th>조회</th>
                    </tr>
                </thead>
                <tbody class="align-middle">
                	<c:forEach var="eventVO" items="${eventList }" >
                		<c:choose>
                			<c:when test="${eventVO.eventendflag == false }">
			                    <tr class="detail" data-eventNo='<c:out value="${eventVO.eventNo }"/>'>
			                        <td class="align-middle" id="targeteventNo">${eventVO.eventNo }</td>
			                        <td class="align-middle" colspan="5">종료된 이벤트입니다.</td>
			                        <td class="align-middle"><fmt:formatDate pattern="yyyy/MM/dd" value="${eventVO.eventRegDate }" /></td>
			                        <td class="align-middle">mangle</td>
			                        <td class="align-middle">${eventVO.eventview }</td>
			                    </tr>                 			
                			</c:when>
                			<c:otherwise>
			                    <tr class="detail" data-eventNo='<c:out value="${eventVO.eventNo }"/>'>
			                        <td class="align-middle" id="targeteventNo">${eventVO.eventNo }</td>
			                        <td class="align-middle" colspan="5">${eventVO.eventTitle }</td>
			                        <td class="align-middle"><fmt:formatDate pattern="yyyy/MM/dd" value="${eventVO.eventRegDate }" /></td>
			                        <td class="align-middle">mangle</td>
			                        <td class="align-middle">${eventVO.eventview }</td>
			                    </tr>                   			
                			</c:otherwise>
                		</c:choose>
                    </c:forEach>
                </tbody>
            </table><br><br>
            
			<div class="col-12 pb-1">
                <nav aria-label="Page navigation">
                  <ul class="pagination justify-content-center mb-3">
                    
                    <c:if test="${createDTO.prev }">
                    	<li class="page-item">
	                    <a class="page-link" href="1" aria-label="Previous">
	                        <span aria-hidden="true">&laquo;</span>
	                        <span class="sr-only">Previous</span>
	                    </a>
	                    </li>
                    </c:if>
                    <c:if test="${createDTO.prev }">
                    	<li class="page-item">
	                    <a class="page-link" href="${createDTO.startPageNum - 1}" aria-label="Previous">
	                        <span aria-hidden="true">이전</span>
	                        <span class="sr-only">Previous</span>
	                    </a>
	                    </li>
                    </c:if>
					<c:forEach var="pageNum" begin="${createDTO.startPageNum}" end="${createDTO.endPageNum}">
						<%-- 선택된 숫자의 경우, Bootstrap의 active 클래스 이름 추가 --%>
						<li class='page-item ${createDTO.pagingDTO.pageNum == pageNum ? "active":"" }'>
						<a class="page-link" href="${pageNum}">${pageNum}</a>
						</li>
					</c:forEach>
					<c:if test="${createDTO.next }">
                    <li class="page-item">
                      <a class="page-link" href="${createDTO.endPageNum +1}" aria-label="Next">
                        <span aria-hidden="true">다음</span>
                        <span class="sr-only">Next</span>
                      </a>
                    </li>                    
                    </c:if>
                    <c:if test="${createDTO.next }">
                    <li class="page-item">
                      <a class="page-link" href="${createDTO.realPageNum}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                        <span class="sr-only">Next</span>
                      </a>
                    </li>                    
                    </c:if>
                  </ul>
                </nav>
            </div>
            
            <form id="frm">
	            <input type='hidden' name='pageNum' value='${createDTO.pagingDTO.pageNum}'> 
				<input type='hidden' name='rowPerPage' value='${createDTO.pagingDTO.rowPerPage}'>
				<input type='hidden' name='realPageNum' value='${createDTO.realPageNum}'>
            </form>
        </div>
<!-- Cart End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-primary back-to-top"><i class="fa fa-angle-double-up"></i></a>
<script type="text/javascript">
	var frm = $("#frm");

	$(".detail").on("click", function (e) {
		frm.append("<input type='hidden' name='eventNo' value='" + $(this).data("eventno") + "'/>");
		frm.attr("action", "${contextPath}/event/detail");
		frm.attr("method", "get");
		frm.submit();
	});
	$(".page-link").on("click", function (e) {
		e.preventDefault();
		frm.find("input[name='pageNum']").val($(this).attr("href"));
		frm.attr("action", "${contextPath}/event/list");
		frm.attr("method", "get");
		frm.submit();
	});
	
	$("#registerMove").on("click", function () {
		frm.attr("action", "${contextPath}/event/register");
		frm.attr("method", "get");
		frm.submit();
	});
</script>

<%@include file="../include/footer.jsp" %>