<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
                  
                <form role="form" id="frmModify" method="post" name="frmModify" >
                <sec:csrfInput/>                
                    <div class="form-group">
						<label>번호</label>
							<input class="form-control" name="bno" value='<c:out value="${bulk.bno}"/>'
								readonly="readonly" />
					</div>
					<div class="form-group">
						<label>제목</label>
							<input class="form-control" name="btitle" value='<c:out value="${bulk.btitle}"/>'
									/>
					</div>
					<div class="form-group">
							<label>작성자</label>
							<input class="form-control" name="bwriter" value='<c:out value="${bulk.bwriter}"/>'
							readonly="readonly"/>
					</div>					
					<div class="form-group">
						<label>글내용</label>
							<%-- <textarea>와 </textarea>는 사이에 공백이 없어야
							데이터베이스 저장 시에 필요 없는 공백이 포함되지 않음 --%>
							<textarea class="form-control" rows="3" name="bcontent"
							><c:out value="${bulk.bcontent}"/></textarea>
					</div>             
                        
                        <div style="text-align:center;">
	                        <button type="button" class="btn btn-primary py-2 px-4" id="btnModify" data-oper="modify">수정</button>
							<button type="button" class="btn btn-primary py-2 px-4" id="btndelete" data-oper="remove">삭제</button>
							<button type="button" class="btn btn-primary py-2 px-4" id="btnList" data-oper="list">취소</button>
						</div>
						
						<input type="hidden" name="pageNum" value="${pagingDTO.pageNum }" />
						<input type="hidden" name="rowPerPage" value="${pagingDTO.rowPerPage}" />
						<input type="hidden" name="scope" value="${pagingDTO.scope }" />
						<input type="hidden" name="keyword" value="${pagingDTO.keyword }" />
				  </form>
         
                </div>
            </div>
        </div>
        
        <%-- 첨부파일 결과 표시 --%>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">첨부 파일 수정</div>
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input id="inputFile" type="file" name="uploadFiles" multiple><br>
				</div>
				<div class="form-group fileUploadResult">
					<ul>
					<%-- 업로드 후, 업로드 처리결과가 표시될 영역 --%>
					</ul>
				</div>
			</div><%-- /.panel-body --%>
		</div><%-- /.panel --%>
	</div><%-- /.col-lg-12 --%>
</div><%-- /.row --%>

    </div>
    <!-- Contact End -->

	<script>
	var bnoValue = '<c:out value="${bulk.bno}"/>';
	//form의 수정/목록 이벤트처리
	var frmModify = $("#frmModify");
	
	$("button").on("click", function(){	
		var operation = $(this).data("oper"); //각 버튼의 data-xxx 속성에 설정된 값을 저장
		
		var bwriter='<c:out value="${board.bwriter}"/>';
		
		if(operation == "modify"){ //게시물 수정 요청
			frmModify.attr("action", "${contextPath}/bulk/modify");
			alert("수정되었습니다.");	
		
		} else if(operation == "list") { //게시물 목록 요청
			var pageNumInput = $("input[name='pageNum']").clone();
			var rowPerPageInput = $("input[name='rowPerPage']").clone();
			var scopeInput = $("input[name='scope']").clone();
			var keywordInput = $("input[name='keyword']").clone();
	
			frmModify.attr("action","${contextPath}/bulk/list").attr("method","get");
			frmModify.empty();
			
			frmModify.append(pageNumInput);
			frmModify.append(rowPerPageInput);
			frmModify.append(scopeInput);
			frmModify.append(keywordInput);
			
		} else if (operation == "remove"){
			frmModify.attr("action", "${contextPath}/bulk/remove");
			 alert("삭제되었습니다.");
			
		}//else
		frmModify.submit() ; //요청 전송
	});
	
//첨부파일 처리 시작

var csrfHeaderName = "${_csrf.headerName}";
var csrfToken = "${_csrf.token}";

