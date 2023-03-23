<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 

<%@ include file="../include/header.jsp" %>


   <!-- Shop Detail Start -->
    <div class="container-fluid py-5">
        <div class="row px-xl-5">
            <div class="col-lg-5 pb-5">
                <div id="product-carousel" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner border">
                        <div class="carousel-item active">
                            <img class="w-100 h-100" src="${contextPath }/resources/img/${product.prodCode }.jpg" alt="Image">
                        </div>
                        <div class="carousel-item">
                            <img class="w-100 h-100" src="${contextPath }/resources/img/${product.prodCode }.jpg" alt="Image">
                        </div>
                    </div>
                    <a class="carousel-control-prev" href="#product-carousel" data-slide="prev">
                        <i class="fa fa-2x fa-angle-left text-dark"></i>
                    </a>
                    <a class="carousel-control-next" href="#product-carousel" data-slide="next">
                        <i class="fa fa-2x fa-angle-right text-dark"></i>
                    </a>
                </div>
            </div>
            <div class="col-lg-7 pb-5">
                <h3 class="font-weight-semi-bold">${product.prodName }</h3>
                <div class="d-flex mb-3">
                    <span class="text-primary mr-2">
                     사용자평점 ${product.ratingAvg}/5점
                    </span>
                    <small class="pt-1">${ total }</small>
                </div>
                <h3 class="font-weight-semi-bold mb-4">${product.price }원</h3>
                
                <div class="d-flex mb-4">
                <c:if test="${product.citemtype == 1 }">
                    <p class="text-dark font-weight-medium mb-0 mr-3">케이스 색상</p>
                    <form action="${contextPath }/mangle/main" method="get" >
						<select id="prodCode" name="prodCode">
			      			<option value="error">기본값</option>
			      			<option value="${product.prodCode }-B" >검정</option>
			      			<option value="${product.prodCode }-W">흰색</option>
			      			<option value="${product.prodCode }-P">핑크</option>
			      			<option value="${product.prodCode }-G">그레이</option>
			      			<option value="${product.prodCode }-Ch">차콜</option>
			      		</select>
			      		<input type="hidden" name="chidden" id="chidden">
                    </form>
                    </c:if>
                </div>
              <form action="${contextPath }/detail/main?prodCode=${product.prodCode}" method="post">
              <sec:authorize access="isAuthenticated()">
              <input type="hidden" id="principalEmail" value='<sec:authentication property='principal.username'/>'>
              </sec:authorize>
                <div class="d-flex align-items-center mb-4 pt-2">
                    <div class="input-group quantity mr-3" style="width: 130px;">
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-primary btn-minus" >
                            <i class="fa fa-minus"></i>
                            </button>
                        </div>
                        <input type="number" class="form-control bg-secondary text-center" value="1" id="quantity_input">
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-primary btn-plus">
                                <i class="fa fa-plus"></i>
                            </button>
                        </div>
                    </div>
                    <button class="btn btn-primary px-3" id="btn_cart" type="button"><i class="fa fa-shopping-cart mr-1"></i> 장바구니에 담기</button>
                </div>
                <input type="hidden" id="quantity" name="prodCode">
              </form> 
                <div class="d-flex pt-2">
                    <p class="text-dark font-weight-medium mb-0 mr-2">공유하기 </p>
                    <div class="d-inline-flex">
                        <a class="text-dark px-2" href="javascript:shareFacebook();">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a class="text-dark px-2" href="javascript:shareTwitter();">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a class="text-dark px-2" href="http://www.linkedin.com/shareArticle?mini=true&url=YOUR-URL&title=YOUR-TITLE&summary=YOUR-SUMMARY&source=YOUR-URL;">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                        <a class="text-dark px-2" href="http://pinterest.com/pin/create/button/?url=YOUR-URL&description=YOUR-DESCRIPTION&media=YOUR-IMAGE-SRC">
                            <i class="fab fa-pinterest"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row px-xl-5">
            <div class="col">
                <div class="nav nav-tabs justify-content-center border-secondary mb-4">
                    <a class="nav-item nav-link active" data-toggle="tab" href="#tab-pane-1">상품 소개</a>
                    <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-2">상품 정보</a>
                    <a class="nav-item nav-link" id="reviewTotal" data-toggle="tab" href="#tab-pane-3">리뷰 (0)</a>
				<sec:authorize access="isAuthenticated()">					
                   	<a class="nav-item nav-link" id="registReview" data-toggle="tab" href="#tab-pane-4">리뷰 작성하기</a>
                </sec:authorize>
                </div>
                
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="tab-pane-1">
                        <c:choose>
                        	<c:when test="${product.citemtype != 2 }">
                        		<h4 class="mb-3" style="text-align: center">상품 소개</h4>
                        		<p><img class="img-fluid w-100" src="${contextPath }/resources/img/${prod.description }.jpg"></p>
                        	</c:when>
                        	<c:otherwise>
                        	 
								    <canvas id="c"></canvas>
								    <input id="filereader" type="file" accept="image/*">
								    <button type="button" id="delObj">사진 삭제</button>
								    <button id="save">사진 저장하기</button>
								   <div class="text-center">
								    내가 사랑하는 남친, 여친💑👨‍👩‍👧‍👦
										<br>
										커플 및 가족, 반려동물 등🐶🐱
										<br>
										위에서 사진을 제작해 전달해주시면<br>
										세상에서 하나뿐인 폰케이스로<br>
										가장 이쁘게 제작해드려요❣️<br>
										<br>
										주문제작이 익숙하시지 않거나<br>
										어려우시다면 언제든지 메세지 주세요📌<br>
										친절하게 설명해드릴께요👍<br>
										<br>

										<br>
										▼▽▼▽▼▽▼▽▼▽▼▽<br>
										<br>
										<br>
										<br>
										1) 저렴하고 합리적인 작품 가격<br>
										2) 택배사 배송을 제외한 주문 후 3일이내 제작 및 발송<br>
										3) 100가지 이상의 국내 최대 폰케이스 기종과 재질!<br>
										4) 문의는 언제나 환영!!! 친절! 또 친절!!<br>
										<br>
										모든 상품은 주문 제작 요청 시,<br>
										새 기종에 새 제품으로 제작하여<br>
										다른사람의 손에 거치지 않은<br>
										주문 후 부터 제작 후 까지<br>
										오로지 고객님의 상품이 됩니다👍<br>
								    
								    </div>


                        	</c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="tab-pane fade" id="tab-pane-2">
                        <h4 class="mb-3" style="width:100%">상품 정보</h4>
                        <p>배송/교환/환불</p>
                        <div class="row">
                            <div class="col-md-6" >
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item px-0" >
                                    	배송정보
                                    </li>
                                    <li class="list-group-item px-0">
                                        교환/환불/AS안내
                                    </li>
                                    <li class="list-group-item px-0" >
                                       기타 기준 사항
                                    </li>
                                  </ul> 
                            </div>
                            <div class="col-md-6" >
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item px-0">
                                    	배송기간은 주문일(무통장입금은 결제완료일)로부터 1일(24시간) ~ 5일정도 걸립니다.
										단, 지정일 배송이 가능한 플라워 상품이나, 제작기간이 별도로 소요되는 상품의 경우에는 상품설명에 있는 제작기간과 배송시기를 숙지해 주시기 바랍니다.
										업체조건배송 상품은 해당 브랜드 배송기준으로 배송비가 부여됩니다. 업체착불배송 상품은 해당 브랜드 배송기준 및 배송지에 따라 배송비가 착불로 부과됩니다.
										가구 및 플라워 등의 상품의 경우에는 지역에 따라 추가 배송비용이 발생할 수 있음을 알려드립니다.
										해외배송 표시가 되어 있는 상품은 해외 주소로 배송이 가능합니다. (배송방법 : EMS)
                                    </li>
                                    <li class="list-group-item px-0" >
                                       교환/반품 신청은 배송완료 후 7일 이내 가능합니다.
								       변심 반품의 경우 왕복배송비를 차감한 금액이 환불되며, 제품 및 포장 상태가 재판매 가능하여야 합니다.
									   상품 불량인 경우는 배송비를 포함한 전액이 환불됩니다.
									   출고 이후 환불요청 시 상품 회수 후 처리됩니다.
									   쥬얼리를 포함한 주문제작 상품/카메라/밀봉포장상품/플라워 등은 변심으로 인한 반품/환불이 불가합니다.
									   완제품으로 수입된 상품의 경우 A/S가 불가합니다.
									   상품페이지에 교환/환불/AS에 대한 브랜드 개별기준이 있는 경우에는 해당 내용이 우선 적용 됩니다.
                                    </li>
                                    <li class="list-group-item px-0">
                                       구매자가 미성년자인 경우에는 상품 구입시 법정대리인이 동의하지 아니하면 미성년자 본인 또는 법정대리인이 구매취소 할 수 있습니다.

                                    </li>
                                  </ul> 
                            </div>
                        </div>
                    </div>
                    <br><br>
