<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 

<%@ include file="../include/header.jsp" %>


<!-- Page Header Start -->
    <div class="container-fluid bg-secondary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
            <h1 class="font-weight-semi-bold text-uppercase mb-3">주문확인</h1>
            <div class="d-inline-flex">

                <p class="m-0">Order History</p>
            </div>
        </div>
    </div>
<!-- Page Header End -->

		<!-- 배송지 정보 폼 시작 -->
		
<!-- 주문번호, 주문아이디 정보 시작 --> 
		
<div>	<!-- 내가 추가한 div. 여기에 forEach 넣어서 돌려돌려~ -->	
	<c:forEach items="${orderList }" var="orderList">
	 	<div class="row px-xl-5">
        	<div class="col-lg-12 table-responsive mb-5">
            	<table class="table table-bordered text-center mb-0">
                	<thead class="bg-secondary text-dark">
	                    <tr> <!-- orderList로 가져옵니다. -->
	                        <th>주문번호</th> <!-- orderId -->
	                        <th>받는사람</th> <!-- userEmail -->
	                        <th>주문날짜</th> <!-- orderDate --><!-- 
	                        <th>수량</th> amount -->
						</tr>
                	</thead>
					
					<tbody class="align-middle">
	                    <tr class="toDetail">
	                    	<td class="align-middle"><a href="${contextPath }/order/myorderlist?orderId=${orderList.orderId }&userEmail=<sec:authentication property='principal.username'/>"
	                    	><c:out value="${orderList.orderId }"/></a></td>
	                        <td class="align-middle"><c:out value="${orderList.receiver }"/></td>
	                        <td class="align-middle"><fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${orderList.orderDate}" /></td> <%--                        
	                        <td class="align-middle"><c:out value="${orderList.amount }"/></td> --%>
	                    </tr>
					</tbody>
           	 	</table>
            <!-- 주문번호 끝 -->
            
            
            
		 <!-- 배송정보 시작 --><%-- 
	<div class="card border-secondary mb-5">
     	<div class="card-header bg-secondary border-0">
        	<h4 class="font-weight-semi-bold m-0">배송정보</h4>
     	</div>
     		<div class="card-body">
				<div class="d-flex justify-content-between mb-3 pt-1">
					<h6 class="font-weight-bold">수령인</h6>
	              	<h6 class="font-weight-medium"><c:out value="${orderList.receiver }"/></h6>
        	   	</div>
        	   	
	 			<div class="d-flex justify-content-between">
					<h6 class="font-weight-bold">연락처</h6>
					<h6 class="font-weight-medium"><c:out value="${orderList.reMobile }"/></h6>
				</div>
     		</div>
    			<div class="card-footer border-secondary bg-transparent">
         		<div class="d-flex justify-content-between">
         			<h6 class="font-weight-bold">주소</h6>
           			<h6 class="font-weight-medium"><c:out value="${orderList.reAddress }"/></h6>
				</div>
      			</div>      
         
     </div> --%>
           <!-- 배송정보(수령인,주소,연락처) 끝 -->   
           
           
           		
		          
  <!-- 주문요약 시작 -->
	<div class="card border-secondary mb-5">
		<div class="card-header bg-secondary border-0">
    		<h4 class="font-weight-semi-bold m-0">주문요약</h4>
		</div>
		<div class="card-body">
			<div class="d-flex justify-content-between mb-3 pt-1">
   		     	<h6 class="font-weight-bold">상품명</h6>
   		     	<c:choose>
   		     		<c:when test="${orderList.total == 0 }">
   		     			<h6 class="font-weight-medium">${orderList.prodName }</h6>
   		     		</c:when>
   		     		<c:when test="${orderList.total != 0 }">
   		     			<h6 class="font-weight-medium">${orderList.prodName } 외 ${orderList.total }개</h6>
   		     		</c:when>
   		     	</c:choose>	         	
   	     	</div>
		</div>
			<div class="card-footer border-secondary bg-transparent">
    		<div class="d-flex justify-content-between">
				<h6 class="font-weight-bold"></h6>
		        <h6 class="font-weight-medium">주문번호를 누르면 상세내역으로 넘어갑니다.</h6>
			</div>
 			</div>      
 	</div>
                    
      <!-- 주문요약 끝 -->      
                    
			</div>                
		</div>
	</c:forEach>
</div>
	
             <!-- 배송지 정보 폼 끝 -->


<%@ include file="../include/footer.jsp" %>