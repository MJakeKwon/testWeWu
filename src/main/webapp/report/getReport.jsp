<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<script>
			function updateReport(){
				var form = document.getElementById("updateReport");
				form.action="/report/updateReport";
				form.submit();
			}
		</script>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<h1>신고 상세조회 View</h1>
		${report}
		<form id="updateReport" method="post">
			<input type="hidden" name="reportNo" value="${report.reportNo}">
		</form>
			<a href="javascript:updateReport()">수정하기</a>
			
	</body>
</html>