<%-- ------------------리뷰 표시------------------------- --%>                     
                    <div class="tab-pane fade" id="tab-pane-3">
                        <div class="row">
                            <div class="col" id="showReview" data-prodcode="ss21n_1" data-rno="12">
                    <%-- 댓글 표시 --%><%-- 
                                <h4 class="mb-4"> 이건 뭐야${oneProd.prodName } </h4>
                                <div class="media mb-4">
                                    <img src="../resources/img/user.jpg" alt="Image" class="img-fluid mr-3 mt-1" style="width: 45px;">
                                    <div class="media-body">
                                        <h6>John Doe<small> - <i>01 Jan 2045</i></small></h6>
                                        <div class="text-primary mb-2">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star-half-alt"></i>
                                            <i class="far fa-star"></i>
                                        </div>
                                        <p>Diam amet duo labore stet elitr ea clita ipsum, tempor labore accusam ipsum et no at. Kasd diam tempor rebum magna dolores sed sed eirmod ipsum.</p>
                                    </div>
                            
                                </div>
                             --%>
                             <p>리뷰가 없습니다. 처음으로 리뷰를 달아보세요.</p>
                            </div> <%-- col-md-6 --%>
                            <%-- 댓글 표시 끝--%>
                            <%-- 댓글 페이징 데이터--%>
                            <form id="frmCmtPagingValue">
                            <sec:csrfInput/>
								<input type='hidden' name='pageNum' value='' />
								<input type='hidden' name='rowPerPage' value='' />
							</form>
						</div>
						<div class="panel-footer text-center" id="showCmtPagingNums">
			                	<%-- 댓글 목록의 페이징 번호 표시 영역 - JavaScript 로 내용이 생성되어 표시됩니다.--%>
	                	</div>
                    </div><%-- tab-pane-3 end --%>
                    
                    <%-- tab-pane-4 --%>
                    <div class="tab-pane fade" id="tab-pane-4">
                    	<div class="row">
	                    	<div class="col">
	                    	<h4 class="mb-4">리뷰 작성</h4>
				            <small>상품을 직접 리뷰해 보세요! *</small>
				            <div class="d-flex my-3">
				                <p class="mb-0 mr-2" style="display: flex;">평점 :</p>
				                <div class="star-rating" >
				               	  <input type="radio" id="5-star" name="rating" value="5" />
								  <label for="5-star" class="star">&#9733;</label>								  
								  <input type="radio" id="4-star" name="rating" value="4" />
								  <label for="4-star" class="star">&#9733;</label>								  
								  <input type="radio" id="3-star" name="rating" value="3" />
								  <label for="3-star" class="star">&#9733;</label>
								  <input type="radio" id="2-star" name="rating" value="2" />
								  <label for="2-star" class="star">&#9733;</label>
								  <input type="radio" id="1-star" name="rating" value="1" />
								  <label for="1-star" class="star">&#9733;</label>
								</div>
				            </div>
				            
				            <form>
				            <sec:csrfInput/>
				            	<sec:authorize access="isAuthenticated()">
					            	<div class="form-group">
					                    <label for="email">작성자</label>
					                    <input type="email" class="form-control" id="userEmail" value="<sec:authentication property='principal.username'/>" disabled="disabled">
					                </div>
					                
					                <div class="form-group">
					                    <label for="message">글 내용</label>
					                    <textarea id="message" cols="30" rows="5" class="form-control"></textarea>
					                </div>
					                <div class="form-group uploadDiv">
										<input id="inputFile" type="file" name="uploadImage"><br>
									</div>
	 								<div class="form-group fileUploadResult" id="showImage">
										<%-- 파일 이미지가 나올곳 --%>
									</div>								
									<div class="form-group mb-0">
	                					<button class="btn btn-primary px-3" type="button" id="registReviewbtn"> 리뷰 등록</button>
	                				</div>
                				</sec:authorize>
				            </form>
				        </div> <%-- col end --%>
				        </div><%-- row end--%>
			        </div><%-- tab-pane-4 end --%>
            </div>
        </div>
    </div>
    <!-- Shop Detail End -->
    
