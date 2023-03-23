<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="contextPath" value="<%=request.getContextPath()  %>"/> 

<%@ include file="../include/header.jsp" %>


    <!-- Contact Start -->
    <div class="container-fluid pt-5">
		<!-- Page Header Start -->
	    <div class="container-fluid bg-secondary mb-5">
	        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 150px">
	            <h1 class="font-weight-semi-bold text-uppercase mb-3">1 대 1 문의 상세</h1>
	        </div>
	    </div>
	    <!-- Page Header End -->
	    
	    
        <div class="row px-xl-5">
            <div class="col-lg-12 mb-5">
                <div class="contact-form">
                    <div id="success"></div>
	                    <div class="form-group">
							<label>번호</label>
								<input class="form-control" name="bno" value='<c:out value="${board.bno}"/>'
									readonly="readonly" />
						</div>
						<div class="form-group">
							<label>제목</label>
								<input class="form-control" name="btitle" value='<c:out value="${board.btitle}"/>'
										readonly="readonly"/>
						</div>
						<div class="form-group">
							<label>글내용</label>
								<%-- <textarea>와 </textarea>는 사이에 공백이 없어야
								데이터베이스 저장 시에 필요 없는 공백이 포함되지 않음 --%>
								<textarea class="form-control" rows="3" name="bcontent"
								readonly="readonly"><c:out value="${board.bcontent}"/></textarea>
						</div>
						<div class="form-group">
								<label>작성자</label>
								<input class="form-control" name="bwriter" value='<c:out value="${board.bwriter}"/>'
								readonly="readonly"/>
						</div>


<form id="frmSendValue">
<sec:csrfInput/>
	<input type="hidden" name="bno" id="bno" value='<c:out value="${board.bno }"/>' />
	<input type="hidden" name="pageNum" value="${boardPagingDTO.pageNum }"/>
	<input type="hidden" name="rowPerPage" value="${boardPagingDTO.rowPerPage }"/>
	<input type="hidden" name="scope" value="${boardPagingDTO.scope }"/>
	<input type="hidden" name="keyword" value="${boardPagingDTO.keyword }"/>
</form>
                 
                 
<%-- 첨부파일 표시 --%>
<div class="row">
	<div class="col-lg-12 mb-5">
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="form-group fileUploadResult">
					<ul><%-- 업로드 후, 업로드 처리결과가 표시될 영역 --%></ul>
				</div>
			</div><%-- /.panel-body --%>
		</div><%-- /.panel --%>
	</div><%-- /.col-lg-12 --%>
</div><%-- /.row --%> 
                 
                 
<%-- Modal 시작 --%>
<div class="modal fade" id="attachModal" tabindex="-1" role="dialog" aria-labelledby="attachModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body attachModalDiv">
            	<!-- 이미지 표시 -->
            </div>
        </div><%-- /.modal-content --%>
    </div><%-- /.modal-dialog --%>
</div><%-- /.modal 끝 --%>                    
                 
               
                        <div style="text-align:center;">
                        <sec:authorize access="isAuthenticated()" >
							<sec:authentication property="principal" var="principal"/> 
								<c:if test="${principal.username eq board.bwriter}">
                            		<button class="btn btn-primary py-2 px-4" type="button" id="btnModify" data-oper="modify"
                            				>수정</button>
                                </c:if>
						</sec:authorize>
						<sec:authorize access="hasAnyAuthority('ADMIN')" >
							<button type="button" class="btn btn-primary py-2 px-4" id="btnRemove" data-oper="remove">삭제</button>
				            <button type="button" class="btn btn-primary py-2 px-4" id="btnReply" data-oper="reply">답글 등록</button>
                        </sec:authorize>    
                            <button class="btn btn-primary py-2 px-4" type="button" id="btnList" data-oper="mtomboard">목록</button>
                        </div>


                </div>
            </div>
        </div>
    </div>
    <!-- Contact End -->


<%-- Modal 시작 --%>
<div class="modal fade" id="yourModal" tabindex="-1" role="dialog" aria-labelledby="yourModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="yourModalLabel">결과</h4>
            </div>
            <div class="modal-body">완료되었습니다.</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
            </div>
        </div><%-- /.modal-content --%>
    </div><%-- /.modal-dialog --%>
</div><%-- /.modal 끝 --%>


