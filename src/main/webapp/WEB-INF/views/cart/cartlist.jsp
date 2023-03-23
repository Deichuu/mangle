<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="contextPath" value="<%=request.getContextPath() %>" />
<c:set var="Total" value="0" />


<%@ include file="../include/header.jsp" %>


    <!-- Page Header Start -->
    <div class="container-fluid bg-secondary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 150px">
            <h1 class="font-weight-semi-bold text-uppercase mb-3">장바구니</h1>
        </div>
    </div>
    <!-- Page Header End -->


    <!-- Cart Start -->
    <div class="container-fluid pt-5">
        <div class="row px-xl-5">
            <div class="col-lg-8 table-responsive mb-5">
                <table class="table table-bordered text-center mb-0">
                    <thead class="bg-secondary text-dark">
                        <tr>
							<th>상품명</th>
							<th>가격</th>
							<th>수량</th>
							<th>합계</th>
							<th>삭제</th>
                        </tr>
                    </thead>
                    <tbody class="align-middle">
						<c:forEach items="${cartInfo}" var="ci">                   
	                        <tr class="cart_info_tr">
	                            <td class="align-middle"><img src="" alt="" style="width: 50px;">${ci.prodName}</td>
	                            <td class="align-middle">${ci.price}원</td>
	                            <td class="align-middle">
	                                <div class="input-group quantity mx-auto" style="width: 100px;">
	                                    <div class="input-group-btn">
	                                        <button class="btn btn-sm btn-primary btn-minus" >
	                                        	<i class="fa fa-minus"></i>
	                                        </button>
	                                    </div>
	                                    <input type="text" class="form-control form-control-sm bg-secondary text-center" id="quantity_input" value="${ci.amount}" />
	                                    <div class="input-group-btn">
	                                        <button class="btn btn-sm btn-primary btn-plus">
	                                            <i class="fa fa-plus"></i>
	                                        </button>
	                                    </div>
	                                </div>
	                                <a class="quantity_modify_btn" data-cartId="${ci.cartId}" data-amount="${ci.amount}">변경</a>
	                            </td>
	                            <td class="align-middle" id="totalPrice">${ci.totalPrice}원</td>
	                            <c:set var="Total" value="${Total + ci.totalPrice}" />
	                            <td class="align-middle">
	                            	<button class="btn btn-sm btn-primary delete_btn" data-cartid="${ci.cartId}"><i class="fa fa-times"></i></button>
	                            </td>
	                    	</tr>
	                	</c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="col-lg-4">
                <form class="mb-5" id="cart_info_form" action="">
	      		    <input type="hidden" class="individual_price_input" value="${ci.price}">
					<input type="hidden" class="individual_amount_input" value="${ci.amount}">
					<input type="hidden" class="individual_totalPrice_input" value="${ci.totalPrice}">
					<input type="hidden" class="individual_prodCode_input" value="${ci.prodCode}">
                </form>
                <div class="card border-secondary mb-5"> 
	                <div class="d-flex justify-content-between mt-2">
	                	<h5 class="font-weight-bold">배송비 포함 총액 : <c:out value="${Total + 3000}" />원</h5>
	                </div>
                    <div class="card-header bg-secondary border-0">
                        <h4 class="font-weight-semi-bold m-0">
							<button type="button" class="btn btn-block btn-primary my-3 py-3 order_btn" id="cartSubmit">주문하기</button>
						</h4>
                    </div>
	            </div>
	        </div>
	    </div>
	</div>	    
    <!-- Cart End -->
    <form id="submitOrder" action="${contextPath}/order/orderinfo" method="get">
    	<input type="hidden" name="userEmail" value="<sec:authentication property='principal.username'/>"/>
    </form>
    
   	<!-- 수량 조정 form -->
		<form action="${contextPath }/cart/update" method="get" class="quantity_update_form">
			<input type="hidden" name="cartId" class="update_cartId">
			<input type="hidden" name="amount" class="update_amount">
			<input type="hidden" name="userEmail" value="${memberInfo}">
		</form>
    
    
 	<!-- 삭제 form -->
		<form action="${contextPath }/cart/delete" method="post" class="quantity_delete_form">
		<sec:csrfInput/>
			<input type="hidden" name="cartId" class="delete_cartId">
			<input type="hidden" name="userEmail" value="${memberInfo}">
		</form>

<script>
	
	
    var amount = 0;
	// 수량버튼
	$(".btn-plus").on("click", function(e){
		var quantity = $(this).parent().siblings(":text").val();
		$(this).parent().siblings(":text").val(++quantity);
		amount=quantity; 
	});
	
	$(".btn-minus").on("click", function(e){
		var quantity = $(this).parent().siblings(":text").val();
		if(quantity > 1){
			$(this).parent().siblings(":text").val(--quantity);		
		}
		amount=quantity;
	});
	
	
	// 수량 변경 버튼 
	$(".quantity_modify_btn").on("click", function(e){
		var cartId = $(this).data("cartid");
		console.log(cartId);
		//let amount =  $(this).data("amount");
		console.log(amount);
		$(".update_cartId").val(cartId);
		$(".update_amount").val(amount);
		$(".quantity_update_form").submit();	
	});
	
	
	// 삭제 버튼
	$(".delete_btn").on("click", function(e){
		e.preventDefault();
		var cartId = $(this).data("cartid");
		$(".delete_cartId").val(cartId);
		$(".quantity_delete_form").submit();
	});
	
	
	// 주문하기
	$("#cartSubmit").on("click", function(){
		$("#submitOrder").submit();
	});	
	
</script>
    
    
    
<%@ include file="../include/footer.jsp" %>