<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<title>아이템 판매 등록</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<!-- HEADER -->
	<jsp:include page="/header.jsp"/>
	<!-- HEADER -->
	

	<script type="text/javascript">
	
	function fncAddItem(){
		
	 	var itemName = $("input[name='itemName']").val();
		var itemPrice = $("input[name='itemPrice']").val();
		var itemRegdate = $("input[name='itemRegdate']").val();
		var itemEffect = $("input[name='itemEffect']").val();
		var itemImg = $("input[name='itemImg']").val();
		
		$("form").attr("method" , "POST").attr("action" , "/item/addItem").submit();
		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
	}
		
	$(function() {
		 $( "td.ct_btn01:contains('등록')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('등록')" ).html() );
			fncAddItem();
		});
	});	

	$(function() {
		 $( "td.ct_btn01:contains('목록')" ).on("click" , function() {
			//history.go(-1);	
			location.href="/item/getItemList"
		 });
	});	
	</script>
	</head>
	<body bgcolor="#ffffff" text="#000000">
				
					
				<div class="main-panel">
		       		<div class="content-wrapper">
		       		
			       		 <div class="col-12 grid-margin stretch-card">
			              <div class="card">
			                <div class="card-body">
						
					     <h4 class="card-title" style="font-size: 22px;">판매 아이템 등록</h4>
					                  <p class="card-description">
					                       
					                  </p>
					                  <form class="forms-sample" encType="multipart/form-data">
					                    <div class="form-group">
					                      <label for="exampleitemName">아이템명</label>
					                      <input type="text" name="itemName" class="form-control" id="itemName">
					                    </div>
					                    <div class="form-group">
					                      <label for="exampleInputitemPrice">가격</label>
					                      <input type="text" name="itemPrice" class="form-control" id="itemPrice">
					                    </div>
					                    <div class="form-group">
					                      <label for="exampleInputitemCategory">아이템 카테고리</label>
					                      <input type="text" name="itemCategory" class="form-control" id="itemCategory">
					                    </div>
					                    <div class="form-group">
					                      <label for="exampleSelectGender">아이템 효과</label>
					                      <input type="text" name="itemEffect" class="form-control" id="itemEffect">
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
					                    
					                    <script type="text/javascript">
					                    
					                    	$('.file-upload-browse').on('click', function() {
					                    		
					                    		$('.file-upload-default').click();
					                    		
					                    	});
					                    
					                    </script>
					                  
									
								
								<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
									<tr>
										<td width="53%"></td>
										<td align="right">
											<table border="0" cellspacing="0" cellpadding="0">
												<tr>					
													<td width="17" height="23">
													
													</td>
													<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
													<button type="button" class="btn btn-primary">등록</button>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<title>아이템 판매 등록</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">


	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

	<script type="text/javascript">
	
	function fncAddItem(){
		
	 	var itemName = $("input[name='itemName']").val();
		var itemPrice = $("input[name='itemPrice']").val();
		var itemRegdate = $("input[name='itemRegdate']").val();
		var itemEffect = $("input[name='itemEffect']").val();
		var itemImg = $("input[name='itemImg']").val();
		
		$("form").attr("method" , "POST").attr("action" , "/item/addItem").submit();
		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
	}
		
	$(function() {
		 $( "td.ct_btn01:contains('등록')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('등록')" ).html() );
			fncAddItem();
		});
	});	

	$(function() {
		 $( "td.ct_btn01:contains('목록')" ).on("click" , function() {
			//history.go(-1);	
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
					
				 <form name="detailForm">
					
					<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="15" height="37">
							
							</td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="93%" class="ct_ttl01">아이템 판매 등록</td>
										<td width="20%" align="right">&nbsp;</td>
									</tr>
								</table>
							</td>
							<td width="12" height="37">
							
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
								<table width="100%" border=" 0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="105">
											<input type="text" name="itemName" class="ct_input_g" 
														style="width: 100px; height: 19px" maxLength="20">
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
								가격 <img  src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td bgcolor="D6D6D6" width="1"></td>
							<td class="ct_write01">
								<input type="text" name="itemPrice" class="ct_input_g" 
											style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
							</td>
						</tr>
						
						<tr>
							<td height="1" colspan="3" bgcolor="D6D6D6"></td>
						</tr>
					
						<tr>
							<td width="104" class="ct_write">
								아이템 카테고리 <img  src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td bgcolor="D6D6D6" width="1"></td>
							<td class="ct_write01">
								<input type="text" name="itemCategory" class="ct_input_g" 
											style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
							</td>
						</tr>
						
						<tr>
							<td height="1" colspan="3" bgcolor="D6D6D6"></td>
						</tr>
						
						
						<tr>
							<td width="104" class="ct_write">
								아이템 효과<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
							</td>
							<td bgcolor="D6D6D6" width="1"></td>
							<td class="ct_write01">
									<input type="text" name="itemEffect" 	class="ct_input_g" 
											style="width: 150px; height: 19px" maxLength="70" minLength="6"/>
							</td>
						</tr>
					
						<tr>
							<td height="1" colspan="3" bgcolor="D6D6D6"></td>
						</tr>
						
						
						<tr>
							<td height="1" colspan="3" bgcolor="D6D6D6"></td>
						</tr>
						
					</table>
							
					
					<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
						<tr>
							<td width="53%"></td>
							<td align="right">
								<table border="0" cellspacing="0" cellpadding="0">
									<tr>					
										<td width="17" height="23">
										
										</td>
										<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
										<button type="button" class="btn btn-primary">등록</button>
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
					
					     <h4 class="card-title">Basic form elements</h4>
                  <p class="card-description">
                    Basic form elements
                  </p>
                  <form class="forms-sample">
                    <div class="form-group">
                      <label for="exampleInputName1">Name</label>
                      <input type="text" class="form-control" id="exampleInputName1" placeholder="Name">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputEmail3">Email address</label>
                      <input type="email" class="form-control" id="exampleInputEmail3" placeholder="Email">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputPassword4">Password</label>
                      <input type="password" class="form-control" id="exampleInputPassword4" placeholder="Password">
                    </div>
                    <div class="form-group">
                      <label for="exampleSelectGender">Gender</label>
                        <select class="form-control" id="exampleSelectGender">
                          <option>Male</option>
                          <option>Female</option>
                        </select>
                      </div>
                    <div class="form-group">
                      <label>File upload</label>
                      <input type="file" name="img[]" class="file-upload-default">
                      <div class="input-group col-xs-12">
                        <input type="text" class="form-control file-upload-info" disabled placeholder="Upload Image">
                        <span class="input-group-append">
                          <button class="file-upload-browse btn btn-primary" type="button">Upload</button>
                        </span>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="exampleInputCity1">City</label>
                      <input type="text" class="form-control" id="exampleInputCity1" placeholder="Location">
                    </div>
                    <div class="form-group">
                      <label for="exampleTextarea1">Textarea</label>
                      <textarea class="form-control" id="exampleTextarea1" rows="4"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary mr-2">Submit</button>
                    <button class="btn btn-light">Cancel</button>
                  </form>
					
					
					</form>
			
				
				</div>
	        </div>
	        
			<!-- FOOTER -->
		    <jsp:include page="/footer.jsp" />
		    <!-- FOOTER -->
		</body>
	</html>
--%>