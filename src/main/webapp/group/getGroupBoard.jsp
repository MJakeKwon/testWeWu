<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- HEADER -->
		<jsp:include page="/header.jsp"/>
		<!-- HEADER -->
		
		<script>
			$(function() 
			{
				$.ajax ({
					  url	: "/app/group/getAcleList", // (Required) 요청이 전송될 URL 주소
					  type	: "POST", // (default: ‘GET’) http 요청 방식
					  async : true,  // (default: true, asynchronous) 요청 시 동기화 여부
					  cache : true,  // (default: true, false for dataType 'script' and 'jsonp') 캐시 여부
					  timeout : 3000, // (ms) 요청 제한 시간 안에 완료되지 않으면 요청을 취소하거나 error 콜백 호출
					  data  : JSON.stringify(
					 				{typeNo:${groupBoard.typeNo}}
				 				), // 요청 시 전달할 데이터
					  processData : true, // (default: true) 데이터를 컨텐트 타입에 맞게 변환 여부
					  contentType : "application/json", // (default: 'application/x-www-form-urlencoded; charset=UTF-8')
					  dataType    : "json", // (default: Intelligent Guess (xml, json, script, or html)) 응답 데이터 형식
					  beforeSend  : function () {
					    // XHR Header 포함, HTTP Request 하기전에 호출
					  },
					  success : function(data, status, xhr) {
						  var str = "";
						  for(var i = 0 ; i < data.length ; i ++){
							  
							  str += "<tr class ='acle' id="+data[i].boardNo+">" +
						          		 "<td>" + data[i].wrteName +"</td>" +
						          		 "<td>" + data[i].acleName +"</td>" +
						          		 "<td>" + data[i].wrteDate +"</td>" +
						          		 "<td>0</td>" +
						          		 "<td>0</td>";
					          		 "</tr>";
						  }
						  $('#acleList').append(str);
						  str = "";
						  
					  },
					  error	: function(xhr, status, error) {
					    // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
					  },
					  complete : function(xhr, status) {
					    // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
					  }
				});
				
				$(document).ready(function() {
				    $(document).on('mouseenter', '.acle', function() {
				        $(this).css('cursor', 'pointer');
				    });
				    
				    $(document).on('click', '.acle', function() {
				    	getGroupAcle($(this).attr("id"));
				    });
				});
				
				$( "span:contains('작성')" ).on("click" , function() 
			 	{
					// 내 모임 신청정보
					addGroupAcle();
				}); 
				$( "span:contains('게시판 수정')" ).on("click" , function() 
			 	{
					// 내 모임 신청정보
					updateGroupBoard();
				}); 
				
				$( "span:contains('게시판 삭제')" ).on("click" , function() 
			 	{
					// 내 모임 신청정보
					deleteGroupBoard();
				}); 
			});
			function getGroupAcle(boardNo){
				var form = document.getElementById("getGroupAcle");
				var str = "<input type=hidden name=boardNo value=" + boardNo +">" + 
				  		  "<input type=hidden name=groupNo value=" + ${group.groupNo} +">";
				 $('#getGroupAcle').append(str);
				form.action="/group/getGroupAcle";
				form.submit();
			}
			
			function updateGroupBoard(){
				var form = document.getElementById("updateGroupBoard");
				form.action="/group/updateGroupBoard";
				form.submit();
			}
			
			function addGroupAcle(){
				var form = document.getElementById("addGroupAcle");
				form.action="/group/addGroupAcle";
				form.submit();
			}
			
			function deleteGroupBoard(){
				
		        if(!confirm("정말 삭제하시겠습니까?")){
					return;
					
		        }else{
		        	
		        	// form 데이터 가져오기
		        	var form = document.getElementById('deleteGroupBoard');
		        	var formData = new FormData(form);

		        	// JSON으로 변환
		        	var jsonData = Object.fromEntries(formData);

		        	//모임 리스트
					$.ajax ({
						url	: "/app/group/deleteGroupBoard", // (Required) 요청이 전송될 URL 주소
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
								var form = document.getElementById("getGroup");
								form.submit();
								
							
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
		</script>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
	
		<!-- SIDEBAR -->
		<jsp:include page="/group/groupSide.jsp"></jsp:include>
		<!-- SIDEBAR -->
		
		<div class="main-panel">
        	<div class="content-wrapper">
        		<jsp:include page="listBoard.jsp"></jsp:include>
        	</div>
        	
        	<form id="getGroupBoard">
				<input type="hidden" name="typeNo" value="${groupBoard.typeNo}">
				<input type="hidden" name="groupNo" id="groupNo" value="${groupBoard.groupNo}">
			</form>
			
			<form id="updateGroupBoard" method="post" action="/group/updateGroupBoard">
				<input type="hidden" name="typeNo" value="${groupBoard.typeNo}">
			</form>
			
			<form id="deleteGroupBoard" method="post">
				<input type="hidden" name="typeNo" value="${groupBoard.typeNo}">
			</form>
				
			<form id="addGroupAcle" method="post">
				<input type="hidden" name="typeNo" value="${groupBoard.typeNo}">
				<input type="hidden" name="groupNo" value="${groupBoard.groupNo}">
			</form>
			
			<form id="getGroupAcle" method="post">
				<input type="hidden" name="groupNo" value="${groupBoard.groupNo}">
			</form>
				
			<form id="getGroup" method="post" action="/group/getGroup">
				<input type="hidden" name="groupNo" value="${groupBoard.groupNo}">
			</form>
			
        </div>
        
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>