<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="contextPath" value="<%=request.getContextPath() %>" />


<%@ include file="../include/adminHeader.jsp" %>


<div id="page-wrapper"> 

     <!-- Page Header Start -->
    <div class="container-fluid bg-secondary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 150px">
            <h1 class="font-weight-semi-bold text-uppercase mb-3">상품 관리</h1>
        </div>
    </div>
    <!-- Page Header End -->


	<!-- 상품 등록 -->
	<div class="col-lg-15 px-xl-5 admin_content_main">
		<form action="${contextPath}/stock/add" method="post" id="enrollForm" name="productVO">
		<sec:csrfInput/>
			<table class="table table-bordered text-center mb-0">
				<thead class="bg-secondary text-dark">
	            	<tr>
	                	<th style="text-align: center;">상품코드</th>
	                    <th style="text-align: center;">상품이름</th>
						<th style="text-align: center;">생산지</th>
						<th style="text-align: center;">재고량</th>
						<th style="text-align: center;">가격</th>
						<th style="text-align: center;">커스텀 종류</th>
						<th style="text-align: center;">분류</th>
						<th style="text-align: center;">등록</th>
	            	</tr>
				</thead>
				<tbody class="align-middle">         
					<tr class="align-middle">
						<td class="align-middle"><input name="prodCode"></td>
	                	<td class="align-middle"><input name="prodName"></td>
	                    <td class="align-middle"><input name="producer"></td>
	                    <td class="align-middle"><input name="stock" size="5"></td>
	                    <td class="align-middle"><input name="price"></td>
	                    <td class="align-middle">
	                    	<select name="citemtype">
	                     		<option selected="selected">선택하세요</option>
	                     		<option value="1">일반</option>
	                     		<option value="2">업로드한 사진</option>
	                     		<option value="3">일러스트레이터</option>
	                    	</select>
                    	</td>
	                    <td class="align-middle">
	                    	<select name="categorized">
	                     		<option selected="selected">선택하세요</option>
	                     		<option value="1">phoneCase</option>
	                     		<option value="2">griptok</option>
	                     		<option value="3">EarphoneCase</option>
	                    	</select>	                    
	                    </td>
	                    <td class="align-middle">
	                    <sec:authorize access="hasAnyAuthority('ADMIN')" >
	                    	<button id="enrollBtn" class="btn enroll_btn" style="color: #F79F81; background:gray; font-size:1em; border-radius:0.5em; padding:5px 20px;">등록</button>
	                	</sec:authorize>
	                	</td>
					</tr>        
				</tbody>
			</table>
		</form> 
	</div>  


   <!-- Stock Start -->
   <div class="container-fluid pt-5" >
       <div class="row px-xl-5">
           <div class="col-lg-15 table-responsive mb-5">
               <table class="table table-bordered text-center mb-0">
                   <thead class="bg-secondary text-dark">
                       <tr>
                       	<th style="text-align: center;">상품순서</th>
                       	<th style="text-align: center;">상품코드</th>
						<th style="text-align: center;">상품명</th>
						<th style="text-align: center;">가격</th>
						<th style="text-align: center;">재고량</th>
						<th style="text-align: center;">삭제</th>
                       </tr>
                   </thead>
                   <tbody class="align-middle">
					<c:forEach items="${prodInfo}" var="pi" varStatus="status">                   
                        <tr class="prod_info_tr">
                        	<td align="center" class="align-middle">${fn:length(prodInfo) - status.index}</td>
                        	<td class="align-middle">${pi.prodCode}</td>
                            <td class="align-middle"><img src="" alt="" style="width: 50px;">${pi.prodName}</td>
                            <td class="align-middle">${pi.price}</td>
                            <td class="align-middle">
                                <div class="input-group quantity mx-auto " style="width: 100px; margin: auto;">
                                    <div class="input-group-btn">
                                        <button class="btn btn-sm btn-primary btn-minus" >
                                        	<i class="fa fa-minus"></i>
                                        </button>
                                    </div>
                                    <input type="text" class="form-control form-control-sm bg-secondary text-center" id="quantity_input" value="${pi.stock}" />
                                    <div class="input-group-btn">
                                        <button class="btn btn-sm btn-primary btn-plus">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                </div>
                                <a class="quantity_modify_btn" data-prodCode="${pi.prodCode}" data-stock="${pi.stock}">변경 적용</a>
                            </td>
                            <td class="align-middle">
                            <sec:authorize access="hasAnyAuthority('ADMIN')" >
                            	<button class="btn btn-sm btn-primary delete_btn" data-prodCode="${pi.prodCode}"><i class="fa fa-times"></i></button>
                            </sec:authorize>
                            </td>
                    	</tr>
                	</c:forEach>        
                   </tbody>
               </table>
           </div>
   	</div>
   </div>
</div>	
   <!-- Stock End -->
    
    
   	<!-- 수량 조정 form -->
		<form action="${contextPath }/stock/update" method="get" class="quantity_update_form">
			<input type="hidden" name="prodCode" class="update_prodCode">
			<input type="hidden" name="stock" class="update_stock">
		</form>
    
    
 	<!-- 삭제 form -->
		<form action="${contextPath }/stock/delete" method="post" class="quantity_delete_form">
			<sec:csrfInput/>
			<input type="hidden" name="prodCode" class="delete_prodCode">
		</form>
			
        
<script>
	
	
<%-- HTML에서 일어나는 모든 Ajax 전송 요청에 대하여 csrf 토큰값이 요청 헤더에 설정됨
앞 실습으로 이미 구성되어 있음, 않된 경우 추가 --%>
var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = "${_csrf.token}";

$(document).ajaxSend(function(e, xhr, options){ 
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});
	
	
    var stock = 0;
	// 수량버튼
	$(".btn-plus").on("click", function(e){
		var quantity = $(this).parent().siblings(":text").val();
		$(this).parent().siblings(":text").val(++quantity);
		stock=quantity; 
	});
	
	$(".btn-minus").on("click", function(e){
		var quantity = $(this).parent().siblings(":text").val();
		if(quantity > 0){
			$(this).parent().siblings(":text").val(--quantity);		
		}
		stock=quantity;
	});
	
	
	// 재고량 변경 버튼 
	$(".quantity_modify_btn").on("click", function(e){
		var prodCode = $(this).data("prodcode");
		$(".update_prodCode").val(prodCode);
		$(".update_stock").val(stock);
		$(".quantity_update_form").submit();	
	});
	
	
	// 상품 삭제 버튼
	$(".delete_btn").on("click", function(e){
		e.preventDefault();
		var prodCode = $(this).data("prodcode");
		$(".delete_prodCode").val(prodCode);
		$(".quantity_delete_form").submit();
	});
	

	// 상품 등록 버튼
	var enrollForm = $("#enrollForm")
	$("#enrollBtn").on("click",function(e){
		
		e.preventDefault();
		
		enrollForm.submit();
		
	});
	
	
function checkResult(result){
	
	if(result === ''){
		return;
	}
	
	alert("상품'"+ result +"'을 등록하였습니다.");
}


$(document).ready(function(){
	
	var eResult = '<c:out value="${add_result}"/>';
	
	checkResult(eResult);
	
});	


</script>
    
        
<%@ include file="../include/adminFooter.jsp" %>