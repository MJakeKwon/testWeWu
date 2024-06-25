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
				getMemberGroupList("");
				$(".btn-primary").text("전체");
				
				$(".dropdown-item").on("click",function(){
					if($(this).text() == "전체")
					{
						$(".btn-primary").text("전체");
						getMemberGroupList("");
					}else
					if($(this).text() == "가입인원")
					{
						$(".btn-primary").text("가입인원");
						getMemberGroupList("T");
					}else
					if($(this).text() == "신청인원")
					{
						$(".btn-primary").text("신청인원");
						getMemberGroupList("E");
					}
				})
			});
			
			function getMemberGroupList(joinFlag)
			{
				// form 데이터 가져오기
				var form = document.getElementById('getMemberGroupList');
				
				var str = "<input type='hidden' name='joinFlag' value='"+ joinFlag +"'>" +
						  "<input type='hidden' name='searchCondition' value='group'>" + 
						  "<input type='hidden' name='searchKeyword' value='${group.groupNo}'>";
				$('#getMemberGroupList').append(str);
				var formData = new FormData(form);
			
				// JSON으로 변환
				var jsonData = Object.fromEntries(formData);
				
				$.ajax ({
					  url	: "/app/group/getMemberGroupList", // (Required) 요청이 전송될 URL 주소
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
							  
							  str += "<tr class ='acle' id="+data[i].boardNo+">" +
						          		 "<td>" + data[i].memberNickName +"</td>" +
						          		 "<td>" + data[i].joinDate +"</td>" +
						          		 "<td>남</td>" +
						          		 "<td>" + data[i].joinFlag + "</td>";
					          		 "</tr>";
						  }
						  $('#memberList').html(str);
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
        		<div class="col-lg-12 grid-margin stretch-card">
	              <div class="card">
	                <div class="card-body">
	                  <h4 class="card-title">모임원 목록</h4>
	                    <div class="dropdown" style="float:right;">
                        <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" 
                        		data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                        		
                        </button>
                        <div class="dropdown-menu " aria-labelledby="dropdownMenuButton">
                          <a class="dropdown-item">전체</a>
                          <a class="dropdown-item">가입인원</a>
                          <a class="dropdown-item">신청인원</a>
                        </div>
                      </div>
	                  <div class="table-responsive">
	                    <table class="table table-hover">
	                      <thead>
	                        <tr>
	                          <th>닉네임</th>
	                          <th>가입/신청일</th>
	                          <th>성별</th>
	                          <th>상태</th>
	                        </tr>
	                      </thead>
	                      <tbody id="memberList">
	                      
	                      </tbody>
	                    </table>
	                  </div>
	                </div>
	              </div>
            	</div>
        	</div>
        </div>
        <form id="getMemberGroupList" method="post">
        
		</form>
		
		<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	</body>
</html>