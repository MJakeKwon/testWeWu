<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
<!-- HEADER -->
<jsp:include page="/header.jsp"/>
<!-- HEADER --> 
<script>

	window.onload=function()
	{
		var flag = "${flag}";
		if (flag != "") {
	        if(flag == "Y"){
	        	alert("구매취소 완료");
	        }else{
	        	alert("구매취소 실패");
	        }
		}else {
			
	    }
	}
	
	function updatePurchase(itemPurchaseNo){
		
        if(!confirm("정말 구매를 취소하시겠습니까?")){
			return;
			
        }else{

        	//모임 리스트
			$.ajax ({
				url	: "/app/item/updatePurchase", // (Required) 요청이 전송될 URL 주소
				type  : "POST", // (default: ‘GET’) http 요청 방식
				async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
				cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
				timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
				data  : JSON.stringify(
				 			{itemPurchaseNo:itemPurchaseNo}
				 		), // 요청 시 전달할 데이터
				processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
				contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
				dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
				beforeSend  : function () {
				  // XHR Header 포함, HTTP Request 하기전에 호출
				  
				},
				success : function(data, status, xhr) {
					
					if(data.flag == "Y"){
						alert("취소가 완료되었습니다");
						location.reload();
					}else{
						alert("취소 실패");
					}
				},
				error	: function(xhr, status, error) {
				  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
				},
				complete : function(xhr, status) {
				  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
				}
			});
        }
	}
	/*
	function updatePurchase(itemPurchaseNo)
	{
		if (!confirm("정말 구매를 취소하시겠습니까?")) {
	        // 취소(아니오) 버튼 클릭 시 이벤트
	    	return;
		} else {
	    	location.href="/item/updatePurchase?itemPurchaseNo="+itemPurchaseNo;
	        // 확인(예) 버튼 클릭 시 이벤트
	    }
	}
	*/
	$(function() {
		 $( "button.btn-primary:contains('상세조회')" ).on("click" , function() {
			 //fncListRefundPoint();
			 var rslt = $("input[type='radio']:checked").val();
			 if(rslt == undefined)
			 {
			 	alert("상세조회할 구매 내역을 선택하세요.");
			 	return;
			 }else
			 {
				 //alert(rslt);
				 location.href="/item/getItemPurchaseHistory?itemPurchaseNo="+rslt;
			 }
			 
		});
		 
		 $( "button.btn-primary:contains('구매취소')" ).on("click" , function() {
			 //fncListRefundPoint();
			 var rslt = $("input[type='radio']:checked").val();
			 if(rslt == undefined)
			 {
			 	alert("취소할 구매 내역을 선택하세요.");
			 	return;
			 }else
			 {
				 updatePurchase(rslt);
				 //alert(rslt);
				
			 }
			 
		});
	});	
	
/*
	$(function() {
		 $( "button.btn-primary:contains('구매 취소')" ).on("click" , function() {
			location.href="/item/updatePurchase?itemPurchaseNo="+itemPurchaseNo;
		 });
	});
*/
	
	
	

</script>


<meta charset="UTF-8">
<title>구매내역 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

</head>

<body>
		
		<div class="main-panel">
        	<div class="content-wrapper">
				<div class="main-panel">
	        		<div class="content-wrapper">
		        		 <div class="row">
		                    <div class="col-lg-12 grid-margin stretch-card">
		                        <div class="card">
		                            <div class="card-body">
		                                <h4 class="card-title">구매내역 목록조회</h4>
		                                <p class="card-description">
		                                   
		                                </p>
		                                <div class="table-responsive">
		                                    <table class="table">
		                                        <thead>
		                                            <tr>
		                                            	<th>구매날짜</th>
														<th>아이템명</th>
														<th>개수</th>
														<th>가격</th>
														<th>구매상태</th>
														<th></th>
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
												 	  <th>${itemPurchase.refundFlag} </th>
												 	 
												 	  
												 	 
												 	  <!-- 
												 	  "미환불 : N
														환불성공 : Y
												 	   -->
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
                                <button type="button" class="btn btn-primary" style="float: right; margin-left: 10px;">구매취소</button>
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





<!-- 
	<c:set var="i" value="0" />
	<c:forEach var="itemPurchase" items="${list}"> 
	<tr>
		<a href="/item/getItemSalesHistory?itemPurchaseNo=${itemPurchase.itemPurchaseNo}">${itemPurchase.itemName}</a> ==== <a href="javascript:updatePurchase(${itemPurchase.itemPurchaseNo})">구매취소</a><br>
	</tr>
	</c:forEach>
 -->	
	
</body>
</html>