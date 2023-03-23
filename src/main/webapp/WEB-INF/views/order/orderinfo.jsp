<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dream.mangle.domain.OrderListVO"%>
<%@page import="com.dream.mangle.domain.OrderSelectVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 
<c:set var="prodCode" value="${fromCart[1].prodCode }"/>

<%@ include file="../include/header.jsp" %>




<!-- Page Header Start -->
    <div class="container-fluid bg-secondary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
            <h1 class="font-weight-semi-bold text-uppercase mb-3">주문하기</h1>
            <div class="d-inline-flex">
                <p class="m-0"><a href="">Home</a></p>
                <p class="m-0 px-2">-</p>
                <p class="m-0">Place Order</p>
            </div>
        </div>
    </div>
    <!-- Page Header End -->


    <!-- Checkout Start -->
    <form role="form" id="frmOrder" name="order" >
    <div class="container-fluid pt-5">
        <div class="row px-xl-8" >
            <div class="col-lg-10">
                <div class="mb-4">
                    
                      <div class="card-header bg-secondary border-0">
                        <h4 class="font-weight-semi-bold m-0">주문 정보 입력</h4>
                    </div>
                    <div class="row"><br>
                    	
                    	<input type="hidden" name="userId" value="${userEmail }">
                    	<input type="hidden" name="fromCart" value="${fromCart }">
                    	<div class="col-md-6 form-group">
                    	<br>
                            <button type="button" id="memInfoCall">주문자의 정보를 넣기</button><br>
                        </div>
                        <div class="col-md-6 form-group">
                            <label>수령인</label>
                            <input class="form-control" type="text" placeholder="수령인 입력" name="receiver"><br>
                        </div>
                        <div class="col-md-6 form-group">
                            <label>이메일</label>
                            <input class="form-control" type="text" placeholder="example@email.com" name="userEmail" readonly="readonly"
                            		value="${userEmail}"><br>
                        </div>
                        <div class="col-md-6 form-group">
                            <label>연락처</label>
                            <input class="form-control" type="text" placeholder="+123 456 789" name="reMobile">
                        </div>
                        <div class="col-md-6 form-group px-xl-8">
                            <label>수령인 주소</label><br>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
                            	주소검색
							</button>
							<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
							  <div class="modal-dialog" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title">주소검색</h5>
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							          <span aria-hidden="true">&times;</span>
							        </button>
							      </div>
							      <div class="modal-body">
							      	저장한 주소 목록
							      	<c:forEach items="${addressList }" var="address">
								      	<a class="adr">${address.address_id }</a><br>
								      	<input type="hidden" name="sample4_zonecode" value="${address.zonecode }">
			                            <input type="hidden" name="sample4_roadAddress" value="${address.roadAddress }">
			                            <input type="hidden" name="sample4_jibunAddress" value="${address.jibunAddress }">
			                            <input type="hidden" name="sample4_bname" value="${address.bname }">
			                            <input type="hidden" name="sample4_detailAddress" value="${address.detailAddress }">			                            
							      	</c:forEach>
							      	<input type="hidden" name="reAddress">
							      	<hr>
									<input type="text" id="zonecode" placeholder="우편번호" name="zonecode">
									<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" ><br>
									<input type="text" id="roadAddress" placeholder="도로명주소" name="roadAddress">
									<input type="text" id="jibunAddress" placeholder="지번주소" name="jibunAddress">
									<span id="guide" style="color:#999;display:none"></span>
									<input type="text" id="bname" placeholder="동" name="bname">
									<input type="text" id="extraAddress" placeholder="상세주소" name="detailAddress">
                            
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-primary" data-dismiss="modal" id="AddressSave">확인</button>
							      </div>
							    </div>
							  </div>
							</div>
                        </div>
                        
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>             
 <script>
 var reAddress = "";
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                 document.getElementById('zonecode').value = data.zonecode;
                 document.getElementById("roadAddress").value = roadAddr;
                 document.getElementById("jibunAddress").value = data.jibunAddress;
                 document.getElementById("bname").value = data.bname;
                

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }        
        }).open();
        reAddress = "";
    }
    
    var zonecode ="";
    $(".adr").on("click", function () {
    	reAddress = $(this).text();
    	$("#zonecode").val($(this).next().next().val());
		$("#roadAddress").val($(this).next().next().next().val());
		$("#jibunAddress").val($(this).next().next().next().next().val());
		$("#bname").val($(this).next().next().next().next().next().val());
		$("#extraAddress").val($(this).next().next().next().next().next().next().val());
	})
