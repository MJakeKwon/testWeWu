<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update User Info</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .info-label {
            font-weight: bold;
        }
        .info-value {
            border: 1px solid #ccc;
            border-radius: 4px;
            padding: 10px;
            background-color: #f9f9f9;
        }
        .password-section {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
        .password-input {
            width: 50%;
        }
        .btn-block {
            width: 48%;
            display: inline-block;
        }
        .form-control-lg {
            font-size: 1.1rem;
        }
        .text-danger {
            color: #dc3545 !important;
        }
        .text-success {
            color: #28a745 !important;
        }
    </style>
</head>
<body>

    <!-- HEADER -->
    <jsp:include page="/header.jsp"/>
    <!-- HEADER -->
    <div class="main-panel">
        <div class="content-wrapper">
		    <div class="container-scroller">
		        <div class="container-fluid page-body-wrapper full-page-wrapper">
		            <div class="content-wrapper d-flex align-items-center auth px-0">
		                <div class="row w-100 mx-0">
		                    <div class="col-lg-8 mx-auto">
		                        <div class="auth-form-light text-left py-5 px-4 px-sm-5">
		                            <h4 class="mb-4">회원 정보 수정</h4>
		                            <form id="updateForm" class="pt-3 form-horizontal" method="POST" action="/user/update">
		                                <input type="hidden" name="userId" id="userId" value="${user.userId}">
		                                <div class="form-group row">
		                                    <label for="userName" class="col-sm-3 col-form-label info-label">이름</label>
		                                    <div class="col-sm-9">
		                                        <input type="text" class="form-control form-control-lg" id="userName" name="userName" value="${user.userName}" required <c:if test="${user.role == 2}">disabled</c:if>>
		                                    </div>
		                                </div>
		                                <div class="form-group row">
		                                    <label for="nickname" class="col-sm-3 col-form-label info-label">닉네임</label>
		                                    <div class="col-sm-9">
		                                        <input type="text" class="form-control form-control-lg" id="nickname" name="nickname" value="${user.nickname}" required <c:if test="${user.role == 2}">disabled</c:if>>
		                                    </div>
		                                </div>
		                                <div class="form-group row">
		                                    <label for="email" class="col-sm-3 col-form-label info-label">이메일</label>
		                                    <div class="col-sm-9">
		                                        <input type="email" class="form-control form-control-lg" id="email" name="email" value="${user.email}" required>
		                                    </div>
		                                </div>
		                                <div class="form-group row">
		                                    <label for="phoneNum" class="col-sm-3 col-form-label info-label">휴대전화번호</label>
		                                    <div class="col-sm-9">
		                                        <div class="input-group">
		                                            <input type="text" class="form-control form-control-lg" id="phoneNum" name="phoneNum" value="${user.phoneNum}" required readonly>
		                                            <div class="input-group-append">
		                                                <button type="button" class="btn btn-primary" onclick="openPhoneNumberModal()">핸드폰 번호 변경</button>
		                                            </div>
		                                        </div>
		                                        <span id="verificationCodeMsg" class="help-block"></span>
		                                    </div>
		                                </div>
		                                <div class="form-group row">
		                                    <label for="password" class="col-sm-3 col-form-label info-label">비밀번호</label>
		                                    <div class="col-sm-9">
		                                        <div class="input-group">
		                                            <input type="text" class="form-control form-control-lg" id="password" name="password" value="비밀번호를 변경하시려면 비밀번호 변경버튼을 누르세요." readonly>
		                                            <div class="input-group-append">
		                                                <button type="button" class="btn btn-warning" onclick="openPasswordModal()">비밀번호 변경</button>
		                                            </div>
		                                        </div>
		                                    </div>
		                                </div>
		                                <div class="form-group row">
		                                    <label for="addr" class="col-sm-3 col-form-label info-label">주소</label>
		                                    <div class="col-sm-9">
		                                        <input type="text" class="form-control form-control-lg" id="addr" name="addr" value="${user.addr}" required>
		                                    </div>
		                                </div>
		                                <div class="form-group row">
		                                    <label for="getAddr" class="col-sm-3 col-form-label info-label">상세주소</label>
		                                    <div class="col-sm-9">
		                                        <input type="text" class="form-control form-control-lg" id="getAddr" name="getAddr" value="${user.getAddr}" required>
		                                    </div>
		                                </div>
		                                <div class="form-group text-center mt-4">
		                                    <button type="submit" class="btn btn-primary btn-lg font-weight-medium auth-form-btn">정보 수정</button>
		                                    <a class="btn btn-secondary btn-lg font-weight-medium auth-form-btn" href="#" role="button">취소</a>
		                                </div>
		                                <div class="form-group text-center mt-4">
		                                    <button type="button" class="btn btn-danger btn-lg font-weight-medium auth-form-btn" onclick="openDeleteModal()">회원 탈퇴</button>
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
    <!-- 핸드폰 번호 변경 모달 창 -->
    <div id="phoneNumberModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="phoneNumberModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="phoneNumberModalLabel">핸드폰 번호 변경</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="newPhoneNumber">새 핸드폰 번호</label>
                        <input type="text" id="newPhoneNumber" class="form-control" placeholder="새 핸드폰 번호 입력">
                        <button type="button" class="btn btn-primary" onclick="sendVerificationCode()">인증번호 전송</button>
                    </div>
                    <div id="phoneNumMsg" class="text-danger"></div>
                    <div class="form-group">
                        <label for="verificationCode">인증번호</label>
                        <input type="text" id="verificationCode" class="form-control" placeholder="인증번호 입력">
                        <button type="button" class="btn btn-primary" onclick="verifyCode()">인증번호 확인</button>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 비밀번호 변경 모달 창 -->
    <div id="passwordModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="passwordModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="passwordModalLabel">비밀번호 변경</h4>
                </div>
                <div class="modal-body">
                    <form id="passwordForm">
                        <input type="hidden" name="userId" value="${user.userId}" />
                        <div class="form-group">
                            <label for="newPasswordModal">새 비밀번호</label>
                            <input type="password" id="newPasswordModal" name="newPassword" class="form-control" required />
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">새 비밀번호 확인</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required />
                        </div>
                        <div id="passwordCheckMsg" class="text-danger"></div>
                        <div id="passwordConfirmMsg" class="text-danger"></div>
                        <button type="button" class="btn btn-primary" onclick="checkPassword()">비밀번호 변경</button>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 회원 탈퇴 모달 창 -->
    <div id="deleteModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="deleteModalLabel">회원 탈퇴</h4>
                </div>
                <div class="modal-body">
                    <p>정말로 탈퇴하시겠습니까?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-danger" onclick="deleteUser()">탈퇴</button>
                </div>
            </div>
        </div>
    </div>

    <!-- container-scroller -->
    <!-- plugins:js -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="../../vendors/js/vendor.bundle.base.js"></script>
    <!-- endinject -->
    <!-- Plugin js for this page -->
    <!-- End plugin js for this page -->

    <!-- FOOTER -->
    <jsp:include page="/footer.jsp" />
    <!-- FOOTER -->

    <script type="text/javascript">
        function openPhoneNumberModal() {
            $('#phoneNumberModal').modal('show');
        }

        function sendVerificationCode() {
            var phoneNum = document.getElementById("newPhoneNumber").value;
            var phoneNumMsg = document.getElementById("phoneNumMsg");

            // 숫자만 입력되었는지 확인
            if (!/^\d+$/.test(phoneNum)) {
                phoneNumMsg.textContent = "숫자만 입력해주세요.";
                return;
            }

            // 번호가 010으로 시작하는지 확인
            if (!/^010/.test(phoneNum)) {
                phoneNumMsg.textContent = "휴대전화번호는 010으로 시작해야 합니다.";
                return;
            }

            // 번호가 11자리인지 확인
            if (phoneNum.length !== 11) {
                phoneNumMsg.textContent = "휴대전화번호는 11자리여야 합니다.";
                return;
            }

            phoneNumMsg.textContent = "";

            // 서버로 인증번호 전송 요청
            $.ajax({
                url: "/user/send-verification-code",
                type: "POST",
                data: { phoneNum: phoneNum },
                success: function(response) {
                    alert("인증번호가 전송되었습니다.");
                },
                error: function() {
                    alert("인증번호 전송에 실패했습니다.");
                }
            });
        }

        function verifyCode() {
            var phoneNum = document.getElementById("newPhoneNumber").value;
            var code = document.getElementById("verificationCode").value;
            // 서버로 인증번호 확인 요청
            $.ajax({
                url: "/user/verify-code-user",
                type: "POST",
                data: { phoneNum: phoneNum, code: code },
                success: function(response) {
                    if (response.valid) {
                        alert("인증 성공");
                        $('#phoneNumberModal').modal('hide');
                        // 새로운 핸드폰 번호를 폼에 반영
                        document.getElementById("phoneNum").value = phoneNum;
                    } else {
                        alert("인증 실패");
                    }
                },
                error: function() {
                    alert("인증 과정에서 오류가 발생했습니다.");
                }
            });
        }

        function openPasswordModal() {
            $('#passwordModal').modal('show');
        }

        function checkPassword() {
            var newPassword = document.getElementById("newPasswordModal").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            if (newPassword !== confirmPassword) {
                alert("비밀번호가 일치하지 않습니다. 다시 확인하세요.");
                return;
            }

            var userId = document.querySelector("input[name='userId']").value;

            $.ajax({
                url: "/user/updateAdmin",
                type: "POST",
                data: { userId: userId, newPassword: newPassword, confirmPassword: confirmPassword },
                success: function(response) {
                    alert("비밀번호가 성공적으로 변경되었습니다.");
                    $('#passwordModal').modal('hide');
                },
                error: function() {
                    alert("비밀번호 변경에 실패했습니다.");
                }
            });
        }

        function openDeleteModal() {
            $('#deleteModal').modal('show');
        }

        function deleteUser() {
            var userId = document.querySelector("input[name='userId']").value;
            
            $.ajax({
                url: "/user/userQuit",
                type: "POST",
                data: { userId: userId },
                success: function(response) {
                    alert("회원 탈퇴가 성공적으로 처리되었습니다.");
                    if (response.redirect) {
                        window.location.href = response.redirect;
                    }
                },
                error: function() {
                    alert("회원 탈퇴 처리에 실패했습니다.");
                }
            });
        }

        function submitForm() {
            var form = document.getElementById("updateForm");
            var userId = document.getElementById("userId").value;
            form.action = "/user/update?userId=" + userId;
            form.submit();
        }

        function debounce(func, wait) {
            let timeout;
            return function(...args) {
                clearTimeout(timeout);
                timeout = setTimeout(() => func.apply(this, args), wait);
            };
        }

        // 비밀번호 유효성 검사 및 일치 여부 확인
        $("#newPasswordModal").on("keyup", debounce(function() {
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
        $("#confirmPassword").on("keyup", debounce(function() {
            checkPasswordMatch();
        }, 300));

        function checkPasswordMatch() {
            var password = $("#newPasswordModal").val();
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
    </script>
</body>
</html>
