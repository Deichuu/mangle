<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="contextPath" value="<%=request.getContextPath() %>" />

<%@include file="../include/header.jsp" %>

 <div class="text-center col-lg-12">
            <h2 class="section-title col-lg-12"><span class="px-2">대량주문 게시판</span></h2>
        </div>
        
    <div class="row" style="width: 100%; padding:5%;">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <!-- <h4>게시물 목록</h4> -->
                   	<div class="row" style="text-align:center;">
						<div class="col-md-6" style="font-size:20px; height: 45px; padding-top:10px;"></div>
						<div class="col-md-6 text-right" style="padding-top:8px;">
						<sec:authorize access="hasAnyAuthority('USER')" >
							<button type="button" id="btnMoveRegister" class="btn btn-primary btn-sm pull-right">새글 등록</button>
						</sec:authorize>	
						</div>
					</div>
                </div>
                <%-- /.panel-heading --%>
                
                <div class="panel-body">
        
			<form action="${contextPath }/bulk/list">
				<input type="hidden" name="pageNum" id="pageNum" value="${pageCreate.pagingDTO.pageNum }" />
				<input type="hidden" name="rowAmountPerPage" id="rowAmountPerPage" value="${pageCreate.pagingDTO.rowPerPage }" />
				<input type="hidden" name="lastPageNum" id="lastPageNum" value="${pageCreate.realPageNum }" />
			</form>
			
			<br>
			
				<table class="table table-striped table-bordered table-hover"
						style="width:100%;text-align:center;" >
					<thead>
                            <tr>
	                           	<th style="text-align:center;">번호</th>
								<th style="text-align:center;">제목</th>
							 	<th style="text-align:center;">작성자</th>
								<th style="text-align:center;">작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                          <c:forEach items="${bulkList}" var="bulk">
	                           	<tr class="moveDetail" data-bno    ='<c:out value="${bulk.bno }" />'
	                           						   data-bwriter='<c:out value="${bulk.bwriter }" />' >
	              					<td>${bulk.bno}</td>
	              					<td style="text-align: left;">${bulk.btitle }</td>	
                       				<td>${bulk.bwriter }</td>
                       				<td>${bulk.bregDate }<br></td>
                       			</tr>                     			
	                          <c:forEach items="${reply}" var="reply">
	                          		<c:if test="${bulk.bno == reply.rbno}">
		                       			<tr class="moveDetail" data-bno='<c:out value="${reply.bno }" />'
		                       								   data-bwriter='<c:out value="${bulk.bwriter }" />' >
			              					<td style="padding-left: 20px;"><strong> ↳ </strong>&nbsp;${reply.bno}(${reply.rbno})</td>
			              					<td style="text-align: left;">${reply.btitle }</td>	
		                       				<td style="padding-left: 20px;" >${reply.bwriter }</td>
		                       				<td style="padding-left: 20px;" >${reply.bregDate }<br></td>	                       			
		                       			</tr>
	                          		</c:if>
                       			</c:forEach>
                       		</c:forEach>  
                        </tbody>
                    </table> <%-- /.table-responsive --%>
                     
                    <form id="frmSendValue">
                    <input type="hidden" name="pageNum" id="pageNum" value="${pageCreate.pagingDTO.pageNum }" />
                    </form>
                    <br>
              <%-- Pagination 시작 --%>
                  <div class="col-12 pb-1">
                <nav aria-label="Page navigation">
                  <ul class="pagination justify-content-center mb-3">
                    
                    <c:if test="${pageCreate.prev}">
                       <li class="page-item">
                       <a class="page-link" href="1" aria-label="Previous">
                           <span aria-hidden="true">&laquo;</span>
                           <span class="sr-only">Previous</span>
                       </a>
                       </li>
                    </c:if>
                    <c:if test="${pageCreate.prev  }">
                       <li class="page-item">
                       <a class="page-link" href="${pageCreate.startPageNum - 1}" aria-label="Previous">
                           <span aria-hidden="true">이전</span>
                           <span class="sr-only">Previous</span>
                       </a>
                       </li>
                    </c:if>
                <c:forEach var="pageNum" begin="${pageCreate.startPageNum }" end="${pageCreate.endPageNum }">
                  <li class='page-item ${pageCreate.pagingDTO.pageNum == pageNum ? "active" :"" }'>
                  <a class="page-link" href="${pageNum}">${pageNum}</a>
                  </li>
               </c:forEach>
               
               <c:if test="${pageCreate.next }">
                    <li class="page-item">
                      <a class="page-link" href="${pageCreate.endPageNum + 1}" aria-label="Next">
                        <span aria-hidden="true">다음</span>
                        <span class="sr-only">Next</span>
                      </a>
                    </li>                    
                    </c:if>
                    <c:if test="${pageCreate.next }">
                    <li class="page-item">
                      <a class="page-link" href="${pageCreate.realPageNum - 1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                        <span class="sr-only">Next</span>
                      </a>
                    </li>                    
                    </c:if>
                  </ul>
                </nav>
            </div>
				
                  
           		</div>
            </div>
        </div>
 	</div>
   
<script type="text/javascript">


<%--로그인 계정을 loginUser 변수에 저장,
앞 실습으로 이미 구성되어 있음, 않된 경우 추가 --%>
var loginUser = ""; 
<sec:authorize access="hasAuthority('USER')">
	loginUser = '<sec:authentication property="principal.username"/>';
</sec:authorize>

<sec:authorize access="hasAuthority('ADMIN')">
	loginUser = 'ADMIN';
</sec:authorize>


<%-- HTML에서 일어나는 모든 Ajax 전송 요청에 대하여 csrf 토큰값이 요청 헤더에 설정됨
앞 실습으로 이미 구성되어 있음, 않된 경우 추가 --%>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";
$(document).ajaxSend(function(e, xhr, options){ 
xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});


var frmSendValue = $("#frmSendValue");

//새글등록 이동
$("#btnMoveRegister").on("click",function(){
	//location.href = "${contextPath}/myboard/register";
	self.location.href = "${contextPath}/bulk/register";
});

//페이징 버튼 클릭
$(".page-item a").on("click",function(e) {
	e.preventDefault();
	
	frmSendValue.find("input[name='pageNum']").val($(this).attr("href"));
	frmSendValue.attr("action","${contextPath}/bulk/list");
	frmSendValue.attr("method","get");
	frmSendValue.submit();
});

//디테일로 이동
$(".moveDetail").on("click",function(e){
	<%--로그인 안 한 경우--%>
	if(!loginUser){
		alert("로그인 후, 작성자와 관리자만 조회가 가능합니다.");
		return ;
	}
	<%--작성자 변수에 저장--%>
	var bwriterVal = $(this).data("bwriter");
	console.log("bwriterVal: " + bwriterVal);
	console.log("loginUser: " + loginUser);
	<%--로그인 계정과 작성자가 다른 경우--%>
	if(bwriterVal == loginUser || loginUser =='ADMIN'){
		frmSendValue.append("<input type='hidden' name='bno' value='"+ $(this).data("bno") +"'/>");
		frmSendValue.append("<input type='hidden' name='bwriter' value='"+ $(this).data("bwriter") +"'/>");
		
		frmSendValue.attr("action", "${contextPath}/bulk/detail");
		frmSendValue.attr("method","get");
		frmSendValue.submit();
		
	} else {
		alert("작성자와 관리자만 조회가 가능합니다");
		return ;
		
	}

	
});

</script>

<%@include file="../include/footer.jsp" %>