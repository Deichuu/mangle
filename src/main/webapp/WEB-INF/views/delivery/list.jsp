<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="<%=request.getContextPath() %>"/>

<%@ include file="../include/header.jsp" %>



  <!-- Page Header Start -->
    <div class="container-fluid bg-secondary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 200px">
            <h1 class="font-weight-semi-bold text-uppercase mb-1">배송조회</h1>
            <div class="d-inline-flex">
            </div>
        </div>
    </div>
    <!-- Page Header End -->

  <div class="container-fluid pt-5">
    <div class="row px-xl-5">
        <div class="col-lg-12 table-responsive mb-5">
          <form id="frm" name="frm">
            <table class="table table-bordered text-center mb-0">
                <thead class="bg-secondary text-dark">
                    <tr>
                        <th>주문번호</th>
                        <th>송장번호</th>
                        <th>결제수량</th>
                        <th>배송관리</th>
                    </tr>
                </thead>
                
                
            <tbody class="align-middle">
            
	            <c:forEach items="${delivlist }" var="delivery">
	            
	            <c:choose>
	            	<c:when test="${ delivery.dstatus == 0}">
	            		<c:set var="status" value="주문접수중" ></c:set>
	            	</c:when>
	            	<c:when test="${ delivery.dstatus == 1}">
	            		<c:set var="status" value="배송중"></c:set>
	            	</c:when>
	            	<c:when test="${ delivery.dstatus == 3}">
	            		<c:set var="status" value="주문취소"></c:set>
	            	</c:when>
	            	<c:when test="${ delivery.dstatus == 4}">
	            		<c:set var="status" value="구매확정"></c:set>
	            	</c:when>
	            	<c:otherwise><c:set var="status" value="배송완료"/></c:otherwise>
	            </c:choose>
	            
	              <tr>
	                  <td class="align-middle" style="width: 10%;" id="orderId"
	                  	><a href="${contextPath }/delivery/detail?orderId=${delivery.orderId }&userEmail=<sec:authentication property='principal.username'/>"
	                  		><c:out value="${delivery.orderId }"/></a></td>
	                  <td class="align-middle" style="width: 10%;"><c:out value="${delivery.invoice}"/>
	                  <td class="align-middle" style="width: 10%;"><c:out value="${delivery.count }"/></td>
	                  
	                  <c:choose >
	                  	<c:when test="${delivery.dstatus == 0 }">
		                  <td class="align-middle" style="width: 10%;"><strong><c:out value="${ status}"/></strong><br>
	                  	  	<button class="btn btn-sm" type="button" name="canclebtn" >주문취소</button><input type="hidden" value="${delivery.orderId }">
	                  	  	</td>
	                  	  	
	                	</c:when>
	                	<c:when test="${delivery.dstatus == 1 }">
		                  <td class="align-middle" style="width: 10%;" id="status"><strong><c:out value="${ status}"/></strong><br>
	                	</c:when>
	                	<c:when test="${delivery.dstatus == 3 }">
		                  <td class="align-middle" style="width: 10%;" id="status"><strong><c:out value="${ status}"/></strong><br>
	                	</c:when>
	                	<c:when test="${delivery.dstatus == 4 }">
		                  <td class="align-middle" style="width: 10%;" id="status"><strong><c:out value="${ status}"/></strong><br>
	                	</c:when>
	                  	<c:otherwise >
	    	              <td class="align-middle" style="width: 10%;" name="status" id="status" >
	    	              	<strong><c:out value="${ status}"/></strong><br>
	                  		<button class="btn btn-primary btn-sm" type="button" name="permitbtn"  value="${st==4}">구매확정</button>&nbsp;
	                  		<input type="hidden" value="${delivery.orderId }">
	                  	</td>
	                  	</c:otherwise>
	                  </c:choose>
	              </tr>
	              <sec:csrfInput/>
	            </c:forEach>
	            
           </tbody>
      </table><br>
      		<input type="hidden" name="userEmail" value="<sec:authentication property='principal.username'/>" />
          </form>
     </div>
    </div>
   </div>

<script type="text/javascript">

var csrfHeaderName = "${_csrf.headerName}";
var csrfToken = "${_csrf.token}";
var frm = $("#frm");
/*
function permit(){
	$("td[name='status']").html("구매가 확정되었습니다.");
}

function cancle(){
	$("#statusCancle").html("구매가 취소되었습니다.");
}
*/

$(document).ajaxSend(function(e,xhr, options){
   xhr.setRequestHeader(csrfHeaderName, csrfToken);
});

$("button[name=permitbtn]").on("click", function (e) {
	
	var orderId = $(this).parent().siblings('#orderId').text();

	console.log("cancleOrderID: " + orderId);

	$.ajax({
		type : "post",
		url : "${contextPath}/delivery/status",
		data: {orderId: orderId, dstatus: 4},
		success: function (data) {
			alert("주문번호: " + orderId + "번 주문이 구매확정되었습니다.");
			window.location.reload();
		}
	});

});

$("button[name=canclebtn]").on("click", function (e){
	var orderId = $(this).parent().siblings('#orderId').text();
	
	console.log("cancleOrderID: " + orderId);

 	$.ajax({
		type : "post",
		url : "${contextPath}/delivery/status",
		data: {orderId: orderId, dstatus: 3},
		success: function (data) {
			alert("주문번호: " + orderId + "번 주문이 취소되었습니다.");
			window.location.reload();
		}
	});
});

</script>

<%@ include file="../include/footer.jsp" %>