<%-- ------------------리뷰 표시끝------------------------- --%>

    <!-- Products Start -->
   <div class="container-fluid py-5">
        <div class="text-center mb-4">
            <h2 class="section-title px-5"><span class="px-2">관련 추천 상품</span></h2>
        </div><br>
        <div class="row px-xl-5">
            <div class="col">
                <div class="card-group" style="text-align: center"> 
                <c:forEach var="rateAvg" items="${rating }">
                    <div class="card" style="width: 18rem;">
                        <a href="${contextPath }/detail/main?prodCode=${rateAvg.prodCode}"><img class="card-img-top" src="${contextPath }/resources/img/${rateAvg.prodCode }.jpg"></a>
                        <div class="card-body">
                            <h6 class="text-truncate mb-3">${rateAvg.prodName }</h6>
                            <div class="d-flex justify-content-center">
                                <h6> ${rateAvg.price }원</h6><h6 class="text-muted ml-2"></h6>
                            </div>
                        </div>
	                    <div class="card-footer d-flex justify-content-between bg-light border" >
                        </div>
                    </div>
                    
				</c:forEach>   
				</div>
            </div>
		    
        </div>
    </div>
    <%-- Products End --%>
</div>

<script type="text/javascript" src="${contextPath }/resources/js/review.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fabric.js/5.3.1/fabric.js"></script>
<script src="../resources/dist/js/FileSaver.min.js"></script>

<script>
var csrfHeaderName = "${_csrf.headerName}";
var csrfToken = "${_csrf.token}";

$(document).ajaxSend(function(e,xhr, options){
	xhr.setRequestHeader(csrfHeaderName, csrfToken);
});

userEmail = $("#principalEmail").val();


var str = "";
var rattFile = "";
var rcontent = "";
var pageNum = "";
var rwriter = "";
var rno = "";
var rating = "";
var loginUser = "";
	loginUser = $("#principalEmail").val();


//리뷰 시작
var prodCodeValue = '<c:out value="${product.prodCode}"/>';


var commentUL = $("#showReview");  					<%-- 댓글 div --%>
var frmCmtPagingValue = $("#frmCmtPagingValue");    <%-- 페이징 form --%>

