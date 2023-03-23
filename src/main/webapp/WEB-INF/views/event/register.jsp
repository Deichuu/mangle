<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="<%=request.getContextPath() %>"/>


<%@include file="../include/header.jsp" %> 


<!-- 
    Page Header Start
    <div class="container-fluid bg-secondary mb-5">
        <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
            <h1 class="font-weight-semi-bold text-uppercase mb-3">Contact Us</h1>
            <div class="d-inline-flex">
                <p class="m-0"><a href="">Home</a></p>
                <p class="m-0 px-2">-</p>
                <p class="m-0">Contact</p>
            </div>
        </div>
    </div>
    Page Header End
 -->

    <!-- Contact Start -->
    <div class="container-fluid pt-5">
        <div class="text-center mb-4">
            <h2 class="section-title px-5"><span class="px-2">이벤트 등록페이지</span></h2>
        </div>
        <div class="row px-xl-5">
            <div class="col-lg-12 mb-5">
                <div class="contact-form">
                    <div id="success"></div>
                    <form name="sentMessage" id="registerForm" action="${contextPath }/event/register" method="post">
                        <div class="control-group">
                            <input type="text" class="form-control" id="eventTitle" name="eventTitle" placeholder="제목입력"
                                required="required" data-validation-required-message="제목을 입력하세요" />
                            <p class="help-block text-danger"></p>
                        </div>
                        <div class="control-group">
                            <textarea class="form-control" rows="6" id="eventContent" name="eventContent" placeholder="Content"
                                required="required"
                                data-validation-required-message="글 내용을 입력하세요"></textarea>
                            <p class="help-block text-danger"></p>
                     
                        </div>
                        <div class="uploadDiv">
								<input id="inputFile" type="file" name="uploadFiles" accept="image/*"/><br>
							</div>
							<button id="btnFileUpload" type="button">파일 업로드</button>
							<div class="fileUploadResult">
							       <div class='bigImageWrapper'>
										<div class='bigImage'>
											<!-- 이미지파일이 표시되는 DIV -->
										</div>
									</div>
								 <ul>
								 	<%-- 업로드 후 처리결과가 표시될 영역 --%>
								 </ul>
							</div>
                        <div>
                        	<sec:csrfInput/>
                            <button class="btn btn-primary py-2 px-4" type="submit" id="registCompl">글 등록</button>
                        </div>
                    </form>
   
                </div>
            </div>
        </div>
    </div>
    <!-- Contact End -->

<script>


var cloneInputFile = $(".uploadDiv").clone();

$(".uploadDiv").on("change", "input[type='file']" ,function(){
	//FormData() Ajax 파일 전송 시 사용 Web API 클래스
	var formData = new FormData();
	
	var inputFiles = $("input[name='uploadFiles']");
	//inputFiles[0]은 첫번째 input 요소
	
	var files = inputFiles[0].files;
	
	if(files == null || files.length == 0) {
		return ;
	}
	
	console.log(files);
	
	//formData 객체에 파일추가
//	formData.append("uploadFiles", files[0]);
 	for(var i=0; i< files.length; i++){
		
		if(!checkUploadFile(files[i].name, files[i].i)) {
			//$(".uploadDiv input[name='myFiles']").val("");
		
			$(".uploadDiv").html(cloneInputFiles);
			return;
		}

		formData.append("uploadFiles", files[i]);
	}
	//url 키에 명시된 주소의 컨트롤러에게 formData 객체를 POST 방식으로 전송.
	$.ajax({
		type: 'post',
		url: '${contextPath}/fileUpload',
		data: formData,
		dataType: "json",
		contentType: false,
		processData: false, 
		success: function(uploadResult) {
			console.log(uploadResult);
			$(".uploadDiv").html(cloneInputFile.html());
			showUploadedFiles(uploadResult);
		}
	});
});

function checkUploadFile(fileName, fileSize) {
	var maxFileSizeAllowed = 104857600;
	var regExpFileExtension = /.*?\.(jpg|jpeg|png|gif|bmp|pdf)$/;
	
	//최대 허용 크기 제한 검사
	if(fileSize >= maxFileSizeAllowed){
		alert("업로드 파일이 제한된 크기를 초과했습니다.");
		return false;
	}
	
 	if(!regExpFileExtension.test(fileName)){
		alert("jpg, jpeg, png, gif, bmp, pdf 유형의 파일만 업로드 가능합니다.");
		return false;
	}
 	return true;
}

//파일 이미지 보여줌
function showUploadedFiles(uploadResult){
	
	if(!uploadResult || uploadResult.length == 0){
		return;	
	}

	var fileUploadResult = $(".fileUploadResult ul");
	
	var str = "";
		
	$(uploadResult).each(function(i, obj){
		

		var thumbnailPath = obj.repoPath + "/" + obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName;
				
		str += "<li data-repopath='" + obj.repoPath + "' "
			+  "  data-uploadpath='" + obj.uploadPath + "'"
			+  "  data-uuid='" + obj.uuid + "'"
			+  "  data-filename='" + obj.fileName + "'  data-filetype='I'>"
			+  "		<img src='${contextPath}/displayThumbnail?fileName=" + encodeURI(thumbnailPath) + "'"
		 	+  "			 alt='No Image' style='height:18px; width:18px;'/>&nbsp;"
			+ 			obj.fileName
			+  "    <span data-filename='"+ encodeURI(thumbnailPath) +"' data-filetype='I'>[삭제]</span>"
			+  "</li>";
				
		
	fileUploadResult.append(str);
	});
}

//파일 삭제
$(".fileUploadResult ul").on("click","li span",function(e){
	var targetFileName = $(this).data("filename");
	var targetFileType = $(this).data("filetype");
	console.log("targetFileName: " + targetFileName);
	console.log("targetFileType: " + targetFileType);
		
	var parentLi = $(this).parent();
		
	$.ajax({
		url: '${contextPath}/deleteUploadedFile',
		data: {fileName: targetFileName, fileType: targetFileType},
		dataType:'json',
		type: 'post',
/* 			beforeSend: function(xhr) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		}, */
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

var strInputHidden = "";

$("#registCompl").on("click", function () {
	var registerForm = $("#registerForm");
	var eventTitle = $("#eventTitle").val();
	var eventContent= $("#eventContent").val();
	
	if(eventTitle.length == 0 || eventContent.length == 0){
		alert("제목과 내용은 반드시 있어야 합니다.");
		return;
	}
	
	$(".fileUploadResult ul li").each(function(i, obj){
		var objLi = $(obj);
		strInputHidden += "<input type='hidden' name='uploadFileList[" + i + "].uuid' value='" + objLi.data("uuid") + "' > "
					   +  "<input type='hidden' name='uploadFileList[" + i + "].uploadPath' value='" + objLi.data("uploadpath") + "' > "
					   +  "<input type='hidden' name='uploadFileList[" + i + "].fileName' value='" + objLi.data("filename") + "' > "
					   +  "<input type='hidden' name='uploadFileList[" + i + "].fileType' value='" + objLi.data("filetype") + "' > "
					   +  "<input type='hidden' name='uploadFileList[" + i + "].repoPath' value='" + objLi.data("repopath") + "' > ";
				   
	});
	
	registerForm.append(strInputHidden);	
	registerForm.submit();
	
})

$(".a").on("click", function () {
	if($(this).val() == 1){
		
	}
})

var csrfHeaderName = "${_csrf.headerName}";
var csrfToken = "${_csrf.token}";

$(document).ajaxSend(function(e,xhr, options){
   xhr.setRequestHeader(csrfHeaderName, csrfToken);
});

</script>
<%@include file="../include/footer.jsp" %>