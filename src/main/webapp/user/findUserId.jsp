<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>사용자 아이디</title>
    <!-- HEADER -->
    <jsp:include page="/header.jsp"/>
    <!-- HEADER -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
    
    	.jumbotron {
            position: relative;
            background-color: white; /* 배경 색깔 흰색으로 변경 */
            padding: 11rem 0rem 0rem 0px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: -31rem;
        }
        
        .jumbotron img {
            width: 100%;
        }
        
        .jumbotron-container {
            padding: 0;
            margin: 0;
            width: 100%;
        }
        body {
            background-color: #f8f9fa;
        }
        .container-scroller {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .auth-form-light {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            text-align: center;
        }
        .auth-form-light h1 {
            font-size: 1.5rem;
            margin-bottom: 20px;
        }
        .auth-form-light p {
            font-size: 1.2rem;
            margin-bottom: 20px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .btn {
            font-size: 1.1rem;
            padding: 10px 20px;
        }
        .auth-form-light h1{
        	font-size:1.8rem;
        	color:#07a707;
        	font-weight:bold;
        }
         .auth-form-light p{
        	font-size:1.5rem;
        	margin-bottom : 25px;
        }
    </style>
</head>
<body>
	<div class="jumbotron">
        <div class="container">
            <img src="/images/wewujumbo.jpg" alt="Background Image">
        </div>
    </div>

    <div class="main-panel">
        <div class="content-wrapper">
		    <div class="container-scroller">
		        <div class="auth-form-light py-5 px-4 px-sm-5">
		            <h1>아이디 찾기에 성공하셨습니다.</h1>
		            <p>회원님의 아이디는	 &nbsp; "${userId}" 입니다.</p>
		            <a href="/user/login" class="btn btn-primary">로그인 페이지로 이동</a>
		        </div>
		    </div>
	    </div>
    </div>

    <!-- FOOTER -->
    <jsp:include page="/footer.jsp" />
    <!-- FOOTER -->

</body>
</html>
