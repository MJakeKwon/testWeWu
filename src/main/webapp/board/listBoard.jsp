<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록 보기</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
 <style>
     .thumbnail {
         padding: 10px;
     }
     .thumbnail img {
         width: 100%;
         height: auto;
     }
 </style>
<script type="text/javascript">


	function addBookmark(boardNo){
		
		var formData = {
				boardNo: boardNo,
				nickName: "nick1"
		};
		
		$.ajax ({
			url	: "/app/board/addBookmark", // (Required) 요청이 전송될 URL 주소
			type	: "POST", // (default: ‘GET’) http 요청 방식
			async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
			cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
			timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
			data  : JSON.stringify(formData), // 요청 시 전달할 데이터
			processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
			contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
			dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
			beforeSend  : function () {
			  // XHR Header 포함, HTTP Request 하기전에 호출
			  
			},
			success : function(data, status, xhr) {
			
				if(data.flag == "Y"){
					alert("북마크 완료.");
					location.reload();
				}else{
					alert("북마크 실패");
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
	
	function deleteBookmark(boardNo) {
		var formData = {
			boardNo: boardNo
		};

		$.ajax({
			url: "/app/board/deleteBookmark",
			type: "POST",
			async: true,
			cache: true,
			timeout: 3000,
			data: JSON.stringify(formData),
			processData: true,
			contentType: "application/json",
			dataType: "json",
			success: function(data, status, xhr) {
				if(data.flag == "Y"){
					alert("삭제 완료.");
					location.reload();
				}else{
					alert("삭제 실패");
				}
			},
			error: function(xhr, status, error) {
				alert("삭제 실패.");
			}
		});
    }
	$(function(){
		$("td:nth-child(2)").on(
				"click",
				function() {
					self.location = "/board/getBoard?boardType=${param.boardType}"
							+"&boardNo="
							+ $($(this).children()).val();

				});
	});
	
	 $(function(){
			$("button.btn.btn-outline-primary").on("click", function() {
				self.location="/board/addBoard?boardType=${param.boardType}"
			});

		});
</script>

</head>
<body>
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
		                  <h1 class="card-title">
							<c:if test="${param.boardType eq '1'}"> 공지 사항 </c:if>
							<c:if test="${param.boardType eq '2'}"> 모임 홍보 </c:if>
							<c:if test="${param.boardType eq '3'}"> 모임 후기 </c:if>
							<c:if test="${param.boardType eq '4'}"> 후원 </c:if>
						</h1>
		                
		                  <div class="table-responsive">
		                    <table class="table table-striped">
		                      <thead>
		                        <tr>
		                          <th>
		                            No
		                          </th>
		                          <th>
		                            제목
		                          </th>
		                          <th>
		                            닉네임
		                          </th>
		                          <th>
		                            등록일
		                          </th>
		                          <th>
		                            즐겨찾기 수
		                          </th>
		                          <th>
		                            조회수
		                          </th>
		                          <th>
		                            댓글 수
		                          </th>
		                     
		                        </tr>
		                      </thead>
		                      <tbody>
		                      	<c:set var="i" value="0" />
		                      	<c:forEach var="board" items="${list}">
		                      	<c:set var="i" value="${ i+1 }" />
		                        <tr>
		                          <td>
		                           
		                            ${i}
		                            
		                          </td>
		                          <td>
		                            ${board.title}
		                             <input type="hidden" value="${board.boardNo}"> 
		                          </td>
		                          <td>
		                          	${board.nickName}
		                          </td>
		                          <td>
		                            ${board.regDate}
		                          </td>
		                          <td>
		                            ${board.bookmarkCnt}
		                          </td>
		                          <td>
		                            ${board.views}
		                          </td>
		                          <td>
		                            ${board.commentCnt}
		                          </td>
		                          
		                        </tr>
		                        </c:forEach>
		                      </tbody>
		                    </table>
		                  </div>
		                  
		                  
		                  
		                  <button type="button" class="btn btn-outline-primary btn-fw"> 
		                  <c:if test="${param.boardType eq '1'}"> 공지 </c:if>
							<c:if test="${param.boardType eq '2'}"> 모임 홍보 </c:if>
							<c:if test="${param.boardType eq '3'}"> 모임 후기 </c:if>
							<c:if test="${param.boardType eq '4'}"> 후원 </c:if>
							글 등록하기
		                   </button>
		                  
		              </div>
		         </div>
		         
		         </div>
		        </div>
		       </div>
				<!-- FOOTER -->
		<jsp:include page="/footer.jsp" />
		<!-- FOOTER -->

</body>
</html>