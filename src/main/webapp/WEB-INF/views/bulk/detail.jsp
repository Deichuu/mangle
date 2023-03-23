<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 

<%@ include file="../include/header.jsp" %>

    <!-- Contact Start -->
    <div class="container-fluid pt-5">
        <div class="text-center mb-4">
            <h2 class="section-title px-5"><span class="px-2">대량 주문<br></span></h2>
        </div>
        <div class="row px-xl-5">
            <div class="col-lg-12 mb-5">
                <div class="contact-form">
                  <div id="success"></div>
                  
                <form role="form" id="frmDetail" method="post" name="frmBoard" >                
                    <div class="form-group">
						<label>번호</label>
							<input class="form-control" name="bulkNo" value='<c:out value="${bulk.bno}"/>'
								readonly="readonly" />
					</div>
					<div class="form-group">
						<label>제목</label>
							<input class="form-control" name="bulkTitle" value='<c:out value="${bulk.btitle}"/>'
								readonly="readonly"	/>
					</div>
					
					<div class="form-group">
							<label>작성자</label>
							<input class="form-control" name="bulkWriter" value='<c:out value="${bulk.bwriter}"/>'
							readonly="readonly"/>
					</div>
					
					<div class="form-group">
						<label>글내용</label>
							<%-- <textarea>와 </textarea>는 사이에 공백이 없어야
							데이터베이스 저장 시에 필요 없는 공백이 포함되지 않음 --%>
							<textarea class="form-control" rows="3" name="bulkContent"  readonly="readonly"
							><c:out value="${bulk.bcontent}"/></textarea>
					</div>
             
                        
                        <div style="text-align:center;">
                        <sec:authorize access="isAuthenticated()" >
							<sec:authentication property="principal" var="principal"/> 
								<c:if test="${principal.username eq bulk.bwriter}">
	                        		<button type="button" class="btn btn-primary py-2 px-4" id="btnModify" data-oper="modify">수정</button>
	                        	</c:if>
						</sec:authorize>
						<sec:authorize access="hasAnyAuthority('ADMIN')" >
							<button type="button" class="btn btn-primary py-2 px-4" id="btndelete" data-oper="remove">삭제</button>
							<button type="button" class="btn btn-primary py-2 px-4" id="btnReply" data-oper="reply">답글 등록</button>
						</sec:authorize>	
							<button type="button" class="btn btn-primary py-2 px-4" id="btnList" data-oper="list">목록</button>
						</div>
				  </form>
				  <form id="frmSendValue">
				  <sec:csrfInput/>
				  	<input type="hidden" name="bno" id="bno" value='<c:out value="${bulk.bno }" />'>
				  	<input type="hidden" name="bwriter" id="bwriter" value='<c:out value="${bulk.bwriter }" />'>
				  	<input type="hidden" name="pageNum" value="${pagingDTO.pageNum }" />
					<input type="hidden" name="rowAmountPerPage" value="${pagingDTO.rowPerPage }" />
					<input type="hidden" name="scope" value="${pagingDTO.scope }" />
					<input type="hidden" name="keyword" value="${pagingDTO.keyword }" />
				  </form>
         
                </div>
            </div>
        </div>
    </div>
    
<%-- 첨부파일 표시 --%>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading"></div>
			<div class="panel-body">
				<div class="form-group fileUploadResult">
					<ul><%-- 업로드 후, 업로드 처리결과가 표시될 영역 --%></ul>
				</div>
			</div><%--/.panel-body --%>
		</div><%--/.panel --%>
	</div><%--/.col-lg-12 --%>
</div><%--/.row --%>
<!-- Contact End -->

	<script>
	
	var bnoValue = '<c:out value="${bulk.bno}"/>';
	
	var frmSendValue = $("#frmSendValue");
	
	//목록으로 이동
	$("#btnList").on("click",function(){
		frmSendValue.find("#bno").remove();
		frmSendValue.attr("action","${contextPath}/bulk/list");
		frmSendValue.attr("method","get");
		frmSendValue.submit();
	});
	
	
	//게시물 삭제
	$("#btndelete").on("click", function(){
		frmSendValue.attr("action", "${contextPath}/bulk/remove");
		frmSendValue.attr("method", "post") ;
		frmSendValue.submit() ;
	});
	
	
