<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="../../css/vertical-layout-light/style.css">
  <link rel="shortcut icon" href="../../images/favicon.png" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
  <style>
  
  .jumbotron {
      position: relative;
      background: none;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      margin-bottom: 0;
    }

    .jumbotron img {
      width: 100%;
      height: auto;
    }

    .jumbotron-container {
      background-color: #FBFBFB;
      padding: 0;
      margin: 0;
      width: 100%;
    }

  .content-wrapper {
    padding-top: 0; /* content-wrapper 위쪽 여백 제거 */
    margin-top: 0; /* content-wrapper 위쪽 여백 제거 */
  }

    .input-group-append .btn {
      position: relative;
      z-index: 1;
    }

    #reload-captcha {
      background-color: #fff;
      border-color: #e8eff594;
    }

    .text-danger {
      color: red;
    }

    .text-success {
      color: green;
    }

    .main-panel {
      margin-top: 0; /* 여백 없애기 */
    }

    .content-wrapper {
      padding-top: 0; /* 여백 없애기 */
      margin-top: 0; /* 여백 없애기 */
    }

    .auth-form-light {
      margin-top: 0; /* 여백 없애기 */
    }

  </style>
  <script type="text/javascript">
    $(function () {
        let captchaKey = '';

        function loadCaptcha() {
            $.get("/captcha/key", function (data) {
                if (data.success) {
                    captchaKey = data.key.match(/"key":"(\w+)"/)[1];
                    $("#captcha-image").attr("src", "https://naveropenapi.apigw.ntruss.com/captcha-bin/v1/ncaptcha?key=" + captchaKey);
                } else {
                    alert("캡차를 불러오는 중 오류가 발생했습니다.");
                }
            });
        }

        loadCaptcha();

        $("#reload-captcha").on("click", function () {
            loadCaptcha();
            $("#captcha").focus();
        });

        $("#captcha-verify").on("click", function(event) {
            event.preventDefault();
            var captchaValue = $("#captcha").val();

            if (captchaValue == null || captchaValue.length < 1) {
                alert('캡차 값을 입력하지 않으셨습니다.');
                $("#captcha").focus();
                return;
            }

            $.ajax({
                url: "/captcha/compare",
                method: "POST",
                data: { captcha: captchaValue, key: captchaKey },
                success: function(response) {
                    if (response.success) {
                        alert('캡차 검증에 성공했습니다.');
                        $("#captcha-verify-msg").text("캡차 검증 성공").removeClass("text-danger").addClass("text-success");
                        $("#fncAddUser").prop("disabled", false);
                    } else {
                        alert('캡차 값이 올바르지 않습니다.');
                        $("#captcha").focus();
                        $("#captcha-verify-msg").text("캡차 검증 실패").removeClass("text-success").addClass("text-danger");
                        loadCaptcha();
                    }
                },
                error: function() {
                    alert('캡차 확인 중 오류가 발생했습니다.');
                    loadCaptcha();
                }
            });
        });

        $("#registerForm").on("submit", function(event) {
            event.preventDefault();
            fncAddUser(captchaKey);
        });

        function fncAddUser(captchaKey) {
            var id = $("input[name='userId']").val();
            var nickname = $("input[name='nickname']").val();
            var pw = $("input[name='userPwd']").val();
            var pw_confirm = $("input[name='password2']").val();
            var name = $("input[name='userName']").val();
            var residentNum = $("input[name='residentNum']").val();
            var phoneNum = $("input[name='phoneNum']").val();
            var verificationCode = $("#verificationCode").val();
            var email = $("input[name='email']").val();
            var addr = $("input[name='addr']").val();
            var getAddr = $("input[name='getAddr']").val();
            var captchaValue = $("#captcha").val();

            if (id == null || id.length < 1) {
                alert("아이디는 반드시 입력하셔야 합니다.");
                return;
            }
            if (nickname == null || nickname.length < 1) {
                alert("닉네임은 반드시 입력하셔야 합니다.");
                return;
            }
            if (pw == null || pw.length < 1) {
                alert("패스워드는 반드시 입력하셔야 합니다.");
                return;
            }
            if (pw_confirm == null || pw_confirm.length < 1) {
                alert("패스워드 확인은 반드시 입력하셔야 합니다.");
                return;
            }
            if (name == null || name.length < 1) {
                alert("이름은 반드시 입력하셔야 합니다.");
                return;
            }
            if (residentNum == null || residentNum.length < 1) {
                alert("주민번호는 반드시 입력하셔야 합니다.");
                return;
            }
            if (addr == null || addr.length < 1) {
                alert("주소는 반드시 입력하셔야 합니다.");
                return;
            }
            if (getAddr == null || getAddr.length < 1) {
                alert("상세주소는 반드시 입력하셔야 합니다.");
                return;
            }
            if (phoneNum == null || phoneNum.length < 1) {
                alert("휴대전화번호는 반드시 입력하셔야 합니다.");
                return;
            }
            if (verificationCode == null || verificationCode.length < 1) {
                alert("인증번호는 반드시 입력하셔야 합니다.");
                return;
            }
            if (email == null || email.length < 1) {
                alert("이메일은 반드시 입력하셔야 합니다.");
                return;
            }
            if (captchaValue == null || captchaValue.length < 1) {
                alert("캡차 값을 입력하지 않으셨습니다.");
                $("#captcha").focus();
                return;
            }
            if (pw != pw_confirm) {
                alert("비밀번호 확인이 일치하지 않습니다.");
                $("input:text[name='password2']").focus();
                return;
            }

            alert("회원가입이 완료되었습니다."); // 회원가입 성공 알림창 추가

            $("#registerForm").off("submit");
            $("#registerForm").submit();
        }

        // 추가된 부분 - 회원가입 버튼 비활성화
        $("#fncAddUser").prop("disabled", true);

        $(document).ready(function () {
            function debounce(func, wait) {
                let timeout;
                return function () {
                    const context = this, args = arguments;
                    clearTimeout(timeout);
                    timeout = setTimeout(() => func.apply(context, args), wait);
                };
            }

            $("#userId").on("keyup", debounce(function () {
                var userId = $(this).val();
                var idPattern = /^[a-zA-Z가-힣0-9]{2,30}$/;
                if (userId.length > 0) {
                    if (!idPattern.test(userId)) {
                        $("#idCheckMsg").text("아이디는 2자 이상 30자 이하, 영어, 한글, 숫자만 가능합니다.").removeClass("text-success").addClass("text-danger");
                    } else {
                        $.ajax({
                            type: "GET",
                            url: "/user/checkId",
                            data: { userId: userId },
                            success: function (response) {
                                if (response.available) {
                                    $("#idCheckMsg").text("사용 가능한 아이디입니다.").removeClass("text-danger").addClass("text-success");
                                } else {
                                    $("#idCheckMsg").text("이미 사용 중인 아이디입니다.").removeClass("text-success").addClass("text-danger");
                                }
                            },
                            error: function () {
                                $("#idCheckMsg").text("아이디 중복 체크 중 오류가 발생했습니다.").removeClass("text-success").addClass("text-danger");
                            }
                        });
                    }
                } else {
                    $("#idCheckMsg").text("입력전 중복확인 부터..").removeClass("text-success").addClass("text-danger");
                }
            }, 300));

            $("#nickname").on("keyup", debounce(function () {
                var nickname = $(this).val();
                var nicknamePattern = /^[a-zA-Z가-힣0-9]{2,20}$/;
                if (nickname.length > 0) {
                    if (!nicknamePattern.test(nickname)) {
                        $("#nicknameCheckMsg").text("닉네임은 2자 이상 20자 이하, 영어, 한글, 숫자만 가능합니다.").removeClass("text-success").addClass("text-danger");
                    } else {
                        $.ajax({
                            type: "GET",
                            url: "/user/checkNickname",
                            data: { nickname: nickname },
                            success: function (response) {
                                if (response.available) {
                                    $("#nicknameCheckMsg").text("사용 가능한 닉네임입니다.").removeClass("text-danger").addClass("text-success");
                                } else {
                                    $("#nicknameCheckMsg").text("이미 사용 중인 닉네임입니다.").removeClass("text-success").addClass("text-danger");
                                }
                            },
                            error: function (xhr, status, error) {
                                console.log("AJAX error: ", status, error);
                                $("#nicknameCheckMsg").text("닉네임 중복 체크 중 오류가 발생했습니다.").removeClass("text-success").addClass("text-danger");
                            }
                        });
                    }
                } else {
                    $("#nicknameCheckMsg").text("").removeClass("text-success text-danger");
                }
            }, 300));

            $("#password").on("keyup", debounce(function () {
                var password = $(this).val();
                $.ajax({
                    type: "GET",
                    url: "/user/validatePassword",
                    data: { password: password },
                    success: function (response) {
                        if (response.isValid) {
                            $("#passwordCheckMsg").text("사용 가능한 비밀번호입니다.").removeClass("text-danger").addClass("text-success");
                        } else {
                            $("#passwordCheckMsg").text("비밀번호는 8자 이상 30자 이하, 영문과 특수기호를 포함해야 합니다.").removeClass("text-success").addClass("text-danger");
                        }
                    },
                    error: function () {
                        $("#passwordCheckMsg").text("비밀번호 유효성 검사 중 오류가 발생했습니다.").removeClass("text-success").addClass("text-danger");
                    }
                });
                checkPasswordMatch();
            }, 300));

            $("#password2").on("keyup", debounce(function () {
                checkPasswordMatch();
            }, 300));

            function checkPasswordMatch() {
                var password = $("#password").val();
                var password2 = $("#password2").val();
                if (password2.length > 0) {
                    if (password === password2) {
                        $("#passwordConfirmMsg").text("비밀번호가 일치합니다.").removeClass("text-danger").addClass("text-success");
                    } else {
                        $("#passwordConfirmMsg").text("비밀번호가 일치하지 않습니다.").removeClass("text-success").addClass("text-danger");
                    }
                } else {
                    $("#passwordConfirmMsg").text("").removeClass("text-success text-danger");
                }
            }

            $("#sendVerificationCode").click(function () {
                var phoneNum = $("#phoneNum").val();
                $.ajax({
                    url: "/user/send-verification-code",
                    type: "POST",
                    data: { phoneNum: phoneNum },
                    success: function (response) {
                        $("#phoneNumMsg").text("인증번호가 전송되었습니다.").removeClass("text-danger").addClass("text-success");
                    },
                    error: function (xhr, status, error) {
                        $("#phoneNumMsg").text("인증번호 전송에 실패했습니다.").removeClass("text-success").addClass("text-danger");
                    }
                });
            });

            $("#verifyCode").click(function () {
                var phoneNum = $("#phoneNum").val();
                var code = $("#verificationCode").val();
                $.ajax({
                    url: "/user/verify-code-user",
                    type: "POST",
                    data: { phoneNum: phoneNum, code: code },
                    success: function (response) {
                        if (response.valid) {
                            $("#phoneNumMsg").text("인증 성공").removeClass("text-danger").addClass("text-success");
                        } else {
                            $("#phoneNumMsg").text("인증 실패").removeClass("text-success").addClass("text-danger");
                        }
                    },
                    error: function (xhr, status, error) {
                        $("#verificationCodeMsg").text("인증 과정에서 오류가 발생했습니다.");
                    }
                });
            });

            $("input[name='email']").on("change", function () {
                var email = $("input[name='email']").val();
                if (email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)) {
                    alert("이메일 형식이 아닙니다.");
                }
            });

            // 실시간 휴대전화 번호 입력 검증
            $("#phoneNum").on("input", function() {
                var phoneNum = $(this).val();
                var phoneNumPattern = /^\d{0,11}$/;
                var isValid = phoneNumPattern.test(phoneNum);

                if (!isValid) {
                    $("#phoneNumMsg").text("- 제외한 숫자만 입력해주세요").removeClass("text-success").addClass("text-danger");
                    $("#sendVerificationCode").prop("disabled", true);
                } else if (phoneNum.length > 11) {
                    $("#phoneNumMsg").text("핸드폰 번호 11자리로 입력해주세요").removeClass("text-success").addClass("text-danger");
                    $("#sendVerificationCode").prop("disabled", true);
                } else if (phoneNum.length === 11) {
                    $("#phoneNumMsg").text("유효한 전화번호입니다.").removeClass("text-danger").addClass("text-success");
                    $("#sendVerificationCode").prop("disabled", false);
                } else {
                    $("#phoneNumMsg").text("").removeClass("text-success text-danger");
                    $("#sendVerificationCode").prop("disabled", true);
                }
            });

        });
    });

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                var fullAddr = '';
                var extraAddr = '';

                if (data.userSelectedType === 'R') {
                    fullAddr = data.roadAddress;
                } else {
                    fullAddr = data.jibunAddress;
                }

                if (data.userSelectedType === 'R') {
                    if (data.bname !== '') {
                        extraAddr += data.bname;
                    }
                    if (data.buildingName !== '') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
                }

                document.getElementById('addr').value = fullAddr;

                document.getElementById('getAddr').focus();
            },
            theme: {
                bgColor: "#ECECEC",
                searchBgColor: "#0B65C8",
                contentBgColor: "#FFFFFF",
                pageBgColor: "#FAFAFA",
                textColor: "#333333",
                queryTextColor: "#FFFFFF",
                postcodeTextColor: "#FA4256",
                emphTextColor: "#008BD3",
                outlineColor: "#E0E0E0"
            }
        }).open();
    }
