<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 

<html lang="ko">
<head>
	<title>403</title>
	<meta charset="utf-8">
	<style type="text/css">
	</style>
</head>
<body>
<div style="text-align: center;">

<a href="${contextPath }/shop/index"><img src="${contextPath }/resources/img/403error.png"></a>

</div>
</body>
</html>



