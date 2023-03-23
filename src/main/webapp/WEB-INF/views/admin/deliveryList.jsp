<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="<%=request.getContextPath() %>"/>
    
<%@ include file="../include/adminHeader.jsp" %>


<div id="page-wrapper">
  <h1 style="text-align: center">배송관리</h1>
  <br><br>
	<div> 
		<form id="formSubmit"  name="frmInvoice">
			<input type="hidden" id="orderId" name="orderId" value="">
			<input type="hidden" id="invoice" name="invoice" value="">
			<sec:csrfInput/>
		</form>

		<form action="${contextPath }/admin/deliveryList" method="post" id="frm" name="frm" >
			<sec:csrfInput/><%-- 	
			<div class="input-group" >
		          <input type="text" class="form-control" id="inputKeyword" name="keyword" placeholder="검색어를 입력하세요" 
		          value='<c:out value="${ paging.keyword}"/>'/>
		          <span class="input-group-btn">
		              <button class="btn btn-primary py-2 px-3" type="button" id="btnSearchGo">
		              검색&nbsp;<i class="fa fa-search"></i>
		              </button>
		          </span>
		    </div> --%>
		</form>
	</div>
	<br><br>
	<form id="frmInvoice" method="post" action="${contextPath }/admin/deliveryList">	
	<table class="table"  style="text-align: center">
	  <thead>
	    <tr>
	      <th scope="col"  style="text-align: center">주문번호</th>
	      <th scope="col"  style="text-align: center">회원계정</th>
	      <th scope="col"  style="text-align: center">수령인</th>
	      <th scope="col"  style="text-align: center">연락처</th>
	      <th scope="col"  style="text-align: center">주소</th>
	      <th scope="col"  style="text-align: center">주문날짜</th>
	      <th scope="col"  style="text-align: center">송장입력</th>
	      <th scope="col"  style="text-align: center">송장번호</th>
	      <th scope="col"  style="text-align: center">배송상태</th>
	      <th scope="col"  style="text-align: center">배송관리</th>
	    </tr>
	  </thead>
	  <tbody>
	  <c:forEach items="${list }" var="list">
	    <tr>
	      <th scope="row"  style="text-align: center" id="orderth">${list.orderId }</th>
	      <td>${list.userEmail }</td>
	      <td>${list.receiver }</td>
	      <td>${list.reMobile }</td>
	      <td>${list.reAddress }</td>
	      <td><fmt:formatDate value="${list.orderDate }" pattern="yyyy/MM/dd HH:mm:ss"/></td>
	     <td><input type="number" name="invoice" id="invoiceInput">&nbsp;<button type="button" name="invoiceBtn" id="invoiceBtn" >입력</button>
	     	 <input type="hidden" id="hiddenOrder" value="${list.orderId }">	</td>
	     <td>${list.deliveryList[0].invoice}&nbsp;</td>
	      
	      <%-- <td>${list.deliveryList[0].dstatus }</td> --%>
	      <td>
	       	<c:choose>
         		<c:when test="${list.deliveryList[0].dstatus==0}">배송 전</c:when>
         		<c:when test="${list.deliveryList[0].dstatus==1}">배송 중</c:when>
         		<c:when test="${list.deliveryList[0].dstatus==2}">배송 완료</c:when>
         		<c:when test="${list.deliveryList[0].dstatus==3}">주문 취소</c:when>
         		<c:when test="${list.deliveryList[0].dstatus==4}">구매 확정</c:when>
          	</c:choose>
	      </td>
	      </form>
	     <td>
	    
 		<form id="change" name="adminDelivery">
	      	<sec:csrfInput/>
	      		<select id="cha" name="dstatus">
	      			<option value="">선택</option>
	      			<option value="0">배송 전</option>
	      			<option value="1">배송 중</option>
	      			<option value="2">배송 완료</option>
	      			<option value="2">주문 취소</option>
	      			<option value="2">구매 확정</option>
	      		</select>
	      		
	      		<input type="hidden" name="orderId" value="${list.orderId }" />
 	      	</form>
	      </td> 
	    </tr>
	    </c:forEach>
	  </tbody>
	</table>
	<br>
	<div style="text-align: center;">
		<form action="${contextPath }/admin/deliveryList">
		<button type="submit">목록으로</button>
		
		</form>
	</div>
	
	<div style="text-align: center;">
		<form action="${contextPath }/admin/dashboard">
		<button type="submit">관리자 페이지로 돌아가기</button>
		</form>
	</div>
</div>


<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

//배송관리 select box
$("select[name='dstatus']").on("change",function(e){
	var change = $(this).closest("#change");
	
	change.attr("method","post");
	change.attr("action","${contextPath}/admin/deliveryStatus");
	change.submit();
});

//송장번호 입력 버튼
var formSubmit=$("#formSubmit");

$("button[name=invoiceBtn]").on("click", function(e){
	var invoice= $(this).siblings("#invoiceInput").val();
	var orderId= $(this).siblings("#hiddenOrder").val();
//	var orderId= $(this).parent(".").siblings("#orderth").val();
	console.log(invoice);
	console.log("order: " + orderId);
	
	if(invoice!="" || invoice.length != 0){
		alert("송장번호 입력 완료");
		
		formSubmit.find("#invoice").val(invoice);
		formSubmit.find("#orderId").val(orderId);
		formSubmit.attr("action", "${contextPath}/admin/deliveryInvoice" );
		formSubmit.attr("method", "post" );
	}
	formSubmit.submit();
	
	
});

</script>

<%@ include file="../include/adminFooter.jsp" %>
