<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>회원 목록 조회</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>

    <!-- HEADER -->
    <jsp:include page="/header.jsp"/>
    <!-- HEADER -->

<div class = "main-panel">
	 <div class = "content-wrapper">
	    <div class="container">
	        <div class="page-header text-info">
	            <h3>회원목록조회</h3>
	        </div>
	
	        <!-- table 위쪽 검색 Start -->
	        <div class="row">
	            <div class="col-md-6 text-left">
	                <p class="text-primary">
	                    전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지
	                </p>
	            </div>
	            <div class="col-md-6 text-right">
	                <form class="form-inline" name="detailForm" style="float:right;">
	                    <div class="form-group">
	                        <select class="form-control" name="searchCondition">
	                            <option value="0" ${search.searchCondition == 0 ? "selected" : ""}>회원ID</option>
	                            <option value="1" ${search.searchCondition == 1 ? "selected" : ""}>회원명</option>
	                        </select>
	                    </div>
	                    <div class="form-group">
	                        <label class="sr-only" for="searchKeyword">검색어</label>
	                        <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="검색어" value="${search.searchKeyword}">
	                    </div>
	                    <button type="submit" class="btn btn-default">검색</button>
	                    <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}" />
	                </form>
	            </div>
	        </div>
	        <!-- table 위쪽 검색 End -->
	
	        <!-- table Start -->
	        <table class="table table-hover table-striped">
	            <thead>
	                <tr>
	                    <th align="center">No</th>
	                    <th align="left">회원 ID</th>
	                    <th align="left">회원명</th>
	                    <th align="left">닉네임</th>
	                    <th align="left">성별</th>
	                    <th align="left">핸드폰번호</th>
	                    <th align="left">이메일</th>
	                    <th align="left">현재 포인트</th>
	                    <th align="left">주소</th>
	                    <th align="left">상태</th>
	                </tr>
	            </thead>
	            <tbody>
	                <c:set var="i" value="0" />
	                <c:forEach var="user" items="${list}">
	                    <c:set var="i" value="${i + 1}" />
	                    <tr>
	                        <td align="center">${i}</td>
	                        <td align="left" title="Click : 회원정보 확인"><a href="#" onclick="fncGetUser('${user.userId}')">${user.userId}</a></td>
	                        <td align="left">${user.userName}</td>
	                        <td align="left">${user.nickname}</td>
	                        <td align="left">${user.gender}</td>
	                        <td align="left">${user.phoneNum}</td>
	                        <td align="left">${user.email}</td>
	                        <td align="left">${user.currentPoint}</td>
	                        <td align="left">${user.addr}</td>
	                        <td align="left">${user.role}</td>
	                    </tr>
	                </c:forEach>
	            </tbody>
	        </table>
	        <!-- table End -->
	
	        <!-- 페이지 네비게이션 Start -->
	        <nav aria-label="Page navigation">
	            <ul class="pagination justify-content-center">
	                <c:if test="${resultPage.currentPage > 1}">
	                    <li>
	                        <a href="#" onclick="fncGetList(${resultPage.currentPage - 1})" aria-label="Previous">
	                            <span aria-hidden="true">&laquo;</span>
	                        </a>
	                    </li>
	                </c:if>
	                <c:forEach begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" var="i">
	                    <c:choose>
	                        <c:when test="${i == resultPage.currentPage}">
	                            <li class="active"><a href="#">${i}</a></li>
	                        </c:when>
	                        <c:otherwise>
	                            <li><a href="#" onclick="fncGetList(${i})">${i}</a></li>
	                        </c:otherwise>
	                    </c:choose>
	                </c:forEach>
	                <c:if test="${resultPage.currentPage < resultPage.maxPage}">
	                    <li>
	                        <a href="#" onclick="fncGetList(${resultPage.currentPage + 1})" aria-label="Next">
	                            <span aria-hidden="true">&raquo;</span>
	                        </a>
	                    </li>
	                </c:if>
	            </ul>
	        </nav>
	        <!-- 페이지 네비게이션 End -->
	
	    </div>
   	</div>
  </div>
    <!-- FOOTER -->
    <jsp:include page="/footer.jsp" />
    <!-- FOOTER -->

    <script type="text/javascript">
        function fncGetList(currentPage) {
            document.getElementById('currentPage').value = currentPage;
            document.detailForm.submit();
        }
        
        function fncGetUser(userId) {
            window.location.href = "/user/getUser?userId=" + userId;
        }
    </script>
</body>
</html>