</script>

</head>

<body>
	  <!-- HEADER -->
	  <jsp:include page="/header.jsp" />
	  <!-- HEADER -->
	  <div class="jumbotron">
	    <div class="container">
	      <img src="/images/wewujumbo.jpg" alt="Background Image">
	    </div>
	  </div>

<!--   <div class="main-panel"> -->
      <div class="container-scroller">
        <div class="container-fluid page-body-wrapper full-page-wrapper">
            <div class="row w-100 mx-0">
              <div class="col-lg-8 mx-auto">
                <div class="auth-form-light text-left py-5 px-4 px-sm-5">
                  <h4 style="font-size: 24px; color: #2340ea; font-weight: bold;">회 원 가 입</h4>
                  <form id="registerForm" class="pt-3 form-horizontal" method="post" action="/user/addUser">
                    <div class="form-group">
                      <label for="userId" class="col-sm-3 control-label">아 이 디</label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control form-control-lg" id="userId" name="userId" placeholder="중복확인하세요">
                        <span id="idCheckMsg" class="help-block"></span>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="nickname" class="col-sm-3 control-label">닉네임</label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control form-control-lg" id="nickname" name="nickname" placeholder="중복확인하세요">
                        <span id="nicknameCheckMsg" class="help-block"></span>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="password" class="col-sm-3 control-label">비밀번호</label>
                      <div class="col-sm-9">
                        <input type="password" class="form-control form-control-lg" id="password" name="userPwd" placeholder="비밀번호">
                        <span id="passwordCheckMsg" class="help-block"></span>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="password2" class="col-sm-3 control-label">비밀번호 확인</label>
                      <div class="col-sm-9">
                        <input type="password" class="form-control form-control-lg" id="password2" name="password2" placeholder="비밀번호 확인">
                        <span id="passwordConfirmMsg" class="help-block"></span>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="userName" class="col-sm-3 control-label">이름</label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control form-control-lg" id="userName" name="userName" placeholder="회원이름">
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="residentNum" class="col-sm-3 control-label">주민번호</label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control form-control-lg" id="residentNum" name="residentNum" placeholder="주민번호">
                        <span id="helpBlock" class="help-block">
                          <strong class="text-danger">" - " 제외 13자리입력하세요</strong>
                        </span>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="identityGender" class="col-sm-3 control-label">성별</label>
                      <div class="col-sm-9">
                        <div style="display: inline-block; margin-right: 10px;">
                          <input type="radio" id="identityGender1" name="gender" value="M">
                          <label for="identityGender1">남자</label>
                        </div>
                        <div style="display: inline-block; margin-right: 10px;">
                          <input type="radio" id="identityGender2" name="gender" value="F">
                          <label for="identityGender2">여자</label>
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="addr" class="col-sm-3 col-form-label info-label">주소</label>
                      <div class="col-sm-9">
                        <div class="input-group">
                          <input type="text" class="form-control form-control-lg" id="addr" name="addr" placeholder="주소 찾기를 눌러 주소를 입력해주세요." readonly>
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary" id="find-postcode" onclick="execDaumPostcode()">주소 찾기</button>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="getAddr" class="col-sm-3 control-label">상세주소</label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control form-control-lg" id="getAddr" name="getAddr" placeholder="상세주소">
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="phoneNum" class="col-sm-3 control-label">휴대전화번호</label>
                      <div class="col-sm-9">
                        <div class="input-group">
                          <input type="text" class="form-control form-control-lg" id="phoneNum" name="phoneNum" placeholder="휴대전화번호">
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary" id="sendVerificationCode" disabled>인증번호 전송</button>
                          </div>
                        </div>
                        <span id="phoneNumMsg" class="help-block"></span>
                        <span id="verificationCodeMsg" class="help-block"></span>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="verificationCode" class="col-sm-3 control-label">인증번호</label>
                      <div class="col-sm-9">
                        <div class="input-group">
                          <input type="text" class="form-control form-control-lg" id="verificationCode" name="verificationCode" placeholder="인증번호 입력">
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary" id="verifyCode">인증번호 확인</button>
                          </div>
                        </div>
                        <span id="verificationCodeMsg" class="help-block"></span>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="email" class="col-sm-3 control-label">이메일</label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control form-control-lg" id="email" name="email" placeholder="이메일">
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="captcha" class="col-sm-3 control-label">캡차</label>
                      <div class="col-sm-9">
                        <div class="input-group">
                          <img id="captcha-image" src="" alt="CAPTCHA Image" class="mr-2" style="width: 300px; height: 100px;">
                          <div class="input-group-append">
                            <button type="button" id="reload-captcha" class="btn btn-secondary" style="background-color: #fff; border-color: #e8eff594;">
                              <i class="fas fa-redo"></i>
                            </button>
                          </div>
                        </div>
                        <div class="input-group mt-2">
                          <input type="text" class="form-control" id="captcha" name="captcha" placeholder="캡차 값" style="max-width: 250px; font-size: 14px;">
                          <div class="input-group-append">
                            <button type="button" class="btn btn-primary" id="captcha-verify">캡차 검증</button>
                          </div>
                        </div>
                        <span id="captcha-verify-msg" class="help-block"></span>
                      </div>
                    </div>
                    <div class="form-group text-center mt-4">
                      <button type="submit" id="fncAddUser" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn">가입하기</button>
                      <a class="btn btn-block btn-secondary btn-lg font-weight-medium auth-form-btn" href="#" role="button" id="cancelButton">취소</a>
                    </div>
                  </form>

                </div>
              </div>
            </div>
          </div>
          <!-- content-wrapper ends -->
        </div>
        <!-- page-body-wrapper ends -->
  <!-- container-scroller -->
  <script src="../../vendors/js/vendor.bundle.base.js"></script>
  <jsp:include page="/footer.jsp" />
  <script type="text/javascript">
    $('footer').removeClass('fixed-bottom');

    // 추가된 부분 - 취소 버튼 클릭 이벤트
    $("#cancelButton").on("click", function(event) {
      event.preventDefault();
      window.location.href = "/user/loginView.jsp"; // 로그인 페이지로 리다이렉트
    });
  </script>
</body>

</html>