//댓글 목록 표시 함수
function showCmtList(page){
	prodReviewClsr.showReviews(
		{prodCode: prodCodeValue, page: page || 1},
		function (reviewPagingCreator){
			$("#reviewTotal").html("리뷰 (" + reviewPagingCreator.totalRowCnt + ")");
			$(".pt-1").html("(" + reviewPagingCreator.totalRowCnt + " Reviews )");
			
			var reviewstr = '<span class="text-primary mr-2">' 
	    		   + '사용자평점 ' + reviewPagingCreator.ratingAvg + '/5점'
				   + '</span>'
				   + '<small class="pt-1">'
				   + '(' + reviewPagingCreator.totalRowCnt + ' Reviews )'
				   + '</small>';

			$(".pb-5 .mb-3").html(reviewstr);
			
			frmCmtPagingValue.find("input[name='pageNum']").val(reviewPagingCreator.pagingDTO.pageNum);
			
		 str = "";
			//댓글이 없으면, if 문의 블록이 실행되고, 함수 실행이 중지됨(return)
		if(!reviewPagingCreator.reviewList || reviewPagingCreator.reviewList.length == 0){
				str += '  <div class="media mb-4">'
					+  '    <div class="media-body"'
				    +  '        style="text-align: center; background-color: lightCyan; height: 35px; margin:bottom:0px; padding-bottom: 0px; padding-top: 6px; border: 1px dotted; "'
				    +  '	    <strong>등록된 리뷰가 없습니다.</strong>'
				    +  '     </div>'
				    +  '    </div>';
				    return;
				}
			
			for(var i = 0, len = reviewPagingCreator.reviewList.length; i<len; i++){
				var rating = reviewPagingCreator.reviewList[i].rating;
				
	            var text = reviewPagingCreator.reviewList[i].rcontent; //enter => <br>
				
				str +='  <div class="col" id="showReview"'
					+ ' 			data-prodcode="' + prodCodeValue + '"'
				    + ' 			data-rno="' + reviewPagingCreator.reviewList[i].rno + '"'
				    + ' 			data-useremail="' + reviewPagingCreator.reviewList[i].userEmail +'">'
				    + '    <h4 class="mb-4">' + reviewPagingCreator.reviewList[i].prodCode +'</h4>  '
				    + '   <div class="media mb-4">'
				    
			
			
					+ '   <div class="media-body">'
					+  '		<h6>' + reviewPagingCreator.reviewList[i].userEmail + '<small> '
					+  '		<i> ' + prodReviewClsr.showDatetime(reviewPagingCreator.reviewList[i].rregDate) + ' </i></small></h6>'
					+  '   <div class="star-rating">'
					
					+  '		<input type="radio" id="5-stars'+ i +'" name="star'+ i +'" value="5" disabled="disabled"';
					
				if(rating == 5 ){
				 str += 'checked = "checked"';
				}
					
			    str += ' />'
				  	+  '		<label for="5-stars'+ i +'" class="star">&#9733;</label>'
				  	
				  	+  '		<input type="radio" id="4-stars'+ i +'" name="star'+ i +'" value="4" disabled="disabled"';
				  	
				if(rating == 4 ){
				str += 'checked = "checked"';
				}
					
				str += ' />'
				  	+  '		<label for="4-stars'+ i +'" class="star">&#9733;</label>'
				  	
				  	+  '		<input type="radio" id="3-stars'+ i +'" name="star'+ i +'" value="3" disabled="disabled"';
				  	
				if(rating == 3 ){
			    str += 'checked = "checked"';
				}
				
				str += ' />'
				  	+  '		<label for="3-stars'+ i +'" class="star">&#9733;</label>'
				  	
				  	+  '		<input type="radio" id="2-stars'+ i +'" name="star'+ i +'" value="2" disabled="disabled"';
				  	
				 if(rating == 2 ){
				str += 'checked = "checked"';
				}
				  	
				str += '/>'
				  	+  '		<label for="2-stars'+ i +'" class="star">&#9733;</label>'
				  	
				  	+  '		<input type="radio" id="1-stars'+ i +'" name="star'+ i +'" value="1" disabled="disabled"';
				  	
				 if(rating == 1 ){
			    str += 'checked = "checked"';
				}
				  	
			  	str +=	'/>'
				  	+  '		<label for="1-stars'+ i +'" class="star">&#9733;</label>'
					+  '   </div>';
					if(reviewPagingCreator.reviewList[i].rattfile != null) {
						
			            var thumbnailPath = reviewPagingCreator.reviewList[i].rattfile.repoPath + "/"
										  + reviewPagingCreator.reviewList[i].rattfile.uploadPath + "/"
		   				  				  + reviewPagingCreator.reviewList[i].rattfile.uuid + "_"
							  			  + reviewPagingCreator.reviewList[i].rattfile.fileName;
						 
						str +='<span data-repopath="' + reviewPagingCreator.reviewList[i].rattfile.repoPath + '"'
							+ '  data-uploadpath="' + reviewPagingCreator.reviewList[i].rattfile.uploadPath + '"'
						    + '  data-uuid="' + reviewPagingCreator.reviewList[i].rattfile.uuid + '"'
							+ '  data-filename="' + reviewPagingCreator.reviewList[i].rattfile.fileName + '"  data-filetype="I"'
							+ '  class="fileUploadResult" >'
							+ '		<img src="${contextPath}/displayThumbnail?fileName=' + encodeURI(thumbnailPath) + '"'
							+ '			 alt="No Image" style="height:150px; width:150px;"/>&nbsp;'
							+ '	</span>';
					}			
			str	+=  '	<p id="rvwContent">' + text + '</p>'
					
				+ '<div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">'
				+  '	<div class="modal-dialog">'
				+  '		<div class="modal-content">'
				+  '			<div class="modal-body imageModalDiv">'
				+  '			</div>'
				+  '		</div>'
				+  '	</div>'
				+  '</div>'
				+ '<button type="button" class="btn btn-info btn-sm btnLikeCmt" name="reviewButton"'
				+ 'style="color:white;">'
				+  '좋아요 ' +	reviewPagingCreator.reviewList[i].rlike + '</button> ';
				
			if(loginUser == reviewPagingCreator.reviewList[i].userEmail) {				
			str += '<button type="button" class="btn btn-warning btn-sm btnModRvw" name="reviewButton">수정</button> '
				+  '<button type="button" class="btn btn-danger btn-sm btnDelRvw" name="reviewButton">삭제</button>';
			}
			
			str	+='      </div>'
				+ '   </div>'
				+ '</div>';
				
			}// for-end
			commentUL.html(str); //html() 사용 시, 새로운 내용으로 교체
		    //commentUL.append(str);  //append 사용 시, 기존 내용 밑에 새로운 내용 추가 (페이징 대신 사용)

			showCmtPagingNums(reviewPagingCreator.pagingDTO.pageNum ,
							  reviewPagingCreator.startPageNum ,
							  reviewPagingCreator.endPageNum ,
							  reviewPagingCreator.prev ,
							  reviewPagingCreator.next ,
							  reviewPagingCreator.realPageNum);
		    

		}// callback-함수 end
	); //매개변수 선언 end
} // showCmtList 함수 end

