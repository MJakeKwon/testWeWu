<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chat server</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		
		//alert('check');
		
		function listServer() {
			$.ajax({
				
				url: 'https://223.130.157.128:3000/listServer',
				method: 'GET',
				success: function(response) {
			        // 서버 목록을 성공적으로 가져왔을 때의 처리
			        console.log('Received server list:', response);
			        
			     	// 서버 목록을 테이블에 추가
			        var tbody = $('#tableBody');
			     	
			     	tbody.empty();
			     	
			        response.forEach(function(server, index) {
			            var row = '<tr>' +
			                          '<td>' + (index + 1) + '</td>' +
			                          '<td></td>' +
			                          '<td class="serverName" >' + server.server_name + '</td>' +
			                          '<td></td>' +
			                          '<td>' + server.server_pers + '명</td>' +
			                      '</tr>';
			            tbody.append(row);
			        });
			        
			        $('.serverName').css('color', 'red');
					
					$('.serverName').on('click', function(event) {
						//alert('check');
						
						var nick = $('#nick').val();
						
						if(nick == '') {
							alert('닉네임을 입력해주세요');
							return;
						}
						
						var room = $(event.target).text().trim();
						console.log(room);
						
						self.location = '/chat/chatting.jsp?room="'+room+'"&nick="'+nick+'"';
					});
			        
			    },
			    error: function(xhr, status, error) {
			        // 서버 목록을 가져오는 데 실패했을 때의 처리
			        console.error('Failed to fetch server list:', error);
			    }
				
			});
		}
		
		listServer();
		
		setInterval(listServer, 1000);
		
	});
	
</script>
</head>
<body>

	<!-- <img src="https://wewu-project-test.kr.object.ncloudstorage.com/677e32c7-b7b6-4d23-ba8f-f6270767d664"> -->

	<h2>닉네임</h2>
	<input type="text" id="nick" >
	<br/>
	<br/>

	<table>
		<thead>
			<tr>No</tr>
			<tr></tr>
			<tr>서버 이름</tr>
			<tr></tr>
			<tr>접속 인원</tr>
		</thead>
		<tbody id="tableBody" >
			
		</tbody>
	</table>

</body>
</html>