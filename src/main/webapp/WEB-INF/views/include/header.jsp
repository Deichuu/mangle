<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="contextPath" value="<%=request.getContextPath() %>" />

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <title>MANGLE A DREAM</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Free HTML Templates" name="keywords">
    <meta content="Free HTML Templates" name="description">

    <!-- Favicon -->
    <link href="../resources/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet"> 

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="../resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="../resources/css/style.css" rel="stylesheet">
    
    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="../resources/lib/easing/easing.min.js"></script>
    <script src="../resources/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Contact Javascript File -->
<!--     <script src="../resources/mail/jqBootstrapValidation.min.js"></script>
    <script src="../resources/mail/contact.js"></script> -->

    <!-- Template Javascript -->
    <script src="../resources/js/main.js"></script>
    <link rel="icon" href="${contextPath }/resources/img/favicon.png">
</head>

<body>    
    <!-- Topbar Start -->
    <div class="container-fluid" id="md">       
        <div class="row align-items-center py-3 px-xl-5">
            <div class="col-lg-3 d-none d-lg-block">
                <a href="${contextPath }/shop/index" class="text-decoration-none">
                    <h1 class="m-0 display-5 font-weight-semi-bold"><span class="text-primary font-weight-bold border px-3 mr-1">MANGLE</span>A DREAM</h1>
                </a>
            </div>
            <div class="col-lg-6"></div>  
            <div class="col-lg-3 col-6 text-right">
            <sec:authorize access="isAuthenticated()">
                <a href="${contextPath }/cart/cartlist?userEmail=<sec:authentication property="principal.username"/>" class="btn border">
                    <i class="fas fa-shopping-cart text-primary"></i>
                </a>
            </sec:authorize>
            </div>
        </div>
    </div>
    <!-- Topbar End -->


    <!-- Navbar Start -->
    <div class="container-fluid mb-5">
        <div class="row border-top px-xl-5">
            <div class="col-lg-3 d-none d-lg-block">
                <a class="btn shadow-none d-flex align-items-center justify-content-between bg-primary text-white w-100" data-toggle="collapse" href="#navbar-vertical" style="height: 65px; margin-top: -1px; padding: 0 30px;">
                    <h6 class="m-0">카테고리</h6>
                    <i class="fa fa-angle-down text-dark"></i>
                </a>
                <nav class="collapse show navbar navbar-vertical navbar-light align-items-start p-0 border border-top-0 border-bottom-0" id="navbar-vertical">
                    <div class="navbar-nav w-100 overflow-hidden" style="height: 164px">
                        <div class="nav-item dropdown">
                            <a href="${contextPath }/shop/list?citemtype=1&categorized=1" class="nav-link" data-toggle="dropdown">스마트폰케이스 <i class="fa fa-angle-down float-right mt-1"></i></a>
                            <div class="dropdown-menu position-absolute bg-secondary border-0 rounded-0 w-100 m-0">
                                <a href="${contextPath }/shop/list?citemtype=1&categorized=1" class="dropdown-item">일반</a>
                                <a href="${contextPath }/shop/list?citemtype=2&categorized=1" class="dropdown-item">업로드 사진</a>
                                <a href="${contextPath }/shop/list?citemtype=3&categorized=1" class="dropdown-item">커스텀</a>
                            </div>
                        </div>
                        <div class="nav-item dropdown">
                            <a href="${contextPath }/shop/list?categorized=3" class="nav-link" data-toggle="dropdown">이어폰케이스 <i class="fa fa-angle-down float-right mt-1"></i></a>
                            <div class="dropdown-menu position-absolute bg-secondary border-0 rounded-0 w-100 m-0">
                                <a href="${contextPath }/shop/list?producer=삼성&citemtype=&categorized=3" class="dropdown-item">삼성</a>
                                <a href="${contextPath }/shop/list?producer=애플&citemtype=&categorized=3" class="dropdown-item">애플</a>
                            </div>
                        </div>
                        <a href="${contextPath }/shop/list?categorized=2" class="nav-item nav-link">그립톡</a>
                        <a href="${contextPath }/shop/illustrator" class="nav-item nav-link" id="moveIllu">작가중개</a>
                    </div>
                </nav>
            </div>
            <div class="col-lg-9">
                <nav class="navbar navbar-expand-lg bg-light navbar-light py-3 py-lg-0 px-0">
                    <a href="" class="text-decoration-none d-block d-lg-none">
                        <h1 class="m-0 display-5 font-weight-semi-bold"><span class="text-primary font-weight-bold border px-3 mr-1">MANGLE</span>A DREAM</h1>
                    </a>
                    <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                        <div class="navbar-nav mr-auto py-0">
                            <a href="${contextPath }/notice/list" class="nav-item nav-link active">공지사항</a>
                            <a href="${contextPath }/event/list" class="nav-item nav-link">이벤트</a>
                            <a href="${contextPath }/shop/list" class="nav-item nav-link">상품목록</a>
                            <a href="${contextPath }/bulk/list" class="nav-item nav-link">대량주문</a>
                            <a href="${contextPath }/mtomboard/list" class="nav-item nav-link">1대1문의</a>
                            <a href="${contextPath }/faqBoard/list" class="nav-item nav-link">FAQ</a>
                        </div>
                        
                        <form id="frmsec" action="${contextPath }/logout" method="post">
                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form>
                        
                        <div class="navbar-nav ml-auto py-0">
	                        <sec:authorize access="hasAuthority('ADMIN')">
	                        	<a class="btn btn-outline-primary" href="${contextPath }/admin/dashboard">관리자 페이지로</a>
	                        </sec:authorize>
	                        <div class="btn-group">
	                        <sec:authorize access="hasAuthority('ILLUSTRATOR')">	                        	
	                        	<a href="${contextPath }/admin/artist?userEmail=<sec:authentication property="principal.username"/>">작가의 통계 페이지로</a>
	                        </sec:authorize>
	                        	<sec:authorize access="isAuthenticated()">
								 <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" >
									<sec:authentication property="principal.username"/><span>님</span><span class="caret"></span>
									</button>
										<ul class="dropdown-menu" role="menu" style="text-align: center">
											<li><a href="${contextPath }/member/myPage?userEmail=<sec:authentication property="principal.username"/>">마이페이지</a></li>
											<li><a href="${contextPath }/cart/cartlist?userEmail=<sec:authentication property="principal.username"/>">장바구니</a></li>
											<li><a href="${contextPath }/delivery/list?userEmail=<sec:authentication property="principal.username"/>">배송 조회</a></li>
											<li><a href="${contextPath }/order/list?userEmail=<sec:authentication property="principal.username"/>">주문내역</a></li>
											<li><hr class="dropdown-divider"></li>
											<li><a class="btn-default" id="logoutbtn">로그아웃</a></li>
										</ul>
								</sec:authorize>
								
							</div>
							<sec:authorize access="isAnonymous()">
	                            <a href="${contextPath }/member/signInUp" class="nav-item nav-link">로그인/회원가입</a>
	                        </sec:authorize>
                        </div>
                    </div>
                </nav>
                
                
                <!-- carousel -->               
                <div id="header-carousel" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner">
                        
                        <div class="carousel-item active" style="height: 410px;">
                            <img class="img-fluid" src="${contextPath }/resources/img/illcontact.jpg" alt="Image">
                            <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                                <div class="p-3" style="max-width: 700px;">
                                    <h4 class="text-light text-uppercase font-weight-medium mb-3">나만의 케이스를 만드세요!</h4>
                                    <h3 class="display-4 text-white font-weight-semi-bold mb-4">일러스트 작가 중개</h3>
                                    <a href="${contextPath }/shop/illustrator" class="btn btn-light py-2 px-3">바로가기</a>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item" style="height: 410px;">
                            <img class="img-fluid" src="${contextPath }/resources/img/제목을 입력해주세요_-001 (2).png" alt="Image">
                            <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                                <div class="p-3" style="max-width: 700px;">
                                    <h4 class="text-light text-uppercase font-weight-medium mb-3">이 벤 트</h4>
                                    <h3 class="display-4 text-white font-weight-semi-bold mb-4">새해맞이 신규회원 이벤트</h3>
                                    <a href="${contextPath }/event/detail?eventNo=1" class="btn btn-light py-2 px-3">바로가기</a>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item" style="height: 410px;">
                            <img class="img-fluid" src="${contextPath }/resources/img/a13m_1.jpg" alt="Image">
                            <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                                <div class="p-3" style="max-width: 700px;">
                                    <h4 class="text-light text-uppercase font-weight-medium mb-3">인 기 상 품</h4>
                                    <h3 class="display-4 text-white font-weight-semi-bold mb-4">아이폰13미니-일반케이스1</h3>
                                    <a href="${contextPath }/detail/main?prodCode=a13m_1" class="btn btn-light py-2 px-3">바로가기</a>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    <a class="carousel-control-prev" href="#header-carousel" data-slide="prev">
                        <div class="btn btn-dark" style="width: 45px; height: 45px;">
                            <span class="carousel-control-prev-icon mb-n2"></span>
                        </div>
                    </a>
                    <a class="carousel-control-next" href="#header-carousel" data-slide="next">
                        <div class="btn btn-dark" style="width: 45px; height: 45px;">
                            <span class="carousel-control-next-icon mb-n2"></span>
                        </div>
                    </a>
                </div>
                <!-- carousel End --> 
                
                
            </div>
        </div>
    </div>
    <!-- Navbar End -->


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

</html>