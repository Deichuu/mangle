<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="<%=request.getContextPath() %>"/>

<%@ include file="../include/adminHeader.jsp" %>

<div style="padding: 100px;"  id="page-wrapper">
  <h1 style="text-align: center">회원목록리스트</h1>
  <br><br>
	<div>
		<form action="${contextPath }/admin/memberList" method="post" id="frm" name="frm" >
			<sec:csrfInput/>	
			<div class="input-group" >
		          <input type="text" class="form-control" id="inputKeyword" name="keyword" placeholder="검색어를 입력하세요" 
		          value='<c:out value="${ paging.keyword}"/>'/>
		          <span class="input-group-btn">
		              <button class="btn btn-primary py-2 px-3" type="button" id="btnSearchGo">
		              검색&nbsp;<i class="fa fa-search"></i>
		              </button>
		          </span>
		    </div>
		</form>
	</div>
	<br><br>
	<table class="table"  style="text-align: center">
	  <thead>
	    <tr>
	      <th scope="col"  style="text-align: center">회원계정</th>
	      <th scope="col"  style="text-align: center">이름</th>
	      <th scope="col"  style="text-align: center">가입일</th>
	      <th scope="col"  style="text-align: center">생년월일</th>
	      <th scope="col"  style="text-align: center">핸드폰</th>
	      <th scope="col"  style="text-align: center">쿠폰</th>
	      <th scope="col"  style="text-align: center">포인트</th>
	      <th scope="col"  style="text-align: center">권한여부</th>
	      <th scope="col"  style="text-align: center">권한수정</th>
	    </tr>
	  </thead>
	  <tbody>
	  <c:forEach items="${list }" var="list">
	    <tr>
	      <th scope="row"  style="text-align: center">${list.userEmail }</th>
	      <td>${list.userName }</td>
	      <td><fmt:formatDate value="${list.userRegdate }" pattern="yyyy/MM/dd"/></td>
	      <td><fmt:formatDate value="${list.userBirth }" pattern="yyyy/MM/dd"/></td>
	      <td>${list.userMobile }</td>
	      <td>${list.userCoupon }개</td>
	      <td>${list.userPoint }원</td>
	      <td>${list.authorityList[0].authority }</td>
	      <td>
	      <form id="change" name="auth">
	      	<sec:csrfInput/>
	      		<select id="cha" name="authority">
	      			<option value="">기본값</option>
	      			<option value="USER" >user</option>
	      			<option value="ADMIN">admin</option>
	      			<option value="ILLUSTRATOR"  >illustrator</option>
	      		</select>
	      		
	      		<input type="hidden" name="userEmail" value="${list.userEmail }" />
	      	</form>
	      </td>
	    </tr>
	    </c:forEach>
	  </tbody>
	</table>
	<br>
	<div style="text-align: center;">
		<form action="${contextPath }/admin/memberList">
		<button type="submit">목록으로</button>
		</form>
	</div>
</div>


<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

var frm = $("#frm");

<%--검색버튼 클릭 이벤트 처리 --%>
$("#btnSearchGo").on("click",function(e){
	
	if(    !( (frm.find("input[name='keyword']").val() ) || (frm.find("input[name='keyword']").val() != "") )      ){
		alert("검색어를 입력하세요");
		return false;
	}
	frm.submit();
});
	
$("select[name='authority']").on("change",function(e){
	var change = $(this).parent();
	change.attr("method","post");
	change.attr("action","${contextPath}/admin/memberAuth");
	change.submit();
});

</script>


<%@ include file="../include/adminFooter.jsp" %>