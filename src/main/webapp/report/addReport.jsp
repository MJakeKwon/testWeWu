<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script>
	
		function addReport()
		{
	        if(!confirm("정말 신고 하시겠습니까?")){
				return;
				
	        }else{
	        	// form 데이터 가져오기
	        	var form = document.getElementById('addReport');
	        	var formData = new FormData(form);

	        	// JSON으로 변환
	        	var jsonData = Object.fromEntries(formData);

	        	//모임 리스트
				$.ajax ({
					url	: "/app/report/addReport", // (Required) 요청이 전송될 URL 주소
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
						alert("신고 완료되었습니다. \n변경된 내용을 확인하세요");
						var str = "";
								
						str += "<input type='hidden' name='reportNo' value = '"+ data.reportNo +"'>";
						$('#getReport').append(str);
						$('#getReport').submit();
						 
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
		<h1>신고하기</h1>
		<c:if test="${reportType eq 'B'}">
			게시글
		</c:if>
		<c:if test="${reportType eq 'C'}">
			댓글
		</c:if>
		<c:if test="${reportType eq 'O'}">
			채팅
		</c:if>
		${groupAcle }
		<form id="addReport">
			<input type="hidden" name="targetNo" value="${targetNo}">
			<input type="hidden" name="reportNickname" value="nick1">
			<input type="hidden" name="reportType" value="${reportType}">
			<input type="hidden" name="targetNickname" value="${groupAcle.wrteName }">
			<input type="hidden" name="reportContents" value="${groupAcle.acleContents }">
			게시글 제목 : ${groupAcle.acleName }
			<br>
			게시글 내용 : ${groupAcle.acleContents }
			<br>
			작성자 : ${groupAcle.wrteName }
			<br>
			신고 사유 : <input type="text" name="reportNote">
		</form>
		<form id="getReport" method="post" action="/report/getReport">
			
		</form>
		<a href="javascript:addReport();">개설하기</a>
	</body>
</html>