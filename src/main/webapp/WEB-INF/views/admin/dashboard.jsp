<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 

<%@ include file="../include/adminHeader.jsp" %>
<!-- Content wrapper -->
          <div class="content-wrapper">
            <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <div class="row">
                <div class="col-lg-8 mb-4 order-0">
                  <div class="card">
                    <div class="row row-bordered g-0">
                      <div class="text-sm-left">
                        <div class="card-body">
	                        <h5>일별 매출 그래프</h5>
	                       	<i class="fa fa-bar-chart-o fa-fw"></i>
	                       	<div id="perDay" class="px-2"></div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-12 col-md-8 col-lg-4 order-3 order-md-2">
                  <div class="row">
                    <div class="col-6 mb-4">
                    
                      <div class="card">
                      
                        <div class="card-body">
                          <div class="card-title d-flex align-items-start justify-content-between">
                            <div class="avatar flex-shrink-0">
                            <a href="${contextPath }/admin/memberList">
                              <img
                                src="${contextPath }/resources/img/unicons/chart-success.png"
                                alt="chart success"
                                class="rounded"
                              /></a>
                            </div>

                          </div>
                          <span class="fw-semibold d-block mb-1">새로운 회원</span>
                          <h3 class="card-title mb-2">${memberCnt }</h3>
                        </div>
                        
                      </div>
                     </div> 
                    
                    <div class="col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="card-title d-flex align-items-start justify-content-between">
                            <div class="avatar flex-shrink-0">
                           
                              <img
                                src="${contextPath }/resources/img/unicons/wallet-info.png"
                                alt="Credit Card"
                                class="rounded"
                              />
                            </div>
                          </div>
                          <span>1년간 전체 판매액</span>
                          <h3 class="card-title text-nowrap mb-1">${totalSales }</h3>
                        </div>
                      </div>
                    </div>
                                      
                    <div class="col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="card-title d-flex align-items-start justify-content-between">
                            <div class="avatar flex-shrink-0">
                            <a href="${contextPath }/admin/deliveryList">
                              <img src="${contextPath }/resources/img/unicons/paypal.png" alt="Credit Card" class="rounded" />
                              </a>
                            </div>
                          </div>
                          <span class="d-block mb-1">오늘 들어온 주문</span>
                          <h3 class="card-title text-nowrap mb-2">${newOrder }</h3>
                        </div>
                      </div>
                    </div>
                    
                    <div class="col-6 mb-4">
                      <div class="card">
                        <div class="card-body">
                          <div class="card-title d-flex align-items-start justify-content-between">
                            <div class="avatar flex-shrink-0">
                            <a href="${contextPath }/mtomboard/list">
                              <img src="${contextPath }/resources/img/unicons/cc-primary.png" alt="Credit Card" class="rounded" /></a>
                            </div>
                          </div>
                          <span class="fw-semibold d-block mb-1">새 문의 답변</span>
                          <h3 class="card-title mb-2">${newMtoM }</h3>
                        </div>
                      </div>
                    </div>
                    
                    </div>
                  </div>
                
                </div>
                <div class="row">
                                <!-- Order Statistics -->
                <div class="col-md-6 col-lg-4 col-xl-4 order-0 mb-4">
                  <div class="card h-100">
                    <div class="card-header d-flex align-items-center justify-content-between pb-0">
                      <div class="card-title mb-0">
                        <h5 class="m-0 me-2">3년간의 매출 그래프</h5>
                      </div>
                    </div>
                    <div class="card-body">
                        
                        <div id="perYears"></div>
                
                    </div>
                  </div>
                </div>
                <!--/ Order Statistics -->

                <!-- Expense Overview -->
                <div class="col-md-6 col-lg-4 order-1 mb-4">
                  <div class="card">
                    <div class="card-header">
                      가장 잘 팔리는 상품
                    </div>
                    <div class="card-body px-0">
                      <table width="100%" class="table table-striped table-bordered table-hover">
								<tr>
									<th>상품코드</th>
									<th>상품이름</th>
									<th>가격</th>
									<th>팔린 개수</th>
								</tr>
								<c:forEach var="best" items="${bestProd }">
								<tr>
									<td>${best.prodCode }</td>
									<td>${best.prodName }</td>
									<td>${best.price }</td>
									<td>${best.stock }</td>
								</tr>
								</c:forEach>
							</table>
                    </div>
                  </div>
                </div>
                <!--/ Expense Overview -->
                
                <div class="col-12 col-md-8 col-lg-4 order-3 order-md-2">
                  <div class="row">

                    </div>
                    <!-- </div>
    <div class="row"> -->
                    <div class="col-12 mb-4">
                      <div class="card">
                      <div class="card-header">
                      <div class="card-title">
                      	<h5 class="text-nowrap mb-2">품목별 매출</h5>
                      	</div>
                      </div>
                        <div class="card-body">
                          <div class="d-flex justify-content-between flex-sm-row flex-column gap-3">
                            <div class="d-flex flex-sm-column flex-row align-items-start justify-content-between">
                              
                                
                                <div id="perCate"></div>
                              
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  
                </div>
              </div>
              <div class="row">
              <div class="col-md-4 col-lg-8 col-xl-8 order-0 mb-4">
             
                  <div class="card h-100">
                    <div class="card-header">
                      <div class="card-title mb-0">
                        <h5 class="m-0 me-2">월별 매출 그래프</h5>
                      </div>
                    </div>
                    <div class="card-body">
                        
                        <div id="perMonths"></div>
                
                    </div>
                  </div>
                  </div>
                  <div class="col-md-6 col-lg-4 col-xl-4 order-0 mb-4">
                  <div class="card">
                    <div class="card-header">
                      재고가 부족한 상품
                    </div>
                    <div class="card-body px-0">
						<table width="100%" class="table table-striped table-bordered table-hover">
								<tr>
									<th>상품코드</th>
									<th>상품이름</th>
									<th>재고 개수</th>
								</tr>
								<c:forEach var="prod" items="${lowStock }">
								<tr>
									<td>${prod.prodCode }</td>
									<td>${prod.prodName }</td>
									<td>${prod.stock }</td>
								</tr>
								</c:forEach>
							</table>
                    </div>
                  </div>
                </div>
				</div>
                
              </div>
            </div>
            <!-- / Content -->

    
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js"></script>-->