<script type="text/javascript">


var bnoValue = '<c:out value="${board.bno}"/>';

var frmSendValue = $("#frmSendValue");


//게시물 수정 페이지로 이동
$("#btnModify").on("click", function(){
	frmSendValue.attr("action", "${contextPath}/mtomboard/modify");
	frmSendValue.attr("method", "get") ;
	frmSendValue.submit() ;
});


//게시물 삭제
$("#btnRemove").on("click", function(){
	frmSendValue.attr("action", "${contextPath}/mtomboard/remove");
	frmSendValue.attr("method", "post") ;
	frmSendValue.submit() ;
});


//게시물 목록 페이지로 이동
$("#btnList").on("click", function(){
	frmSendValue.find("#bno").remove() ;
	frmSendValue.attr("action", "${contextPath}/mtomboard/list");
	frmSendValue.attr("method", "get") ;
	frmSendValue.submit() ;
	
});


//답글 페이지 이동
$("#btnReply").on("click",function(){
	var pageNumInput = $("input[name='pageNum']").clone();
	var rowPerPageInput = $("input[name='rowPerPage']").clone();
	var scopeInput = $("input[name='scope']").clone();
	var keywordInput = $("input[name='keyword']").clone();
	var bno = '<c:out value="${board.bno}"/>';
	
	frmSendValue.attr("action","${contextPath}/mtomboard/reply");
	frmSendValue.attr("method","get");
	
	frmSendValue.append(pageNumInput);
	frmSendValue.append(rowPerPageInput);
	frmSendValue.append(scopeInput);
	frmSendValue.append(keywordInput);
	
	frmSendValue.submit();
});


var result = '<c:out value="${result}"/>';

function checkModifyOperation(result) {
	if (result === ''|| history.state) {
		return;
	} else if (result === 'successModify'){
		var myMsg = "글이 수정되었습니다";
	}
	
	$(".modal-body").html(myMsg) ;
	$("#yourModal").modal("show");
	myMsg='';
}


//선택된 페이징 번호의 게시물목록 가져오는 함수: 이벤트 전파 이용
$("#showCmtPagingNums").on("click", "ul li a" ,function(e){
	e.preventDefault() ;
	
	var targetPageNum = $(this).attr("href")  ;
	console.log("targetPageNum: " + targetPageNum);
	
	showCmtList(targetPageNum) ;
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
					
					str += "<li data-repopath='" + obj.repoPath + "' "
						+  "  data-uploadpath='" + obj.uploadPath + "'"
						+  "  data-uuid='" + obj.uuid + "'"
						+  "  data-filename='" + obj.fileName + "'  data-filetype='F'>"	
						+  "		<img src='${contextPath}/resources/img/icon-attach.png'"
						+  "			 alt='No Icon' style='height:18px; width: 18px;' />&nbsp;"
						+  			obj.fileName
						+  "</li>";
				} else {									//if(obj.fileType == "I")
					
					var thumbnailPath = obj.repoPath + "/" + obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName;
							
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


$(".fileUploadResult ul").on("click", "li", function(){
	var objLi = $(this);
	
	var downloadFileName = objLi.data("repopath") + "/" + objLi.data("uploadpath") + "/" + objLi.data("uuid") + "_" + objLi.data("filename") ;
	downloadFileName = downloadFileName.replace(new RegExp(/\\/g), "/") ;
	
	if(objLi.data("filetype") == "I") {
		$(".attachModalDiv").html(
				"<img src='${contextPath}/fileDownload?fileName=" + encodeURI(downloadFileName) + "' width='100%' />"
		);
		
		$("#attachModal").modal("show") ;
		
	} else {
		self.location.href = "${contextPath}/fileDownload?fileName=" + encodeURI(downloadFileName) ;
	}
	
}) ;


//이미지 표시 모달 감추기
$("#attachModal").on("click", function(){
	$("#attachModal").modal("hide") ;
});


$(document).ready(function(){
	
	$.ajax({
		type: "get" ,
		url: "${contextPath}/mtomboard/getFiles" ,
		data: {mtombno: bnoValue} ,
		dataType: "json" ,
		success: function(fileList, status) {
			showUploadedFiles(fileList) ;
		}
	});
	
});


</script>


<%@ include file="../include/footer.jsp" %>