//페이징
function showCmtPagingNums(pageNum, startPageNum, endPageNum, prev, next,realPageNum){
	if(endPageNum >= realPageNum){ 	//계산된 끝 게시물 번호 >= 실제 게시물 번호
		endPageNum = realPageNum;		//계산된 끝 번호 = 실제 끝 번호
	}
	
	//페이징 버튼 구현(화면처리)
	var str ='<ul class="pagination pagination-sm">';
	//맨 앞으로
	if(prev) {
		str +='   <li class="page-item">'
			+'			<a class="page-link" href="1">'
			+'				<span aria-hidden="true">&laquo;</span>'
			+'			</a>'
			+'     </li>';
	//이전 페이지
		str +='   <li class="page-item">'
			+'			<a class="page-link" href="' + (startPageNum-1) + '">'
			+'				<span aria-hidden="true">이전</span>'
			+'			</a>'
			+'     </li>';
	}
	//선택된 페이지 번호 Bootstrap의 색상표시
	for(var i= startPageNum; i<= endPageNum; i++){
		//active는 Bootstrap 클래스 이름
		var active = ((pageNum == i) ? "active" : "");
		
		str +='	<li class="page-item' + active + '">'
		    +'		<a class="page-link" href="' + i + '">'
			+'			<span aria-hidden="true">'+ i +'</span>'
			+'		</a>'
			+'  </li>';
	}
	
	if(next) {
		//다음페이지	
		str +='   <li class="page-item">'
			+'			<a class="page-link" href="' + (endPageNum+1) + '">'
			+'				<span aria-hidden="true">다음</span>'
			+'			</a>'
			+'     </li>';
		
		//맨 마지막으로
		str +='   <li class="page-item">'
			+'			<a class="page-link" href="'+ realPageNum +'">'
			+'				<span aria-hidden="true">&raquo;</span>'
			+'			</a>	'
			+'     </li>';
			
		str += '</ul> ';
	}
	
	$("#showCmtPagingNums").html(str);
}
	
//선택된 페이징 번호의 게시물목록 가져오는 함수: 이벤트 전파 이용
$("#showCmtPagingNums").on("click","ul li a" ,function(e){
	e.preventDefault();
	
	pageNum = $(this).attr("href");
	showCmtList(pageNum);
});

<%--댓글등록 버튼 작동--%>
$("#registReviewbtn").on("click", function(){
	<sec:authorize access="isAuthenticated()">
		loginUser =  $("#principalEmail").val();
	</sec:authorize>
	
	if(loginUser == null || loginUser.size == 0){
		alert("로그인을 하시고 등록해주세요");
		return;
	}
	
	var message = $("#message").val();	   
	
	var formObj = $(".fileUploadResult div");
	var rating = $("input[name=rating]:checked").val();
	
	if(rating == null){
		alert("평점을 입력해야 합니다.");
		return;
	}

    var rattfile = {uuid: formObj.data("uuid"),
              uploadPath: formObj.data("uploadpath"),
                fileName: formObj.data("filename"),
                fileType: formObj.data("filetype"),
  			    repoPath: formObj.data("repopath")};
	
	var review = {prodCode: prodCodeValue, rcontent: message, userEmail: loginUser, rating: rating, rattfile: rattfile};
	

	prodReviewClsr.registerReview(
			review,
			function(serverResult){
				if(serverResult == "RegisterSuccess"){
					showCmtList(1);
					alert("댓글이 등록되었습니다.");					
					$("#reviewTotal").trigger("click");
				}
			})
});

<%--댓글 수정의 취소 버튼 클릭 이벤트 --%>
$("#showReview").on("click", "div .btnCancelCmt", function(e){
	showCmtList(pageNum);
});

