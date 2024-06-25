<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 상세 보기</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("button.btn:contains('삭제')").on("click",function(){
			self.location="/board/deleteDonation?payType=${param.payType}&payNo=${param.payNo}"
		});
	});
	
	$(function(){
		$("button.btn:contains('목록 보기')").on("click", function() {
			self.location="/board/listDonation?payType=${param.payType}"
		});
		//footer고정
		$('footer').removeClass('fixed-bottom');

	});
	 
	
	
</script>

</head>
<body>
<input type="hidden" name="payType" value="${param.payType}" >
<input type="hidden" name="payNo" value="${param.payNo}" >	

	<!-- HEADER -->
	<jsp:include page="/header.jsp"/>
	<!-- HEADER -->

	<div class="container-fluid page-body-wrapper">
		<jsp:include page="boardSideBar.jsp" />


		<div class="main-panel">
				<div class="col-12 grid-margin stretch-card">
					<div class="card">
						<div class="card-body">
						<h1 class="card-title">후원 내역 상세</h1>
						<p class="card-description">
							WEWU 후원
						</p>

						<div class="form-group row">
							<label for="" class="col-sm-3 col-form-label"></label>
							<div class="col-sm-3">
								
							</div>
						</div>
						
						<div class="form-group row">
							<label for="userName" class="col-sm-3 col-form-label">이름</label>
							<div class="col-sm-3">
								${donation.userName}
							</div>
						</div>
						
						<div class="form-group row">
							<label for="email" class="col-sm-3 col-form-label">이메일</label>
							<div class="col-sm-3">
								${donation.email}
							</div>
						</div>
						
						<div class="form-group row">
							<label for="phoneNum" class="col-sm-3 col-form-label">전화번호</label>
							<div class="col-sm-3">
								${donation.phoneNum}
							</div>
						</div>
						
						<div class="form-group row">
							<label for="userBirth" class="col-sm-3 col-form-label">생년월일</label>
							<div class="col-sm-3">
								${donation.userBirth}
							</div>
						</div>
						
						<div class="form-group row">
							<label for="payDate" class="col-sm-3 col-form-label">결제 날짜</label>
							<div class="col-sm-3">
								${donation.payDate}
							</div>
						</div>
						
						<div class="form-group row">
							<label for="payOption" class="col-sm-3 col-form-label">결제 수단</label>
							<div class="col-sm-3">
								${donation.payOption}
							</div>
						</div>
						
						<div class="form-group row">
							<label for="payType" class="col-sm-3 col-form-label">결제 사용처</label>
							<div class="col-sm-3">
								${donation.payType}
							</div>
						</div>
						
						<div class="form-group row">
							<label for="payAmount" class="col-sm-3 col-form-label">결제 금액</label>
							<div class="col-sm-3">
								${donation.payAmount}
							</div>
						</div>

						

						<button type="button" class="btn btn-primary mr-2">삭제</button>
						<button class="btn btn-light" >목록&nbsp;보기</button>
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