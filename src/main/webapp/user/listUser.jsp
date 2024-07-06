<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>회원 목록 조회</title>
    <!-- HEADER -->
    <header>
        <jsp:include page="/header.jsp"/>
    </header>
    <!-- HEADER -->
    <link rel="shortcut icon" href="../../images/favicon.png" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0/css/bootstrap.min.css">
    <style>
        .jumbotron {
            position: relative;
            background-color: white; /* 배경 색깔 흰색으로 변경 */
            padding: 10rem 0rem 10rem 0;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: -9rem;
        }
        .jumbotron img {
            width: 100%;
        }
        .jumbotron-container {
            padding: 0;
            margin: 0;
            width: 100%;
        }
        .navbar {
            margin-bottom: 0;
        }
        .container {
            font-size: 1rem; /* 전체 글씨 크기 조정 */
        }
        .table {
            width: 100%;
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            margin-bottom: 20px; /* 테이블과 네비게이션 바 사이 여백 추가 */
        }
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
        .table th {
            background-color: #57b657;
            color: white;
        }
        .table tbody tr:nth-child(even) {
            background-color: #f2f2f2; /* 짝수 줄 회색빛 */
        }
        .btn {
            height: 35px;
            font-size: 0.9rem;
            border-radius: 0;
            background-color: #482adf;
            color: white;
        }
        h3 {
            font-size: 2rem; /* h3 글씨 크기 조정 */
            color: #57b657;
        }
        .page-header {
            margin: 20px 0;
        }
        .main-panel, .content-wrapper {
            margin: 0;
            padding-bottom: 0;
        }
        .content-wrapper {
            min-height: calc(100vh - 50px);
            padding-bottom: 0;
        }
        .footer {
            margin-top: 10px;
        }
        .pagination {
            margin-top: 20px; /* 페이지네비게이션과 테이블 사이의 여백 추가 */
        }
        .pagination > li > a, .pagination > li > span {
            background-color: white;
            color: #007bff;
            font-size: 1rem;
            padding: 10px 15px; /* 버튼 크기 조정 */
        }
        .pagination > .active > a, .pagination > .active > span, 
        .pagination > .active > a:hover, .pagination > .active > span:hover, 
        .pagination > .active > a:focus, .pagination > .active > span:focus {
            background-color: #0052ff;
            color: white;
            border-color: #003366;
            font-size: 1.2rem;
        }
        .table thead th, .jsgrid .jsgrid-table thead th {
            font-size: 0.9rem !important;
        }
        .table tr td, .jsgrid .jsgrid-table tr td {
            font-size: 0.8rem;
        }
        .search-form .form-group {
            display: flex;
            align-items: center;
        }
        .search-form .form-control {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }
        .search-form .btn {
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
        }
    </style>
</head>
<body>

    <script type="text/javascript">
        function fncGetList(currentPage) {
            document.getElementById('currentPage').value = currentPage;
            document.detailForm.submit();
        }
        
        function fncGetUser(userId) {
            window.location.href = "/user/getUser?userId=" + userId;
        }
    </script>
    
    <div class="jumbotron">
        <div class="container">
            <img src="/images/wewujumbo.jpg" alt="Background Image">
        </div>
    </div>
    <div class="main-panel">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-left">
                    <div class="page-header text-info">
                        <h3>회원목록조회</h3>
                        <p class="text-primary">
                            전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage == 0 ? 1 : resultPage.currentPage} 페이지
                        </p>
                    </div>
                </div>
                <div class="col-md-6 text-right">
                    <form class="form-inline search-form" name="detailForm" style="float:right; position: relative; top: 45px;">
                        <div class="form-group">
                            <select class="form-control" name="searchCondition" style="height: 35px; font-size: 0.9rem; color : #000000; bold">
                                <option value="0" ${search.searchCondition == 0 ? "selected" : ""}>회원ID</option>
                                <option value="1" ${search.searchCondition == 1 ? "selected" : ""}>회원명</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="sr-only" for="searchKeyword">검색어</label>
                            <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="${search.searchKeyword}" style="height: 35px; font-size: 0.9rem;">
                            <button type="submit" class="btn btn-primary" style="height: 35px; font-size: 0.9rem;">검색</button>
                        </div>
                        <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}" />
                    </form>
                </div>
                <div class="col-md-12 text-right">
                    <!-- table Start -->
                    <table class="table table-hover table-striped">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>회원 ID</th>
                                <th>회원명</th>
                                <th>닉네임</th>
                                <th>성별</th>
                                <th>핸드폰번호</th>
                                <th>이메일</th>
                                <th>현재 포인트</th>
                                <th>주소</th>
                                <th>상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="i" value="0" />
                            <c:forEach var="user" items="${list}">
                                <c:set var="i" value="${i + 1}" />
                                <tr>
                                    <td style="color: #007bff; bold;">${i}</td>
                                    <td title="Click : 회원정보 확인"><a href="#" onclick="fncGetUser('${user.userId}')">${user.userId}</a></td>
                                    <td>${user.userName}</td>
                                    <td>${user.nickname}</td>
                                    <td>${user.gender}</td>
                                    <td>${user.phoneNum}</td>
                                    <td>${user.email}</td>
                                    <td>${user.currentPoint}</td>
                                    <td>${user.addr}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.role == 1}">관리자</c:when>
                                            <c:when test="${user.role == 2}">사용자</c:when>
                                            <c:when test="${user.role == 3}">그룹장</c:when>
                                            <c:when test="${user.role == 4}">탈퇴</c:when>
                                            <c:when test="${user.role == 5}">정지</c:when>
                                            <c:otherwise>알 수 없음</c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty list}">
                                <tr>
                                    <td colspan="10">데이터가 없습니다.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                    <!-- table End -->
                </div>
            </div>

            <!-- 페이지 네비게이션 Start -->
            <nav aria-label="Page navigation" class="mt-3">
                <ul class="pagination justify-content-center">
                    <li class="page-item">
                        <a class="page-link" href="#" onclick="fncGetList(${resultPage.currentPage > 1 ? resultPage.currentPage - 1 : 1})" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <c:forEach begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" var="i">
                        <c:choose>
                            <c:when test="${i == resultPage.currentPage}">
                                <li class="page-item active"><a class="page-link" href="#">${i}</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link" href="#" onclick="fncGetList(${i})">${i}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <li class="page-item">
                        <a class="page-link" href="#" onclick="fncGetList(${resultPage.currentPage < resultPage.maxPage ? resultPage.currentPage + 1 : resultPage.maxPage})" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- 페이지 네비게이션 End -->
        </div>
    </div>

    <!-- FOOTER -->
    <div class="footer">
        <jsp:include page="/footer.jsp" />
    </div>
    <!-- FOOTER -->

</body>
</html>
