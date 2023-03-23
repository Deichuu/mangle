<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="<%=request.getContextPath() %>"/>


  <!-- Footer Start -->
    <div class="container-fluid bg-secondary text-dark mt-5 pt-5">
        <div class="row px-xl-5 pt-5">
            <div class="col-lg-4 col-md-12 mb-5 pr-3 pr-xl-5">
                <a href="${contextPath }/shop/index" class="text-decoration-none">
                    <h1 class="mb-4 display-5 font-weight-semi-bold">
                    	<span class="text-primary font-weight-bold border border-white px-3 mr-1">MANGLE</span>A DREAM</h1>
                </a>
                <p>맹글어드림에서는 커스텀 폰케이스와 그립톡 제작을 주력으로 하고 있습니다.
					다양한 디자이너와 협업을 통해 개성있는 자신만의 케이스를 만들 수 있습니다. 
					기억하고 싶은 사진을 업로드하고, 다양한 일러스트를 골라보세요.
					원하는 사진을 전송하면 제품을 만들어서 배송해드립니다.
				</p>
                <p class="mb-2"><i class="fa fa-map-marker-alt text-primary mr-3"></i>서울시 마포구 연남로 12길</p>
                <p class="mb-2"><i class="fa fa-envelope text-primary mr-3"></i>mangleadream@naver.com</p>
                <p class="mb-0"><i class="fa fa-phone-alt text-primary mr-3"></i>+821012345678</p>
            </div>
            <div class="col-lg-8 col-md-12">
                <div class="row">
<%--                     <div class="col-md-4 mb-5">
                        <h5 class="font-weight-bold text-dark mb-4">Mangle</h5>
                        <div class="d-flex flex-column justify-content-start">
                            <a class="text-dark mb-2" href="index.html"><i class="fa fa-angle-right mr-2"></i>Home</a>
                            <a class="text-dark mb-2" href="${contextPath }/shop/list?citemtype=1&categorized=1"><i class="fa fa-angle-right mr-2"></i>Our Shop</a>
                            <a class="text-dark mb-2" href="${contextPath }/detail/main?prodCode=ss21n_1"><i class="fa fa-angle-right mr-2"></i>Shop Detail</a>
                            <a class="text-dark mb-2" href=""><i class="fa fa-angle-right mr-2"></i>Shopping Cart</a>
                            <a class="text-dark mb-2" href=""><i class="fa fa-angle-right mr-2"></i>Checkout</a>
                            <a class="text-dark" href=""><i class="fa fa-angle-right mr-2"></i>Contact Us</a>
                        </div>
                    </div>
 --%>                    <div class="col-md-4 mb-5">
                        <h5 class="font-weight-bold text-dark mb-4">카테고리</h5>
                        <div class="d-flex flex-column justify-content-start">
                            <a class="text-dark mb-2" href="${contextPath }/shop/illustrator"><i class="fa fa-angle-right mr-2"></i>작가중개</a>
                            <a class="text-dark mb-2" href="${contextPath }/shop/list?citemtype=1&categorized=1"><i class="fa fa-angle-right mr-2"></i>스마트폰케이스</a>
                            <a class="text-dark mb-2" href="${contextPath }/shop/list?categorized=2"><i class="fa fa-angle-right mr-2"></i>그립톡</a>
                            <a class="text-dark mb-2" href="${contextPath }/shop/list?producer=삼성&citemtype=&categorized=3"><i class="fa fa-angle-right mr-2"></i>이어폰케이스</a>
                        </div>
                    </div>
                    <div class="col-md-4 mb-5">
                        <h5 class="font-weight-bold text-dark mb-4">게시판</h5>
                        <div class="d-flex flex-column justify-content-start">
                            <a class="text-dark mb-2" href="${contextPath }/notice/list"><i class="fa fa-angle-right mr-2"></i>공지사항</a>
                            <a class="text-dark mb-2" href="${contextPath }/faqBoard/list"><i class="fa fa-angle-right mr-2"></i>FAQ</a>
                            <a class="text-dark mb-2" href="${contextPath }/mtomboard/list"><i class="fa fa-angle-right mr-2"></i>1:1 문의</a>
                            <a class="text-dark mb-2" href="${contextPath }/bulk/list"><i class="fa fa-angle-right mr-2"></i>대량주문문의</a>
                            <a class="text-dark mb-2" href="${contextPath }/event/list"><i class="fa fa-angle-right mr-2"></i>이벤트</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row border-top border-light mx-xl-5 py-4">
            <div class="col-md-6 px-xl-0">
                <p class="mb-md-0 text-center text-md-left text-dark">
                    &copy; <a class="text-dark font-weight-semi-bold" href="#md">MANGLE A DREAM</a>. All Rights Reserved. <br>
                    Distributed By <a href="https://themewagon.com" target="_blank">ThemeWagon</a>
                </p>
            </div>
            <div class="col-md-6 px-xl-0 text-center text-md-right">
                <img class="img-fluid" src="${contextPath }/resources/img/payments.png" alt="">
            </div>
        </div>
    </div>
    <!-- Footer End -->


    <!-- Back to Top -->
    <a href="#md" class="btn btn-primary back-to-top" style="right: 100px;"><i class="fa fa-angle-double-up"></i></a>
    
	<!-- Channel Plugin Scripts -->
	<script>
	  (function() {
	    var w = window;
	    if (w.ChannelIO) {
	      return (window.console.error || window.console.log || function(){})('ChannelIO script included twice.');
	    }
	    var ch = function() {
	      ch.c(arguments);
	    };
	    ch.q = [];
	    ch.c = function(args) {
	      ch.q.push(args);
	    };
	    w.ChannelIO = ch;
	    function l() {
	      if (w.ChannelIOInitialized) {
	        return;
	      }
	      w.ChannelIOInitialized = true;
	      var s = document.createElement('script');
	      s.type = 'text/javascript';
	      s.async = true;
	      s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
	      s.charset = 'UTF-8';
	      var x = document.getElementsByTagName('script')[0];
	      x.parentNode.insertBefore(s, x);
	    }
	    if (document.readyState === 'complete') {
	      l();
	    } else if (window.attachEvent) {
	      window.attachEvent('onload', l);
	    } else {
	      window.addEventListener('DOMContentLoaded', l, false);
	      window.addEventListener('load', l, false);
	    }
	  })();
	  ChannelIO('boot', {
	    "pluginKey": "48d47077-e63b-4393-b5de-437cdc0e6d14"
	  });
	</script>
<!-- End Channel Plugin -->
 </body>

</html>