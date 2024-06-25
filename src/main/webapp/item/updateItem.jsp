<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>아이템 판매 수정</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">
function fncUpdateItem() {
    $("form").attr("method", "POST").attr("action", "/item/updateItem").submit();
}

$(function() {
    $("td.ct_btn01:contains('수정')").on("click", function() {
        fncUpdateItem();
    });
});

$(function() {
    $("td.ct_btn01:contains('목록')").on("click", function() {
        location.href = "/item/getItemList";
    });
});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">
    <!-- HEADER -->
    <jsp:include page="/header.jsp" />
    <!-- HEADER -->

    <div class="main-panel">
        <div class="content-wrapper">
            <div class="col-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title" style="font-size: 22px;">판매 아이템 수정</h4>
                        <p class="card-description">
					                       
					    </p>
                        <form class="forms-sample" name="detailForm" method="post">
                            <input type="hidden" name="itemNo" value="${item.itemNo}">
                            <div class="form-group">
                                <label for="itemName">아이템명</label>
                                <input type="text" name="itemName" class="form-control" id="itemName" value="${item.itemName}" maxLength="20">
                            </div>
                            <div class="form-group">
                                <label for="itemPrice">가격</label>
                                <input type="text" name="itemPrice" class="form-control" id="itemPrice" value="${item.itemPrice}" maxLength="10">
                            </div>
                            <div class="form-group">
                                <label for="itemCategory">아이템 카테고리</label>
                                <input type="text" name="itemCategory" class="form-control" id="itemCategory" value="${item.itemCategory}">
                            </div>
                            <div class="form-group">
                                <label for="itemEffect">아이템 효과</label>
                                <input type="text" name="itemEffect" class="form-control" id="itemEffect" value="${item.itemEffect}" maxLength="70">
                            </div>
                            <div class="form-group">
                                <label>아이템 이미지</label>
                                <input type="file" name="file" class="file-upload-default">
                                <div class="input-group col-xs-12">
                                    <input type="text" class="form-control file-upload-info" disabled placeholder="이미지 파일 첨부">
                                    <span class="input-group-append">
                                        <button class="file-upload-browse btn btn-primary" type="button">파일 업로드</button>
                                    </span>
                                </div>
                            </div>
                            <%-- 
                            <button type="button" class="btn btn-primary mr-2">수정</button>
                            <button type="button" class="btn btn-light">목록</button>
                        	--%>
                        	
                        				
							<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
								<tr>
									<td width="53%"></td>
									<td align="right">
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>					
												<td width="17" height="23">
												
												</td>
												<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
												<button type="button" class="btn btn-primary">수정</button>
												</td>
												<td width="17" height="23">
												
												</td>
												<td width="30"></td>					
												<td width="17" height="23">
												</td>
												<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
												<button type="button" class="btn btn-primary">목록</button>
												</td>
												<td width="14" height="23">
												
												</td>
                   							</tr>
									</table>
								</td>
							</tr>
						</table>
                        	
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


<%-- 
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>아이템 판매 수정</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">

function fncUpdateItem(){
		
	$("form").attr("method" , "POST").attr("action" , "/item/updateItem").submit();
}

	$(function() {
		 $( "td.ct_btn01:contains('수정')" ).on("click" , function() {
			fncUpdateItem();
		});
	});	

	 $(function() {
			 $( "td.ct_btn0    1:contains('목록')" ).on("click" , function() {
				location.href="/item/getItemList"
		});
	});
	


	</script>
	</head>
	
	<body bgcolor="#ffffff" text="#000000">
				<!-- HEADER -->
				<jsp:include page="/header.jsp"/>
				<!-- HEADER -->
					
				<div class="main-panel">
		       		<div class="content-wrapper">
	
	<form name="detailForm" method="post" > 
	
	<input type="hidden" name="itemNo" value="${item.itemNo}">
	
	<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="15" height="37">
				<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
			</td>
			<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="93%" class="ct_ttl01">아이템 판매 수정</td>
						<td width="20%" align="right">&nbsp;</td>
					</tr>
				</table>
			</td>
			<td width="12" height="37">
				<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
			</td>
		</tr>
	</table>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">
				아이템명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="105">
							<input 	type="text" name="itemName" class="ct_input_g" 
											style="width: 100px; height: 19px" maxLength="20" value="${item.itemName}">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">
				가격 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">
				<input type="text" name="itemPrice" value="${item.itemPrice}" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="10"	minLength="6">
			</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">
				아이템 효과< <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">
				<input type="text" name="itemEffect" value="${item.itemEffect}"
							class="ct_input_g" style="width: 100px; height: 19px" maxLength="70" minLength="6"/>
			</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
	
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
		<tr>
			<td width="53%"></td>
			<td align="right">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
						<!--  	<a href="javascript:fncAddProduct();">수정</a>-->
						수정
						</td>
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
						</td>
						<td width="30"></td>
						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<!--  	<a href="javascript:history.go(-1)">취소</a> -->
						목록
						</td>
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	</form>

</body>
</html>
--%>