<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		<script>
			$(document).ready(function() {
				getCommentList();
			});
				
		
			function deleteGroupAcle(){
				
		        if(!confirm("정말 삭제하시겠습니까?")){
					return;
					
		        }else{
		        	
		        	// form 데이터 가져오기
		        	var form = document.getElementById('deleteGroupAcle');
		        	var formData = new FormData(form);
	
		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);

		        	//모임 리스트
					$.ajax ({
						url	: "/app/group/deleteGroupAcle", // (Required) 요청이 전송될 URL 주소
						type  : "POST", // (default: ‘GET’) http 요청 방식
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
							if(data.flag == "Y"){
								alert("삭제가 완료되었습니다");
								$('#getGroupBoard').submit();
							}else{
								alert("삭제 실패 : 기타 원인.");
							}
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
			
			function getCommentList()
			{
				$.ajax ({
					  url	: "/app/board/getCommentListByBoard", // (Required) 요청이 전송될 URL 주소
					  type	: "POST", // (default: ‘GET’) http 요청 방식
					  async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
					  cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
					  timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
					  data  : JSON.stringify(
					 				{boardNo:'${groupAcle.boardNo}'}
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
							  str += "작성자 : " + data[i].commentNickName + 
									  	" ===  내용 : " + data[i].commentContents + 
									  	" ===  작성날짜 : " + data[i].commentDate +
									  	"<a href=javascript:deleteComment("+ data[i].commentNo +");>댓글 삭제</a>"+
									  	"<a href=javascript:updateComment("+ data[i].commentNo +");>댓글 수정</a><br>" +
										"<form id='updateCommentForm_" + data[i].commentNo + "'>" +
										"<input type='hidden' name='commentNo' value='" + data[i].commentNo + "'>" +
										"<input type='hidden' name='boardNo' value='" + '${board.boardNo}' + "'>" +
										"<input type='hidden' name='commentNickName' value='" + data[i].commentNickName + "'>" +
										"<textarea name='commentContents'>" + data[i].commentContents + "</textarea>" +
										"<button type='button' onclick='updateComment(" + data[i].commentNo + ");'>수정 완료</button>" +
										"</form><br>";
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
			
			function updateGroupAcle(){
				var form = document.getElementById("updateGroupAcle");
				form.action="/group/updateGroupAcle";
				form.submit();
			}
			
			function addReport(){
				var form = document.getElementById("addReport");
				form.action="/report/addReport";
				form.submit();
			}
		</script>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		
		
		<!-- SIDEBAR -->
		<jsp:include page="/group/groupSide.jsp"></jsp:include>
		<!-- SIDEBAR -->
		
		<div class="main-panel">
        	<div class="content-wrapper">
        		<div class="card">
	                <div class="card-body">
	                    <h4 class="card-title">${groupBoard.boardName}</h4>
	                    <div style="float:right;">
	                    	<img src="/group/img/person-fill-add.svg"><span>가입신청</span>&nbsp;
	                    	<img src="/group/img/arrow-repeat.svg"><span>수정</span>&nbsp;
	                    	<img src="/group/img/eraser-fill.svg"><span>삭제</span>
	                    </div>
	                    <hr>
	                    <div class="col-md-12">
                            <div class="card">
                                <div class="card-body">
                                <h5 class="card-title">${groupAcle.acleName}</h5>
                                    <b>${groupAcle.wrteName}</b>
                                    <p class="card-description">
                                    	${groupAcle.wrteDate}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-body">
                                	<h5 class="card-title">${groupAcle.acleContents}</h5>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="col-md-12">
                           <div class="card">
                               <div class="card-body">
                               	<h5 class="card-title">댓글</h5>
                               	<form id="commentForm">
									<input type="hidden" name="boardNo" id="boardNo" value="${groupAcle.boardNo}">
									nick1<input type="hidden" name="commentNickName" id="commentNickName" value="nick1">
									<input type="text" name="commentContents" id="commentContents">
									<a href="javascript:addComment();">댓글 쓰기</a>
								</form>
                               </div>
                           </div>
                       </div>
                       <div class="col-md-12">
                           <div class="card">
                               <div class="card-body">
	                               	<div id="commentList">
	                               	
									</div>
                               </div>
                           </div>
                       </div>
	                </div>
	            </div>
				
				<button type="button" class="btn">삭제</button>
				
				<form id="deleteGroupAcle" method="post">
					<input type="hidden" name="boardNo" value="${groupAcle.boardNo}">
				</form>
					<a href="javascript:deleteGroupAcle();">삭제하기</a>
					
				<form id="updateGroupAcle" method="post">
					<input type="hidden" name="boardNo" value="${groupAcle.boardNo}">
				</form>
					<a href="javascript:updateGroupAcle();">수정하기</a>
					
				<form id="getGroupBoard" method="post" action="/group/getGroupBoard">
					<input type="hidden" name="typeNo" value="${groupAcle.typeNo}">
				</form>
				
				<form id="addReport" method="post" action="/report/addReport">
					<input type="hidden" name="targetNo" value="${groupAcle.boardNo}">
					<input type="hidden" name="reportType" value="B">
				</form>
					<a href="javascript:addReport();">신고하기</a>

        	</div>
        </div>
        
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>