//댓글 수정 함수
function modifyReview(result){
	var userEmailVal = rwriter;	
	var rnoVal = rno;
	var formObj = $(".fileUploadResult div");
	
	console.log(formObj.data("uuid"));
	
	var rattfile = {uuid: formObj.data("uuid"),
            uploadPath: formObj.data("uploadpath"),
              fileName: formObj.data("filename"),
              fileType: formObj.data("filetype"),
			   repoPath: formObj.data("repopath")};
		
	var review = {prodCode : prodCodeValue,
				  rno: rnoVal,
				  rcontent: result,
				  useremail: userEmailVal,
				  rating : rating,
				  rattfile: rattfile
				 };
 	
	prodReviewClsr.modifyReview(
		review,
		function(serverResult){
			alert("수정되었습니다.");
			
			showCmtList(pageNum);
		}		
	);
}

<%-- 리뷰 수정 처리: 목록에서 수정 버튼 클릭 이벤트 --%>
$("#showReview").on("click", "div .btnModRvw", function(e){
/*
	if(!loginUser){
		alert("로그인하세요!!!");
		return;
	}
*/
	rwriter = $(this).closest("#showReview").data("useremail");
	rcontent  = $(this).siblings("#rvwContent").text();
	rno = $(this).closest("#showReview").data("rno");
	$(this).siblings(".star-rating").find("input").attr("disabled",false);
	
//	console.log("loginUser: " + loginUser);
/* 	
	if(loginUser != rwriterVal){
		alert("작성자가 아니군요");
		return;
	}
	 */
	 
	var strTxtBoxReview =
		   '<textarea class="form-control txtBoxMod" id="message" style="margin-bottom:10px;"'
		 + ' placeholder="문구를 입력하시고 수정 버튼을 눌러주세요."'
		 + '></textarea>'
		 + '<div class="form-group uploadDiv">'
		 +	'<input id="inputFile" type="file" name="uploadImage"><br>'
		 +	'</div>'
		 +	'<div class="form-group fileUploadResult" id="showImage">'
		 
		 +	'</div>	'
		 + '<button type="button" class="btn btn-warning btn-sm btnModCmt">수정</button>'
		 + '<button type="button" class="btn btn-info btn-sm btnCancelCmt" style="margin-left: 4px;">취소</button>';
		 
	$(this).siblings("#rvwContent").html(strTxtBoxReview);

	hideReviewListBtn();
	$("button[name=reviewButton]").attr("style", "display: none;");
	
	$(".txtBoxMod").val(rcontent);
	
});

//목록에서 수정을 눌렀을 때
function hideReviewListBtn(){
	
//	$("#showReview").attr("style", "display:in-block;");
	
	$(".btnLikeCmt").attr("style", "display:none;"); //좋아요 버튼 안보이게
	$(".btnDelRvw").attr("style", "display:none;");  //삭제 버튼 안보이게
}

<%-- 리뷰 수정 처리: 수정에서 수정 버튼 클릭(인서트) --%>
$("#showReview").on("click", "div .btnModCmt", function(e){
	var result = $(this).siblings("textarea").val();
	rating = $(this).parent("p").siblings(".star-rating").find("input:checked").val();
	
	 
	
	modifyReview(result);
	
});

<%-- 댓글-답글 삭제 처리: 삭제 버튼 클릭 이벤트 --%>
$("#showReview").on("click", "div .btnDelRvw", function(){
	var userEmailVal = $(this).siblings("p").data("useremail");
	
	var delConfirm = confirm('삭제하시겠습니까?');
	
	if(!delConfirm) {     
		alert("삭제가 취소되었습니다.");
		return ;
	}
	
	pageNum = frmCmtPagingValue.find("input[name='pageNum']").val();
	
	rnoVal = $(this).closest("#showReview").data("rno");
	
	var comment = {rno: rnoVal,
				   useremail: userEmailVal};
	
	prodReviewClsr.removeReview(
		comment,
		function(serverResult){
			alert("삭제되었습니다.");
			
			showCmtList(pageNum);
		}		
	);
});


var cloneInputFile = $(".uploadDiv").clone();		<%-- 업로드 div --%>

<%-- 파일 업로드 시작 --%>
$(".uploadDiv").on("change", "input[type='file']" ,function(){	

	var formData = new FormData();
	
	//uploadFiles 이름의 file 유형 input 요소를 변수에 저장
	var inputImage = $("input[name='uploadImage']");
	//inputFiles에 저장된 파일들을 files 변수에 저장.
	//inputFiles[0]은 첫번째 input 요소를 의미(input 요소가 하나만 있더라도 [0]을 명시해야 함).
	var yourFiles = inputImage[0].files;
	
	if(yourFiles == null || yourFiles.length == 0) {
		return ;
	}
	
	//formData 객체에 파일추가
	for(var i=0; i< yourFiles.length; i++){
		
		if(!checkUploadFile(yourFiles[i].name, yourFiles[i].i)) {
			//$(".uploadDiv input[name='myFiles']").val("");
		
			$(".uploadDiv").html(cloneInputFile);
			return;
		}

		formData.append("uploadFiles", yourFiles[i]);
	}

	//url 키에 명시된 주소의 컨트롤러에게 formData 객체를 POST 방식으로 전송.
	$.ajax({
		type: 'post',
		url: '${contextPath}/fileUpload',
		data: formData,
		dataType: "json",		
		success: function(uploadResult) {
			$(".uploadDiv").html(cloneInputFile.html());
			showUploadedFiles(uploadResult);
		}
	});
});

