<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변 등록</title>
</head>
<body>
<form method="post" action="/board/updateReply" encType="multipart/form-data" >
<input type="hidden" name="questionNo" value="${param.questionNo}" >
<input type="hidden" name="questionType" value="${param.questionType}" >
	<!-- HEADER -->
	<jsp:include page="/header.jsp" />
	<!-- HEADER -->
	<div class="container-fluid page-body-wrapper">
		<jsp:include page="boardSideBar.jsp"/>
	
		<div class="main-panel">
				<div class="col-12 grid-margin stretch-card">
					<div class="card">
						<div class="card-body">
							<h1 class="card-title">${question.title}</h1>
							<p class="card-description">
								1:1 문의 / ${question.questionCategory}
							</p>
							<br> <br>
							<h2 class="card-title">문의 내용</h2>
							<p class="card-description">닉네임 : ${question.nickName}
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 등록일 : ${question.regDate}</p>
							<blockquote class="blockquote">
								<p class="mb-0">${question.contents}</p>
							</blockquote>
							<br> <br>

							
							<div class="form-group row">
									<label for="title" class="col-sm-3 col-form-label">답변</label>
									<div class="col-sm-3">
										<input type="text" class="form-control" name="reply"> <br /> 
									</div>
							</div>
										
										
						  <button type="submit" class="btn btn-primary mr-2">등록하기</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>