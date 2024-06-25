<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script>
	function deleteShoppingCartList(shoppingCartNo)
	{
		if (!confirm("정말 삭제하시겠습니까?")) {
	        // 취소(아니오) 버튼 클릭 시 이벤트
	    	return;
		} else {
	    	location.href="/item/deleteShoppingCartList?shoppingCartNo="+shoppingCartNo;
	        // 확인(예) 버튼 클릭 시 이벤트
	    }
	}
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>장바구니</h1>
<c:set var="i" value="0" />
	<c:forEach var="shoppingCart" items="${shoppingCart}"> <!-- 향상된 for문 돌릴 때 값을 저장하는 곳의 이름을 itemPurchase라고 한다는 의미. 따라서 refundCompdate, itemName도 저장된 곳의 이름인 itemPurchase. 으로 가져옴.   -->
		${shoppingCart.itemName}<a href="javascript:deleteShoppingCartList(12)">삭제하기</a><br>    <!-- 삭제되는지 테스트할 때 끝에 itemPurchaseNo 넣어서 해야 함. 지금 그렇게 만들어놔서.  -->
	</c:forEach>

</body>
</html>