$(document).ajaxSend(function(e,xhr, options){
	xhr.setRequestHeader(csrfHeaderName, csrfToken);
});

var cloneInputFile = $(".uploadDiv").clone();

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
					+  "  data-filename='" + obj.fileName + "'  data-filetype='F' style='height:25px;'>"	
					+  	  obj.fileName
					+ " &nbsp;<button type='button' class='btn btn-danger btn-xs' "
					+ " data-filename='" + calledPathFileName + "' data-filetype='F'>X</button>"
					+  "</li>";
			} else {									//if(obj.fileType == "I")
				
				var thumbnailPath = obj.repoPath + "/" + obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
						
				str += "<li data-repopath='" + obj.repoPath + "' "
					+  "  data-uploadpath='" + obj.uploadPath + "'"
					+  "  data-uuid='" + obj.uuid + "'"
					+  "  data-filename='" + obj.fileName + "'  data-filetype='I' style='height:25px;'>"
					+  "  <img src='${contextPath}/displayThumbnail?fileName=" + encodeURI(thumbnailPath) + "'"
				 	+  "	   alt='No Image' style='height:18px; width:18px;'/>&nbsp;&nbsp;"
					+ 	  obj.fileName
					+ " &nbsp;<button type='button' class='btn btn-danger btn-xs' "
					+ " data-filename='" + thumbnailPath + "' data-filetype='I'>X</button>"
					+  "</li>";
			}
		});		
		
	fileUploadResult.append(str);
}

function checkUploadFile(fileName, fileSize) {
	var maxFileSizeAllowed = 104857600;
	var regExpFileExtension = /.*\.(exe|sh|zip|alz)$/i;
	
	//최대 허용 크기 제한 검사
	if(fileSize >= maxFileSizeAllowed){
		alert("업로드 파일의 제한된 크기(1MB)를 초과했습니다.");
		return false;
	}
	
 	if(regExpFileExtension.test(fileName)){
		alert("exe, sh, zip, alz 유형의 파일은 업로드 할 수 없습니다.");
		return false;
	}
 	return true;
}

$(".uploadDiv").on("change", "input[type='file']" ,function(){
	//FormData() Ajax 파일 전송 시에 사용되는 Web API 클래스의 생성
	var formData = new FormData();
	
	//uploadFiles 이름의 file 유형 input 요소를 변수에 저장
	var inputFiles = $("input[name='uploadFiles']");
	//inputFiles에 저장된 파일들을 files 변수에 저장.
	//inputFiles[0]은 첫번째 input 요소를 의미(input 요소가 하나만 있더라도 [0]을 명시해야 함).
	var yourFiles = inputFiles[0].files;
	
	if(yourFiles == null || yourFiles.length == 0) {
		return ;
	}
	
	console.log(yourFiles);
	
	//formData 객체에 파일추가
	for(var i=0; i< yourFiles.length; i++){
		
		if(!checkUploadFile(yourFiles[i].name, yourFiles[i].size)) {
			//$(".uploadDiv input[name='myFiles']").val("");
		
			$(".uploadDiv").html(cloneInputFiles);
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
//		success: function(uploadResult, status){
		success: function(uploadResult){
			console.log(uploadResult);
			$(".uploadDiv").html(cloneInputFile.html());
			showUploadedFiles(uploadResult);
		}
		
	});
	
});

$(".fileUploadResult ul").on("click","li span",function(e){
	var targetFileName = $(this).data("filename");
	var targetFileType = $(this).data("filetype");
	console.log("targetFileName: " + targetFileName);
	console.log("targetFileType: " + targetFileType);
		
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

$(".fileUploadResult ul").on("click","li button",function(e){
	if(confirm("이 파일을 삭제하겠습니까?")){
		vartargetLi = $(this).closest("li");
		targetLi.remove();
		alert("파일이 삭제되었습니다.")
	}
});

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
</script>



<%@ include file="../include/footer.jsp" %>