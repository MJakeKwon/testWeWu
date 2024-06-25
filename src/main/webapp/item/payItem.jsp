<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">

	function fncAddPurchase(){
		var form = document.getElementById("detailForm")
		form.action="/item/addPurchase";
		form.submit();
	}
	
</script>

<meta charset="UTF-8">
<title>아이템 구매하기</title>


</head>


<body bgcolor="#ffffff" text="#000000">

<form name="detailForm" id="detailForm" method="post">
<input type="hidden" name="buyerNickname" value="nick1">
<input type="hidden" name="itemNo" value="${item.itemNo}">
${item }<br>
<h1>아이템 구매 View</h1>
	구매 아이템 : ${item.itemName }<br>
	
	가격 : ${item.itemPrice}<br>
	
	구매 수량 : <input type="text" name="itemCnt">
	
	<table border="0" cellspacing="0" cellpadding="0">
		<tr>					
			<td width="17" height="23">
			
			</td>
			<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
			<a href="javascript:fncAddPurchase();">구매하기</a>
			</td>
			<td width="17" height="23">
			
			</td>
			<td width="30"></td>					
			<td width="17" height="23">
			</td>
			<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
			<a href="#">장바구니 돌아가기</a>
			
			</td>
			<td width="14" height="23">
			
			</td>
		</tr>
	</table>

</form>

</body>

</html>
