<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 변경</title>
    
    <!-- HEADER -->
    <jsp:include page="/header.jsp"/>
    <!-- HEADER -->
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
   		 .jumbotron {
            position: relative;
            background-color: white; /* 배경 색깔 흰색으로 변경 */
            padding: 17rem 0rem 0rem 0px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: -27rem;
        }
        
        .jumbotron img {
            width: 100%;
        }
        
        .jumbotron-container {
            padding: 0;
            margin: 0;
            width: 100%;
        }
        body {
            background-color: #f8f9fa;
        }
        .container-scroller {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
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
            text-align: center;
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
        .text-danger, .text-success {
            margin-top: 15px;
            font-size: 0.9rem;
        }
        .input-group-append .btn {
            margin-left: 10px;
        }
        .form-text {
            margin-top: 5px;
            font-size: 0.9rem;
            color: #6c757d;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $("#newPassword").on("keyup", debounce(function() {
                var password = $(this).val();
                $.ajax({
                    type: "GET",
                    url: "/user/validatePassword",
                    data: { password: password },
                    success: function(response) {
                        if (response.isValid) {
                            $("#passwordCheckMsg").text("사용 가능한 비밀번호입니다.").removeClass("text-danger").addClass("text-success");
                        } else {
                            $("#passwordCheckMsg").text("비밀번호는 8자 이상 30자 이하, 영문과 특수기호를 포함해야 합니다.").removeClass("text-success").addClass("text-danger");
                        }
                    },
                    error: function() {
                        $("#passwordCheckMsg").text("비밀번호 유효성 검사 중 오류가 발생했습니다.").removeClass("text-success").addClass("text-danger");
                    }
                });
                checkPasswordMatch();
            }, 300));

            $("#confirmPassword").on("keyup", debounce(function() {
                checkPasswordMatch();
            }, 300));

            function checkPasswordMatch() {
                var password = $("#newPassword").val();
                var confirmPassword = $("#confirmPassword").val();
                if (confirmPassword.length > 0) {
                    if (password === confirmPassword) {
                        $("#passwordConfirmMsg").text("비밀번호가 일치합니다.").removeClass("text-danger").addClass("text-success");
                    } else {
                        $("#passwordConfirmMsg").text("비밀번호가 일치하지 않습니다.").removeClass("text-success").addClass("text-danger");
                    }
                } else {
                    $("#passwordConfirmMsg").text("").removeClass("text-success text-danger");
                }
            }

            function debounce(func, wait) {
                let timeout;
                return function(...args) {
                    clearTimeout(timeout);
                    timeout = setTimeout(() => func.apply(this, args), wait);
                };
            }

            $(".toggle-password").click(function() {
                $(this).toggleClass("fa-eye fa-eye-slash");
                var input = $($(this).attr("toggle"));
                if (input.attr("type") == "password") {
                    input.attr("type", "text");
                } else {
                    input.attr("type", "password");
                }
            });
        });

        function check() {
            var password = document.getElementById("newPassword").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            if (password != confirmPassword) {
                alert("비밀번호 확인하세요");
            } else {
                var form = document.getElementById("myForm");
                form.submit();
            }
        }
    </script>
</head>
<body>

   	<div class="jumbotron">
        <div class="container">
            <img src="/images/wewujumbo.jpg" alt="Background Image">
        </div>
    </div>
    
    <div class="main-panel">
        <div class="content-wrapper">
		    <div class="container-scroller">
		        <div class="auth-form-light text-left py-5 px-4 px-sm-5">
		            <div class="form-section">
		                <h1>비밀번호 변경</h1>
		                <form id="myForm" action="/user/updatePwd" method="post">
		                    <input type="hidden" name="userId" value="${userId}" />
		                    <div class="form-group">
		                        <label for="newPassword">새 비밀번호:</label>
		                        <div class="input-group">
		                            <input type="password" class="form-control form-control-lg" id="newPassword" name="newPassword" required />
		                            <div class="input-group-append">
		                                <button class="btn btn-outline-secondary toggle-password" type="button" toggle="#newPassword"><i class="fa fa-eye"></i></button>
		                            </div>
		                        </div>
		                        <small class="form-text">비밀번호는 8자 이상 16자 이하, 영문과 특수기호를 포함해주세요.</small>
		                        <div id="passwordCheckMsg" class="text-danger"></div>
		                    </div>
		                    <div class="form-group">
		                        <label for="confirmPassword">새 비밀번호 확인:</label>
		                        <div class="input-group">
		                            <input type="password" class="form-control form-control-lg" id="confirmPassword" name="confirmPassword" required />
		                            <div class="input-group-append">
		                                <button class="btn btn-outline-secondary toggle-password" type="button" toggle="#confirmPassword"><i class="fa fa-eye"></i></button>
		                            </div>
		                        </div>
		                        <div id="passwordConfirmMsg" class="text-danger"></div>
		                    </div>
		                    <button type="button" class="btn btn-primary btn-lg btn-block" onclick="check();">비밀번호 변경</button>
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

    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
</body>
</html>
