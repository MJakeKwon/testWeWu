<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<script>
		window.onload = function() {
			// form 데이터 가져오기
			var form = document.getElementById('getGroupBoardList');
			var formData = new FormData(form);
		
			// JSON으로 변환
			var jsonData = Object.fromEntries(formData);
			//모임 리스트
			$.ajax ({
				  url	: "/app/group/getGroupBoardList", // (Required) 요청이 전송될 URL 주소
				  type	: "POST", // (default: ‘GET’) http 요청 방식
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
					  var str = "";
					  for(var i = 0 ; i < data.length ; i ++){
						  str += "<li class=nav-item>" +
					          		 "<a class=nav-link href=javascript:getGroupBoard(" + data[i].typeNo + ")>" +
						            	 "<i class='icon-grid menu-icon'></i>" +
					            		 "<span class=menu-title>" + data[i].boardName + "</span>" +
				          			 "</a>" +
				          		 "</li>";
					  }
					  $('.boardList').append(str);
					  str = "";
				  },
				  error	: function(xhr, status, error) {
				    // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
				  },
				  complete : function(xhr, status) {
				    // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
				  }
			});
		}
		
		function getGroupBoard(typeNo){
			var form = document.getElementById("getGroupBoardSide");
			var str = "<input type=hidden name=typeNo value=" + typeNo +">" + 
					  "<input type=hidden name=groupNo value=" + ${group.groupNo} +">";
			$('#getGroupBoardSide').append(str);
			form.action="/group/getGroupBoard";
			form.submit();
		}
		
		$(function() 
		{
			$( "span" ).css("cursor","pointer");
			
			$( "span:contains('게시판추가')" ).on("click" , function() 
		 	{
				// 내 모임 신청정보
				addGroupBoardSide();
			}); 
			
			$( ".home" ).on("click" , function() 
		 	{
				// 내 모임 신청정보
				getGroupSide();
			}); 
			
			$(".nav-link:contains('모임정보')").on("click",function()
			{
				getGroupSide();
			});
			
			$(".nav-link:contains('내 정보')").on("click",function()
			{
				getMemberGroupSide();
			});
			
			$(".nav-link:contains('모임원목록')").on("click",function()
			{
				getMemberGroupListSide();
			});
			
			$(".nav-link:contains('가입신청서 양식')").on("click",function()
			{
				updateApplJoinFormSide();
			});
		});
		
		function getGroupSide(){
			var form = document.getElementById("getGroupSide");
			form.action="/group/getGroup";
			form.submit();
		}
		
		function addGroupBoardSide(){
			var form = document.getElementById("addGroupBoardSide");
			form.action="/group/addGroupBoard";
			form.submit();
		}
		
		function getMemberGroupSide(){
			var form = document.getElementById("getMemberGroupSide");
			form.action="/group/getMemberGroupForNick";
			form.submit();
		}
		
		function updateApplJoinFormSide(){
			var form = document.getElementById("updateApplJoinFormSide");
			form.action="/group/updateApplJoinForm";
			form.submit();
		}
		
		function getMemberGroupListSide(){
			var form = document.getElementById("getMemberGroupListSide");
			form.action="/group/getMemberGroupList";
			form.submit();
		}
		
	</script>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	</head>
	<body>
		<!-- partial:partials/_sidebar.html -->
	    <div class="container-fluid">
	    	<div class="row">
			    <nav class="sidebar sidebar-offcanvas" id="sidebar">
			      <ul class="nav boardList">
			        <br><br>
			        <li>
			        <br>
			          <h4><img src="/group/img/house-door.svg">&nbsp;<span class="home">${group.groupName }</span></h4>
			        </li>
			      </ul>
			      &nbsp;&nbsp;&nbsp;<img src="/group/img/journal-plus.svg">&nbsp;<span>게시판추가</span>
			      <hr>
			      <ul class="nav">
			      	<li>
			        <br>
			          <h4>관리</h4>
			        </li>
			         <li class="nav-item">
				      	<a class="nav-link" data-toggle="collapse" href="#auth" aria-expanded="false" aria-controls="auth">
				              <i class="icon-paper menu-icon"></i>
				              <span class="menu-title">모임정보</span>
				        </a>
			        </li>
			        <li class="nav-item">
			            <a class="nav-link" data-toggle="collapse" href="#auth" aria-expanded="false" aria-controls="auth">
			              <i class="icon-head menu-icon"></i>
			              <span class="menu-title">내 정보</span>
			            </a>
			        </li>
			        <li class="nav-item">
			            <a class="nav-link" data-toggle="collapse" href="#form-elements" aria-expanded="false" aria-controls="form-elements">
			              <i class="icon-ellipsis menu-icon"></i>
			              <span class="menu-title">모임원목록</span>
			            </a>
			         </li>
			         <li class="nav-item">
			            <a class="nav-link" data-toggle="collapse" href="#tables" aria-expanded="false" aria-controls="tables">
			              <i class="icon-grid-2 menu-icon"></i>
			              <span class="menu-title">가입신청서 양식</span>
			            </a>
			         </li>
			      </ul>
			    </nav>
			    
			    <form id="getGroupBoardList" method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
				
				<form id="getGroupBoardSide" method="post">
					
				</form>
				
				<form id="addGroupBoardSide" method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
				
				<form id="getGroupSide" method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
				
				<form id="updateApplJoinFormSide" method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
				
				<form id="getMemberGroupSide" method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
					<input type="hidden" name="memberNickName" value="nick4">
				</form>
				
				<form id="getMemberGroupListSide" method="post">
					<input type="hidden" name="groupNo" value="${group.groupNo}">
				</form>
	</body>
</html>