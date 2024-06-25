<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="../../css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="../../images/favicon.png" />
</head>

<body>

    <!-- HEADER -->
    <jsp:include page="/header.jsp"/>
    <!-- HEADER -->
	<div class = "main-panel">
		 <div class = "content-wrapper">
		  <div class="container-scroller">
		    <div class="container-fluid page-body-wrapper full-page-wrapper">
		      <div class="content-wrapper d-flex align-items-center auth px-0">
		        <div class="row w-100 mx-0">
		          <div class="col-lg-8 mx-auto">
		            <div class="auth-form-light text-left py-5 px-4 px-sm-5">
		              <h4>회 원 가 입</h4>
		              <form class="pt-3 form-horizontal">
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
		                  <label for="addr" class="col-sm-3 control-label">주소</label>
		                  <div class="col-sm-9">
		                    <input type="text" class="form-control form-control-lg" id="addr" name="addr" placeholder="주소">
		                  </div>
		                </div>
		                <div class="form-group">
		                  <label for="addrDetail" class="col-sm-3 control-label">상세주소</label>
		                  <div class="col-sm-9">
		                    <input type="text" class="form-control form-control-lg" id="addrDetail" name="getAddr" placeholder="상세주소">
		                  </div>
		                </div>
		                <div class="form-group">
		                  <label for="phoneNum" class="col-sm-3 control-label">휴대전화번호</label>
		                  <div class="col-sm-9">
		                    <input type="text" class="form-control form-control-lg" id="phoneNum" name="phoneNum" placeholder="휴대전화번호">
		                    <button type="button" class="btn btn-primary" id="sendVerificationCode">인증번호 전송</button>
		                    <span id="verificationCodeMsg" class="help-block"></span>
		                  </div>
		                </div>
		                <div class="form-group">
		                  <label for="verificationCode" class="col-sm-3 control-label">인증번호</label>
		                  <div class="col-sm-9">
		                    <input type="text" class="form-control form-control-lg" id="verificationCode" name="verificationCode" placeholder="인증번호 입력">
		                    <button type="button" class="btn btn-primary" id="verifyCode">인증번호 확인</button>
		                    <span id="verificationCodeMsg" class="help-block"></span>
		                  </div>
		                </div>
		                <div class="form-group">
		                  <label for="email" class="col-sm-3 control-label">이메일</label>
		                  <div class="col-sm-9">
		                    <input type="text" class="form-control form-control-lg" id="email" name="email" placeholder="이메일">
		                  </div>
		                </div>
		                <div class="form-group text-center mt-4">
		                  <button type="button" class="btn btn-block btn-primary btn-lg font-weight-medium auth-form-btn" onclick="fncAddUser()">가입하기</button>
		                  <a class="btn btn-block btn-secondary btn-lg font-weight-medium auth-form-btn" href="#" role="button">취소</a>
		                </div>
		              </form>
		            </div>
		          </div>
		        </div>
		      </div>
		      <!-- content-wrapper ends -->
		    </div>
		    <!-- page-body-wrapper ends -->
		  </div>
	  </div>
	 </div>
	  <!-- container-scroller -->
	  <!-- plugins:js -->
	  <script src="../../vendors/js/vendor.bundle.base.js"></script>
	  <!-- endinject -->
	  <!-- Plugin js for this page -->
	  <!-- End plugin js for this page -->
  
	    <!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	    <script type="text/javascript">
	    	$('footer').removeClass('fixed-bottom');
	    </script>

  <script type="text/javascript">
    //============= "취소"  Event 처리 및  연결 =============
    $(function() {
        $("a[href='#' ]").on("click" , function() {
            $("form")[0].reset();
        });
    });

    function fncAddUser() {
        var id = $("input[name='userId']").val();
        var pw = $("input[name='userPwd']").val();
        var pw_confirm = $("input[name='password2']").val();
        var name = $("input[name='userName']").val();
        var phone = $("input:hidden[name='phoneNum']").val();
        var verificationCode = $("#verificationCode").val();

        if (id == null || id.length < 1) {
            alert("아이디는 반드시 입력하셔야 합니다.");
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
        if (phoneNum == null || phoneNum.length < 1) {
            alert("휴대전화번호는 반드시 입력하셔야 합니다.");
            return;
        }
        if (verificationCode == null || verificationCode.length < 1) {
            alert("인증번호는 반드시 입력하셔야 합니다.");
            return;
        }
        if (pw != pw_confirm) {
            alert("비밀번호 확인이 일치하지 않습니다.");
            $("input:text[name='password2']").focus();
            return;
        }

        var value = "";
        if ($("input:text[name='phone2']").val() != "" && $("input:text[name='phone3']").val() != "") {
            var value = $("option:selected").val() + "-" +
                $("input[name='phone2']").val() + "-" +
                $("input[name='phone3']").val();
        }

        $("input:hidden[name='phone']").val(value);

        $("form").attr("method", "POST").attr("action", "/user/addUser").submit();
    }

    //==>"이메일" 유효성Check  Event 처리 및 연결
    $(function() {
        $("input[name='email']").on("change" , function() {
            var email=$("input[name='email']").val();
            if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
                alert("이메일 형식이 아닙니다.");
            }
        });
    });

    $(document).ready(function() {
        // Debounce 함수 추가
        function debounce(func, wait) {
            let timeout;
            return function() {
                const context = this, args = arguments;
                clearTimeout(timeout);
                timeout = setTimeout(() => func.apply(context, args), wait);
            };
        }

        $("#userId").on("keyup", debounce(function() {
            var userId = $(this).val();
            var idPattern = /^[a-zA-Z가-힣0-9]{2,10}$/;
            if (userId.length > 0) {
                if (!idPattern.test(userId)) {
                    $("#idCheckMsg").text("아이디는 2자 이상 10자 이하, 영어, 한글, 숫자만 가능합니다.").removeClass("text-success").addClass("text-danger");
                } else {
                    $.ajax({
                        type: "GET",
                        url: "/user/checkId",
                        data: { userId: userId },
                        success: function(response) {
                            if (response.available) {
                                $("#idCheckMsg").text("사용 가능한 아이디입니다.").removeClass("text-danger").addClass("text-success");
                            } else {
                                $("#idCheckMsg").text("이미 사용 중인 아이디입니다.").removeClass("text-success").addClass("text-danger");
                            }
                        },
                        error: function() {
                            $("#idCheckMsg").text("아이디 중복 체크 중 오류가 발생했습니다.").removeClass("text-success").addClass("text-danger");
                        }
                    });
                }
            } else {
                $("#idCheckMsg").text("입력전 중복확인 부터..").removeClass("text-success").addClass("text-danger");
            }
        }, 300));

        // 닉네임 실시간 중복 체크 및 유효성 검사
		$("#nickname").on("keyup", debounce(function() {
		    var nickname = $(this).val();
		    var nicknamePattern = /^[a-zA-Z가-힣0-9]{2,10}$/;
		    if (nickname.length > 0) {
		        if (!nicknamePattern.test(nickname)) {
		            $("#nicknameCheckMsg").text("닉네임은 2자 이상 10자 이하, 영어, 한글, 숫자만 가능합니다.").removeClass("text-success").addClass("text-danger");
		        } else {
		            $.ajax({
		                type: "GET", // 여기서 메서드가 서버에서 허용되는지 확인하세요.
		                url: "/user/checkNickname", // URL이 올바른지 확인하세요.
		                data: { nickname: nickname },
		                success: function(response) {
		                    if (response.available) {
		                        $("#nicknameCheckMsg").text("사용 가능한 닉네임입니다.").removeClass("text-danger").addClass("text-success");
		                    } else {
		                        $("#nicknameCheckMsg").text("이미 사용 중인 닉네임입니다.").removeClass("text-success").addClass("text-danger");
		                    }
		                },
		                error: function(xhr, status, error) {
		                    console.log("AJAX error: ", status, error); // 콘솔에 오류 로그를 추가하여 디버깅을 쉽게 합니다.
		                    $("#nicknameCheckMsg").text("닉네임 중복 체크 중 오류가 발생했습니다.").removeClass("text-success").addClass("text-danger");
		                }
		            });
		        }
		    } else {
		        $("#nicknameCheckMsg").text("").removeClass("text-success text-danger");
		    }
		}, 300));


        // 비밀번호 유효성 검사 및 일치 여부 확인
        $("#password").on("keyup", debounce(function() {
            var password = $(this).val();
            $.ajax({
                type: "GET",
                url: "/user/validatePassword",
                data: { password: password },
                success: function(response) {
                    if (response.isValid) {
                        $("#passwordCheckMsg").text("사용 가능한 비밀번호입니다.").removeClass("text-danger").addClass("text-success");
                    } else {
                        $("#passwordCheckMsg").text("비밀번호는 8자 이상 16자 이하, 영문과 특수기호를 포함해야 합니다.").removeClass("text-success").addClass("text-danger");
                    }
                },
                error: function() {
                    $("#passwordCheckMsg").text("비밀번호 유효성 검사 중 오류가 발생했습니다.").removeClass("text-success").addClass("text-danger");
                }
            });
            checkPasswordMatch();
        }, 300));

        // 비밀번호 확인 일치 여부 검사
        $("#password2").on("keyup", debounce(function() {
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

        $("#sendVerificationCode").click(function() {
            var phoneNum = $("#phoneNum").val();
            $.ajax({
                url: "/user/send-verification-code",
                type: "POST",
                data: { phoneNum: phoneNum },
                success: function(response) {
                    $("#verificationCodeMsg").text("인증번호가 전송되었습니다.");
                },
                error: function(xhr, status, error) {
                    $("#verificationCodeMsg").text("인증번호 전송에 실패했습니다.");
                }
            });
        });

        $("#verifyCode").click(function() {
            var phoneNum = $("#phoneNum").val();
            var code = $("#verificationCode").val();
            $.ajax({
                url: "/user/verify-code-user",
                type: "POST",
                data: { phoneNum: phoneNum, code: code },
                success: function(response) {
                    if (response.valid) {
                        $("#verificationCodeMsg").text("인증 성공").removeClass("text-danger").addClass("text-success");
                    } else {
                        $("#verificationCodeMsg").text("인증 실패").removeClass("text-success").addClass("text-danger");
                    }
                },
                error: function(xhr, status, error) {
                    $("#verificationCodeMsg").text("인증 과정에서 오류가 발생했습니다.");
                }
            });
        });
    });
  </script>  

</body>

</html>
