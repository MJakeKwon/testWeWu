<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보드메인</title>
</head>
<body>
	
	<a href="/board/addQuestion.jsp">문의 등록</a>
	<br>
	<a href="/board/getQuestion.jsp">문의 상세 조회</a>
	?questionType=문의&questionNo=15
	<br>
	<a href="/board/updateQuestion.jsp">문의 수정</a>
	?questionType=문의&questionNo=15
	<br>
	<a href="/board/listQuestion.jsp">문의 목록</a>
	?questionType=문의
	<br>
	<a href="/board/updateReply.jsp">답변 등록</a>
	?questionType=문의&questionNo=15
	<br>
	<a href="/board/addDonation.jsp">후원 등록</a>
	?payType=후원
	<br>
	<a href="/board/listDonation.jsp">후원 목록</a>
	?payType=후원
	<br>
	<a href="/board/getDonation.jsp">후원 상세 보기</a>
	?payType=후원
	<br>
	<br>
	<a href="/board/addBoard.jsp">게시글 등록하기</a>
	?boardType=1
	<br>
	<a href="/board/getBoard.jsp">게시글 상세보기</a>
	?boardType=1
	<br>
	<a href="/board/listBoard.jsp">게시글 목록 보기</a>
	?boardType=1
	<br>
	
</body>
</html>