<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="contextPath" value="<%=request.getContextPath() %>" />


<%@ include file="../include/header.jsp" %>


    <%-- Featured Start --%>
    <div class="container-fluid pt-5">
        <div class="row px-xl-5 pb-3">
            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                <div class="d-flex align-items-center border mb-4" style="padding: 30px;">
                    <h1 class="fa fa-check text-primary m-0 mr-3"></h1>
                    <h5 class="font-weight-semi-bold m-0">좋은 품질의 서비스</h5>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                <div class="d-flex align-items-center border mb-4" style="padding: 30px;">
                    <h1 class="fa fa-shipping-fast text-primary m-0 mr-3"></h1>
                    <h5 class="font-weight-semi-bold m-0">빠른 배송</h5>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                <div class="d-flex align-items-center border mb-4" style="padding: 30px;">
                    <h1 class="fas fa-exchange-alt text-primary m-0 mr-3"></h1>
                    <h5 class="font-weight-semi-bold m-0">고객님과 일러스트레이터의 컨텍</h5>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                <div class="d-flex align-items-center border mb-4" style="padding: 30px;">
                    <h1 class="fa fa-keyboard text-primary m-0 mr-3"></h1>
                    <h5 class="font-weight-semi-bold m-0">실시간 채팅 상담 서비스<br>[09:00 ~ 18:00]</h5>
                </div>
            </div>
        </div>
    </div>
    <%-- Featured End --%>


    <%-- 인기 상품 Start --%>
    <div class="container-fluid pt-5">
        <div class="text-center mb-4">
            <h2 class="section-title px-5"><span class="px-2">인기 상품</span></h2>
        </div>

			<div class="row px-xl-5 pb-3">
            <c:forEach items="${product}" var="product"><%-- 컨트롤러에서 보낸 목록객체 이름: productList --%>
			
	            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
	                <div class="card product-item border-0 mb-4">
	                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
	                        <a href="${contextPath }/detail/main?prodCode=${product.prodCode}"><img class="card-img-top" src="${contextPath }/resources/img/${product.prodCode }.jpg"></a>
	                    </div>
	                    <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
	                        <h6 class="text-truncate mb-3"><c:out value="${product.prodName}" /></h6>
	                        <div class="d-flex justify-content-center">
	                            <h6><c:out value="${product.price}원" /></h6>
	                        </div>
	                    </div>
	                    <div class="card-footer d-flex justify-content-between bg-light border" >
                        </div>
	                </div>
	            </div>
	        
            </c:forEach>
			</div>
        
    </div>
    <%-- 인기 상품 End --%>
    
    
<script>

   
</script>
    
    
<%@ include file="../include/footer.jsp" %>