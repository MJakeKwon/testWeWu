<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>loginView</title>
    <header>
        <jsp:include page="/header.jsp"/>
    </header>
    <style>
        .jumbotron {
            position: relative;
            background-color: white; /* 배경 색깔 흰색으로 변경 */
            padding: 10rem 0rem 11rem 0px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: -24rem;
        }
        
        .jumbotron img {
            width: 100%;
        }
        
        .jumbotron-container {
            padding: 0;
            margin: 0;
            width: 100%;
        }
        
        .welcome-message {
            width: 100%;
            font-weight: 900;
            text-align: center;
            margin-bottom: 20px;
            font-size: 2.85em;
            font-family: 'Baloo Bhai 2', cursive;
            font-weight: bold;
        }
        
        .green {
            color: #049f04;
        }
        
        .yellow {
            color: #ffd120;
        }
        
        .font-weight-light {
            width: 100%;
            margin-bottom: 20px;
            font-family: 'Noto Sans', sans-serif;
            font-size: 1.7rem;
            text-align: center;
            font-weight: 900;
            color: #1e35e5;
        }
        
        .auth-form-light {
            padding: 60px 50px;
        }
        
        .form-control-lg {
            height: calc(2.875rem + 2px);
            font-size: 1rem;
        }
        
        .btn-lg {
            padding: 0.75rem 1.5rem;
            font-size: 1.25rem;
        }
        
        .text-primary {
            font-size: 1.25rem;
        }
        
        .link-group {
            text-align: center;
            margin-top: 15px;
        }
        
        .link-group a {
            margin: 0 10px;
            font-size: 1rem;
            color: black;
            text-decoration: none;
        }
        
        .link-group a:hover {
            text-decoration: underline;
        }
        
        #captcha-section {
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        
        .spinner {
            margin: 10px;
            width: 40px;
            height: 40px;
            border: 5px solid lightgray;
            border-top: 5px solid #3498db;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        .captcha-container {
            display: flex;
            align-items: center;
        }

        .captcha-container img {
            margin-right: 10px;
            width: 300px;
            height: 120px;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        #reload-captcha {
            cursor: pointer;
            font-size: 1.5rem;
            color: #3498db;
        }

        .captcha-input {
            width: 300px;
            margin-top: 10px;
        }

        .centered {
            display: flex;
            justify-content: center;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <script type="text/javascript">
        $(function() {
            let captchaKey = '';
            let loginAttempts = 0; // 로그인 시도 횟수

            function loadCaptcha() {
                $.get("/captcha/key", function(data) {
                    if (data.success) {
                        captchaKey = data.key.match(/"key":"(\w+)"/)[1];
                        $("#captcha-image").attr("src", "https://naveropenapi.apigw.ntruss.com/captcha-bin/v1/ncaptcha?key=" + captchaKey);
                    } else {
                        alert("캡차를 불러오는 중 오류가 발생했습니다.");
                    }
                });
            }

            function showCaptcha() {
                $("#captcha-section").show();
                loadCaptcha();
            }

            function hideCaptcha() {
                $("#captcha-section").hide();
            }

            hideCaptcha(); // 초기에는 캡차를 숨김

            $("#userId").focus();

            function login() {
                var id = $("#userId").val();
                var pw = $("#password").val();
                var captchaValue = $("#captcha").val();

                if (id == null || id.length < 1) {
                    alert('ID 를 입력하지 않으셨습니다.');
                    $("#userId").focus();
                    return;
                }

                if (pw == null || pw.length < 1) {
                    alert('패스워드를 입력하지 않으셨습니다.');
                    $("#password").focus();
                    return;
                }

                var requestData = {
                    userId: id,
                    userPwd: pw
                };

                if (loginAttempts >= 3) {
                    if (captchaValue == null || captchaValue.length < 1) {
                        alert('캡차 값을 입력하지 않으셨습니다.');
                        $("#captcha").focus();
                        return;
                    }
                    requestData.captcha = captchaValue;
                    requestData.captchaKey = captchaKey;
                }

                $.ajax({
                    url: "/user/login",
                    method: "POST",
                    data: requestData,
                    success: function(response) {
                        if (response.success) {
                            window.location.href = "/index.jsp";
                        } else {
                            loginAttempts++;
                            alert('로그인에 실패하였습니다. \n' + response.error);
                            if (response.error === "삭제처리 되었습니다." || response.error === "정지처리 되었습니다.") {
                                alert("로그인이 제한된 계정입니다");
                            }
                            if (loginAttempts >= 3) {
                                showCaptcha();
                            }
                        }
                    },
                    error: function() {
                        loginAttempts++;
                        alert('로그인 중 오류가 발생했습니다.');
                        if (loginAttempts >= 3) {
                            showCaptcha();
                        }
                    }
                });
            }

            $("a.login-btn").on("click", function(event) {
                event.preventDefault();
                login();
            });

            $("a.register-link").on("click", function(event) {
                event.preventDefault();
                self.location = "/user/addUser";
            });

            $("a.find-id").on("click", function(event) {
                event.preventDefault();
                self.location = "/user/findUserId";
            });

            $("a.find-pw").on("click", function(event) {
                event.preventDefault();
                self.location = "/user/findPwd";
            });

            $("#reload-captcha").on("click", function() {
                loadCaptcha();
            });

            // 페이지 로드 시 로그인 시도 횟수 확인
            $.get("/user/loginAttempts", function(data) {
                loginAttempts = data.loginAttempts;
                if (loginAttempts >= 3) {
                    showCaptcha();
                }
            });

            // 엔터 키 이벤트 처리
            $(document).on("keypress", function(event) {
                if (event.which === 13) {
                    login();
                }
            });

            // 새로고침 이미지 클릭 이벤트 추가
            $("#reload-captcha").on("click", function() {
                loadCaptcha();
            });
        });
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
            <div class="row w-100 mx-0">
                <div class="col-lg-4 mx-auto">
                    <div class="auth-form-light text-left py-5 px-5 px-sm-6">
                        <div class="brand-logo"></div>
                        <h3 class="welcome-message">
                            <span class="green">W</span>
                            <span class="yellow">e</span>
                            <span class="green">W</span>
                            <span class="yellow">u</span>
                        </h3>
                        <h6 class="font-weight-light">로그인을 진행해주세요.</h6>
                        <form class="pt-3">
                            <div class="form-group">
                                <input type="text" class="form-control form-control-lg" name="userId" id="userId" placeholder="아이디">
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control form-control-lg" name="userPwd" id="password" placeholder="패스워드">
                            </div>
                            <div id="captcha-section" class="form-group centered">
                                <div class="captcha-container">
                                    <img id="captcha-image" src="" alt="CAPTCHA Image">
                                    <i id="reload-captcha" class="fas fa-sync-alt"></i>
                                </div>
                                <input type="text" class="form-control form-control-lg captcha-input" name="captcha" id="captcha" placeholder="캡차 값">
                            </div>
                            <div class="mt-3">
                                <a class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn login-btn" href="#">로 그 인</a>
                            </div>
                            <div class="link-group">
                                <a href="#" class="text-primary register-link">회원가입</a>
                                <a href="#" class="auth-link find-id">아이디 찾기</a>
                                <a href="#" class="auth-link find-pw">비밀번호 찾기</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/footer.jsp"/>
</body>
</html>
