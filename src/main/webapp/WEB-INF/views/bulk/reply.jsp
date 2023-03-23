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
                  
<form role="form" id="frmRegist" method="post" name="frmRegist"
	  action="${contextPath}/bulk/reply">
<sec:csrfInput/>           	  
<div class="form-group">
	<label>답변할 글 제목</label>
	<input class="form-control" name="r_btitle" readonly="readonly" value='<c:out value="${bulk.btitle }" />'>
</div>

<div class="form-group">
	<label>제목</label>
	<input class="form-control" name="btitle" placeholder="제목을 입력해주세요">
</div>

<div class="form-group">
	<label>작성자</label>
	<input class="form-control" name="bwriter" value='<sec:authentication property="principal.username"/>'
		   readonly="readonly"/>
</div>

<div class="form-group">
	<label>글내용</label>
	<%-- <textarea>와 </textarea>는 사이에 공백이 없어야
		  데이터베이스 저장 시에 필요 없는 공백이 포함되지 않음 --%>
		<textarea class="form-control" rows="3" name="bcontent"
		placeholder="내용을 작성해주세요"></textarea>
</div>
					
					<%-- 첨부파일 결과 표시 --%>
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default">
								<div class="panel-heading">파일첨부</div>
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
					
                    <div style="text-align:center;">
	                    <button type="button" class="btn btn-primary py-2 px-4" id="btnReply" data-oper="reply">답글 등록</button>
						<button type="button" class="btn btn-primary py-2 px-4" id="btnList" data-oper="list">취소</button>
			
							 	<sec:csrfInput/>
							</div>
							
							<input type="hidden" name="rbno" value='<c:out value="${bulk.bno }" />'>
							<input type="hidden" name="pageNum" value="${pagingDTO.pageNum }" />
							<input type="hidden" name="rowPerPage" value="${pagingDTO.rowPerPage}" />
							<input type="hidden" name="scope" value="${pagingDTO.scope }" />
							<input type="hidden" name="keyword" value="${pagingDTO.keyword }" />
					  </form>         
                </div>
            </div>
		</div>
	</div>
<!-- Contact End -->

<script type="text/javascript">

var frmRegist = $("#frmRegist");

$("button").on("click", function(){	
	var operation = $(this).data("oper"); //각 버튼의 data-xxx 속성에 설정된 값을 저장
	
	var bwriter='<c:out value="${board.bwriter}"/>';
	
	if(operation == "reply"){ //게시물 수정 요청
	
		//게시물 등록: 첨부파일 포함
			if(!sendBoard()){
				alert("글제목/글내용/작성자를 모두 입력해야 합니다.");
				return;
			}
			
			var formObj = $("form[role='form']");
			var strInputHidden = "";
			
			//업로드 결과의 li 요소 각각에 대하여 다음을 처리(이벤트 위임 이용)
			$(".fileUploadResult ul li").each(function(i, obj){
				var objLi = $(obj);
				strInputHidden += "<input type='hidden' name='uploadFileList[" + i + "].uuid' value='" + objLi.data("uuid") + "' > "
							   +  "<input type='hidden' name='uploadFileList[" + i + "].uploadPath' value='" + objLi.data("uploadpath") + "' > "
							   +  "<input type='hidden' name='uploadFileList[" + i + "].fileName' value='" + objLi.data("filename") + "' > "
							   +  "<input type='hidden' name='uploadFileList[" + i + "].fileType' value='" + objLi.data("filetype") + "' > "
							   +  "<input type='hidden' name='uploadFileList[" + i + "].repoPath' value='" + objLi.data("repopath") + "' > ";
				
			});
			
			formObj.append(strInputHidden);
			formObj.submit();
		
	} else if(operation == "list") { //게시물 목록 요청
		var pageNumInput = $("input[name='pageNum']").clone();
		var rowPerPageInput = $("input[name='rowPerPage']").clone();
		var scopeInput = $("input[name='scope']").clone();
		var keywordInput = $("input[name='keyword']").clone();

		frmRegist.attr("action","${contextPath}/bulk/list").attr("method","get");
		frmRegist.empty();
		
		frmRegist.append(pageNumInput);
		frmRegist.append(rowPerPageInput);
		frmRegist.append(scopeInput);
		frmRegist.append(keywordInput);
		
	}//else
	frmRegist.submit() ; //요청 전송
});

//전송 할때 공백확인
function sendBoard(){
	var frmBulk = document.frmRegist;
	
	var btitle 	 = frmBulk.btitle.value;
	var bwriter  = frmBulk.bwriter.value;
	var bcontent = frmBulk.bcontent.value;
	
	if((btitle.length == 0 || btitle=="") ||
	   (bwriter.length == 0 || bwriter=="") ||
	   (bcontent.length == 0 || bcontent=="") ){
		
		return false;
	} else {
		return true;
	}		
}
	
	var cloneInputFile = $(".uploadDiv").clone();

	//ajax를 통한 첨부파일 전송 시 필요한 csrf 토큰값을 변수에 저장
 
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e,xhr, options){
		   xhr.setRequestHeader(csrfHeaderName, csrfToken);
	});

	//파일이 바뀌면 (change) 실행됨
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
			
			if(!checkUploadFile(yourFiles[i].name, yourFiles[i].i)) {
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
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
//			success: function(uploadResult, status){
			success: function(uploadResult) {
				console.log(uploadResult);
				$(".uploadDiv").html(cloneInputFile.html());
				showUploadedFiles(uploadResult);
			}
		});
	});
	
	//업로드 파일의 확장자 및 최대 파일 크기를 제한하는 함수
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
	
	//파일 이미지 보여줌
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
						+  "		<img src='${contextPath}/resources/img/icon-attach.png'"
						+  "			 alt='No Icon' style='height:18px; width: 18px;' />&nbsp;"
						+  			obj.fileName
						+  "    <span data-filename='"+ encodeURI(calledPathFileName) +"' data-filetype='F'>[삭제]</span>"
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
						+  "    <span data-filename='"+ encodeURI(thumbnailPath) +"' data-filetype='I'>[삭제]</span>"
						+  "</li>";
				}
			});		
			
		fileUploadResult.append(str);
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
			dataType:'text',
			type: 'post',
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
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

</script>



<%@ include file="../include/footer.jsp" %>