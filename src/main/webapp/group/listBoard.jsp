<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<div class="col-lg-12 grid-margin stretch-card">
	<div class="card">
		<div class="card-body">
		    <h4 class="card-title">${groupBoard.boardName}</h4>
		    <div style="float:right;">
	           	<img src="/group/img/pencil.svg"><span>작성</span>&nbsp;
	           	<img src="/group/img/arrow-repeat.svg"><span>게시판 수정</span>&nbsp;
	           	<img src="/group/img/eraser-fill.svg"><span>게시판 삭제</span>
	        </div>
			<p class="card-description">
				${groupBoard.boardIntro}
		    </p>
			<div class="table-responsive">
			  	<table class="table table-striped table-hover">
				    <thead>
				      <tr>
				        <th>
				          작성자
				        </th>
				        <th>
				          제목
				        </th>
				        <th>
				          작성일
				        </th>
				        <th>
				          조회수
				        </th>
				        <th>
				          댓글수
				        </th>
				      </tr>
				    </thead>
				    <tbody id="acleList">
				    
				    </tbody>
			    </table>
			</div>
		</div>
	</div>
</div>
	<form id="getGroupBoard">
		<input type="hidden" name="typeNo" value="${groupBoard.typeNo}">
		<input type="hidden" name="groupNo" id="groupNo" value="${groupBoard.groupNo}">
	</form>
	
	<form id="updateGroupBoard" method="post" action="/group/updateGroupBoard">
		<input type="hidden" name="typeNo" value="${groupBoard.typeNo}">
	</form>
	
	<form id="deleteGroupBoard" method="post">
		<input type="hidden" name="typeNo" value="${groupBoard.typeNo}">
	</form>
		
	<form id="addGroupAcle" method="post">
		<input type="hidden" name="typeNo" value="${groupBoard.typeNo}">
		<input type="hidden" name="groupNo" value="${groupBoard.groupNo}">
	</form>
		
	<form id="getGroup" method="post" action="/group/getGroup">
		<input type="hidden" name="groupNo" value="${groupBoard.groupNo}">
	</form>
</body>
</html>