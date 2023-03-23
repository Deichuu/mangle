<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="contextPath" value="<%=request.getContextPath() %>"/>

<%@ include file="../include/header.jsp" %>


 <div class="text-center col-lg-12">
            <h2 class="section-title col-lg-12"><span class="px-2">공지사항</span></h2>
        </div>
 
<%--              <form><br>
            	<div class="text-right" style="text-align: center">
                   <button class="btn btn-primary py-2 px-4" type="button" id="sendMessageButton" onclick="location.href='${contextPath}/notice/register'">새글등록</button>
                </div>
            </form> --%>
 
  <!-- notice board Start -->
  <div class="container-fluid pt-5">
    <div class="row px-xl-5">
        <div class="col-lg-12 table-responsive mb-5">
            <table class="table table-bordered text-center mb-0">
                <thead class="bg-secondary text-dark">
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                    </tr>
                </thead>
                <tbody class="align-middle">
                  <c:forEach items="${noticeList }" var="notice" >
                    <tr class="moveDetail" data-bno='<c:out value="${notice.noticeNo}"/>'>
                        <td class="align-middle" style="width: 10%;"><c:out value="${notice.noticeNo }"/></td>
                        <td class="align-middle" style="width: 30%;"><c:out value="${notice.noticeTitle}"/> </td>
                        <td class="align-middle" style="width: 10%;"><c:out value="${ notice.noticeWriter}"/></td>
                        <td class="align-middle" style="width: 10%;"><fmt:formatDate value="${ notice.noticeDate}" pattern="yyyy/MM/dd"/></td>
                        <td class="align-middle" style="width: 10%;"><c:out value="${notice.noticeViewCnt}"/></td>
                    </tr>
                  </c:forEach>
                </tbody>
            </table><br>

            <br>
   			<form class="form-inline" action="${contextPath }/notice/list" method="get" name="frm" id="frm">
                 <!-- 처음 호출시 10이 selected되도록 옵션을 줌 -->
   			<div class="form-group col-lg-6">
                       <label class="sr-only">frmSendValue</label>
                       <select class="form-control" id="selectAmount" name="rowPerPage">
                           <option value="10" <c:out value="${ createDTO.pagingDTO.rowPerPage eq '10' ? 'selected':''}"/>
                           >10</option>  
                           <option value="20" <c:out value="${ createDTO.pagingDTO.rowPerPage == '20' ? 'selected':''}"/>
                           >20</option>
                           <option value="50" <c:out value="${ createDTO.pagingDTO.rowPerPage == '50' ? 'selected':''}"/>
                           >50</option>
                           <option value="100" <c:out value="${ createDTO.pagingDTO.rowPerPage == '100' ? 'selected':''}"/>
                           >100</option>
                       </select>
                       <select class="form-control" id="selectScope" name="scope">
                           <option value="" <c:out value="${ createDTO.pagingDTO.scope == null ? 'selected':''}"/>
                           >검색범위</option>     
                             <option value="T" <c:out value="${ createDTO.pagingDTO.scope == 'T' ? 'selected':''}"/>
                           >제목</option> 
                             <option value="C" <c:out value="${ createDTO.pagingDTO.scope == 'C' ? 'selected':''}"/>
                           >내용</option> 
                             <option value="W" <c:out value="${ createDTO.pagingDTO.scope == 'W' ? 'selected':''}"/>
                           >작성자</option> 
                             <option value="TC" <c:out value="${ createDTO.pagingDTO.scope == 'TC' ? 'selected':''}"/>
                           >제목+내용</option> 
                             <option value="TW" <c:out value="${ createDTO.pagingDTO.scope == 'TW' ? 'selected':''}"/>
                           >제목+작성자</option> 
                             <option value="TCW" <c:out value="${ createDTO.pagingDTO.scope == 'TCW' ? 'selected':''}"/>
                           >제목+내용+작성자</option>                                           
                       </select>
                       <div class="input-group">
                           <input type="text" class="form-control" id="inputKeyword" name="keyword" placeholder="검색어를 입력하세요"
                           value='<c:out value="${ createDTO.pagingDTO.keyword}"/>'/>
                           <span class="input-group-btn">
                               <button class="btn btn-primary py-2 px-3" type="button" id="btnSearchGo">
                               검색&nbsp;<i class="fa fa-search"></i>
                               </button>
                           </span>
                       </div>                       
                       <div class="input-group">
                       		<button class="btn btn-primary py-2 px-4" type="button" id="btnReset">검색초기화</button>
                       </div>
                   </div>
                    <input type='hidden' id = "pageNum" name='pageNum' value='${createDTO.pagingDTO.pageNum}'> 
		            <input type='hidden' name='rowPerPage' value='${createDTO.pagingDTO.rowPerPage}'>
		            <input type='hidden' name='realPageNum' value='${createDTO.realPageNum}'>
            
            
                <div class="col-lg-6 text-right" style="padding-top:8px;">
                <sec:authorize access="hasAnyAuthority('ADMIN')" >
                   <button class="btn btn-primary py-2 px-4" type="button" id="sendMessageButton" onclick="location.href='${contextPath}/notice/register'">새글등록</button>
                </sec:authorize>
                </div>
            
            
            
            </form>
        </div>
 	</div>
 </div>	
<!-- notice board End -->

<!-- pagination -->
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
				
<script type="text/javascript">
var frm = $("#frm");

$(".moveDetail").on("click",function(e){
	frm.append("<input type='hidden' name='noticeNo' value= '"+$(this).data("bno")+"'/>");
	frm.attr("action", "${contextPath}/notice/detail");
	frm.attr("method","get");
	frm.submit();
});
<%--페이징 --%>
$(".page-link").on("click", function(e) {
    e.preventDefault();
    frm.find("input[name='pageNum']").val($(this).attr("href"));
    frm.attr("action", "${contextPath}/notice/list");
    frm.attr("method", "get");
    frm.submit();
 });
<%--표시행수 변경 이벤트 처리--%>
$("#selectAmount").on("change", function(){
	 frm.find("input[name='pageNum']").val(1);
	 frm.attr("action", "${contextPath}/notice/list");
	 frm.attr("method", "get");
	 frm.submit();
});

<%--검색버튼 클릭 이벤트 처리 --%>
$("#btnSearchGo").on("click",function(e){
	if($("selectScope").find("option:selected").val()){
		alert("검색범위를 선택하세요");
		return false;
	}
	
	if(    !( (frm.find("input[name='keyword']").val() ) || (frm.find("input[name='keyword']").val() != "") )      ){
		alert("검색어를 입력하세요");
		return false;
	}
	frm.find("input[name='pageNum']").val(1);
	frm.submit();
});
	
	 
<%--검색초기화 버튼 이벤트처리, 버튼 초기화 시, 1페이지에 목록 정보 다시 표시 --%>
$("#btnReset").on("click", function(){
	 $("#selectAmount").val(10);
	 $("#selectScope").val("");
	 $("#inputKeyword").val("") ;
	 $("#pageNum").val(1);

 	frm.submit();
});

 

</script>
<%@ include file="../include/footer.jsp" %>