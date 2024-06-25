<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<script>
			function addApplJoin()
			{
		        if(!confirm("정말 가입신청 하시겠습니까?")){
					return;
					
		        }else{
		        	// form 데이터 가져오기
		        	var form = document.getElementById('addApplJoin');
		        	var formData = new FormData(form);
	
		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);
	
		        	//모임 리스트
					$.ajax ({
						url	: "/app/group/addApplJoin", // (Required) 요청이 전송될 URL 주소
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
							var str = "";
							alert("가입신청이 완료되었습니다");
							str += "<input type='hidden' name='memberNo' value = "+ data.memberNo +">";
							$('#getApplJoin').append(str);
							$('#getApplJoin').submit();
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
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		
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
	                  <form class="forms-sample" id="addApplJoin" method="post" action="/group/getApplJoin">
	                  	<input type="hidden" name="groupNo" value="${group.groupNo}">
						<input type="hidden" name="memberNickName" value="nick3">
						<input type="hidden" name="frstQuest" value="${group.frstQuest}">
						<input type="hidden" name="scndQuest" value="${group.scndQuest}">
						<input type="hidden" name="thrdQuest" value="${group.thrdQuest}">
	                    <div class="form-group">
	                      <label>${group.frstQuest}</label>
	                      <input type="text" class="form-control" name="frstRepl" placeholder="1번 답변">
	                    </div>
	                    <div class="form-group">
	                      <label>${group.scndQuest}</label>
	                      <input type="text" class="form-control" name="scndRepl" placeholder="2번 답변">
	                    </div>
	                    <div class="form-group">
	                      <label>${group.thrdQuest}</label>
	                      <input type="text" class="form-control" name="thrdRepl" placeholder="3번 답변">
	                    </div>
	                  </form>
	                <button onclick="javascript:addApplJoin();"  class="btn btn-primary mr-2">신청</button>
	    			<button onclick="javascript:history.go(-1);" class="btn btn-light">취소</button>
	                </div>
	              </div>
	            </div>
        	</div>
        </div>
        <form id="getApplJoin" method="post" action="/group/getApplJoin">
					
		</form>
		
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>