//업로드 파일의 확장자 및 최대 파일 크기를 제한하는 함수
function checkUploadFile(fileName, fileSize) {
	var maxFileSizeAllowed = 104857600;
	var regExpFileExtension = /.*\.(jpg|png|jpeg)$/i;
	
	//최대 허용 크기 제한 검사
	if(fileSize >= maxFileSizeAllowed){
		alert("업로드 파일의 제한된 크기(100MB)를 초과했습니다.");
		return false;
	}
	
 	if(!regExpFileExtension.test(fileName)){
		alert("jpg,png,jpeg 유형의 파일만 업로드 할 수 있습니다.");
		return false;
	}
 	return true;
}

//파일 이미지 보여줌
function showUploadedFiles(uploadResult){
	
	if(!uploadResult || uploadResult.length == 0){
		return;	
	}

	var fileUploadResult = $("#showImage");
	
	str = "";
		
	$(uploadResult).each(function(i, obj){
		
		var thumbnailPath = obj.repoPath + "/" + obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
		
		str = "<div data-repopath='" + obj.repoPath + "' "
			+  "  data-uploadpath='" + obj.uploadPath + "'"
			+  "  data-uuid='" + obj.uuid + "'"
			+  "  data-filename='" + obj.fileName + "'  data-filetype='I'>"
			+  "		<img src='${contextPath}/displayThumbnail?fileName=" + encodeURI(thumbnailPath) + "'"
		 	+  "			 alt='No Image' style='height:200px; width:200px;'/>&nbsp; <br></div>"
			+  "</div>";
					
			
		});		
		
	fileUploadResult.html(str);
}

//파일 삭제
$("#showImage").on("click","div button",function(e){
	var targetFileName = $(this).data("filename");
	var targetFileType = $(this).data("filetype");
		
	var parentLi = $(this).parent();
		
	$.ajax({
		url: '${contextPath}/deleteUploadedFile',
		data: {fileName: targetFileName, fileType: targetFileType},
		dataType:'text',
		type: 'post',
		success: function(result){
			if(result == "SuccessFileDelete"){
				alert("파일이 삭제되었습니다");
				parentLi.remove();
			}else {
				alert("오류: 파일 삭제 실패");
			}
		}
	});
});

//좋아요 상승
$("#showReview").on("click","div .btnLikeCmt" ,function(e){
	<sec:authorize access="isAnonymous()">
		alert("로그인 한뒤 이용할수 있습니다.")
		location.href = "${contextPath }/member/signInUp";
		return;
	</sec:authorize>

	pageNum = frmCmtPagingValue.find("input[name='pageNum']").val();
	var rno = $(this).closest("#showReview").data("rno");

	prodReviewClsr.likeUpdate(
		rno,
		function(serverResult){
			showCmtList(pageNum);
		
		}		
	);
});

//이미지 크게 띄우기
$("#showReview").on("click","div .fileUploadResult" , function(e){
	var obj = $(this);
	
	var downloadFileName = obj.data("repopath") + "/" + obj.data("uploadpath") + "/" + obj.data("uuid") + "_" + obj.data("filename");
	downloadFileName = downloadFileName.replace(new RegExp(/\\/g),"/");
			
		$(".imageModalDiv").html(
				"<img src='${contextPath}/fileDownload?fileName=" + encodeURI(downloadFileName) + "' width='100%' />"
		);
		
		$("#imageModal").modal("show");

});

//이미지표시 모달 지우기
$("#imageModal").on("click", function(){
	$("#imageModal").modal("hide");
}); 

//이미지 표시
//display 속성의 flex 옵션을 이용하면, 이미지가 웹브라우저의 중앙에 표시됩니다.
function showImage(calledPathImageName){
	$(".bigImageWrapper").css("display", "flex").show();
		  
	$(".bigImage").html("<img src='${contextPath}/fileDownload?fileName="+ encodeURI(calledPathImageName) + "'/>")
				  .animate({width: '100%', height: '100%'}, 1000);
} 

//이미지 제거
 $(".bigImageWrapper").on("click", function(){
	
	$(".bigImageWrapper").hide();
	
});

<%-- 리뷰 끝 --%>

function shareTwitter() {
    var sendText = "oneProd.prodName"; // 전달할 텍스트
    var sendUrl = "mangle/detail/main?prodCode=aaa"; // 전달할 URL
    window.open("https://twitter.com/intent/tweet?text=" + sendText + "&url=" + sendUrl);
}
function shareFacebook() {
    var sendUrl = "mangle/detail/main?prodCode=aaa"; // 전달할 URL
    window.open("http://www.facebook.com/sharer/sharer.php?u=" + sendUrl);
}
var csrfHeaderName = "${_csrf.headerName}";
var csrfToken = "${_csrf.token}";

// 수량 버튼 조작
var quantity = $("#quantity_input").val();
$(".btn-plus").on("click", function(){
   $("#quantity_input").val(++quantity);
});

