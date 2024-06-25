<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script>
		
			function getReport(reportNo)
			{
				var form = document.getElementById("getReport");
				var str = "<input type=hidden name=reportNo value=" + reportNo +">";
				$('#getReport').append(str);
				form.action="/report/getReport";
				form.submit();
			}
		</script>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<h1>모든 신고내역</h1>
		<c:forEach var="report" items="${list}">
		    <a href="javascript:getReport(${report.reportNo})">${report.reportNo}</a>
		    ====
		    <c:out value="${report.reportNote}"/>
		    ====
		    <c:out value="${report.rsltFlag}"/>
		    ====
		    <c:out value="${report.reportType}"/><br>
		</c:forEach>
		<form id="getReport" method="post">
		
		</form>
	</body>
</html>