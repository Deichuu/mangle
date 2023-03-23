<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 

<%@ include file="../include/adminHeader.jsp" %>
<!-- Content wrapper -->
          <div class="content-wrapper">
          
          <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header" style="text-align: center;">작가 통계</h1>
                </div> <!-- /.col-lg-12 -->
            </div> <!-- /.row -->    
              
                <!-- Content -->
            <div class="container-xxl flex-grow-1 container-p-y">
            
            <!-- Expense Overview -->
                <div class="col-md-6 col-lg-12 order-1 mb-4">
                  <div class="card h-100">
                    <div class="card-header">
                      오늘 들어온 주문
                    </div>
                    <div class="card-body px-0">
                      <table width="100%" class="table table-striped table-bordered table-hover">
								<tr>
									<th>주문번호</th>
                                    <th>제품이름</th>
                                    <th>제품가격</th>
                                    <th>주문수량</th>
                                    <th>주문날짜</th>
								</tr>
								<c:forEach items="${todaySales }" var="todaySales">                                       
                                	<c:forEach items="${todaySales.orderDetailList }" var="orderDetailList">
		                            	<c:forEach items="${orderDetailList.productList }" var="productList">
								<tr>
		                            <td>${todaySales.orderId }</td>
		                            <td>${productList.prodName }</td>
		                            <td>${orderDetailList.amount }</td>
		                            <td>${productList.price }</td>
		                            <td><fmt:formatDate value='${todaySales.orderDate }' pattern="yyyy-MM-dd HH:mm:ss" /></td>
		                        </tr>
		                                 </c:forEach>
	                                </c:forEach>
                                </c:forEach>
							</table>
                    </div>
                  </div>
                </div>
                <!--/ Expense Overview -->
                
                <!-- Expense Overview -->
                <div class="col-md-6 col-lg-12 order-1 mb-4">
                  <div class="card h-100">
                    <div class="card-header">
                      제품별 판매 수량
                    </div>
                    <div class="card-body px-0">
                      <table width="100%" class="table table-striped table-bordered table-hover">
								<tr>
									 <th>판매한 제품명</th>
                                     <th>제품의 가격</th>
                                     <th>총 판매한 제품 개수</th>
                                     <th>제품의 평점</th>
                                     <th>제품 종류</th>
								</tr>
								<c:forEach items="${productList }" var="product">
	                                <tr class="odd gradeX">
	                                    <td>${product.prodName }</td>
	                                    <td>${product.price }</td>
	                                    <td>${product.total.totalPrice }</td>
	                                    <td>${product.ratingAvg }</td>
	                                    <td>${product.accType }</td>
	                                </tr>
                                </c:forEach>
							</table>
                    </div>
                  </div>
                </div>
                <!--/ Expense Overview -->
                
              <div class="row">
                <div class="col-lg-12 mb-4 order-0">
                  <div class="card">
                    <div class="d-flex align-items-end row">
                      <div class="text-sm-left">
                        <div class="card-body">
	                        <h5>카테고리별 그래프</h5>
	                       	<i class="fa fa-bar-chart-o fa-fw"></i>
	                       	<div id="totalCategory" class="px-2"></div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
               </div>
                
                <!-- Expense Overview -->
                <div class="col-md-6 col-lg-12 order-1 mb-4">
                  <div class="card h-100">
                    <div class="card-header">
                       케이스 종류별 금액 합계
                    </div>
                    <div class="card-body px-0">
                      <table width="100%" class="table table-striped table-bordered table-hover">
								<tr>
                                   <th style="width: 50%">카테고리</th>
                                   <th>합계금액</th>
                                </tr>
                                <% int total = 0;%>
								<c:forEach items="${totalCategory }" var="totalCategory">
                                    <tr>
                                        <td>${totalCategory.category }</td>
	                                    <td>${totalCategory.totalPrice }</td>
                                    </tr>
                                </c:forEach>
							</table>
                    </div>
                  </div>
                </div>
                <!--/ Expense Overview -->
                
                <div class="row">
                <div class="col-lg-12 mb-4 order-0">
                  <div class="card">
                    <div class="d-flex align-items-end row">
                      <div class="text-sm-left">
                        <div class="card-body">
	                        <h5>일별 그래프</h5>
	                       	<i class="fa fa-bar-chart-o fa-fw"></i>
	                       	<div id="perDays" class="px-2"></div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
               </div>            
              
              <!-- Expense Overview -->
                <div class="col-md-6 col-lg-12 order-1 mb-4">
                  <div class="card h-100">
                    <div class="card-header">
                       케이스 종류별 금액 합계
                    </div>
                    <div class="card-body px-0">
                      <table width="100%" class="table table-striped table-bordered table-hover">
								<tr>
                                   <th style="width: 50%">날짜</th>
                                   <th>총 금액</th>
                                </tr>
								<c:forEach items="${perDays }" var="perDays">                                       
                                   <tr>
                                      <td>${perDays.orderDate }</td>
	                                  <td>${perDays.totalPrice }</td>
                                   </tr>
                                </c:forEach>
							</table>
                    </div>
                  </div>
                </div>
                <!--/ Expense Overview -->
                
                <div class="row">
                <div class="col-lg-12 mb-4 order-0">
                  <div class="card">
                    <div class="d-flex align-items-end row">
                      <div class="text-sm-left">
                        <div class="card-body">
	                        <h5>월별 그래프</h5>
	                       	<i class="fa fa-bar-chart-o fa-fw"></i>
	                       	<div id="perMonths" class="px-2"></div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
               </div>            
              
              <!-- Expense Overview -->
                <div class="col-md-6 col-lg-12 order-1 mb-4">
                  <div class="card h-100">
                    <div class="card-header">
                       월별 통계
                    </div>
                    <div class="card-body px-0">
                      <table width="100%" class="table table-striped table-bordered table-hover">
								<tr>
                                    <th style="width: 50%">날짜</th>
                                    <th>총 금액</th>
                                </tr>
								<c:forEach items="${perMonths }" var="perMonths">                                       
                                    <tr>
                                        <td>${perMonths.orderDate }</td>
                                 	<td>${perMonths.totalPrice }</td>
                                    </tr>
                                </c:forEach>
							</table>
                    </div>
                  </div>
                </div>
                <!--/ Expense Overview -->
                
                <div class="row">
                <div class="col-lg-12 mb-4 order-0">
                  <div class="card">
                    <div class="d-flex align-items-end row">
                      <div class="text-sm-left">
                        <div class="card-body">
	                        <h5>년도별 그래프</h5>
	                       	<i class="fa fa-bar-chart-o fa-fw"></i>
	                       	<div id="perYears" class="px-2"></div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
               </div>            
              
              <!-- Expense Overview -->
                <div class="col-md-6 col-lg-12 order-1 mb-4">
                  <div class="card h-100">
                    <div class="card-header">
                       년도별 통계
                    </div>
                    <div class="card-body px-0">
                      <table width="100%" class="table table-striped table-bordered table-hover">
								<tr>
                                    <th style="width: 50%">날짜</th>
                                    <th>총 금액</th>
                                </tr>
								<c:forEach items="${perYears }" var="perYears">                                       
                                    <tr>
                                        <td>${perYears.orderDate }</td>
                                 	<td>${perYears.totalPrice }</td>
                                    </tr>
                                </c:forEach>
							</table>
                    </div>
                  </div>
                </div>
                <!--/ Expense Overview -->
            </div>
    
