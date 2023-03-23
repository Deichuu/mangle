<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 

<%@ include file="../include/header.jsp" %>


  <div class="container-fluid pt-5" style="padding-bottom: 50px;">
 		<div class="text-center col-lg-12">
            <h2 class="section-title col-lg-12"><span class="px-2">FAQ</span></h2>
        </div>	
	</div>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
	<button class="btn btn-primary py-1 px-3 a" type="button" name="boardCate" id="order" value="1">주문/결제</button>
	<button class="btn btn-primary py-1 px-3 a" type="button" name="boardCate" id="delivery" value="2">배송</button>
	<button class="btn btn-primary py-1 px-3 a" type="button" name="boardCate" id="refund" value="3">취소/환불</button>
	<button class="btn btn-primary py-1 px-3 a" type="button" name="boardCate" id="exchange" value="4">반품/교환</button><br>
	<br>

    <div class="row px-xl-5">
        <div class="col-lg-12 table-responsive mb-5">
            <table class="table table-bordered text-center mb-0">
                <thead class="bg-secondary text-dark">
                    <tr> <!-- faqList로 가져옵니다. -->
                        <th>번호</th> <!-- faqNo -->
                        <th>분류</th> <!-- boardCate -->                        
                        <th>제목</th> <!-- faqTitle -->
                        <th>작성자</th> <!-- faqWriter -->
                        <th>작성일</th> <!-- faqDate -->
                        <th>조회</th> <!-- faqViewCnt -->
                    </tr>
                </thead>
                <tbody class="align-middle">
                <c:forEach items="${faqList }" var="faq">
                     <tr class="toDetail" data-faqNo='<c:out value="${faq.faqNo}"/>'>
                    	<td class="align-middle"><c:out value="${faq.faqNo }"/></td>
                    	<td class="align-middle">
                    	<%-- <c:out value="${faq.boardCate }"/> --%>
                    	<c:choose>
                    		<c:when test="${faq.boardCate==1}">주문/결제</c:when>
                    		<c:when test="${faq.boardCate==2}">배송</c:when>
                    		<c:when test="${faq.boardCate==3}">취소/환불</c:when>
                    		<c:when test="${faq.boardCate==4}">반품/교환</c:when>
                    	</c:choose>
                    	</td>
                        <td class="align-middle"><c:out value="${faq.faqTitle }"/></td>
                        <td class="align-middle"><c:out value="mangle"/></td>
                        <td class="align-middle"><fmt:formatDate pattern="yyyy/MM/dd" value="${faq.faqDate}" /><br>
												<!-- ${faq.faqDate} --></td>
                        <td class="align-middle"><c:out value="${faq.faqViewCnt }"/></td>
                    </tr>
                </c:forEach>	        
                </tbody>
            </table>
            
            <br>
            <div class="col-12 pb-1">
                <nav aria-label="Page navigation">
                  <ul class="pagination justify-content-center mb-3">
                    <li class="page-item disabled">
                    <c:if test="${pageCreate.prev }">
                       <a class="page-link" href="1" aria-label="Previous">
                           <span aria-hidden="true">&laquo;</span>
                           <span class="sr-only">Previous</span>
                       </a>
                    </c:if>
                    </li>
                    
               <c:forEach var="pageNum" begin="${pageCreate.startPageNum}" end="${pageCreate.endPageNum}">
                  <%-- 선택된 숫자의 경우, Bootstrap의 active 클래스 이름 추가 --%>
                  <li class='page-item ${pageCreate.pagingDTO.pageNum == pageNum ? "active":"" }'>
                  <a class="page-link" href="${pageNum}">${pageNum}</a>
                  </li>
               </c:forEach>
               
                    <c:if test="${pageCreate.next }">
                    <li class="page-item">
                      <a class="page-link" href="${pageCreate.realPageNum}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                        <span class="sr-only">Next</span>
                      </a>
                    </li>                    
                    </c:if>

                  </ul>
                </nav>
            </div>
	            <form id="frmSend">
		            <input type='hidden' name='pageNum' value='${pageCreate.pagingDTO.pageNum}'>
					<input type='hidden' name='rowPerPage' value='${pageCreate.pagingDTO.rowPerPage}'>
					<input type='hidden' name='realPageNum' value='${pageCreate.realPageNum}'>
	            </form>
	            <sec:authorize access="hasAnyAuthority('ADMIN')" >
                	<div style="text-align:right;">
                  		<button class="btn btn-primary py-1 px-3" type="button" id="writeBtn">글쓰기</button>
   					</div>	   
   				</sec:authorize>     
        </div>     

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
	
	        <form class="form-inline" id="frmSendSearch" action="${contextPath}/faqBoard/list" method="get" name="frmSend">
			<div class="form-group" style="text-align:center;"><%-- 
			<label class="sr-only">frmSendValues</label>
		<select class="form-control" id="selectAmount" name="rowPerPage"><!-- 표시 게시물 수 선택 -->
			<option value="10" <c:out value="${pageCreate.pagingDTO.rowPerPage eq '10'
			? 'selected' : ''}" /> >10개</option>
			<option value="20" <c:out value="${pageCreate.pagingDTO.rowPerPage eq '20'
			? 'selected' : ''}" /> >20개</option>
			<option value="50" <c:out value="${pageCreate.pagingDTO.rowPerPage eq '50'
			? 'selected' : ''}" /> >50개</option>
			<option value="100" <c:out value="${pageCreate.pagingDTO.rowPerPage eq '100'
			? 'selected' : ''}" /> >100개</option>
		</select> --%>
		<select class="form-control" id="selectScope" name="scope"><!-- 검색 범위 선택 -->
			<option value="T" <c:out value="${pageCreate.pagingDTO.scope eq 'T'
			? 'selected' : ''}" /> >제목</option>
			<option value="C" <c:out value="${pageCreate.pagingDTO.scope eq 'C'
			? 'selected' : ''}" /> >내용</option>
			<option value="TC" <c:out value="${pageCreate.pagingDTO.scope eq 'TC'
			? 'selected' : ''}" /> >제목 + 내용</option>
		</select>
		<div class="input-group"><!-- 검색어 입력 -->
			<input class="form-control" id="inputKeyword" name="keyword" type="text" placeholder="검색어를 입력"
					value='<c:out value="${pageCreate.pagingDTO.keyword}" />' >
					<%-- value='<c:out value="${pageCreate.pagingDTO.keyword}" />' /> --%>
					
		<span class="input-group-btn"><!-- 전송버튼 -->
			<button class="bbtn btn-primary py-1 px-3" type="button" id="btnSearchGo">
			검색 &nbsp;<i class="fa fa-search"></i>
			</button>
		</span>
		</div>
	<div class="input-group"><!-- 검색 초기화 버튼 -->
	<button id="btnReset" class="bbtn btn-primary py-1 px-3" type="reset">검색초기화</button><br>
	</div>
		</div>
	</form>

