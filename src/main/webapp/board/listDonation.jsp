<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후원 내역 보기</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
$(function() {

	//검색 event연결 처리부분
	//dom object get 3가지 방법: $(tagName)/(#id)/$(.className)
	//$("tagName.className:filter함수")사용함
	$("button:contains('검색')").on("click", function() {
		//alter($("td.ct_btn01:contains('검색')").html());
		//fncGetUserList(1);
	});

	$("td:nth-child(2)").on(
			"click",
			function() {
				self.location = "/board/getDonation?payType=후원"
						+"&payNo="
						+ $($(this).children()).val();

			});

	$(".ct_list_pop:nth-child(4n-6)").css("background-color", "whitesmoke");

});
</script>

</head>
<body>
<input type="hidden" name="payType" value="${param.payType}" >
	<!-- HEADER -->
	<jsp:include page="/header.jsp"/>
	<!-- HEADER -->

	<div class="container-fluid page-body-wrapper">
		<jsp:include page="boardSideBar.jsp" />

		<div class="main-panel">
			<div class="col-12 grid-margin stretch-card">

				<div class="card">
					<div class="card-body">
						<h4 class="card-title">후원하기</h4>
						<div class="table-responsive">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>No</th>
										<th>이름</th>
										<th>이메일</th>
										<th>후원 날짜</th>
										<th>결제 수단</th>
										<th>금액</th>
									</tr>
								</thead>
								<tbody>
									<c:set var="i" value="0" />
									<c:forEach var="donation" items="${list}">
										<c:set var="i" value="${ i+1 }" />
										<tr>
											<td>${i}</td>
											<td>${donation.userName} <input type="hidden"
												value="${donation.payNo}">
											</td>
											<td>${donation.email}</td>
											<td>${donation.payDate}</td>
											<td>${donation.payOption}</td>
											<td>${donation.payAmount}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						
					</div>
				</div>

			</div>
		</div>
	</div>
	<!-- FOOTER -->
	<jsp:include page="/footer.jsp" />
	<!-- FOOTER -->
</body>
</html>