<script type="text/javascript">

function daychart() {
		window.areaChart = Morris.Area({
		element: "perDay",
		
		data: [
			<c:forEach var="i" items="${salePerDay }" varStatus="status">
			{day: '${i.orderDate }', value:'${i.sale }'}<c:if test="${status.last eq false}">,</c:if>
			</c:forEach>
		],
		xkey: 'day',
		ykeys: ['value'],
		labels: ['Value']
	});
}
function monthchart() {
	window.barChart = Morris.Bar({
	element: "perMonths",
	
	data: [
		<c:forEach var="i" items="${salePerMonth}" varStatus="status">
		{month: '${i.orderDate }', value:'${i.sale }'}<c:if test="${status.last eq false}">,</c:if>
		</c:forEach>
	],
	xkey: 'month',
	ykeys: ['value'],
	labels: ['Value']
});
}

function yearchart() {
	window.barChart = Morris.Bar({
	element: "perYears",
	
		data: [
			<c:forEach var="i" items="${salePerYear}" varStatus="status">
			{year: '${i.orderDate }', value:'${i.sale }'}<c:if test="${status.last eq false}">,</c:if>
			</c:forEach>
		],
		xkey: 'year',
		ykeys: ['value'],
		labels: ['Value']
	});
}
function donutchart() {
	 window.donutChart = Morris.Donut({
		element: "perCate",
		
		data: [
			<c:forEach var="i" items="${perCate}" varStatus="status">
			{label: '${i.cateDeli }', value:'${i.cnt }'}<c:if test="${status.last eq false}">,</c:if>
			</c:forEach>
		]
	});
}

$(document).ready(function () {
	daychart();
	monthchart();
	yearchart();
	donutchart();
	
/* 	$(window).resize(function () {
	    window.barChart.redraw();
	    window.areaChart.redraw();
	    window.donutChart.redraw();
	}) */
})
</script>


<%@ include file="../include/adminFooter.jsp" %>