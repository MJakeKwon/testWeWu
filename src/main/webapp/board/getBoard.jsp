<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세 보기</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<style>
        .comment-container {
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .comment-header {
            font-weight: bold;
        }
        .comment-content {
            margin: 10px 0;
        }
        .comment-date {
            color: #888;
            font-size: 0.9em;
        }
        .comment-actions {
            margin-top: 10px;
        }
        .comment-actions a {
            margin-right: 10px;
            color: #007bff;
            text-decoration: none;
        }
        .comment-actions a:hover {
            text-decoration: underline;
        }
        .comment-form {
            margin-top: 10px;
             /* 수정 폼을 기본적으로 숨김 display: none; */
        }
        .comment-form textarea {
            width: 100%;
            height: 60px;
            margin-bottom: 10px;
        }
        .comment-form button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 3px;
        }
        .comment-form button:hover {
            background-color: #0056b3;
        }
    </style>
<script type="text/javascript">
	window.onload = function() {
		getCommentList();
		
	}
	
	$(function(){
		$("button.btn:contains('삭제')").on("click",function(){
			self.location="/board/deleteBoard?boardType=${param.boardType}&boardNo=${param.boardNo}"
		});
	});
	
	$(function(){
		$("button.btn:contains('수정')").on("click",function(){
			self.location="/board/updateBoard?boardType=${param.boardType}&boardNo=${param.boardNo}"
		});
	});
	
	function addComment(){
		// form 데이터 가져오기
    	var form = document.getElementById('commentForm');
    	var formData = new FormData(form);

    	// JSON으로 변환
    	var jsonData = Object.fromEntries(formData);

    	//모임 리스트
		$.ajax ({
			url	: "/app/board/addComment", // (Required) 요청이 전송될 URL 주소
			type	: "POST", // (default: ‘GET’) http 요청 방식
			async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
			cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
			timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
			data  : JSON.stringify(
			 			jsonData
			 		), // 요청 시 전달할 데이터
			processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
			contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
			dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
			beforeSend  : function () {
			  // XHR Header 포함, HTTP Request 하기전에 호출
			  
			},
			success : function(data, status, xhr) {
				alert("댓글 등록 완료.");
				
			    $("#commentList").empty();
				getCommentList();
				 
			},
			error	: function(xhr, status, error) {
			  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
			},
			complete : function(xhr, status) {
			  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
			}
		});
    }
	
	function deleteComment(commentNo){
		if(!confirm("댓글을 삭제하시겠습니까?")){
			return;
		}else{
			$.ajax ({
				url	: "/app/board/deleteComment", // (Required) 요청이 전송될 URL 주소
				type  : "POST", // (default: ‘GET’) http 요청 방식
				async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
				cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
				timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
				data  : JSON.stringify
						({
							commentNo:commentNo,
				 			boardNo:${board.boardNo}
				 		}), // 요청 시 전달할 데이터
				processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
				contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
				dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
				beforeSend  : function () {
				  // XHR Header 포함, HTTP Request 하기전에 호출
				  
				},
				success : function(data, status, xhr) {
					alert("삭제가 완료되었습니다.");
					$("#commentList").empty();
					getCommentList();
				},
				error	: function(xhr, status, error) {
				  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
				},
				complete : function(xhr, status) {
				  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
				}
			});
        }
	}

	
	function updateComment(commentNo){
		var form = document.getElementById('updateCommentForm_'+commentNo);
    	var formData = new FormData(form);

    	// JSON으로 변환
    	var jsonData = Object.fromEntries(formData);

		$.ajax ({
			url	: "/app/board/updateComment", // (Required) 요청이 전송될 URL 주소
			type	: "POST", // (default: ‘GET’) http 요청 방식
			async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
			cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
			timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
			data  : JSON.stringify(
			 			jsonData
			 		), // 요청 시 전달할 데이터
			processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
			contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
			dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
			beforeSend  : function () {
			  // XHR Header 포함, HTTP Request 하기전에 호출
			  
			},
			success : function(data, status, xhr) {
				alert("댓글 수정 완료.");
				
			    $("#commentList").empty();
				getCommentList();
				 
			},
			error	: function(xhr, status, error) {
			  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
			},
			complete : function(xhr, status) {
			  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
			}
		});
    }
	function getCommentList()
	{
		$.ajax ({
			  url	: "/app/board/getCommentListByBoard", // (Required) 요청이 전송될 URL 주소
			  type	: "POST", // (default: ‘GET’) http 요청 방식
			  async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
			  cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
			  timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
			  data  : JSON.stringify(
			 				{boardNo:'${board.boardNo}'}
		 				), // 요청 시 전달할 데이터
			  processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
			  contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
			  dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
			  beforeSend  : function () {
			    // XHR Header 포함, HTTP Request 하기전에 호출
			  },
			  success : function(data, status, xhr) {
				  var str = "";
				  for(var i = 0 ; i < data.length ; i ++){
			            str += "<div class='comment-container'>" +
			                   "<div class='comment-header'>작성자 : " + data[i].commentNickName + "</div>" +
			                   "<div class='comment-content'>내용 : " + data[i].commentContents + "</div>" +
			                   "<div class='comment-date'>작성날짜 : " + data[i].commentDate + "</div>" +
			                   "<div class='comment-actions'>" +
			                   "<a href='javascript:deleteComment("+ data[i].commentNo + ");'>댓글 삭제</a>" +
			                   "<a href='javascript:updateComment("+ data[i].commentNo + ");'>댓글 수정</a>" +
			                   "</div>" +
			                   "<form id='updateCommentForm_" + data[i].commentNo + "' class='comment-form'>" +
			                   "<input type='hidden' name='commentNo' value='" + data[i].commentNo + "'>" +
			                   "<input type='hidden' name='boardNo' value='" + '${board.boardNo}' + "'>" +
			                   "<input type='hidden' name='commentNickName' value='" + data[i].commentNickName + "'>" +
			                   "<textarea name='commentContents'>" + data[i].commentContents + "</textarea>" +
			                   
			                   "</form>" +
			                   "</div><br>";
			        }
				  $('#commentList').append(str);
				  str = "";
			  },
			  error	: function(xhr, status, error) {
			    // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
			  },
			  complete : function(xhr, status) {
			    // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
			  }
		});
	}
	$(function(){
		$("div.comment-content").on("click",function(){
			style.display = 'block';
		})
	})

	 function showUpdateForm(commentNo) {
	        document.getElementById('updateCommentForm_' + commentNo).style.display = 'block';
	    }
	
	$(function(){
		$("button.btn:contains('삭제')").on("click",function(){
			self.location="/board/deleteBoard?boardType=${param.boardType}&boardNo=${param.boardNo}"
		});
	});
