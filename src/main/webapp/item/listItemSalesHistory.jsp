<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>판매내역 목록조회</title>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">

function fncListItesmSalesHistory(){
	
	$("form").attr("method" , "POST").attr("action" , "/item/getItemSalesHistoryList").submit(); //이거 controller에 있는 거랑은 좀 다르네...괜찮나..
}

	$(function() {
		 $( "button.btn-primary:contains('상세조회')" ).on("click" , function() {
			 //fncListRefundPoint();
			 var rslt = $("input[type='radio']:checked").val();
			 if(rslt == undefined)
			 {
			 	alert("상세조회할 판매 내역을 선택하세요.");
			 	return;
			 }else
			 {
				 //alert(rslt);
				 location.href="/item/getItemSalesHistory?itemPurchaseNo="+rslt;
			 }
			 
		});
	});	




</script>
</head>

<body>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		
			<form name="detailForm" id="detailForm" method="post">
			<input type="hidden" name="itemPurchaseNo" value="${item.itemPurchaseNo}">
			<input type="hidden" name="buyerNickname" value="${item.buyerNickname}">
		
		<div class="main-panel">
        	<div class="content-wrapper">
				<div class="main-panel">
	        		<div class="content-wrapper">
		        		 <div class="row">
		                    <div class="col-lg-12 grid-margin stretch-card">
		                        <div class="card">
		                            <div class="card-body">
		                                <h4 class="card-title">판매내역 목록조회</h4>
		                                <p class="card-description">
		                                   
		                                </p>
		                                <div class="table-responsive">
		                                    <table class="table">
		                                        <thead>
		                                            <tr>
		                                            	<th>판매날짜</th>
														<th>아이템명</th>
														<th>개수</th>
														<th>가격</th>
														<th> </th>
													</tr>
												</thead>
											<tbody>
												<c:set var="i" value="0" />
												<c:forEach var="itemPurchase" items="${list}"> <!-- 향상된 for문 돌릴 때 값을 저장하는 곳의 이름을 itemPurchase라고 한다는 의미. 따라서 refundCompdate, itemName도 저장된 곳의 이름인 itemPurchase. 으로 가져옴.   -->
													<tr>
												 	  <td>${itemPurchase.itemPurchaseDate}</td>
												 	  <td>${itemPurchase.itemName}</td>
												 	  <td>${itemPurchase.itemCnt}</td>
												 	  <td>${itemPurchase.itemPrice}</td>
												 	  <td>
												 	  	<div class="form-check">
								                          <label class="form-check-label text-muted">
								                            <input type="radio" class="form-check-input" name="pno" value="${itemPurchase.itemPurchaseNo}">
								                          </label>
								                        </div>
													  </td>
									         		</tr>
												</c:forEach>
												 
	                                        </tbody>
	                                    </table>
	                                </div>
	                                 <div class="text-right mt-4">
                                <button type="button" class="btn btn-primary" style="float: right; margin-left: 10px;">상세조회</button>
                                <!-- 
							    <div class="text-right mt-4">
	     		 						<button type="button" class="btn btn-primary">목록</button>
		 					   	</div>
		 					   	 -->
		 					   	
				            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>  	
    
    
    	    	<!-- FOOTER -->
		    <jsp:include page="/footer.jsp" />
		    <!-- FOOTER -->
	</body>
</html>
					
	

		 					   	