</div>
 
<script type="text/javascript">
//글쓰기 버튼 누르면 -> register로 이동
$("#writeBtn").on("click", function(){
	location.href="${contextPath}/faqBoard/register";
});

//게시물 제목 누르면 -> detail로 이동
var frmSend=$("#frmSend");
var frmSendSearch = $("#frmSendSearch");
$(".toDetail").on( "click", function(e) {
	<%-- bno 값이 값이 설정된 hidden 유형의 input 요소를 form에 추가 --%>
	<%-- tr 태그의 data-bno 속성의 값을 data() 함수로 값을 읽어와 value 속성에 지정 --%>
	frmSend.append("<input type='hidden' name='faqNo' value='" + $(this).data("faqno") + "'/>");
	frmSend.attr("action", "${contextPath}/faqBoard/detail");<%-- form에 action 속성 지정 --%>
	frmSend.attr("method", "get");<%-- form에 method 속성 지정 --%>
	frmSend.submit();<%-- form 전송 --%>
});

//페이지 번호 누르면 이동
$(".page-link").on("click", function (e) {
    e.preventDefault();
    frmSend.find("input[name='pageNum']").val($(this).attr("href"));
    frmSend.attr("action", "${contextPath}/faqBoard/list");
    frmSend.attr("method", "get");
    frmSend.submit();
 })


 
<%--검색 관련 요소의 이벤트 처리--%>
<%--표시행수 변경 이벤트 처리--%>

$("#selectAmount").on("change", function(){
frmSend.find("input[name='pageNum']").val(1);
frmSend.attr("action", "${contextPath}/faqBoard/list");
frmSend.attr("method", "get");
frmSend.submit();
});

<%--검색버튼 클릭 이벤트 처리 --%>
$("#btnSearchGo").on("click", function(e) {
// if (!$("#selectScope").find("option:selected").val()) {
// alert("검색범위를 선택하세요");
// return false; 
// }
if (!((frmSendSearch.find("input[name='keyword']").val() ) ||
	  (frmSendSearch.find("input[name='keyword']").val() !="" )) ){
	alert("검색어를 입력하세요");
	return false;
}

frmSendSearch.find("input[name='pageNum']").val("1");
frmSendSearch.attr("action", "${contextPath}/faqBoard/list");
frmSendSearch.attr("method", "get");
frmSendSearch.submit();
});


<%--검색초기화 버튼 이벤트처리, 버튼 초기화 시, 1페이지에 목록 정보 다시 표시 --%>
$("#btnReset").on("click", function(){
$("#selectAmount").val(10);
$("#selectScope").val("");
$("#inputKeyword").val("") ;
$("#hiddenPageNum").val(1);
$("#hiddenLastPageNum").val("");
frmSend.submit();
});



$(".a").on("click",function(){
	frmSend.append("<input type='hidden' name='boardCate' value='" + $(this).val()+ "'/>");
	frmSend.attr("action", "${contextPath}/faqBoard/list");<%-- form에 action 속성 지정 --%>
	frmSend.attr("method", "get");<%-- form에 method 속성 지정 --%>
	frmSend.submit();<%-- form 전송 --%>
	
});

</script>


<%@ include file="../include/footer.jsp" %>