</script>
			 <div class="col-lg-10">
                <div class="card border-secondary mb-5">
                    <div class="card-header bg-secondary border-0">
                        <h4 class="font-weight-semi-bold m-0">포인트 & 쿠폰 사용</h4>
                    </div>
                    <div class="card-body">
                    	<div>
                    		현재 갖고있는 포인트: ${memberInfo.userPoint }<br>
                    		<input type="number" id="userPoint" 
                    				placeholder="사용하실 포인트를 입력하세요." style="width: 40%;">
                    	</div>
                    	<br><br>
                    	<div>
                    		생일쿠폰 유무: 
                    		<c:choose>
                    		
                    		<c:when test="${memberInfo.userCoupon == 0}">
                    		쿠폰 없음
                    		</c:when>
                    		
							<c:otherwise>
                    			<input type="checkbox" name="userCoupon" onclick="Coupon()" >쿠폰 사용
							</c:otherwise>
							
                    		</c:choose>
                    	</div>
                    	
                    </div>
                    <div class="card-footer border-secondary bg-transparent">
                        <div class="d-flex justify-content-between mt-2">
                        </div>
                    </div>
                </div>                          
                        
                        
			 <div class="col-lg-10">
                <div class="card border-secondary mb-5">
                    <div class="card-header bg-secondary border-0">
                        <h4 class="font-weight-semi-bold m-0">주문 요약</h4>
                    </div>
                    
                     <div class="card-body">
						<c:forEach items="${fromCart }" var="cart">
						
						<c:set var="sum" value="${sum + (cart.price*cart.amount) }"/>
						
						<h5 class="font-weight-medium mb-3">상품정보 (수량)</h5>
                        <hr class="mt-0">
                        <div class="d-flex justify-content-between">
							<p>${cart.prodName }(${cart.amount }개)</p>
							<p>${cart.price }원</p>
						</div>
						<div class="d-flex justify-content-between mb-3 pt-1">
                            <h6 class="font-weight-medium">상품금액</h6>
                            <h6 class="font-weight-medium">${cart.price * cart.amount }원</h6>
                        </div>
						</c:forEach>
                        
                        <hr class="mt-0">

                        <div class="d-flex justify-content-between">
                            <h6 class="font-weight-medium">배송비</h6>
                            <h6 class="font-weight-medium">3000원</h6>
                        </div>
                        <div class="d-flex justify-content-between" id="pointDiv" style="display: none;">
                            <h6 class="font-weight-medium">포인트</h6>
                            <h6 class="font-weight-medium" id="pointH5">-</h6>
                        </div>                        
                        <div class="d-flex justify-content-between" id="pointDiv" style="display: none;">
                            <h6 class="font-weight-medium">쿠폰</h6>
                            <h6 class="font-weight-medium" id="couponH5">-</h6>
                        </div>                        

                        
                    </div>
                    <div class="card-footer border-secondary bg-transparent">
                        <div class="d-flex justify-content-between mt-2">
                            <h5 class="font-weight-bold">총합</h5>
                            <h5 class="font-weight-bold" id="total">${sum +3000}원</h5>
                        </div>
                    </div>
                </div>                        
             
             <!-- 결제수단 선택하기 시작 -->
                <div class="card border-secondary mb-5">
                    <div class="card-header bg-secondary border-0">
                        <h4 class="font-weight-semi-bold m-0">결제수단</h4>
                    </div>
                    <div class="card-body">
                          <div class="form-group">
                            <div class="custom-control custom-radio">
                                <input type="radio" class="custom-control-input" name="payment" id="kakaoPay" value="카카오페이">
                                <label class="custom-control-label" for="kakaoPay">카카오페이</label>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer border-secondary bg-transparent">
                        <button type="button" class="btn btn-lg btn-block btn-primary font-weight-bold my-3 py-3" id="placeorderBtn">주문하기</button>
                        <button type="button" class="btn btn-lg btn-block btn-primary font-weight-bold my-3 py-3" id="cancelBtn">취소</button>
                    </div>
                </div>
            <!-- 결제수단 선택하기 끝 -->
            	<input type="hidden" name="point">
            	<input type="hidden" name="coupon">
            	<input type="hidden" name="total" value="${sum +3000}">
            </div>
        </div>
    </div>
    </div>
  </div>
