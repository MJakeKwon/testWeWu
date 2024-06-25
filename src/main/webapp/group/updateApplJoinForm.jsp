<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		<script>
		
			function updateApplJoinForm()
			{
		        if(!confirm("정말 수정하시겠습니까?")){
					return;
					
		        }else{
		        	// form 데이터 가져오기
		        	var form = document.getElementById('updateApplJoinForm');
		        	var formData = new FormData(form);

		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);
					console.log(jsonData);
		        	//모임 리스트
					$.ajax ({
						url	: "/app/group/updateApplJoinForm", // (Required) 요청이 전송될 URL 주소
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
							alert("수정이 완료되었습니다. \n변경된 내용을 확인하세요");
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
	        	<div class="col-md-12 grid-margin stretch-card">
	              <div class="card">
	                <div class="card-body">
	                  <h1 class="card-title">모임가입신청</h1>
	                  <h4 class="card-title">${group.groupName}</h4>
	                  <form class="forms-sample" id="addApplJoinForm" method="post" action="/group/addApplJoinForm">
	                  	<input type="hidden" name="groupNo" value="${group.groupNo}">
	                    <div class="form-group">
	                      <label>1번 질문</label>
	                      <input type="text" class="form-control" name="frstRepl" value="${group.frstQuest}" placeholder="1번 질문">
	                    </div>
	                    <div class="form-group">
	                      <label>2번 질문</label>
	                      <input type="text" class="form-control" name="scndRepl" value="${group.scndQuest}"  placeholder="2번 질문">
	                    </div>
	                    <div class="form-group">
	                      <label>3번 질문</label>
	                      <input type="text" class="form-control" name="thrdRepl" value="${group.thrdQuest}"  placeholder="3번 질문">
	                    </div>
	                  </form>
	                <button onclick="javascript:updateApplJoinForm();" class="btn btn-primary mr-2">수정</button>
	    			<button onclick="javascript:history.go(-1);" class="btn btn-light">취소</button>
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