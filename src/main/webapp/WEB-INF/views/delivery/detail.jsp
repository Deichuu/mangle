<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="<%=request.getContextPath() %>"/>

<%@ include file="../include/header.jsp" %>



  <!-- Page Header Start -->
    <div class="container-fluid bg-secondary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 200px">
            <h1 class="font-weight-semi-bold text-uppercase mb-1">주문상세조회</h1>
            <div class="d-inline-flex">
            </div>
        </div>
    </div>
    <!-- Page Header End -->

  <div class="container-fluid pt-5">
    <div class="row px-xl-5">
        <div class="col-lg-12 table-responsive mb-5">
          <form action="${contextPath }/delivery/detail" id="frm" name="frm">
            <table class="table table-bordered text-center mb-0">
                <thead class="bg-secondary text-dark">
                    <tr>
                        <th>주문번호</th>
                        <th>제품</th>
                        <th>결제금액</th>
                        <th>결제수량</th>
                        <th>결제상태</th>
                    </tr>
                </thead>
         <tbody class="align-middle">
            <c:forEach items="${dl }" var="dl">
            <c:choose>
            	<c:when test="${ dl.dstatus == 0}">
            		<c:set var="status" value="주문접수중" ></c:set>
            	</c:when>
            	<c:when test="${ dl.dstatus == 1}">
            		<c:set var="status" value="배송중"></c:set>
            	</c:when>
            	<c:when test="${ dl.dstatus == 3}">
            		<c:set var="status" value="주문취소"></c:set>
            	</c:when>
            	<c:when test="${ dl.dstatus == 4}">
            		<c:set var="status" value="구매확정"></c:set>
            	</c:when>
            	<c:otherwise><c:set var="status" value="배송완료"/></c:otherwise>
            </c:choose> 
            
           		<c:forEach items="${dl.order}" var="dlOrder">
              	  <c:forEach items="${dlOrder.productList}" var="dlOrderProd">
              <tr>
	                  <td class="align-middle" style="width: 10%;"><c:out value="${dl.orderId }"/></td>
	              	  <td class="align-middle" style="width: 10%;"><c:out value="${dlOrderProd.prodName}"/></td>
	                  <td class="align-middle" style="width: 10%;"><c:out value="${dlOrderProd.price*dlOrder.amount}"/></td>
	              	  <td class="align-middle" style="width: 10%;"><c:out value="${dlOrder.amount}"/></td>
              	  
                  <c:choose >
                  	<c:when test="${dl.dstatus == 0 }">
	                  <td class="align-middle" style="width: 10%;" id="status" name="canclebtn"><strong><c:out value="${ status}"/></strong><br></td>
                	</c:when>
                	<c:when test="${dl.dstatus == 1 }">
	                  <td class="align-middle" style="width: 10%;" id="status"><strong><c:out value="${ status}"/></strong><br>
                	</c:when>
                  	<c:otherwise >
    	              <td class="align-middle" style="width: 10%;" name="status" id="status" ><strong><c:out value="${ status}"/></strong><br></td>
                  	</c:otherwise>
                  </c:choose>
              </tr>
                </c:forEach>
            </c:forEach>
         </c:forEach>
          </tbody>
      </table><br>
          </form>
     </div>
    </div>
   </div>   

<div class="container-fluid pt-5">
    <div class="row px-xl-5">
        <div class="col-lg-12 table-responsive mb-5">
          <form action="${contextPath }/delivery/detail" id="frm" name="frm">
            <table class="table table-bordered text-center mb-0">
                <thead class="bg-secondary text-dark">
                    <tr>
                        <th>총 결제수량</th>
                        <th>총 결제금액</th>
                    </tr>
                </thead>
         	<tbody class="align-middle">
		        	<tr>
		         		<td><c:out value="${total.count }"/></td>
		         		<td><c:out value="${total.totalPrice }"/></td>
		         	</tr>
         	</tbody>
		</table>
	  </form>
    </div>
  </div>
</div>
		

<%@ include file="../include/footer.jsp" %>