/**
 * mycomment.js : 리뷰 데이터 처리용 Ajax Closure Module
 */
 
 var prodReviewClsr = (function(){
 
 	//리뷰 목록
 	function showReviews(pagingParams, callback,error){
 	
 		var prodCode = pagingParams.prodCode;
 		var page = pagingParams.page || 1;
 	
		$.ajax({
			type: "get",
			url : "/mangle/reviews/" + prodCode + "/page/" + page,
			dataType : 'json',
			success: function(reviewPagingCreator, status, xhr){
					if(callback){
						callback(reviewPagingCreator);
					}			
			},// success
			error: function(xhr, status, err){
					if(error){
						error(xhr);
					} //error if
			} //error
		}); //ajax
 	} //getReviewList end
 	
 	//이미지 파일
 	function showImage(reviewno, callback,error){
 	 		 	
		$.ajax({
			type: "get",
			url : "/mangle/reviews/getFile/" + reviewno,
			dataType : 'json',
			success: function(reviewno, status, xhr){
					if(callback){
						callback(reviewno);
					}			
			},// success
			error: function(xhr, status, err){
					if(error){
						error(xhr);
					} //error if
			} //error
		}); //ajax
 	} //showImage end
 	
	//리뷰 등록	
 	function registerReview(review,callback,error){
 		var prodCode = review.prodCode;
 		var uuid = review.rattfile.uuid;
 		
		$.ajax({
			type: "post",
			url : "/mangle/reviews/" + prodCode + "/new" ,
			data: JSON.stringify(review) ,
			contentType:"application/json; charset=UTF-8",
			success: function(result, status, xhr) {
						if(callback){
							callback(result);
						}// if
			}, //success
			error: function(xhr, status, er) {
						if(error){
							error(er);
						}//if end
			} // error end
		}); //ajax
 	} //registerReview-end
 	
 	//리뷰 이미지 파일 등록	
 	function registerImage(uploadFile,callback,error){
 		
		$.ajax({
			type: "post",
			url : "/mangle/reviews/registImage" ,
			data: JSON.stringify(uploadFile) ,
			contentType:"application/json; charset=UTF-8",
			success: function(result, status, xhr) {
						if(callback){
							callback(result); //RegisterSuccess 문자열
						}// if
			}, //success
			error: function(xhr, status, er) {
						if(error){
							error(er); //RegisterSuccess 문자열
						}//if end
			} // error end
		}); //ajax
 	} //registerImage-end
 	
 	//리뷰 수정
 	function modifyReview(review, callback, error){
 		var rno = review.rno;
 		var prodCode = review.prodCode;
 		
 		$.ajax({
 			type: "put",
 			url : "/mangle/reviews/" + prodCode + "/" + rno,
 			data: JSON.stringify(review),
 			contentType: "application/json;charset=UTF-8",
 			dataType: "text",
 			success: function(result){
 						if(callback){
 							callback(result);
 						}
 				}
 		});//ajax 		
 	} //modifyReview-end
 	
 	//리뷰 삭제
 	function removeReview(review, callback, error){
		var prodCode = review.prodCode;
		var rno = review.rno;
		var userEmail = review.userEmail;
		
		$.ajax({
			type: "delete",
			url: "/mangle/reviews/"+prodCode + "/" + rno,
			data: JSON.stringify({prodCode: prodCode, rno: rno, userEmail : userEmail}),
			contentType: "application/json; charset=UTF-8",
			success: function(removeResult){
						if(callback){
							callback(removeResult);
					}//if
			}//success
		
		}); //ajax-end
	
	}//removeCmtReply-end
 	
 	//날짜문자열 변경
 	function showDatetime(datetimeValue){
		var dateObj = new Date(datetimeValue);
		
		var str = "";
		
		var yyyy = dateObj.getFullYear();
		var MM = dateObj.getMonth() + 1; 
		var dd = dateObj.getDate(); 
		var hh = dateObj.getHours(); 
		var mm = dateObj.getMinutes(); 
		var ss = dateObj.getSeconds();
		
		str =  [yyyy, '-',
				(MM > 9 ? '' : '0') + MM, '-',
				(dd > 9 ? '' : '0') + dd, ' ',
				(hh > 9 ? '' : '0') + hh, ':',
				(mm > 9 ? '' : '0') + mm, ':',
				(ss > 9 ? '' : '0') + ss].join('');
				
			return str;
	} //showDatetime-end
 	
 	//좋아요
 	function likeUpdate(rno, callback, error){
		
		$.ajax({
			type: "post",
			url: "/mangle/reviews/"+ rno + "/like",
			data: JSON.stringify({rno: rno}),
			contentType: "application/json; charset=UTF-8",
			success: function(likeResult){
						if(callback){
							callback(likeResult);
					}//if
			}//success		
		}); //ajax-end	
	}//likeUpdate-end
 	
 	return {
 		showReviews : showReviews,
 	 registerReview : registerReview,
 	  registerImage : registerImage,
	   modifyReview : modifyReview,
	   removeReview : removeReview,
	   showDatetime : showDatetime,
	   	  showImage	: showImage,
	   	 likeUpdate : likeUpdate
 	};
 
 })();