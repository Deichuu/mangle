<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextPath" value="<%=request.getContextPath() %>"/>

<%@ include file="../include/header.jsp" %>

    <!-- Page Header Start -->
    <div class="container-fluid bg-secondary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
            <h1 class="font-weight-semi-bold text-uppercase mb-3"><c:out value="${title }" /> </h1>
            <div class="d-inline-flex">
                <p class="m-0">${subtitle }</p>
            </div>
        </div>
    </div>
    <!-- Page Header End -->


   <!-- Shop Start -->
    <div class="container-fluid pt-5">
        <div class="row px-xl-5">
            <!-- Shop Sidebar Start -->
            <div class="col-lg-3 col-md-12">
              <!-- Size Start -->
                <div class="mb-5">
                <c:if test="${prod[0].categorized ne 2 }">
                    <h5 class="font-weight-semi-bold mb-4">기종선택</h5>
                    <form action="${contextPath }/shop/list" method="get" name="frm1" id="frm1">
                        <div class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                            <input type="checkbox" class="custom-control-input"  id="size-all" name="selectProducer" data-producer="전체">
                            <label class="custom-control-label" for="size-all">전체</label>
                        </div>
                        <div class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                            <input type="checkbox" class="custom-control-input" id="size-1" name="selectProducer" data-producer="삼성">
                            <label class="custom-control-label" for="size-1" >삼성</label>
                        </div>
                        <div class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                            <input type="checkbox" class="custom-control-input" id="size-2" name="selectProducer" data-producer="애플">
                            <label class="custom-control-label" for="size-2">애플</label>
                        </div>
                        <input type="hidden" name="citemtype" value="${pagingDTO.citemtype }" />
                        <input type="hidden" name="categorized" value="${pagingDTO.categorized }" />
                        <input type="hidden" name="producer" />
                    </form>
                    </c:if>
                </div>
                <!-- Size End -->
            </div>
            <!-- Shop Sidebar End -->

              <!-- Shop Product Start -->
              <div class="col-lg-9 col-md-12">
                <div class="row pb-3">
                    <div class="col-12 pb-1">
                       <form action="${contextPath }/shop/list" method="get" name="frm" id="frm">
                       	<input type="hidden" name="sort">
                    	<input type="hidden" name="producer">
                        <input type="hidden" name="citemtype" id="citemtype" value="${pagingDTO.citemtype }"><!-- 1.일반 2. 업로드 3.일러스트 -->
		                <input type="hidden" name="categorized" id="categorized" value="${pagingDTO.categorized }"> <!-- 1.폰케이스, 2. 이어폰케이스 3.그립톡 -->
		                
                       <select class="form-control" id="selectScope" name="scope">
                             <option>제목</option> 
                           </select>
                        <div class="d-flex align-items-center justify-content-between mb-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="제품을 검색하세요" name="keyword"
                                    value='<c:out value="${ createDTO.pagingDTO.keyword}"/>'/>
                                    <div class="input-group-append">
                                        <span class="input-group-text bg-transparent text-primary">
                                           <a class="btnSearchGo" ><i class="fa fa-search"></i></a>
                                          </span> 
                                    </div>
                                </div>
                                <input type="hidden" name="pageNum" id="pageNum" value="${createDTO.pagingDTO.pageNum }"/>
			                   	<input type="hidden" name="rowPerPage" id="rowPerPage" value="${createDTO.pagingDTO.rowPerPage }"/>
			                   	<input type="hidden" name="lastPageNum" id="lastPageNum" value="${CreateDTO.realPageNum }"/>
                            
                            <div class="dropdown ml-4">
                                <button class="btn border dropdown-toggle" type="button" id="triggerId" data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false">
                                            Sort by
                                        </button>
                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="triggerId">
                                    <a class="dropdown-item pop sel" data-sel="pop">인기제품</a>
                                    <a class="dropdown-item getrow sel" data-sel="row">낮은가격</a>
                                    <a class="dropdown-item high sel" data-sel="high">높은가격</a>
                                </div>
                            </div>
                        </div>
                      </form>
                    </div>
                    <c:forEach items="${prod }" var="prod">
                    <c:if test="${fn:contains(prod.prodCode, '-') != true}">
                    <div class="col-lg-4 col-md-6 col-sm-12 pb-1 moveDetail">
                    	<input type="hidden" value="${prod.prodCode}"/>
                        <div class="card product-item border-0 mb-4">
                            <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0 ">
                                <a href="${contextPath }/detail/main?prodCode=${prod.prodCode}"><img class="img-fluid w-100" src="${contextPath }/resources/img/${prod.prodCode }.jpg"></a>
                            </div>
                            <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                                <h6 class="text-truncate mb-3"><c:out value="${prod.prodName }"></c:out></h6>
                                <div class="d-flex justify-content-center">
                                    <h6><c:out value="${prod.price }원"></c:out></h6>
                                </div>
                            </div>
                            <div class="card-footer d-flex justify-content-between bg-light border" >
                            </div>
                        </div>
                    </div>
                    </c:if>
                    </c:forEach>
                   
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
                </div>
            </div>
            <!-- Shop Product End -->
        </div>
    </div>
    <!-- Shop End -->

				
<script type="text/javascript">
var frm = $("#frm");
var frm1 = $("#frm1");

<%--페이징 --%>
$(".page-link").on("click", function(e) {
    e.preventDefault();
    frm.find("input[name='pageNum']").val($(this).attr("href"));
    var query = window.location.search;
    var param = new URLSearchParams(query);
    var sort = param.get('sort');
    var citemtype = param.get('citemtype');
    var categorized = param.get('categorized');
    var producer = param.get('producer');
	frm.find("input[name='sort']").val(sort);
	frm.find("input[name='producer'] ").val(producer);
    frm.attr("action", "${contextPath}/shop/list");
    frm.attr("method", "get");
    $("#citemtype").val(citemtype);
    $("#categorized").val(categorized);
    frm1.submit();
    frm.submit();
 });

<%--검색버튼 클릭 이벤트 처리 --%>
$(".btnSearchGo").on("click",function(e){
	if($("selectScope").find("option:selected").val()){
		alert("검색범위를 선택하세요");
		return false;
	}
	
	if(    !( (frm.find("input[name='keyword']").val() ) || (frm.find("input[name='keyword']").val() != "") )      ){
		alert("검색어를 입력하세요");
		return false;
	}
	frm.find("input[name='pageNum']").val(1);
	frm.append("select[name='scope']").val();
	frm.append("input[name='keyword']").val();
	frm.submit();
});

$(".sel").on("click",function(){
	var data = $(this).data("sel");
	frm.find("input[name='sort']").val(data);
	frm.submit();
});

$(".custom-control-input").click(function(){
	var data = $(this).data("producer");
	frm1.find("input[name='producer']").val(data);
	frm1.submit();
});

$(".moveDetail").on("click", function (e) {
	var prodCode =$(this).find("input").val();
	window.location = "${contextPath}/detail/main?prodCode="+prodCode;
})



$(document).ready(function(){
	
	if("${subtitle}".includes('삼성')){
		$("#size-1").attr("checked",true);
	} else if("${subtitle}".includes('애플')){
		$("#size-2").attr("checked",true);
	} else {
		$("#size-all").attr("checked",true);
	}
	
	var data = $("input[name='selectProducer']:checked").data("producer");	
	check = $("input[name='producer']").val(data);
});

</script> 

<%@ include file="../include/footer.jsp" %>