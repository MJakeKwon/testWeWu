<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<script>
			function getGroup(){
				var form = document.getElementById("getGroup");
				form.action="/group/getGroup";
				form.submit();
			}
			
			function getAddAppl(){
				var form = document.getElementById("getAddAppl");
				form.action="/group/getAddAppl";
				form.submit();
			}
			
			function getApplJoin(){
				var form = document.getElementById("getApplJoin");
				form.action="/group/getApplJoin";
				form.submit();
			}
			
			function getApplJoinList(){
				var form = document.getElementById("getApplJoinList");
				form.action="/group/getApplJoinList";
				form.submit();
			}
			
			function getMemberGroup(){
				var form = document.getElementById("getMemberGroup");
				form.action="/group/getMemberGroup";
				form.submit();
			}
			
			function getGroupAcle(){
				var form = document.getElementById("getGroupAcle");
				form.action="/group/getGroupAcle";
				form.submit();
			}
			
			function mainGroup(){
				var form = document.getElementById("mainGroup");
				form.action="/group/mainGroup";
				form.submit();
			}
			
			function updateGroup(){
				var form = document.getElementById("updateGroup");
				form.action="/group/updateGroup";
				form.submit();
			}
			
			function deleteGroup(){
				
		        if(!confirm("정말 삭제하시겠습니까?")){
					return;
					
		        }else{
		        	
		        	// form 데이터 가져오기
		        	var form = document.getElementById('deleteGroup');
		        	var formData = new FormData(form);

		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);

		        	//모임 리스트
					$.ajax ({
						url	: "/app/group/deleteGroup", // (Required) 요청이 전송될 URL 주소
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
							}else{
								alert("삭제 실패 : 모임장 이외의 모임원이 존재하는 경우.");
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
			
			function addApplGroup(){
				var form = document.getElementById("addApplGroup");
				form.action="/group/addApplGroup";
				form.submit();
			}
			
			function deleteApplGroup(){
				
		        if(!confirm("정말 삭제하시겠습니까?")){
					return;
					
		        }else{
		        	
		        	// form 데이터 가져오기
		        	var form = document.getElementById('deleteApplGroup');
		        	var formData = new FormData(form);

		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);

		        	//모임 리스트
					$.ajax ({
						url	: "/app/group/deleteApplGroup", // (Required) 요청이 전송될 URL 주소
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
							}else if(data.flag == "board"){
								alert("삭제 실패 : 모임의 모든 게시판을 삭제해주세요.");
							}else if(data.flag == "user"){
								alert("삭제 실패 : 모임의 모든 모임원을 강퇴 후 삭제해주세요.");
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
			
			function getReportList(){
				var form = document.getElementById("getReportList");
				form.action="/report/getReportList";
				form.submit();
			}
			
		</script>
		<meta charset="UTF-8">
	<title>Insert title here</title>
	</head>
	<body>
		<jsp:include page="/header.jsp"></jsp:include>
		
		<div class="main-panel">
        	<div class="content-wrapper">
        		<form id="getGroup" method="post">
					<input type="hidden" name="groupNo" value="3">
				</form>
					<a href="javascript:getGroup();">getGroup</a>
					
				<form id="getAddAppl" method="post">
					<input type="hidden" name="groupNo" value="3">
				</form>
					<a href="javascript:getAddAppl();">getAddAppl</a>
					
				<form id="getApplJoin" method="post">
					<input type="hidden" name="memberNo" value="4">
				</form>
					<a href="javascript:getApplJoin();">getApplJoin</a>
					
				<form id="getApplJoinList" method="post">
					<input type="hidden" name="searchCondition" value="group"> 
					<input type="hidden" name="searchKeyword" value="2">
				</form>
					<a href="javascript:getApplJoinList();">getApplJoinList</a>
					
				<form id="getMemberGroup" method="post">
					<input type="hidden" name="memberNo" value="2">
				</form>
					<a href="javascript:getMemberGroup();">getMemberGroup</a>
				
				<form id="mainGroup" method="post">
				</form>
					<a href="javascript:mainGroup();">mainGroup</a>
					
				<form id=updateGroup method="post">
					<input type="hidden" name="groupNo" value="3">
				</form>
					<a href="javascript:updateGroup();">updateGroup</a>
					
				<form id=deleteGroup method="post">
					<input type="hidden" name="groupNo" value="5">
				</form>
					<a href="javascript:deleteGroup();">deleteGroup</a>
					
				<form id=addApplGroup method="post">
				
				</form>
					<a href="javascript:addApplGroup();">addApplGroup</a>
					
				<form id=deleteApplGroup method="post">
					<input type="hidden" name="groupNo" value="4">
				</form>
					<a href="javascript:deleteApplGroup();">deleteApplGroup</a>
					
				<form id=getReportList method="post">
				
				</form>
					<a href="javascript:getReportList();">getReportList</a>
        	</div>
        </div>
		
			
		<!-- footer.jsp 포함 -->
	    <jsp:include page="/footer.jsp" />
	    <!-- footer.jsp 포함 -->
	</body>
</html>