</div>
</div>
    		<sec:csrfInput/>
    		
    </form>
    
    <!-- Checkout End -->
    <script src="https://js.bootpay.co.kr/bootpay-4.2.7.min.js" type="application/javascript"></script>
    
    <%-- <script type="text/javascript" src="${contextPath }/resources/js/mycomment.js"></script> --%>
    
    <script>
    var frmOrder=$("#frmOrder");
    var frmAddress =$("#Address");
    
    var total = ${sum +3000};
    var point = 0;
    var hasPoint = ${memberInfo.userPoint };
    var coupon = 0;
    
   	$("#userPoint").focusout(function (e) {
   		total = Number(total) + Number(point);
   		point = $(this).val();
   		if(point.length == 0 || point == ""){
   			point = 0;
   		}else if(point < 0 || point > hasPoint) {
   			alert("0에서 " + hasPoint + "까지 입력해주세요.");
   			point = 0;  
   			return;
   		}
   		total = Number(total) - Number(point);
		$("#total").text(total);
		$("#pointH5").text($(this).val()); // 포인트
		$("#pointDiv").css("display","inline-block");
		
   	});
   	

   	
    //주문버튼처리 --> 결제하기 페이지로 넘어가게~   //주문버튼처리 시 카트가 비워져야 됨.--> 이거는 결제완료 후 비워져도 될듯? 일단 보류 :)
     $("#placeorderBtn").on("click", function(){
    	var receiver = $("input[name=receiver]").val();
    	var reMobile = $("input[name=reMobile]").val();
		var zonecode = $("input[name=zonecode]").val();
		var roadAddress = $("input[name=roadAddress]").val();
		var jibunAddress = $("input[name=jibunAddress]").val();
		var bname = $("input[name=bname]").val();
		var detailAddress = $("input[name=detailAddress]").val();
    	
    	
    	if( (receiver == null || receiver =="") ||
  			(reMobile == null || reMobile =="")) { 
  		//	(zonecode == null || zonecode =="") ||
  			//(roadAddress == null || roadAddress =="")) 
    		
  			alert("위에 주문 정보를 입력하시고 클릭하세요");  		
    	} else {    		
        	var Address = 
        			{zonecode: zonecode,
        			 roadAddress: roadAddress,
        			 jibunAddress: jibunAddress,
        			 bname: bname,
        			 detailAddress: detailAddress
			   	   	 };
        	
        	frmOrder.attr("Address", Address);
        	
        	callCheckout();	
    	}
    });
    
    //취소버튼처리 --> 취소하면 초기화된 order페이지로 --> 아니면 아예 메인페이지로 갈지 고민중. 장바구니 비우는건 처리하지 않기.
    $("#cancelBtn").on("click", function(){
    	frmOrder.empty();
    	frmOrder.attr("action","${contextPath }/shop/index").attr("method","get");
    	frmOrder.submit();
    });
    
 	async function callCheckout(){
    	//결제 api 호출    	 
	try{
		const response = await Bootpay.requestPayment({		
      	  "application_id": "63aa4544cf9f6d0020d1218f",
      	  <%-- "price": <%=sum +3000 %>, --%>
      	  "price": 1000,
      	  "order_name": "테스트결제",
      	  "order_id": "TEST_ORDER_ID",
      	  "pg": "카카오",
      	  "method": "간편",
      	  "tax_free": 0,
      	  "user": {
      	    "id": "${member.userEmail}",
      	    "username": "${member.userName}",
      	    "phone": "${member.userMobile}"
      	  },
      	  "extra": {
      	    "open_type": "iframe",
      	    "card_quota": "0",
      	    "escrow": true
      	  }
      	});
		
		$("input[name='point']").val(point);
    	$("input[name='coupon']").val(coupon);
    	$("input[name='reAddress']").val(reAddress);
		frmOrder.attr("action", "${contextPath}/order/orderinfo");
		frmOrder.attr("method", "post");
		frmOrder.submit();	
      	
	} catch(e){
		console.log("실패");
	}
}
	
   	$("#memInfoCall").on("click", function () {
		$("input[name=receiver]").val("${memberInfo.userName}");
		$("input[name=reMobile]").val("${memberInfo.userMobile}");
	});
   	
   	function Coupon(){
   		if( $("input[name='userCoupon']").is(":checked") == true){
   			coupon = 5000;
   			total = total - coupon;
   			$("#total").text(total);
   			$("#couponH5").text("5000원 쿠폰");
   			$("#pointDiv").css("display","inline-block");
   		} else {
   			coupon = -5000;
   			total = total - coupon;
   			$("#total").text(total);
   			$("#couponH5").text("");
   		}
   	}

    </script>




<%@ include file="../include/footer.jsp" %>