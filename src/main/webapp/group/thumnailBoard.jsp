<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	${groupBoard}
	<h1>모임 개설게시판 View 페이지</h1>
	<form id="getGroupBoard">
		<input type="hidden" name="typeNo" value="${groupBoard.typeNo}">
		<input type="hidden" name="groupNo" id="groupNo" value="${groupBoard.groupNo}">
		게시판 명 : ${groupBoard.boardName}
		<br>
		소개 : ${groupBoard.boardIntro}
		<br>
		타입  : ${groupBoard.boardType}
		<br>
		권한  : ${groupBoard.boardRole}
	</form>
	<a href="javascript:updateGroupBoard()">게시판 수정하기</a>
	
	<form id="updateGroupBoard" method="post" action="/group/updateGroupBoard">
		<input type="hidden" name="typeNo" value="${groupBoard.typeNo}">
	</form>
	
	<form id="deleteGroupBoard" method="post">
		<input type="hidden" name="typeNo" value="${groupBoard.typeNo}">
	</form>
		<a href="javascript:deleteGroupBoard();">게시판 삭제하기</a>
		
	<form id="addGroupAcle" method="post">
		<input type="hidden" name="typeNo" value="${groupBoard.typeNo}">
		<input type="hidden" name="groupNo" value="${groupBoard.groupNo}">
	</form>
		<a href="javascript:addGroupAcle();">게시글 작성하기</a>
		
	<form id="getGroup" method="post" action="/group/getGroup">
		<input type="hidden" name="groupNo" value="${groupBoard.groupNo}">
	</form>
</body>
</html>