//첨부파일 처리 시작
//DB 정보를 이용 첨부파일 정보 표시 함수
function showUploadedFiles(uploadResult){
		
		if(!uploadResult || uploadResult.length == 0){
			return;	
		}

		var fileUploadResult = $(".fileUploadResult ul");
		
		var str = "";
			
		$(uploadResult).each(function(i, obj){
			
				if(obj.fileType == "F") {
					
					var calledPathFileName = obj.repoPath + "/" + obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;				
		//				console.log("호출된 파일이름: " + calledPathFileName);
					
					str += "<li data-repopath='" + obj.repoPath + "' "
						+  "  data-uploadpath='" + obj.uploadPath + "'"
						+  "  data-uuid='" + obj.uuid + "'"
						+  "  data-filename='" + obj.fileName + "'  data-filetype='F'>"	
						+  			obj.fileName
						+  "</li>";
				} else {									//if(obj.fileType == "I")
					
					var thumbnailPath = obj.repoPath + "/" + obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
							
					str += "<li data-repopath='" + obj.repoPath + "' "
						+  "  data-uploadpath='" + obj.uploadPath + "'"
						+  "  data-uuid='" + obj.uuid + "'"
						+  "  data-filename='" + obj.fileName + "'  data-filetype='I'>"
						+  "		<img src='${contextPath}/displayThumbnail?fileName=" + encodeURI(thumbnailPath) + "'"
					 	+  "			 alt='No Image' style='height:18px; width:18px;'/>&nbsp;"
						+ 			obj.fileName
						+  "</li>";
				}
			});		
			
		fileUploadResult.append(str);
	}
	
//로딩끝난뒤 실행
$(document).ready(function(){
	
 	$.ajax({
		type: 'get',	
		url: '${contextPath}/bulk/getFiles',
		data: {bulkno: bnoValue},
		dataType: 'json',
		success: function(fileList, status){
			console.log("첨부파일 목록 수집: " + status);
			showUploadedFiles(fileList);	
		}	
	}); 

		
});

//수정페이지 이동
$("#btnModify").on("click",function(){
	var pageNumInput = $("input[name='pageNum']").clone();
	var rowAmountPerPageInput = $("input[name='rowAmountPerPage']").clone();
	var scopeInput = $("input[name='scope']").clone();
	var keywordInput = $("input[name='keyword']").clone();
	
	frmSendValue.attr("action","${contextPath}/bulk/modify");
	frmSendValue.attr("method","get");
	
	frmSendValue.append(pageNumInput);
	frmSendValue.append(rowAmountPerPageInput);
	frmSendValue.append(scopeInput);
	frmSendValue.append(keywordInput);
	
	frmSendValue.submit();
});

//답글 페이지 이동
$("#btnReply").on("click",function(){
	var pageNumInput = $("input[name='pageNum']").clone();
	var rowAmountPerPageInput = $("input[name='rowAmountPerPage']").clone();
	var scopeInput = $("input[name='scope']").clone();
	var keywordInput = $("input[name='keyword']").clone();
	
	frmSendValue.attr("action","${contextPath}/bulk/reply");
	frmSendValue.attr("method","get");
	
	frmSendValue.append(pageNumInput);
	frmSendValue.append(rowAmountPerPageInput);
	frmSendValue.append(scopeInput);
	frmSendValue.append(keywordInput);
	
	frmSendValue.submit();
});


	//form의 수정/목록 이벤트처리
/* 	var frmModify = $("#frmModify");
	
		$("button").on("click", function(){
		var operation = $(this).data("oper"); //각 버튼의 data-xxx 속성에 설정된 값을 저장
	
		alert("operation: "+ operation);
	
		if(operation == "modify"){ //게시물 수정 요청
			frmModify.attr("action", "${contextPath}/board/modify");
			
		} else (operation == "list"){ //게시물 목록 요청
	
			frmModify.attr("action","${contextPath}/board/bulk/list").attr("method","get");
			frmModify.empty();
		
		}
		frmModify.submit() ; //요청 전송
	}); */
	
</script>



<%@ include file="../include/footer.jsp" %>