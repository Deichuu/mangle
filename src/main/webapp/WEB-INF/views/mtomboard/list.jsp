<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="contextPath" value="<%=request.getContextPath() %>" />


<%@ include file="../include/header.jsp" %>

 <div class="text-center col-lg-12" style="padding-bottom: 40px">
            <h2 class="section-title col-lg-12"><span class="px-2">1 대 1 문의</span></h2>
        </div>
        
	      
        
        <div class="row" style="width: 100%; padding-left: 15%;">
            <div class="col-lg-10">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="row" style="text-align:center;">
                            <div class="text-left col-md-6" style="font-size:20px;  height: 45px; padding-top:10px;"></div>
                            <div class="text-right col-md-6" style="padding-top:8px;">
                            <sec:authorize access="hasAnyAuthority('USER')" >
                                <button type="button" id="btnMoveRegister" class="btn btn-primary btn-sm pull-right">문의 등록</button>
                            </sec:authorize>
                            </div>
                        </div>
                    </div><%-- /.panel-heading --%>
                    <div class="panel-body">
    
    <form class="form-inline" id="frmSendValue" action="${contextPath}/mtomboard/list" method="get" name="frmSendValue">
    
    <div class="form-group" style="margin: auto;">
        <label class="sr-only">frmSendValue</label>
        <select class="form-control" id="selectAmount" name="rowPerPage">
            <option value="10" <c:out value="${pagingCreator.pagingDTO.rowPerPage == '10' ? 'selected' : '' }" />     
                       >10개</option>
            <option value="20" <c:out value="${pagingCreator.pagingDTO.rowPerPage == '20' ? 'selected' : '' }" />     
                       >20개</option>
        </select>
        
        <select class="form-control" id="selectScope" name="scope">
            <option value="" <c:out value="${pagingCreator.pagingDTO.scope == null ? 'selected' : '' }" />     
                       >검색범위</option>
            <option value="T" <c:out value="${pagingCreator.pagingDTO.scope == 'T' ? 'selected' : '' }" />     
                       >제목</option>
            <option value="C" <c:out value="${pagingCreator.pagingDTO.scope == 'C' ? 'selected' : '' }" />     
                       >내용</option>      
            <option value="W" <c:out value="${pagingCreator.pagingDTO.scope == 'W' ? 'selected' : '' }" />     
                       >작성자</option>    
            <option value="TC" <c:out value="${pagingCreator.pagingDTO.scope == 'TC' ? 'selected' : '' }" />     
                       >제목+내용</option>    
            <option value="TW" <c:out value="${pagingCreator.pagingDTO.scope == 'TW' ? 'selected' : '' }" />     
                       >제목+작성자</option>    
            <option value="TCW" <c:out value="${pagingCreator.pagingDTO.scope == 'TCW' ? 'selected' : '' }" />     
                       >제목+내용+작성자</option>    
        </select>
        
        <div class="input-group">
            <input type="text" class="form-control" id="inputKeyword" name="keyword" placeholder="검색어를 입력하세요" 
                   value='<c:out value="${pagingCreator.pagingDTO.keyword }" />' />
            <span class="input-group-btn">
                <button class="btn btn-primary" type="button" id="btnSearchGo">
                    검색&nbsp;<i class="fa fa-search"></i>
                </button>
            </span>
        </div>
        
        <div class="input-group">
            <button class="btn" style="border-color: lightgray" type="button" id="btnReset">검색초기화</button>
        </div>
        
    </div>
    
        <input type="hidden" name="pageNum" id="pageNum" value="${pagingCreator.pagingDTO.pageNum}"/>
        <input type="hidden" name="rowPerPage" id="rowPerPage"  value="${pagingCreator.pagingDTO.rowPerPage}"/>
        <input type="hidden" name="realPageNum" id="realPageNum" value="${pagingCreator.realPageNum}"/>
        <input type="hidden" id="userEmail" value='<sec:authentication property="principal.username"/>'/>
    </form>
    <br>
    
                    
    <table class="table table-bordered text-center mb-0">
        <thead class="bg-secondary text-dark">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성날짜</th>
                <th>수정시간</th>
                <th>조회수</th>
            </tr>
        </thead>
        <tbody class="align-middle">
            <c:forEach items="${boardList}" var="board"><%-- 컨트롤러에서 보낸 목록객체 이름: boardList --%>
	            <c:if test="${board.bdelFlag == 1}">
	                <tr style="background-color:Ivory; text-align:center">
	                    <td><c:out value="${board.bno}" /></td>
	                    <td colspan="5"><em>삭제된 게시글입니다.</em></td>
	                </tr>
	            </c:if>
	            <c:if test="${board.bdelFlag == 0}">
	                 <tr class="moveDetail" data-bno='<c:out value="${board.bno}"/>'
	                 						data-bwriter='<c:out value="${board.bwriter }" />' >
	                    <td>
	                    	<c:out value="${board.bno}" />
	                    </td>
	                    <td style="text-align:left;">
	                        <c:out value="${board.btitle}"/>
	                    </td>
	                    <td>
	                    	<c:out value="${board.bwriter}" />
	                    </td>
	                    <td>
	                        <fmt:formatDate pattern="yyyy-MM-dd" value="${board.bregDate}" /><br>
	                    </td>
	                    <td>
	                    	<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.bmodDate}" /><br>
						</td>
	                    <td>
	                    	${board.bviewsCnt}
	                    </td>
	                </tr>
	            </c:if>
	            
				<c:forEach items="${reply}" var="reply">
				
				<c:if test="${board.bno == reply.rbno}">
				
					<c:if test="${reply.bdelFlag == 1}">
		                <tr style="background-color:Ivory; text-align:center"; >
		                    <td><c:out value="${reply.bno}" />(<c:out value="${board.bno }" />)</td>
		                    <td colspan="5"><em>삭제된 답글입니다.</em></td>
		                </tr>
		            </c:if>
		            
		            <c:if test="${reply.bdelFlag == 0}">
		    			<tr class="moveDetail" data-bno='<c:out value="${reply.bno }" />'
		    								   data-bwriter='<c:out value="${board.bwriter }" />'>
							<td style="padding-left: 20px;"><strong>    ↳ </strong>&nbsp;${reply.bno}(${reply.rbno})</td>
							<td style="text-align: left;">${reply.btitle }</td>	
		    					<td style="padding-left: 20px;" >${reply.bwriter }</td>
		   					<td>
		                       	<fmt:formatDate pattern="yyyy-MM-dd" value="${reply.bregDate}" /><br>
		                   	</td>
							<td>
		                    	<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${reply.bmodDate}" /><br>
							</td>
							<td>${reply.bviewsCnt}</td>
		    			</tr>
	    			</c:if>
	    			
	      		</c:if>
	      		
	  			</c:forEach>
  			
            </c:forEach>
        </tbody>
    </table><%-- /.table-responsive --%>
    
    <br>
    <%-- Pagination 시작 --%>
			<div class="col-12 pb-1">
                <nav aria-label="Page navigation">
                  <ul class="pagination justify-content-center mb-3">
                    <c:if test="${pagingCreator.prev}">
                       <li class="page-item">
                       <a class="page-link" href="1" aria-label="Previous">
                           <span aria-hidden="true">&laquo;</span>
                           <span class="sr-only">Previous</span>
                       </a>
                       </li>
                    </c:if>
                    <c:if test="${pagingCreator.prev}">
                       <li class="page-item">
                       <a class="page-link" href="${pagingCreator.startPageNum - 1}" aria-label="Previous">
                           <span aria-hidden="true">이전</span>
                           <span class="sr-only">Previous</span>
                       </a>
                       </li>
                    </c:if>
                    
                    
				<%-- 페이징 그룹의 페이징 숫자(10개 표시) --%>
				<c:forEach var="pageNum" begin="${pagingCreator.startPageNum}" end="${pagingCreator.endPageNum}">
					<%-- 선택된 숫자의 경우, Bootstrap의 active 클래스 이름 추가 --%>
					<li class='page-item ${pagingCreator.pagingDTO.pageNum == pageNum ? "active":"" }'>
					<a class="page-link" href="${pageNum}">${pageNum}</a>
					</li>
				</c:forEach>
               
				<c:if test="${pagingCreator.next}">
                	<li class="page-item">
                    	<a class="page-link" href="${pagingCreator.endPageNum +1}" aria-label="Next">
	                        <span aria-hidden="true">다음</span>
	                        <span class="sr-only">Next</span>
                    	</a>
                    </li>                    
				</c:if>       
				<c:if test="${pagingCreator.next}">
					<li class="page-item">
						<a class="page-link" href="${pagingCreator.realPageNum}" aria-label="Next">
					    	<span aria-hidden="true">&raquo;</span>
					    	<span class="sr-only">Next</span>
						</a>
					</li>                    
				</c:if>

					</ul>
				</nav>
			</div>
    
    
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
    
       
                    </div><%-- /.panel-body --%>
                </div><%-- /.panel --%>
            </div><%-- /.col-lg-12 --%>
        </div><%-- /.row --%>
	</div><%-- /#page-wrapper --%>
    
    
    <script>
    
    
    <%--로그인 계정을 loginUser 변수에 저장,
    앞 실습으로 이미 구성되어 있음, 않된 경우 추가 --%>
    var loginUser = ""; 
    <sec:authorize access="hasAuthority('USER')">
       loginUser = $("#userEmail").val();
    </sec:authorize>

    <sec:authorize access="hasAuthority('ADMIN')">
       loginUser = 'ADMIN';
    </sec:authorize>


    <%-- HTML에서 일어나는 모든 Ajax 전송 요청에 대하여 csrf 토큰값이 요청 헤더에 설정됨
    앞 실습으로 이미 구성되어 있음, 않된 경우 추가 --%>
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";
    $(document).ajaxSend(function(e, xhr, options){ 
    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    });
    
    
    $("#btnMoveRegister").on("click", function(){
        //아래에서 self는 window 객체를 의미합니다.
        //self.location.href = "${contextPath}/myboard/register" ;
        location.href = "${contextPath}/mtomboard/register";
        //self.location = "${contextPath}/myboard/register" ;
    })
    
    
	<%--게시물 행(제목) 클릭 이벤트 처리: 게시물 상세 화면 이동//////////////////////////////// --%>
    var frmSendValue = $("#frmSendValue");
    
    <%--tr 태그 클릭 시 form의 데이터를 전달하고 detail 화면 요청 --%>
    $(".moveDetail").on( "click", function(e) {
    	<%--로그인 안 한 경우--%>
    	if(!loginUser){
    		alert("로그인 후, 작성자와 관리자만 조회가 가능합니다.");
    		return ;
    	}
    	<%--작성자 변수에 저장--%>
    	var bwriterVal = $(this).data("bwriter");
    	console.log("bwriterVal: " + bwriterVal);
    	console.log("loginUser: " + loginUser);
    	<%--로그인 계정과 작성자가 다른 경우--%>
    	if(bwriterVal == loginUser || loginUser =='ADMIN'){
            
    		//<%-- bno 값이 값이 설정된 hidden 유형의 input 요소를 form에 추가 --%>
            //<%-- tr 태그의 data-bno 속성의 값을 data() 함수로 값을 읽어와 value 속성에 지정 --%>
            frmSendValue.append("<input type='hidden' name='bno' value='" + $(this).data("bno") + "'/>");
    		frmSendValue.append("<input type='hidden' name='bwriter' value='"+ $(this).data("bwriter") +"'/>");
    		frmSendValue.attr("action", "${contextPath}/mtomboard/detail");//<%-- form에 action 속성 지정 --%>
            frmSendValue.attr("method", "get");//<%-- form에 method 속성 지정 --%>
            frmSendValue.submit();//<%-- form 전송 --%>

    	} else {
    		
    		alert("작성자와 관리자만 조회가 가능합니다");
    		return ;
    		
    	}

    });
			    
    
    var result = '<c:out value="${result}" />' ;
    
    function checkModal(result) {
        if (result === ''|| history.state) {
            return;
            
        } else if(result === 'successRemove'){
            var myMsg = "글이 삭제되었습니다";
            
        } else if (parseInt(result) > 0) {
            var myMsg = "문의 글 " + parseInt(result) + " 번이 등록되었습니다.";
            
        }
        
        $(".modal-body").html(myMsg) ;
        $("#yourModal").modal("show");
        
        myMsg='';
    }
        
    
    //checkModal(result);
    
    
	<%-- 페이지 이동 함수 --%>    
	$(".page-link").on("click", function (e) {
		e.preventDefault();
		frmSendValue.find("input[name='pageNum']").val($(this).attr("href"));
		frmSendValue.attr("action", "${contextPath}/mtomboard/list");
		frmSendValue.attr("method", "get");
		frmSendValue.submit();
	});
    
    
    <%--표시행수 변경 이벤트 처리--%>
    $("#selectAmount").on("change", function(){
        frmSendValue.find("input[name='pageNum']").val(1) ;
        frmSendValue.attr("action", "${contextPath}/mtomboard/list") ;
        frmSendValue.attr("method", "get");
        frmSendValue.submit();
    });
    
    
    <%--검색버튼 클릭 이벤트 처리 --%>
    $("#btnSearchGo").on("click", function(e){
        if(!$("#selectScope").find("option:selected").val()) {
            alert("검색 범위를 선택하세요.");
            return false ;
        }
        
        if(      !( (frmSendValue.find("input[name='keyword']").val())  ||
                    (frmSendValue.find("input[name='keyword']").val() !="") )    ){
            alert("검색어를 입력하세요.") ;
            return false ;
        }
        
        frmSendValue.find("input[name='pageNum']").val(1) ;
        
        frmSendValue.submit() ;
        
    });
    
    
    <%--검색초기화 버튼 이벤트처리, 버튼 초기화 시, 1페이지에 목록 정보 다시 표시 --%>
    $("#btnReset").on("click", function(){
        
        $("#selectAmount").val(10);
        $("#selectScope").val("");
        $("#inputKeyword").val("");
        $("#pageNum").val(1);
        
        frmSendValue.submit();
        
    });
    
    
/*     $(document).ready(function(){
        //모달 동작 후, 아래의 history.pushState() 동작과 popstate 이벤트 리스너에 의해 뒤로가기 방지됨.
        checkModal(result);
        //popstate 이벤트를 처리하는 자바스크립트 리스너 추가, popstate는 간단히 브라우저의 뒤로가기 버튼 클릭 이벤트 이름입니다.
        window.addEventListener('popstate', function(event) {
            history.pushState(null, null, location.href); //뒤로가기 Block.
        })
        //페이지 로딩 시에, 실행되어 현재 목록페이지의 URL을 강제로 최근 URL로서 히스토리 객체에 다시 추가
        history.pushState(null, null, location.href);
    }); */
    
    
    </script>


<%@ include file="../include/footer.jsp" %>