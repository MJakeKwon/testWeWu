<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chat practice</title>
<script>

	

</script>
<style>
    #chatBox {
      border: 1px solid #000;
      height: 500px;
      overflow-y: scroll;
      padding: 10px;
      margin-bottom: 10px;
    }
    #messageInput {
      width: 80%;
      padding: 10px;
    }
    #fileInput {
        margin-top: 10px;
    }
    #sendButton {
      padding: 10px;
    }
    img {
    	height: 150px;
    	width: 150px;
    }
    video {
    	height: 250px;
    }
    
</style>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://223.130.157.128:3000/socket.io/socket.io.js"></script>
<script type="text/javascript">
	
	$(function () {
		
		var nick = ${param.nick};
		var room = ${param.room};
		var data = {};
		data.nick = nick;
		data.room = room;
			
		console.log(data);
			
		socket = io('https://223.130.157.128:3000');
		
		socket.emit('join_room', data);
		
		$('#messageInput').focus();
		
		//이전 기록 가져오는 함수
		socket.on('chatList', function(previousChats) {
			
			previousChats.forEach(function(chat) {
				
				console.log(chat);
				
				var date = new Date(chat.chat_date);
				var formattedDate = date.toLocaleString();
				
				//console.log(chat.file_url);
				
				var chatBox = $('#chatBox');
		        var isScrolledToBottom = chatBox[0].scrollHeight - chatBox[0].clientHeight <= chatBox[0].scrollTop + 1;
		        if(chat.file_url != undefined && chat.file_type == 'img') {
		        	$('#chatBox').append('<div><strong>'+chat.chat_nickname+'</strong>: '+chat.file_name+'<br/><img src="'+chat.file_short_url+'"><span style="font-size: 10px;">' + formattedDate + '</span></div>');
		        } else if(chat.file_url != undefined && chat.file_type == 'video') {
		        	$('#chatBox').append('<div><strong>'+chat.chat_nickname+'</strong>: '+chat.file_name+'<br/><video src="'+chat.file_short_url+'" controls="controls" ></video><span style="font-size: 10px;">' + formattedDate + '</span></div>');
		        }  
		        if(chat.chat_contents != '') {
		        	$('#chatBox').append('<div><strong>'+ chat.chat_nickname +'</strong> : ' + chat.chat_contents + ' ' + '<span style="font-size: 10px;">' + formattedDate + '</span></div>');
		        }
		        if (isScrolledToBottom) {
		            chatBox.scrollTop(chatBox[0].scrollHeight);
		        }
				
			});
			
		});
			
		//채팅방 입장 함수
		socket.on('enter', function(nick) {
			//$('#chatBox').append('<div><strong>'+${param.nick}+'</strong>님이 입장하였습니다.</div>');
			
			var chatBox = $('#chatBox');
			var isScrolledToBottom = chatBox[0].scrollHeight - chatBox[0].clientHeight <= chatBox[0].scrollTop + 1;
			$('#chatBox').append('<div><strong>'+nick+'</strong>님이 입장하였습니다.</div>');
			if (isScrolledToBottom) {
				chatBox.scrollTop(chatBox[0].scrollHeight);
			}
		});
			
		//전송받은 메세지 채팅창에 출력
		socket.on('message', function(data) {
			//$('#chatBox').append('<div><strong>'+data.nick+'</strong> : ' + data.msg + '</div>');
			
			console.log(data);
			
			var chatBox = $('#chatBox');
			var isScrolledToBottom = chatBox[0].scrollHeight - chatBox[0].clientHeight <= chatBox[0].scrollTop + 1;
			//$('#chatBox').append('<div><strong>'+data.nick+'</strong> : ' + data.msg + '<span>' + data.date + '</span></div>');
			if(data.file_url != undefined && data.fileType == 'img') {
	        	$('#chatBox').append('<div><strong>'+data.nick+'</strong>: '+data.fileName+'<br/><img src="'+data.shortUrl+'"><span style="font-size: 10px;">' + data.date + '</span></div>');
	        }else if(data.file_url != undefined && data.fileType == 'video') {
	        	$('#chatBox').append('<div><strong>'+data.nick+'</strong>: '+data.file_name+'<br/><video src="'+data.file_short_url+'" controls="controls" ></video><span style="font-size: 10px;">' + data.date + '</span></div>');
	        }
			if(data.msg != '') {
				$('#chatBox').append('<div><strong>'+data.nick+'</strong> : ' + data.msg + ' ' + '<span style="font-size: 10px;">' + data.date + '</span></div>');
			}
			if (isScrolledToBottom) {
				chatBox.scrollTop(chatBox[0].scrollHeight);
			}
		});
		
		//메시지 전송(enter 입력)
		$('#messageInput').on('keyup', function(event) {
			if($('#messageInput').val() != ''){
				if(event.keyCode == 13) {
					event.preventDefault();
					$('#sendButton').click();
				}
			}
		});
		
		//메시지 전송(button 클릭)
		$('#sendButton').on('click', function() {
			
			//아무것도 입력하지 않았다면 보낼 수 없다.
			if($('#messageInput').val() == '' && $('#fileInput').val() == ''){
				if($('#videoInput').val() == '') {
					//alert('check');
					
					return;
				}
			}
			
			//alert('check');
			
			//영상은 영상만 보낼 수 있다.
			if($('#videoInput').val() != '') {
				$('#messageInput').val('');
				$('#fileInput').val('');
			}
			
			var msg = $('#messageInput').val();
			
			//console.log(msg);
			
			var send_data = {};
			send_data.room = room;
			send_data.msg = msg;
			send_data.nick = nick;
			
			if($('#fileInput').val() != '') {
				
				//파일 업로드, 채팅 저장 후 return
				var file = $('#fileInput')[0].files[0];
				
				if(file) {
					
					var reader = new FileReader();
					
					reader.onload = function(event) {
						var buffer = event.target.result;
						var fileData = {
								fileName: file.name,
								fileData: buffer,
								room: room,
								nick: nick,
								msg: msg
						};
						
						socket.emit('upload', fileData);
						
						//입력필드 초기화
						$('#fileInput').val('');
						$('#messageInput').val('');
					};
					
					reader.readAsArrayBuffer(file);
					
				}
				
				return;
				
			}else if($('#videoInput').val() != '') {
				
				//alert('check');
				
				//파일 업로드, 채팅 저장 후 return
				var file = $('#videoInput')[0].files[0];
				
				if(file) {
					
					//alert('check');
					
					var formData = new FormData();
	                formData.append('video', file);
	               	formData.append('nick', nick);
	               	formData.append('fileName', file.name);
	               	formData.append('room', room);
	               	formData.append('msg', '');

	               	//alert('check');
	               	
	               	$.ajax({
	                    url: 'http://192.168.0.11:3000/upload',
	                    type: 'POST',
	                    data: formData,
	                    processData: false,
	                    contentType: false,
	                    success: function(response) {
	                        console.log('Video uploaded successfully.');
	                        $('#videoInput').val('');
	                    },
	                    error: function(jqXHR, textStatus, errorThrown) {
	                    	alert(errorThrown);
	                        console.error('Error uploading video: ' + textStatus, errorThrown);
	                    }
	                });
	               	
	               	//alert('check');
	               	
				}
				
				return;
				
			}
			
			socket.emit('send_msg', send_data);
			
			$('#messageInput').val('');
			
			$('#messageInput').focus();
			
		});
		
		//메세지에 <>이거 불가하게 바꾸기
		$('#messageInput').on('input', function() {
            var value = $(this).val();
            if (value.includes('<') || value.includes('>')) {
                $(this).val(value.replace(/[<>]/g, ''));
            }
        });
			
	});
	
</script>
</head>
<body>

	<h1>
		채팅 연습
	</h1>
	
	<div id="chatBox"></div>
	<input type="text" id="messageInput" placeholder="Type your message here...">
	<input type="file" id="fileInput" accept=".jpg,.jpeg,.png,.gif">
	<input type="file" id="videoInput" accept=".mp4">
	<button id="sendButton">Send</button>

</body>
</html>