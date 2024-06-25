<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>비밀번호 찾기</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h1>비밀번호 찾기</h1>
    <div class="main-panel">
        <div class="content-wrapper">
		    <form id="userInfoForm">
		        <label for="userId">사용자 아이디:</label>
		        <input type="text" id="userId" name="userId" required />
		        <br/>
		        <label for="phoneNum">전화번호:</label>
		        <input type="text" id="phoneNum" name="phoneNum" required />
		        <br/>
		        <button type="button" id="sendVerificationCode">인증번호 전송</button>
		    </form>
		
		    <h1>인증번호 입력</h1>
		    <form id="verificationForm" action="/user/verify-code-userPwd" method="post">
		        <input type="hidden" id="verificationPhoneNum" name="phoneNum" value="${user.phoneNum}" />
		        <input type="hidden" id="verificationUserId" name="userId" value="${user.userId}" />
		        <label for="code">인증번호:</label>
		        <input type="text" id="code" name="code" required />
		        <button type="submit">확인</button>
		    </form>
		    
		    <form id="resendForm" action="/user/send-verification-code" method="post">
		        <input type="hidden" id="resendPhoneNum" name="phoneNum" value="${phoneNum}" />
		        <input type="hidden" id="resendUserId" name="userId" value="${userId}" />
		        <button type="submit">인증번호 재발송</button>
		    </form>
		    
		    <div id="errorMessage" style="color: red;">
		        <c:if test="${not empty error}">
		            ${error}
		        </c:if>
		    </div>
	   </div>
   </div>

    <script>
        $(document).ready(function() {
            $("#sendVerificationCode").click(function() {
                var userId = $("#userId").val();
                var phoneNum = $("#phoneNum").val();
                
                $.ajax({
                    url: "/user/send-verification-code",
                    type: "POST",
                    data: { userId: userId, phoneNum: phoneNum },
                    success: function(response) {
                        $("#errorMessage").text("인증번호가 전송되었습니다.");
                        $("#verificationPhoneNum").val(phoneNum);
                        $("#verificationUserId").val(userId);
                        $("#resendPhoneNum").val(phoneNum);
                        $("#resendUserId").val(userId);
                    },
                    error: function(xhr, status, error) {
                        $("#errorMessage").text("인증번호 전송에 실패했습니다.");
                    }
                });
            });
        });
    </script>
</body>
</html>
