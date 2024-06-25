<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<style>
		.switch {
		  position: relative;
		  display: inline-block;
		  width: 60px;
		  height: 34px;
		  float:left;
		}
		
		/* Hide default HTML checkbox */
		.switch input {display:none;}
		
		/* The slider */
		.slider {
		  position: absolute;
		  cursor: pointer;
		  top: 0;
		  left: 0;
		  right: 0;
		  bottom: 0;
		  background-color: #ccc;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
		
		.slider:before {
		  position: absolute;
		  content: "";
		  height: 26px;
		  width: 26px;
		  left: 4px;
		  bottom: 4px;
		  background-color: white;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
		
		input.default:checked + .slider {
		  background-color: #444;
		}
		input.primary:checked + .slider {
		  background-color: #2196F3;
		}
		input.success:checked + .slider {
		  background-color: #8bc34a;
		}
		input.info:checked + .slider {
		  background-color: #3de0f5;
		}
		input.warning:checked + .slider {
		  background-color: #FFC107;
		}
		input.danger:checked + .slider {
		  background-color: #f44336;
		}
		
		input:focus + .slider {
		  box-shadow: 0 0 1px #2196F3;
		}
		
		input:checked + .slider:before {
		  -webkit-transform: translateX(26px);
		  -ms-transform: translateX(26px);
		  transform: translateX(26px);
		}
		
		/* Rounded sliders */
		.slider.round {
		  border-radius: 34px;
		}
		
		.slider.round:before {
		  border-radius: 50%;
		}
		</style>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script>
			$(function() 
			{
				$( "span:contains('가입신청')" ).on("click" , function() 
			 	{
					addApplJoin();
				}); 
				
				$( "span:contains('수정')" ).on("click" , function() 
			 	{
					updateGroup();
				}); 
				
				$( "span:contains('삭제')" ).on("click" , function() 
			 	{
					deleteGroup()
				}); 
				
				$( "#scrab" ).on("click" , function() 
			 	{
					 // 체크박스 요소를 가져옵니다.
				    let checkbox = document.getElementById('scrab');

				    // 체크 상태를 확인합니다.
				    if (checkbox.checked) {
				        updateFlag("Y");
				    } else {
				    	
				    	updateFlag("N");
				    }
				}); 
			});
			
			function updateFlag(scrabFlag){
				
				$.ajax ({
					url	: "/app/group/updateScrab", // (Required) 요청이 전송될 URL 주소
					type  : "POST", // (default: ‘GET’) http 요청 방식
					async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
					cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
					timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
					data  : JSON.stringify(
					 			{
					 				memberNo:${groupMember.memberNo eq null ? '0' : groupMember.memberNo},
					 				scrabFlag:scrabFlag
					 			}
					 		), // 요청 시 전달할 데이터
					processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
					contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
					dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
					beforeSend  : function () {
					  // XHR Header 포함, HTTP Request 하기전에 호출
					  
					},
					success : function(data, status, xhr) {
						
					},
					error	: function(xhr, status, error) {
					  // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
					},
					complete : function(xhr, status) {
					  // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
					}
				});
			}
			
			function deleteMemberGroup(){
				
		        if(!confirm("정말 삭제하시겠습니까?")){
					return;
					
		        }else{
		        	
		        	// form 데이터 가져오기
		        	var form = document.getElementById('deleteMemberGroup');
		        	var formData = new FormData(form);
	
		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);
	
		        	//모임 리스트
					$.ajax ({
						url	: "/app/group/deleteMemberGroup", // (Required) 요청이 전송될 URL 주소
						type  : "POST", // (default: ‘GET’) http 요청 방식
						async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
						cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
						timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
						data  : JSON.stringify(
						 			jsonData
						 		), // 요청 시 전달할 데이터
						processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
						contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
						dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
						beforeSend  : function () {
						  // XHR Header 포함, HTTP Request 하기전에 호출
						  
						},
						success : function(data, status, xhr) {
							if(data.flag == "Y"){
								alert("삭제가 완료되었습니다");
								location.href="/";
							}else{
								alert("삭제 실패 : 기타 원인.");
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
			
			function updateMemberGroup(){
				var form = document.getElementById("updateMemberGroup");
				form.action="/group/updateMemberGroup";
				form.submit();
			}
		</script>
	</head>
	<body>
		<!-- SIDEBAR -->
		<jsp:include page="/group/groupSide.jsp"></jsp:include>
		<!-- SIDEBAR -->
		<div class="main-panel">
        	<div class="content-wrapper">
        		<div class="col-12 grid-margin stretch-card">
		            <div class="card">
		                <div class="card-body">
		                    <h4 class="card-title">내 정보</h4>
		                    <div style="float:right;">
                    			<img src="/group/img/arrow-repeat.svg"><span>수정</span>&nbsp;
                    			<img src="/group/img/eraser-fill.svg"><span>탈퇴</span>
		                    </div>
		                        ${groupMember.memberNickName}
		                    <p class="card-description">
		                        가입날짜 : #${groupMember.joinDate}<br>
		                       	성별 : 남성
		                    </p>
	                        <c:if test="${groupMember != null }">
		                        <!-- 모임원만 출력 -->
		                        <div class="col-md-12">
		                            <div class="card">
		                                <div class="card-body">
		                                	<h4 class="card-title">스크랩</h4>
	                                     	<label class="switch">
									        	<input type="checkbox" id="scrab" class="default" ${groupMember.scrabFlag eq 'Y' ? 'checked' : ''}>
									        	<span class="slider round"></span>
									        </label>
		                                </div>
		                            </div>
		                        </div>
		                        <!-- 모임원만 출력 -->
	                        </c:if>
		                    </div>
		                </div>
		            </div>
		        </div>
		        
		        
				${groupMember}
				<form id="deleteMemberGroup" method="post">
					<input type="hidden" name="memberNo" value="${groupMember.memberNo}">
				</form>
					<a href="javascript:deleteMemberGroup();">모임원 삭제하기</a>
					
				<form id="updateMemberGroup" method="post">
					<input type="hidden" name="memberNo" value="${groupMember.memberNo}">
				</form>
					<a href="javascript:updateMemberGroup();">내 정보 수정하기</a>
        	</div>
        </div>
        
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>