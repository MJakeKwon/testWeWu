<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>활동 목록 조회</title>
<style>
    .clickable-text {
        cursor: pointer; /* 커서를 포인터로 변경하여 클릭 가능함을 나타냄 */
    }
</style>
</head>
<body>

	<!-- HEADER -->
	<jsp:include page="/header.jsp"/>
	<!-- HEADER -->
	
	<!-- SIDE -->
	<jsp:include page="/activeSide.jsp"></jsp:include>
	<!-- SIDE -->
	
	<script type="text/javascript">
	
		$(document).ready(function() {
			
			currentPage = 1;
			
			$('.spread-btn').attr('hidden', 'hidden');
			
			if(currentPage == 1) {
				//alert('check');
        		$('.hold-btn').attr('hidden', 'hidden');
        	}
			
			if(${isLast}) {
				//alert('check');
        		$('.more-btn').attr('hidden', 'hidden');
			}
			
			searchCondition = $('.condition').val();
    		searchKeyword = $('.keyword').val();
    		groupNo = ${groupNo};
    		url = '/app/active/listGroupActive?groupNo=' + ${groupNo};
			
			$('.dropdown-item').on('click', function(event) {
				
				$('.dropdown-btn').html($(event.target).html().trim());
				$('.condition').val($(event.target).html().trim());
				console.log($('.condition').val());
				
			});
			
			$('.search-btn').on('click', function() {
				
				var searchKeyword = $('.keyword').val();
				var searchCondition = $('.condition').val();
				
				//alert(searchKeyword);
				//alert(searchCondition);
				
				/* if(searchKeyword == '') {
					return;
				} */
				
				
				$('form').attr('method', 'post');
				$('form').attr('action', '/active/listActive/?groupNo='+${groupNo});
				$('#searchForm')[0].submit();
				
			});
			
		});
	
	</script>
	
	<div class="main-panel">
       	<div class="content-wrapper">
       	
       		<div class="row">
       		
       				<div class="col-lg-2 grid-margin stretch-card">
       				</div>
       		
	       			<div class="col-lg-6 grid-margin stretch-card">
	       			
		       			<form id="searchForm" class="searchForm" >
		       			
			              <div class="card">
			                <div class="card-body">
			                	
								<div class="row">
									<div class="col-lg-6">
										<h4 class="card-title">모임 활동 리스트</h4>
									</div>
									<c:if test="${user.role == '3' }">
										<div class="col-lg-6 d-flex justify-content-end">
											<button type="button" class="btn to-add-btn btn-outline-primary btn-fw">등록하기</button>
										</div>
									</c:if>
								</div>
			                  
								<div class="input-group text-right">
								
									<div class="input-group-prepend">
										<button class="dropdown-btn btn btn-sm btn-outline-primary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
											<c:if test="${search.searchCondition == null || search.searchCondition == ''}">
												활동 상태
											</c:if>
											<c:if test="${search.searchCondition != ''}">
												${search.searchCondition}
											</c:if>
										</button>
										<div class="dropdown-menu" style="">
											<a class="dropdown-item" href="#">전체</a>
											<div role="separator" class="dropdown-divider"></div>
											<a class="dropdown-item" href="#">활동중</a>
											<div role="separator" class="dropdown-divider"></div>
											<a class="dropdown-item" href="#">활동 종료</a>
										</div>
									</div>
									<input type="hidden" class="condition" name="searchCondition" value="${search.searchCondition}" >
								
									<input type="text" name="searchKeyword" class="form-control-sm keyword" value="${search.searchKeyword}" placeholder="활동명 해쉬태그 검색">
									
									<div class="input-group-append">
									  <button class="btn btn-sm btn-primary search-btn" type="button">Search</button>
									</div>
									
					 			</div>
			                  
			                  <p class="card-description">
			                  </p>
			                  <div class="table-responsive">
			                  
			                    <table class="table">
			                    
			                      <thead>
			                        <tr>
			                        	<th>No</th>
			                        	<th>활동 이름</th>
			                        	<th>활동 시작일</th>
			                        	<th>활동 종료일</th>
			                        	<th>활동 등록일</th>
			                        	<th>활동 종료 여부</th>
			                        </tr>
			                      </thead>
			                      
			                      <tbody class="list-body" >
			                      	<c:set var="i" value="1" ></c:set>
			                        <c:forEach var="active" items="${list}">
			                        
			                        	<tr>
											<td>${i}</td>
											<td class="name clickable-text" >
												${active.activeName}
												<input type="hidden" name="activeNo" value="${active.activeNo}">
											</td>
											<td>${active.activeStartDate}</td>
											<td>${active.activeEndDate}</td>
											<td>${active.activeRegDate}</td>
											<td>${active.stateFlag}</td>
										</tr>
			                        	
			                        <c:set var="i" value="${i+1}" ></c:set>
			                        </c:forEach>
			                        
			                      </tbody>
			                      
			                    </table>
			                    
			                    <script type="text/javascript">
			                    
			                    	$('.name').css('color', 'blue');
			                    	
			                    	$('.name').on('click', function(event) {
			                    		
			                    		var activeNo = $(event.target).children().val();
			                    		
			                    		//alert(activeNo);
			                    		
			                    		self.location = '/active/getActive/'+activeNo;
			                    	});
			                    
			                    </script>
			                    
			                   
			                    	
	                    	 	<button type="button" class="more-btn btn btn-secondary btn-lg btn-block">
	                    			더보기
	                    		</button>
	                    		<button type="button" class="hold-btn btn btn-secondary btn-lg btn-block">
	                    			접기
	                    		</button>
	                    		<button type="button" class="spread-btn btn btn-secondary btn-lg btn-block">
	                    			펼치기
	                    		</button>
			                    
			                    
			                    <script type="text/javascript">
			                    
			                    	$('.hold-btn').on('click', function() {
			                    		
			                    		$('.append').attr('hidden', 'hidden');
			                    		$('.hold-btn').attr('hidden', 'hidden');
			                    		$('.spread-btn').removeAttr('hidden');
			                    		
			                    	});
			                    	
			                    	$('.spread-btn').on('click', function() {
			                    		
			                    		$('.spread-btn').attr('hidden', 'hidden');
			                    		$('.hold-btn').removeAttr('hidden');
			                    		$('.append').removeAttr('hidden');
			                    		
			                    	});
			                    
			                    	$('.more-btn').on('click', function() {
			                    	
			                    		//alert(${isLast});
			                    		
			                    		currentPage++;
			                    		body = new Object();
			                			body.searchCondition = searchCondition;
			                    		body.searchKeyword = searchKeyword;
			                    		body.groupNo = groupNo;
			                    		body.currentPage = currentPage;
			                    		
			                    		let data = new Array();
			                    		data.push(body);
			                    		let json = JSON.stringify(body);
			                    		
			                    		console.log(json);
			                    		
			                    		$.ajax({
			                    			url: url,
			                    			method: 'POST',
			                    			data: json,
			                    			contentType : 'application/json',
			                    			success: function(JSONData, status) {
			                    				
			                    				console.log(JSONData);
			                    				console.log(JSONData.isLast);
			                    				
			                    				var list = JSONData.list;
			                    				
			                    				console.log(list);
			                    				
			                    				if(JSONData.isLast) {
						                    		$('.more-btn').attr('hidden', 'hidden');
						                    		$('.hold-btn').removeAttr('hidden');
						                    	}
			                					
			                					if(list.length == 0){
			                						return;
			                					}
			                    				
			                					var appendEl = '';
			                					
			                    				for(let i = 0; i < list.length; i++) {
			                    					
			                    					let j = (currentPage-1) * 10 + i + 1;
			                    					
			                    					appendEl += '<tr class="append">\n'+
																	'<td>'+j+'</td>\n'+
																	'<td class="name clickable-text" >\n'+
																		list[i].activeName+
																		'<input type="hidden" name="activeNo" value="'+list[i].activeNo+'">\n'+
																	'</td>\n'+
																	'<td>'+list[i].activeStartDate+'</td>\n'+
																	'<td>'+list[i].activeEndDate+'</td>\n'+
																	'<td>'+list[i].activeRegDate+'</td>\n'+
																	'<td>'+list[i].stateFlag+'</td>\n'+
																'</tr>';
			                    					
			                    				}
			                    				
			                    				//console.log(appendEl);
			                    				
			                    				$('.list-body').append(appendEl);
			                    				
			                    				$('.name').css('color', 'blue');
						                    	
						                    	$('.name').on('click', function(event) {
						                    		
						                    		var activeNo = $(event.target).children().val();
						                    		
						                    		//alert(activeNo);
						                    		
						                    		self.location = '/active/getActive/'+activeNo;
						                    	});
			                    				
			                    			},
			                    		    error: function(xhr, status, error) {
			                    		        // 서버 목록을 가져오는 데 실패했을 때의 처리
			                    		        console.error('Failed to fetch list:', error);
			                    		    }
			                    		});
			                    		
			                    	});
			                    
			                    </script>
			                    
			                  </div>
			                </div>
			              </div>
		              
		              </form>
		              
		            </div>
		            
		            <div class="col-lg-3 grid-margin stretch-card">
       				</div>
	            
	            
       		
       		</div>
			
       	</div>
       		
			<!-- FOOTER -->
		    <jsp:include page="/footer.jsp" />
		    <!-- FOOTER -->
		    
		    <script type="text/javascript">
		    	$('footer').removeClass('fixed-bottom');
		    </script>
       	
       </div>

</body>
</html>