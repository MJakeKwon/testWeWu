<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후원 등록</title>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<link rel="stylesheet" href="/css/datepicker.css">


</head>
<body>

<!-- HEADER -->
	<jsp:include page="/header.jsp" />
	<!-- HEADER -->
	
	
	
	<div class="container-fluid page-body-wrapper">
	<jsp:include page="boardSideBar.jsp"/>
	
	
	

	<div class="main-panel">
			<div class="col-md-12 grid-margin stretch-card">
				<div class="card">
					<div class="card-body">
						<h1 class="card-title">
							후원 하기
						</h1>

							<form method="post" action="/board/addDonation" encType="multipart/form-data" >
								<input type="hidden" name="payType" value="후원" >
								<input type="hidden" name="payNo" value="${param.payNo }">
								
									<div class="form-group row">
										<label for="title" class="col-sm-3 col-form-label">이름</label>
										<div class="col-sm-4">
											<input type="text" class="form-control" name="userName" >
										</div>
									</div>
									
									<div class="form-group row">
										<label class="col-sm-3 col-form-label">이메일</label>
										<div class="col-sm-4">
											<input type="text" class="form-control" name="email" >
										</div>
									</div>									
								
									<div class="form-group row">
										<label class="col-sm-3 col-form-label">전화번호</label>
										<div class="col-sm-4">
											<input type="text" class="form-control" name="phoneNum" >
										</div>
									</div>
									
									<div class="form-group row">
										<label class="col-sm-3 col-form-label">생년월일</label>
										<div class="col-sm-4">
										<input type = "text" class="form-control" id="userBirth">
										</div>
									</div>
									
									<script type="text/javascript">
										function handleSelectChange(selectElement) {
										    var inputBox = document.getElementById("customInputBox");
										    if (selectElement.value === "직접입력") {
										        inputBox.style.display = "block";
										    } else {
										        inputBox.style.display = "none";
										    }
										}
										$(function(){
											$("button.btn:contains('취소')").on("click", function() {
												self.location="/board/listBoard?boardType=4"
											});
									
										});
										 $(function(){
												$("#userBirth").datepicker({
													dateFormat: "yy-mm-dd"
												});
												
											});
									</script>
									
									<div class="form-group row">
										<label class="col-sm-3 col-form-label">결제수단</label>
										<div class="col-sm-3">
											<div class="form-check">
												<label class="form-check-label">
												<input type="radio" class="form-check-input" name="payOption"
													id="payOption" value="1" checked=""> 카카오 페이 
												<i class="input-helper"></i></label>
											</div>
										</div>
											<div class="col-sm-5">
												<div class="form-check">
													<label class="form-check-label"> <input type="radio"
														class="form-check-input" name="payOption"
														id="payOption" value="2"> 토스 페이
														<i class="input-helper"></i></label>
												</div>
											</div>	
										</div>
										
									<div class="form-group row">
										<label class="col-sm-3 col-form-label">결제 금액</label>
									<div class="col-sm-4">
										<select id="questionCategory" name="questionCategory" class="form-control">
											<option value="10000" selected>10000</option>
											<option value="20000">20000</option>
											<option value="30000">30000</option>
											<option value="50000">50000</option>
											<option value="100000">100000</option>
											<option value="직접입력">직접 입력</option>
										</select>
									</div>
									</div>
		
							
							<div id="customInputBox" style="display:none;">
            					<label for="customInput">Enter your custom value:</label>
            					<input type="text" id="customInput" name="customInput"/>
        					</div>
									
									
							<button type="submit" class="btn btn-primary mr-2">결제하기</button>		
									
				
							</form>
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