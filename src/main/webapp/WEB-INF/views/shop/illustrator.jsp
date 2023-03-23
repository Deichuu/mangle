<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="<%=request.getContextPath() %>" />

<%@ include file="../include/header.jsp" %>


<!-- Page Header Start -->
    <div class="container-fluid bg-secondary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
            <h1 class="font-weight-semi-bold text-uppercase mb-3">작가중개</h1>
        </div>
    </div>
<!-- Page Header End -->


<!-- Contact Start -->
    <div class="container-fluid pt-10">
        <div class="text-center mb-5">
            <h2 class="section-title px-5"><span class="px-2">우리와 함께하는 5명의 작가를 소개합니다.</span></h2>
        </div>
        <div style="text-align:center;">
        	<img class="img-fluid w-50" src="${contextPath }/resources/img/introduce_.jpg">
        </div>
        <br><br>
        <div style="text-align:center;">
        	<button type="button" class="btn btn-primary px-3" onclick="location.href='${contextPath}/shop/list?citemtype=3&categorized=1'">나만의 케이스 주문하러 가기</button>
        </div>
        
        
    </div>
<!-- Contact End -->


<%@ include file="../include/footer.jsp" %>