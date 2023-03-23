<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>mangle a dream의 관리자용 대시보드</title>

    <!-- Bootstrap Core CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <!-- Custom CSS -->
<%--     <link href="${contextPath }/resources/dist/css/sb-admin-2.css" rel="stylesheet"> --%>
    <link href="${contextPath }/resources/dist/css/theme-default.css" rel="stylesheet">
    <link href="${contextPath }/resources/dist/css/core.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="${contextPath }/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- jQuery -->
    <script src="${contextPath }/resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="${contextPath }/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
    <script src="${contextPath }/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="${contextPath }/resources/dist/js/sb-admin-2.js"></script>
    
    <!-- DataTables JavaScript -->
    <script src="${contextPath }/resources/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${contextPath }/resources/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="${contextPath }/resources/vendor/datatables-responsive/dataTables.responsive.js"></script>
        
    
        <!-- Morris Charts JavaScript -->
<%--     <script src="${contextPath }/resources/vendor/raphael/raphael.min.js"></script>
    <script src="${contextPath }/resources/vendor/morrisjs/morris.js"></script>
    <script src="${contextPath }/resources/data/morris-data.js"></script>--%> 
<!-- 
<link rel="stylesheet" href="https://www.cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris" /> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js"></script>
	<link rel="icon" href="${contextPath }/resources/img/favicon.png">
</head>

<body>
 <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container">
        <!-- Menu -->

        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
          <div class="app-brand demo">
            <a href="${contextPath }/shop/index" class="app-brand-link">
              <span class="app-brand-text demo menu-text fw-bolder ms-2">Mangle A Dream</span>
            </a>

            <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
              <i class="bx bx-chevron-left bx-sm align-middle"></i>
            </a>
          </div>

          <div class="menu-inner-shadow"></div>

          <ul class="menu-inner py-1">
            <!-- Dashboard -->
            <sec:authorize access="hasAuthority('ADMIN')">
            <li class="menu-item active">
              <a href="${contextPath }/admin/dashboard" class="menu-link">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Analytics">대시보드</div>
              </a>
            </li>

            <!-- Layouts -->
            <li class="menu-item">
              <a href="${contextPath }/admin/memberList" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-layout"></i>
                <div data-i18n="Layouts">회원 목록</div>
              </a>
            </li>
            <li class="menu-item">
              <a href="${contextPath }/stock/manage" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-layout"></i>
                <div data-i18n="Layouts"> 상품 관리</div>
              </a>
            </li>
                        <li class="menu-item">
              <a href="${contextPath }/admin/deliveryList" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-layout"></i>
                <div data-i18n="Layouts"> 배송 관리</div>
              </a>
            </li>
            <li class="menu-header small text-uppercase">
              <span class="menu-header-text">게시판</span>
            </li>
            <li class="menu-item">
                <li class="menu-item">
                  <a href="${contextPath }/notice/list" class="menu-link">
                    <div data-i18n="Account">공지사항</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="${contextPath }/event/list" class="menu-link">
                    <div data-i18n="Notifications">이벤트</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="${contextPath }/bulk/list" class="menu-link">
                    <div data-i18n="Connections">대량주문</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="${contextPath }/faqBoard/list" class="menu-link">
                    <div data-i18n="Connections">FAQ 게시판</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="${contextPath }/mtomboard/list" class="menu-link">
                    <div data-i18n="Connections">1 대 1 문의</div>
                  </a>
                </li>
            </li>
            <!-- Components -->
		</sec:authorize>
        </aside>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">
          <!-- Navbar -->

          <nav
            class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar">
            <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
            </div>

            <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">

              <ul class="navbar-nav flex-row align-items-center ms-auto">
                <!-- Place this tag where you want the button to render. -->
                <li class="nav-item lh-1 me-3">
                </li>

                <!-- User -->
                <li class="nav-item navbar-dropdown dropdown-user dropdown">
                  <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                  </a>
                    <li>
                      <a class="dropdown-item" id="logoutbtn" href="auth-login-basic.html">
                        <i class="bx bx-power-off me-2"></i>
                        <span class="align-middle">Log Out</span>
                      </a>
                    </li>
                </li>
                <!--/ User -->
              </ul>
              <form id="frmsec" action="${contextPath }/logout" method="post">
                    <sec:csrfInput/>
                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
              </form>
            </div>
          </nav>
	
	
<script type="text/javascript">
var frmsec = $("#frmsec");

$("#logoutbtn").on("click", function () {
	var realyRogout = confirm("로그아웃 하시겠습니까?");
	
	if(realyRogout){
		alert("로그아웃이 완료되었습니다.");
		frmsec.submit();
	}
})

</script>	