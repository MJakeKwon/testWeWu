<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<style>
		.card-body {
	      height: 550px; /* 고정 높이 */
	    }
		</style>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		<script>
			$(function() 
			{
				$( ".btn:contains('개설모임')" ).on("click" , function() 
			 	{
					// 내 모임 신청정보
					sendAjaxRequest("/app/group/getGroupList", "My", "nick1", "getMyGroupList");
				}); 
				$( ".btn:contains('가입모임')" ).on("click" , function() 
			 	{
					// 내 모임 가입신청 정보
		            sendAjaxRequest("/app/group/getApplJoinList", "user", "nick2", "getApplJoinList");
				}); 
				$( ".btn:contains('대기신청서')" ).on("click" , function() 
			 	{
					// 모든 모임 신청정보(개설대기)
		            sendAjaxRequest("/app/group/getGroupList", "E", "", "getGroupListWait");
					
				}); 
				
				$( ".btn:contains('승인신청서')" ).on("click" , function() 
			 	{
					// 모든 모임 신청정보(개설승인)
		            sendAjaxRequest("/app/group/getGroupList", "T", "", "getGroupListTrue");
					
				}); 
				
				$( ".btn:contains('거부신청서')" ).on("click" , function() 
			 	{
					// 모든 모임 신청정보(개설거부)
		            sendAjaxRequest("/app/group/getGroupList", "F", "", "getGroupListNone");
					
				}); 
				
				$(document).ready(function() {
				    $(document).on('mouseenter', '.groupNo', function() {
				        $(this).css('cursor', 'pointer');
				    });
				});
				
				$(document).on('click', '.groupNo', function() {
					var id = $(this).attr("id");
					$("#MyForm").append("<input type=hidden name=groupNo value="+id+">");
					$("#MyForm").attr("method" , "POST").attr("action" , "/group/getGroup").submit();
				});
				
				function sendAjaxRequest(url, searchCondition, searchKeyword, targetElementId) {
	                $.ajax({
	                    url: url,
	                    type: "POST",
	                    async: true,
	                    cache: true,
	                    timeout: 3000,
	                    data: JSON.stringify({
	                        searchCondition: searchCondition,
	                        searchKeyword: searchKeyword
	                    }),
	                    processData: true,
	                    contentType: "application/json",
	                    dataType: "json",
	                    beforeSend: function() {
	                        // AJAX 요청 전에 실행되는 함수
	                    },
	                    success: function(data, status, xhr) {
	                        // AJAX 요청 성공 시 실행되는 함수
	                        var str = "";
	                        if(targetElementId == "getMyGroupList"){
	                        	str = 	"<thead>" +
	                        				"<tr>" +
	                        					"<th>모임명</th>" +
	                        					"<th>모임등급</th>" +
	                        					"<th>개설/신청일</th>" +
	                        					"<th>개설상태</th>" +
	                        				"<tr>" +
	                        			"</thead>";
	                        }else
	                        if(targetElementId == "getApplJoinList"){
	                        	str = 	"<thead>" +
				               				"<tr>" +
				               					"<th>모임명</th>" +
				               					"<th>모임등급</th>" +
				               					"<th>가입/신청일</th>" +
				               					"<th>가입상태</th>" +
				               				"<tr>" +
				               			"</thead>";
	                        }else
	                        if(targetElementId == "getGroupListWait"){
	                        	str = 	"<thead>" +
				               				"<tr>" +
				               					"<th>모임명</th>" +
				               					"<th>신청자</th>" +
				               					"<th>신청일</th>" +
				               					"<th>상태</th>" +
				               				"<tr>" +
				               			"</thead>";
	                        }else
	                        if(targetElementId == "getGroupListTrue"){
	                        	str = 	"<thead>" +
				               				"<tr>" +
					               				"<th>모임명</th>" +
				               					"<th>신청자</th>" +
				               					"<th>개설일</th>" +
				               					"<th>상태</th>" +
				               				"<tr>" +
				               			"</thead>";
	                        }else
	                        if(targetElementId == "getGroupListNone"){
	                        	str = 	"<thead>" +
				               				"<tr>" +
					               				"<th>모임명</th>" +
				               					"<th>신청자</th>" +
				               					"<th>거부일</th>" +
				               					"<th>상태</th>" +
				               				"<tr>" +
				               			"</thead>";
	                        }
	                        
	                        	
                        	if(data.length != 0){
                        		for (var i = 0; i < data.length; i++) {
                        			if(targetElementId == "getGroupList"){
		                        		str +=  "<tr>" +
			    					            "  <td><a class=groupNo id=" + data[i].groupNo + ">"+ data[i].groupName +"</a></td>" +
			    					            "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>" +
			    					            "  <td>"+ data[i].groupPers +"</td>" +
			    					            "</tr>";
		                        	}else
		                        	if(targetElementId == "getGroupRankingList"){
		                        		str +=  "<tr>" +
									            "  <td>"+ data[i].groupName +"</td>" +
									            "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>" +
									            "  <td>"+ data[i].groupPers +"</td>" +
									            "</tr>";
		                        	}else
		                        	if(targetElementId == "getMyGroupList"){
		                        		str +=  "<tr>" +
									            "  <td>"+ data[i].groupName +"</td>" +
									            "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>" +
									            "  <td>"+ data[i].openDate +"</td>" +
									            "  <td>"+ data[i].groupRslt +"</td>" +
									            "</tr>";
		                        		targetElementId = "MyInfo";        
		                        	}else
		                        	if(targetElementId == "getApplJoinList"){
		                        		str +=  "<tr>" +
									            "  <td>"+ data[i].groupName +"</td>" +
									            "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>" +
									            "  <td>"+ data[i].groupPers +"</td>" +
									            "  <td>"+ data[i].groupRslt +"</td>" +
									            "</tr>";
		                        		targetElementId = "MyInfo";        
		                        	}else
		                        	if(targetElementId == "getGroupListWait"){
		                        		str +=  "<tr>" +
									            "  <td>"+ data[i].groupName +"</td>" +
									            "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>" +
									            "  <td>"+ data[i].groupPers +"</td>" +
									            "  <td>"+ data[i].groupRslt +"</td>" +
									            "</tr>";
		                        		targetElementId = "MyInfo";       
		                        	}else
		                        	if(targetElementId == "getGroupListTrue"){
		                        		str +=  "<tr>" +
									            "  <td>"+ data[i].groupName +"</td>" +
									            "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>" +
									            "  <td>"+ data[i].groupPers +"</td>" +
									            "  <td>"+ data[i].groupRslt +"</td>" +
									            "</tr>";
		                        		targetElementId = "MyInfo";
		                        	}else
		                        	if(targetElementId == "getGroupListNone"){
		                        		str +=  "<tr>" +
									            "  <td>"+ data[i].groupName +"</td>" +
									            "  <td class=font-weight-bold>"+ data[i].groupLevel +"</td>" +
									            "  <td>"+ data[i].groupPers +"</td>" +
									            "  <td>"+ data[i].groupRslt +"</td>" +
									            "</tr>";
		                        		targetElementId = "MyInfo";
		                        	}
                        		}
                        	}else{
                        		if(targetElementId == "getGroupList"){
	                        		str +=  "<tr>" +
		    					            "  <td>데이터가 없습니다.</td>" +
		    					            "</tr>";
	                        	}else
	                        	if(targetElementId == "getGroupRankingList"){
	                        		str +=  "<tr>" +
		    					            "  <td>데이터가 없습니다.</td>" +
		    					            "</tr>";
	                        	}else
	                        	if(targetElementId == "getMyGroupList"){
	                        		str +=  "데이터가 없습니다";
	                        		targetElementId = "MyInfo";        
	                        	}else
	                        	if(targetElementId == "getApplJoinList"){
	                        		str +=  "데이터가 없습니다";
                       				targetElementId = "MyInfo";       
	                        	}else
	                        	if(targetElementId == "getGroupListWait"){
	                        		str +=  "데이터가 없습니다";
	                        		targetElementId = "MyInfo";       
	                        	}else
	                        	if(targetElementId == "getGroupListTrue"){
	                        		str +=  "데이터가 없습니다";
	                        		targetElementId = "MyInfo";
	                        	}else
	                        	if(targetElementId == "getGroupListNone"){
	                        		str +=  "데이터가 없습니다";
	                        		targetElementId = "MyInfo";
	                        	}
                        	}
                        	
	                        $('#' + targetElementId).html(str);
	                    },
	                    error: function(xhr, status, error) {
	                        // AJAX 요청 실패 시 실행되는 함수
	                    },
	                    complete: function(xhr, status) {
	                        // AJAX 요청 완료 후 실행되는 함수
	                    }
	                });
	            }
				
				window.onload = function() {
		            // 페이지 로드 시 실행되는 함수
		
		            // AJAX 요청 함수
		            
		
		            // 모임 리스트
		            sendAjaxRequest("/app/group/getGroupList", "T", "", "getGroupList");
		
		            // 모임 랭킹 리스트
		            sendAjaxRequest("/app/group/getGroupRankingList", "Ranking", "", "getGroupRankingList");
		
		            // 내 모임 신청정보
		            sendAjaxRequest("/app/group/getGroupList", "My", "nick1", "getMyGroupList");
		
		         	// 모든 모임 신청정보(개설대기)(관리자만)
		            sendAjaxRequest("/app/group/getGroupList", "E", "", "getGroupListWait");
		
		        }
				
			});
	        
	    </script>
		<meta charset="UTF-8">
	<title>Insert title here</title>
	</head>
	<body>
		<!-- Main Content -->
		<div class="main-panel">
        	<div class="content-wrapper">
				<div class="container my-4">
					<div class="row">
						<!-- 왼쪽 1번  -->
						<div class="col-md-5 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
									<h4 class="card-title">모임목록</h4>
					                <div class="form-group">
										<div class="input-group">
					                    	<input type="text" class="form-control" placeholder="모임명" aria-label="모임명">
						                    <div class="input-group-append">
						                    	<button class="btn btn-sm btn-primary" type="button">Search</button>
						                    </div>
										</div>
					                </div>
									<div class="list-wrapper pt-2">
										<table class="table table-striped todo-list todo-list-custom table-hover">
											<thead id="getGroupList">
												<tr>
													<th>모임명</th>
													<th>모임등급</th>
													<th>인원수</th>
										        </tr>  
									        </thead>
									        <tbody>
									           
											</tbody>
									    </table>
									</div>
								</div>
							</div>
						</div>
						<!-- 왼쪽 1번  -->
						
						<!-- 오른쪽 1번  -->
					    <div class="col-md-7 grid-margin stretch-card">
							<div class="card">
							    <div class="card-body fixed-card-body">
									<p class="card-title">지도</p>
									<div class="pt-4">
								        <div id="map">
				        <div class="search" style="">
				        	<select id="condition" >
				        		<option value="map" >지도</option>
				        		<option value="active" >활동</option>
				        	</select>
				            <input id="address" type="text" placeholder="검색할 주소" value="강남" />
				            <input id="submit" type="button" value="주소 검색" />
				        </div>
				    </div>
									</div>
								</div>
							</div>
					    </div>
					    <!-- 오른쪽 1번  -->
					    
					    <!-- 왼쪽 2번  -->
					    <div class="col-md-5 grid-margin stretch-card">
							<div class="card">
								<div class="card-body">
									<h4 class="card-title">모임랭킹</h4>
					                <div class="form-group">
										<div class="btn-group" role="group" aria-label="Basic example">
				                        <button type="button" class="btn btn-outline-secondary">1</button>
				                        <button type="button" class="btn btn-outline-secondary">2</button>
				                        <button type="button" class="btn btn-outline-secondary">3</button>
				                        </div>
					                </div>
									<div class="list-wrapper pt-2">
										<table class="table table-striped table-borderless todo-list todo-list-custom">
											<thead>
												<tr>
													<th>모임명</th>
													<th>모임등급</th>
													<th>인원수</th>
										        </tr>  
									        </thead>
									        <tbody id="getGroupRankingList">
									          
											</tbody>
									    </table>
									</div>
								</div>
							</div>
						</div>
						<!-- 왼쪽 2번  -->
						
						<!-- 오른쪽 2번  -->
					    <div class="col-md-7 grid-margin stretch-card">
							<div class="card">
							    <div class="card-body fixed-card-body">
							    	<p class="card-title">관리</p>
									 <div class="form-group">
										<div class="btn-group" role="group" aria-label="Basic example">
				                        <button type="button" class="btn btn-outline-secondary">내 개설모임</button>
				                        <button type="button" class="btn btn-outline-secondary">내 가입모임</button>
				                        <button type="button" class="btn btn-outline-secondary">(관리자)대기신청서</button>
				                        <button type="button" class="btn btn-outline-secondary">(관리자)승인신청서</button>
				                        <button type="button" class="btn btn-outline-secondary">(관리자)거부신청서</button>
				                        </div>
					                </div>
									<div class="list-wrapper pt-2">
								        <table class="table table-striped table-borderless table-hover" id="MyInfo">
											
										</table>
									</div>
								</div>
							</div>
					    </div>
					    <!-- 오른쪽 2번  -->
					</div>
				</div>
			</div>
		</div>
		<form id="MyForm"></form>
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>