<script type="text/javascript">
function daychart() {
	window.areaChart = Morris.Area({
		element: 'perDays',
		
		data: [	    		
		<c:forEach items="${perDays }" var="perDays" varStatus="status">
			{ day: '${perDays.orderDate}', value: '${perDays.totalPrice}' }<c:if test="${status.last eq false}">,</c:if>
		</c:forEach>
		],
		xkey: 'day',
		ykeys: ['value'],
		labels: ['value']
	});
}

function Catechart(){
	window.donutChart = Morris.Donut({		
		element: 'totalCategory',
		
		data: [	    		
		<c:forEach items="${totalCategory }" var="c" varStatus="status">
			{ label: '${c.category}', value: '${c.totalPrice}' }<c:if test="${status.last eq false}">,</c:if>
		</c:forEach>
		]
	});
}

function monthchart(){
	window.barChart = Morris.Bar({
		element: 'perMonths',
		
    	data: [	    		
    	<c:forEach items="${perMonths }" var="perMonths" varStatus="status">
    		{ month: '${perMonths.orderDate}', value: '${perMonths.totalPrice}' }<c:if test="${status.last eq false}">,</c:if>
    	</c:forEach>
    	],
    	xkey: 'month',
    	ykeys: ['value'],
    	labels: ['value']
	});
}

function yearchart(){
	window.barChart = Morris.Bar({
		element: 'perYears',
		
    	data: [	    		
    	<c:forEach items="${perYears }" var="perYears" varStatus="status">
    		{ year: '${perYears.orderDate}', value: '${perYears.totalPrice}' }<c:if test="${status.last eq false}">,</c:if>
    	</c:forEach>
    	],
    	xkey: 'year',
    	ykeys: ['value'],
    	labels: ['value']
	});
}

$(document).ready(function () {
	daychart();
	monthchart();
	yearchart();
	Catechart();
})

</script>


<%@ include file="../include/adminFooter.jsp" %>