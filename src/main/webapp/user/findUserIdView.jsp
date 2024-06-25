<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Verification</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container-scroller {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 70vh;
        }
        .auth-form-light {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
        }
        .form-section h1 {
            font-size: 1.5rem;
            margin-bottom: 20px;
        }
        .form-group label {
            font-weight: bold;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-success:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
        }
        .btn-warning:hover {
            background-color: #e0a800;
            border-color: #d39e00;
        }
        .text-danger, .text-success {
            margin-top: 15px;
            font-size: 0.9rem;
        }
        .input-group-append .btn {
            margin-left: 10px;
        }
        .hidden {
            display: none;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

    <!-- HEADER -->
    <jsp:include page="/header.jsp"/>
    <!-- HEADER -->
    <div class="main-panel">
        <div class="content-wrapper">
		    <div class="container-scroller">
		        <div class="auth-form-light text-left py-5 px-4 px-sm-5">
		            <div class="form-section">
		                <h1>아이디 찾기</h1>
		                <form id="userInfoForm">
		                    <div class="form-group">
		                        <label for="userName">사용자 이름:</label>
		                        <input type="text" class="form-control form-control-lg" id="userName" name="userName" required />
		                    </div>
		                    <div class="form-group">
		                        <label for="phoneNum">전화번호:</label>
		                        <div class="input-group">
		                            <input type="text" class="form-control form-control-lg" id="phoneNum" name="phoneNum" required />
		                            <div class="input-group-append">
		                                <button type="button" class="btn btn-primary" id="sendVerificationCode">인증번호 전송</button>
		                            </div>
		                        </div>
		                        <small id="phoneNumHelp" class="form-text text-muted"></small>
		                    </div>
		                </form>
		            </div>
		
		            <div class="form-section">
		                <h1>인증번호 입력</h1>
		                <form id="verificationForm" action="/user/verify-code-userId" method="post">
		                    <input type="hidden" id="verificationPhoneNum" name="phoneNum" value="${user.phoneNum}" />
		                    <input type="hidden" id="verificationUserName" name="userName" value="${user.userName}" />
		                    <div class="form-group">
		                        <label for="code">인증번호:</label>
		                        <div class="input-group">
		                            <input type="text" class="form-control form-control-lg" id="code" name="code" required />
		                            <div class="input-group-append hidden" id="resendContainer">
		                                <button type="button" class="btn btn-warning" id="resendVerificationCode">인증번호 재발송</button>
		                            </div>
		                        </div>
		                    </div>
		                    <div class="form-group text-center">
		                        <button type="submit" class="btn btn-success btn-block">확인</button>
		                    </div>
		                </form>
		            </div>
		
		            <div id="errorMessage" class="text-danger text-center">
		                <c:if test="${not empty error}">
		                    ${error}
		                </c:if>
		            </div>
		        </div>
		    </div>
	    </div>
    </div>

    <!-- FOOTER -->
    <jsp:include page="/footer.jsp" />
    <!-- FOOTER -->

    <script>
        $(document).ready(function() {
            $("#resendContainer").hide();  // 페이지 로드 시 숨김

            $("#phoneNum").on("input", function() {
                var phoneNum = $(this).val();
                var phoneNumPattern = /^010\d{7,8}$/;
                if (phoneNumPattern.test(phoneNum)) {
                    $("#phoneNumHelp").text("유효한 전화번호입니다.").removeClass("text-danger").addClass("text-success");
                } else {
                    $("#phoneNumHelp").text("전화번호는 010으로 시작하고 숫자만 입력해야 합니다.").removeClass("text-success").addClass("text-danger");
                }
            });

            $("#sendVerificationCode").click(function() {
                var userName = $("#userName").val();
                var phoneNum = $("#phoneNum").val();
                if (/^010\d{7,8}$/.test(phoneNum)) {
                    $.ajax({
                        url: "/user/send-verification-code",
                        type: "POST",
                        data: { userName: userName, phoneNum: phoneNum },
                        success: function(response) {
                            $("#errorMessage").text("인증번호가 전송되었습니다.").removeClass("text-danger").addClass("text-success");
                            $("#verificationPhoneNum").val(phoneNum);
                            $("#verificationUserName").val(userName);
                            $("#resendPhoneNum").val(phoneNum);
                            $("#resendUserName").val(userName);
                            $("#sendVerificationCode").prop("disabled", true);
                            $("#resendContainer").show();  // 인증번호 전송 후 나타남
                        },
                        error: function(xhr, status, error) {
                            $("#errorMessage").text("인증번호 전송에 실패했습니다.").removeClass("text-success").addClass("text-danger");
                        }
                    });
                } else {
                    $("#errorMessage").text("유효한 전화번호를 입력하세요.").removeClass("text-success").addClass("text-danger");
                }
            });

            $("#resendVerificationCode").click(function() {
                var phoneNum = $("#verificationPhoneNum").val();
                var userName = $("#verificationUserName").val();
                if (/^010\d{7,8}$/.test(phoneNum)) {
                    $.ajax({
                        url: "/user/send-verification-code",
                        type: "POST",
                        data: { phoneNum: phoneNum, userName: userName },
                        success: function(response) {
                            $("#errorMessage").text("인증번호가 재발송되었습니다.").removeClass("text-danger").addClass("text-success");
                            $("#resendVerificationCode").prop("disabled", true);
                        },
                        error: function(xhr, status, error) {
                            $("#errorMessage").text("인증번호 재발송에 실패했습니다.").removeClass("text-success").addClass("text-danger");
                        }
                    });
                } else {
                    $("#errorMessage").text("유효한 전화번호를 입력하세요.").removeClass("text-success").addClass("text-danger");
                }
            });
        });
        $('footer').removeClass('fixed-bottom');
    </script>

</body>
</html>
