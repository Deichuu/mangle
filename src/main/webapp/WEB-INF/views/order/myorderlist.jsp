<%@page import="org.springframework.ui.Model"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dream.mangle.domain.OrderAllLIstVO"%>
<%@page import="com.dream.mangle.domain.OrderSelectVO"%>
<%@page import="com.dream.mangle.domain.OrderVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 

<%@ include file="../include/header.jsp" %>


<!-- Page Header Start -->
    <div class="container-fluid bg-secondary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
            <h1 class="font-weight-semi-bold text-uppercase mb-3">주문내역</h1>
            <div class="d-inline-flex">

                <p class="m-0">Order Detail</p>
            </div>
        </div>
    </div>
<!-- Page Header End -->



		
<!-- 주문 정보 시작 --> 

		
<div>	<!-- 내가 추가한 div. 여기에 forEach 넣어서 돌려돌려~ -->	
	 	<div class="row px-xl-5">
        	<div class="col-lg-12 table-responsive mb-5">
            	<table class="table table-bordered text-center mb-0">
                	<thead class="bg-secondary text-dark">
	                    <tr>
	                        <th>주문번호</th> <!-- orderId -->
	                        <th>주문계정</th> <!-- userEmail -->
	                        <th>주문날짜</th> <!-- orderDate -->
						</tr>
                	</thead>
					
					<tbody class="align-middle">
	                    <tr class="toDetail">

	                    	<td class="align-middle"><c:out value="${myOrder.orderId }"/></td>
	                        <td class="align-middle"><c:out value="${myOrder.userEmail }"/></td>
	                        <td class="align-middle"><fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${myOrder.orderDate}" /></td>                        

	                    </tr>
					</tbody>
           	 	</table>
           	 	</div>
           	 	</div>
    <!-- 주문정보 끝 -->
            
            
            
		 <!-- 배송정보 시작 -->
	
	<div class="card border-secondary mb-5">
     	<div class="card-header bg-secondary border-0">
        	<h4 class="font-weight-semi-bold m-0">배송정보</h4>
     	</div>
     		<div class="card-body">
				<div class="d-flex justify-content-between mb-3 pt-1">
					<h6 class="font-weight-bold">수령인</h6>
	              	<h6 class="font-weight-medium"><c:out value="${myOrder.receiver }"/></h6>
        	   	</div>
        	   	
	 			<div class="d-flex justify-content-between">
					<h6 class="font-weight-bold">연락처</h6>
					<h6 class="font-weight-medium"><c:out value="${myOrder.reMobile }"/></h6>
				</div>
     		</div>
    			<div class="card-footer border-secondary bg-transparent">
         		<div class="d-flex justify-content-between">
         			<h6 class="font-weight-bold">주소</h6>
           			<h6 class="font-weight-medium"><c:out value="${myOrder.reAddress }"/></h6>
				</div>
      			</div>      
         
    		 </div>
    		
</div>

           <!-- 배송정보(수령인,주소,연락처) 끝 -->   

           		
           		
           		
         		 <div class="card border-secondary mb-5">
                    <div class="card-header bg-secondary border-0">
                        <h4 class="font-weight-semi-bold m-0">주문 요약</h4>
                    </div>
                    
                     <div class="card-body">
                        <h5 class="font-weight-medium mb-3">상품정보 (수량)</h5>
                        <hr class="mt-0">
                    <%
                    	Model model = null;
	                	DecimalFormat df =new DecimalFormat("##,###"); //가격 단위 끊어주기
	            		double deliveryFee=3000;
	                	
                    	int sum = 0;
                    	System.out.println("sum: " + sum);
                    	ArrayList<OrderSelectVO> orderDetail = (ArrayList<OrderSelectVO>)request.getAttribute("fromCart");
                    	OrderVO order = (OrderVO)request.getAttribute("myOrder");
                    	int discount = order.getCoupon() + order.getPoint();
                    	for(int i = 0; i<orderDetail.size(); i++){ 
                    		OrderSelectVO vo = orderDetail.get(i);
                    		int total = vo.getTotal();
                    		sum += total;
                    		System.out.println("OrderSelectVO: " + vo);
                    	
                    		
                    		%>
					
                        <div class="d-flex justify-content-between">
                            <p><%=vo.getProdName() %>&nbsp;(<%=vo.getAmount() %>개)</p>
                            <p><%=df.format(vo.getPrice()) %>원</p>
                        </div>

                        
                        <div class="d-flex justify-content-between mb-3 pt-1">
                            <h6 class="font-weight-medium">상품금액</h6>
                            <h6 class="font-weight-medium"><%=df.format(vo.getTotal() )%>원</h6>
                        </div>
                        
                        <hr class="mt-0">

					<% 	}
                    %>
						<div class="d-flex justify-content-between">
                            <h6 class="font-weight-medium">할인</h6>
                            <h6 class="font-weight-medium">-<%=discount %>원</h6>
                        </div>
                        
                        <div class="d-flex justify-content-between">
                            <h6 class="font-weight-medium">배송비</h6>
                            <h6 class="font-weight-medium"><%=df.format(deliveryFee) %>원</h6>
                        </div>
                    </div>
                    <div class="card-footer border-secondary bg-transparent">
                        <div class="d-flex justify-content-between mt-2">
                            <h5 class="font-weight-bold">총합</h5>
                            <h5 class="font-weight-bold"><%=df.format(sum+deliveryFee-discount )%>원</h5>
                        </div>
                    </div>
                </div>                        
		          
  <!-- 주문요약 시작 --><%-- 
  <div>
  	
	<div class="card border-secondary mb-5">
		<div class="card-header bg-secondary border-0">
    		<h4 class="font-weight-semi-bold m-0">주문요약</h4>
		</div>
		<c:forEach items="${fromCart }" var="fromCart">
		<div class="card-body">
			<div class="d-flex justify-content-between mIdeConnections%2523project//PROJECT/TABLE/ORDERDETAILb-3 pt-1">
   		     	<h6 class="font-weight-bold">상품 총액</h6>
	         	<h6 class="font-weight-medium"><c:out value="${fromCart.price*fromCart.amount }"/>원</h6>
   	     	</div>

			<div class="d-flex justify-content-between">    	
		         <h6 class="font-weight-bold">배송비</h6>
		         <h6 class="font-weight-medium">3000원</h6>
      	 	</div>
		</div>
			<div class="card-footer border-secondary bg-transparent">
    		<div class="d-flex justify-content-between">
				<h6 class="font-weight-bold">총합</h6>
		        <h6 class="font-weight-medium"><c:out value="${fromCart.price*fromCart.amount+3000 }"/>원</h6>
			</div>
 			</div>   
 			</c:forEach>     
 	</div> --%>
                    
      <!-- 주문요약 끝 -->      
                  
			</div>                

             <!-- 배송지 정보 폼 끝 -->


     

<%@ include file="../include/footer.jsp" %>