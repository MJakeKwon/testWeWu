<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<script>
			function updateAddAppl(){
				var form = document.getElementById("updateAddAppl");
				form.action="/group/updateAddAppl";
				form.submit();
			}
		</script>
		<meta charset="UTF-8">
	<title>Insert title here</title>
	</head>
	<body>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		
		<div class="main-panel">
        	<div class="content-wrapper">
        		<h1>모임 개설신청 정보 조회</h1>
				<form id=updateAddAppl method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
					<input type="hidden" name="leaderNick" value="${group.leaderNick}">
					<input type="hidden" name="groupName" value="${group.groupName}">
					<input type="hidden" name="groupIntro" value="${group.groupIntro}">
					<input type="hidden" name="groupHash" value="${group.groupHash}">
					<input type="hidden" name="groupAddr" value="${group.groupAddr}">
					<input type="hidden" name="groupPlan" value="${group.groupPlan}">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
					<input type="hidden" name="groupPers" id="groupPers" value="${group.groupPers}">
					<input type="hidden" name="groupLevel" id="groupLevel" value="${group.groupLevel}">
					닉네임 : ${group.leaderNick}
					<br>
					모임명 : ${group.groupName}
					<br>
					소개  : ${group.groupIntro}
					<br>
					태그  : ${group.groupHash}
					<br>
					주소  : ${group.groupAddr}
					<br>
					계획  : ${group.groupPlan}
				</form>
					<a href="javascript:updateAddAppl();">updateAddAppl</a>
					<br>
				<a href="/">index</a>
        	</div>
        </div>
        
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>