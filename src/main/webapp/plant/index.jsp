<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page import="life.wewu.web.domain.user.User" %>
<%
    // User 객체 생성
    User user = User.builder()
                    .userId("john_doe")
                    .email("john.doe@example.com")
                    .phoneNum("010-1234-5678")
                    .residentNum("123456-1234567")
                    .nickname("nick1")
                    .userPwd("password123")
                    .addr("서울특별시 강남구")
                    .getAddr("역삼동 123-45")
                    .gender("남성")
                    .currentPoint(1000)
                    .role("2.user")
                    .userName("John Doe")
                    .build();
    
    // User 객체를 세션에 설정
    session.setAttribute("user", user);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	function addPlant()
	{
		 /*if (!confirm("정말 삭제하시겠습니까?")) {
		        // 취소(아니오) 버튼 클릭 시 이벤트
		        return;
		    }else{
		    	$.ajax({
		    	    url: '/plant/deletePlant',
		    	    method: 'get',
		    	    dataType : 'html',
		    	    success: function (data) {
		    	    	if(data == "Y")
		    	    	{
		    	    		alert("완료했습니다");
		    	    	}else
		    	    	{
		    	    		alert("실패했습니다");
		    	    	}
		    	    }
		    	   
		    	});
		   */ 	
		    	var form = document.getElementById("addPlant");
				form.submit();
		    	
		    }
	function selectRandomPlant()
	{
		var form = document.getElementById("selectRandomPlant");
		form.submit();
	}
 
		
	}
</script>
<title>Insert title here</title>
</head>
<body>

<a href="/plant/getMyPlant?myPlantNo=1">getMyPlant :: GET</a>

<a href="/plant/inventory?itemPurNo=1">Inventory</a>
<a href="/plant/history">history</a>

<a href="/plant/addQuest">addQuest</a>
<a href="/plant/listQuest?searchKeyword=1">listQuest :: GET</a>
<a href="/plant/updateQuest">updateQuest</a>

<a href="/plant/listPlant">listPlant</a>

<form method="post" action="/plant/addPlant" id="addPlant">
	<input type="hidden" name="addPlant" value="4">
</form>
<a href="javascript:addPlant();">addPlant :: POST</a>
<a href="/plant/addPlant">addPlant :: GET</a>

<a href="/plant/updatePlant">updatePlant</a>
<a href="/plant/selectRandomPlant">selectRandomPlant</a>
<form method="post" action="/plant/selectRandomPlant" id="selectRandomPlant">
	<input type="hidden" name="selectRandomPlant" value="1">
</form>



</body>
</html>