<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<c:set var="i" value="0" />
	<c:forEach var="item" items="${item}">
		<c:set var="i" value="${ i+1 }" />
		${ i } == ${item.itemNo } === ${item.itemName }<br>
	</c:forEach>
</body>
</html>