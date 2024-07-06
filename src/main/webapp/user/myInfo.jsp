<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Info</title>
     <header>
        <jsp:include page="/header.jsp"/>
    </header>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    
    <style>
    	 .jumbotron {
            position: relative;
            background-color: white; /* 배경 색깔 흰색으로 변경 */
            padding: 10rem 0rem 11rem 0px;
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
            display: inline-block;
            color: white;
        }
        .member-info-title {
            color: #3b5cff;
            font-weight: bold;
            text-align: center;
            font-size: 30px;
        }
        .info-label{
        	color: #187fff;
       	 	font-weight: bold;
           	text-align: center;
            font-size: 30px;
        }
    </style>
    
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=YOUR_CLIENT_ID&submodules=geocoder"></script>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="../../vendors/js/vendor.bundle.base.js"></script>
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
                <div class="container-fluid page-body-wrapper full-page-wrapper">
                    <div class="content-wrapper d-flex align-items-center auth px-0">
                        <div class="row w-100 mx-0">
                            <div class="col-lg-8 mx-auto">
                                <div class="auth-form-light text-left py-5 px-4 px-sm-5">
									<h6 class="text-center mb-4 member-info-title">회원 정보</h6>
                                    <div class="pt-3 form-horizontal">
                                        <input type="hidden" name="userId" value="${viewedUser.userId}">
                                        <div class="form-group row">
                                            <label for="userName" class="col-sm-3 col-form-label info-label">이름</label>
                                            <div class="col-sm-9">
                                                <div class="info-value">${viewedUser.userName}</div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="nickname" class="col-sm-3 col-form-label info-label">닉네임</label>
                                            <div class="col-sm-9">
                                                <div class="info-value">${viewedUser.nickname}</div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="email" class="col-sm-3 col-form-label info-label">이메일</label>
                                            <div class="col-sm-9">
                                                <div class="info-value">${viewedUser.email}</div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="phoneNum" class="col-sm-3 col-form-label info-label">휴대전화번호</label>
                                            <div class="col-sm-9">
                                                <div class="info-value">${viewedUser.phoneNum}</div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="addr" class="col-sm-3 col-form-label info-label">주소</label>
                                            <div class="col-sm-9">
                                                <div class="info-value">${viewedUser.addr}</div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="getAddr" class="col-sm-3 col-form-label info-label">상세주소</label>
                                            <div class="col-sm-9">
                                                <div class="info-value">${viewedUser.getAddr}</div>
                                            </div>
                                        </div>

                                        <c:choose>
                                            <c:when test="${sessionScope.isAdmin}">
                                                <form action="/user/checkPassword" method="post">
                                                    <input type="hidden" name="userId" value="${viewedUser.userId}">
                                                    <div class="form-group text-center">
                                                        <input type="submit" value="수정 페이지로 이동" class="btn btn-primary btn-block">
                                                        <a class="btn btn-secondary btn-block" href="/user/listUser" role="button">취소</a>
                                                    </div>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="form-group text-center password-section">
                                                    <form action="/user/checkPassword" method="post">
                                                        <input type="hidden" name="userId" value="${viewedUser.userId}">
                                                        <label for="password" class="info-label">비밀번호:</label>
                                                        <input type="password" id="password" name="password" class="form-control password-input d-inline-block" required>
                                                        <div class="mt-3">
                                                            <input type="submit" value="수정 페이지로 이동" class="btn btn-primary btn-block">
                                                            <a class="btn btn-secondary btn-block" href="../index.jsp" role="button">취소</a>
                                                        </div>
                                                    </form>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <c:choose>
                                            <c:when test="${sessionScope.user.role == '1'}">
                                                <!-- 관리자만 볼 수 있는 버튼 -->
                                                <c:choose>
                                                    <c:when test="${viewedUser.role == '2'}">
                                                        <form action="/user/updateRole" method="post">
                                                            <input type="hidden" name="userId" value="${viewedUser.userId}">
                                                            <div class="form-group text-center">
                                                                <input type="submit" value="사용정지" class="btn btn-danger btn-block">
                                                            </div>
                                                        </form>
                                                    </c:when>
                                                    <c:when test="${viewedUser.role == '5'}">
                                                        <form action="/user/updateRole" method="post">
                                                            <input type="hidden" name="userId" value="${viewedUser.userId}">
                                                            <div class="form-group text-center">
                                                                <input type="submit" value="정지해제" class="btn btn-success btn-block">
                                                            </div>
                                                        </form>
                                                    </c:when>
                                                    <c:when test="${viewedUser.role == '4'}">
                                                        <form action="/user/updateRole" method="post">
                                                            <input type="hidden" name="userId" value="${viewedUser.userId}">
                                                            <div class="form-group text-center">
                                                                <input type="submit" value="계정복구" class="btn btn-success btn-block">
                                                            </div>
                                                        </form>
                                                    </c:when>
                                                </c:choose>
                                            </c:when>
                                        </c:choose>
                                        
                                    </div>
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
    <!-- endinject -->
    <!-- Plugin js for this page -->
    <!-- End plugin js for this page -->

    <!-- FOOTER -->
    <jsp:include page="/footer.jsp" />
    <!-- FOOTER -->

</body>
</html>