$(".btn-minus").on("click", function(){
   if(quantity > 1){
      $("#quantity_input").val(--quantity);   
   }
});

   // 장바구니 추가 버튼	   
   $("#btn_cart").on("click", function(e){		   
   
	  <sec:authorize access="isAuthenticated()">			
	  	 var amount = $("#quantity_input").val();
	   <c:choose>
	   <c:when test="${product.citemtype == 1 }">
			var prodCode = $("select[name=prodCode] option:selected").val();
			if(prodCode == 'error'){
				alert("케이스의 색상을 선택하세요!");
				return;
			}
	   </c:when>
	   <c:otherwise>
	  	 var prodCode = "${product.prodCode }";
		 alert(prodCode);
	   </c:otherwise>
	   </c:choose>
	   
   	
	userEmail = $("#principalEmail").val();
   	$.ajax({
         url: '${contextPath}/cart/check',
         type: 'POST',
         data: {userEmail: userEmail, prodCode: prodCode},
         success: function(result){
        	if(result == "y"){
        		alert("장바구니에 존재하는 상품입니다.");
        		return;
        	}
        	
        	$.ajax({
     	         url: '${contextPath}/cart/add',
     	         type: 'POST',
     	         data: {userEmail: userEmail, prodCode: prodCode, amount: amount},
     	         success: function(result){
     	        	 if(result == "y"){
     	        		 alert("카트에 담겼습니다.");
     	        		 location.href='${contextPath }/cart/cartlist?userEmail='+userEmail;
     	        	 }else {
     	        		 alert("일시적인 오류로 카트에 담지 못했습니다");
     	        		 return;
     	        	}
     	         }
     	      });
         }
     });  
      
      </sec:authorize>
      
      <sec:authorize access="isAnonymous()">
      
      	alert("로그인 후 장바구니에 추가해주세요!");
      	//location.href="${contextPath}/detail/main?prodCode=a12n_1";
      	//location.href="${contextPath}/detail/main?prodCode=${product.prodCode }";
      	
      </sec:authorize>
      
   });
	   
	   <c:if test="${product.citemtype == 2 }">
		  window.onload = function() {

	        var canvas = new fabric.Canvas('c',{
	            width: 450,
	            height: 600
	        });

	        fabric.Image.fromURL('${contextPath}/resources/img/background/${product.prodCode}.png', function(img) {
	        img.set({
	            scaleX: canvas.getWidth() / img.width,
	            scaleY: canvas.getHeight() / img.height,
	            objectCaching: false,
	            originX: 'left',
	            originY: 'top'
	        });
	        canvas.setBackgroundImage(img, canvas.renderAll.bind(canvas));
	        });

	            document.getElementById('filereader').onchange = function handleImage(e){
	                var reader = new FileReader();
	                reader.onload = function (event){
	                    var imgObj = new Image();
	                    imgObj.src = event.target.result;
	                    imgObj.crossOrigin = 'Anonymous';
	                    imgObj.onload = function () {
	                    var image = new fabric.Image(imgObj);
	                    image.set();
	                    canvas.centerObject(image);
	                    canvas.add(image);
	                    canvas.renderAll();
	                    }
	                }
	                reader.readAsDataURL(e.target.files[0]);
	            }

	        fabric.Image.fromURL('${contextPath}/resources/img/overlay/${product.prodCode}.png', function(img) {
	        img.set({
	            scaleX: canvas.getWidth() / img.width,
	            scaleY: canvas.getHeight() / img.height,
	            objectCaching: false,
	            originX: 'left',
	            originY: 'top'
	        });
	        canvas.setOverlayImage(img, canvas.renderAll.bind(canvas));
	        });
	        
	        canvas.controlsAboveOverlay = true;
	        
	        delObj.addEventListener('click', e => {
	            canvas.remove(canvas.getActiveObject());
	        })
	        
			$("#save").on("click", function () {
				$("#c").get(0).toBlob(function (blob) {
					saveAs(blob, "downloadimg.png");
				});
			});
	    }
	   </c:if>
	   
$(document).ajaxSend(function(e,xhr, options){
   xhr.setRequestHeader(csrfHeaderName, csrfToken);
});

$(document).ready(function(){
	showCmtList(1);
		
});

$("#showReview").on("change", "#rvwContent",function(){
	//FormData() Ajax 파일 전송 시에 사용되는 Web API 클래스의 생성
	var formData = new FormData();
	
	//uploadFiles 이름의 file 유형 input 요소를 변수에 저장
	var inputImage = $("input[name='uploadImage']");
	//inputFiles에 저장된 파일들을 files 변수에 저장.
	//inputFiles[0]은 첫번째 input 요소를 의미(input 요소가 하나만 있더라도 [0]을 명시해야 함).
	var yourFiles = inputImage[0].files;
	
	if(yourFiles == null || yourFiles.length == 0) {
		return ;
	}
	
	//formData 객체에 파일추가
	for(var i=0; i< yourFiles.length; i++){
		
		if(!checkUploadFile(yourFiles[i].name, yourFiles[i].i)) {
			//$(".uploadDiv input[name='myFiles']").val("");
		
			$(".uploadDiv").html(cloneInputFile);
			return;
		}

		formData.append("uploadFiles", yourFiles[i]);
	}

	//url 키에 명시된 주소의 컨트롤러에게 formData 객체를 POST 방식으로 전송.
	$.ajax({
		type: 'post',
		url: '${contextPath}/fileUpload',
		data: formData,
		dataType: "json",
		contentType: false, //contentType에 MIME 타입을 지정하지 않음
		processData: false, //contentType에 설정된 형식으로 data를 처리하지 않음. 
/* 			beforeSend: function(xhr) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		}, */
//		success: function(uploadResult, status){
		success: function(uploadResult) {
			$(".uploadDiv").html(cloneInputFile.html());
			showUploadedFiles(uploadResult);
		}
	});
});

</script>

<%@ include file="../include/footer.jsp" %>