</script>

</head>
<body>

<input type="hidden" name="boardNo" value="${param.boardNo}" >
<input type="hidden" name="boardType" value="${param.boardType}" >

<!-- HEADER -->
	<jsp:include page="/header.jsp"/>
	<!-- HEADER -->

	<div class="container-fluid page-body-wrapper">
		<jsp:include page="boardSideBar.jsp" />


		<div class="main-panel">
				<div class="col-12 grid-margin stretch-card">
					<div class="card">
						<div class="card-body">
							<p class="card-description">
							> 
								<c:if test="${param.boardType eq '1'}"> 공지 사항 </c:if>
								<c:if test="${param.boardType eq '2'}"> 모임 홍보 </c:if>
								<c:if test="${param.boardType eq '3'}"> 모임 후기 </c:if>
								<c:if test="${param.boardType eq '4'}"> 후원 </c:if></p>
							
							<h1 class="card-title">${board.title}</h1>
							
							<div class="form-group row">
								<div class="col-sm-9">
								<p class="card-description">
									
									
								     ${board.nickName } &nbsp; &nbsp;
								     등록일 : ${board.regDate}
									<i class="mdi mdi-comment">
										
									</i>
									
								</p>
								</div>
								<div class="col-sm-3">
									<p class="card-description">
									 조회 : ${board.views} &nbsp; 댓글 : ${board.commentCnt} &nbsp;  즐겨찾기 :  ${board.bookmarkCnt }
									</p>
								</div>
							</div>
								<hr>
							<br>
							
							<div class="form-group row">
								<div class="col-sm-12">
								<%-- ${boardFile.fileName} --%>
								<c:forEach var="file" items="${boardFile}">
									<img src="${file.fileName }">
								</c:forEach>
								
							</div>
							</div>
							<div class="form-group row">
								<div class="col-sm-12">${board.contents}</div>
							</div>
							
						</div>
						
						<div class="card-body">
						<hr>
							<p class="card-description">댓글 수 : ${board.commentCnt}
							<div class="form-group row">
								<h1 class="card-title">
									nick1 ${sessionScope.user.nickname} 
								</h1>
								<div class="col-sm-12">
									<form id="commentForm">
									<input type="hidden"
										name="commentNickName" id="commentNickName" value="nick1">
										<input type="hidden" name="boardNo" id="boardNo" value="${board.boardNo}">  									
										<textarea name="commentContents" class="form-control" id="commentContents"></textarea> <br>
									</form>
									<button class="btn btn-link btn-fw" onClick="addComment();">
									댓글 쓰기
									</button>
								</div>
						</div>
						<div id="commentList">
		
						</div>
						</div>
						<br/>
						<div class="card-body">
						
							<button type="button" class="btn btn-primary mr-2">삭제</button>							
							<button type="button" class="btn btn-primary mr-2">수정</button>
						</div>
							
					</div>
								
					</div>
			</div>

</body>
</html>