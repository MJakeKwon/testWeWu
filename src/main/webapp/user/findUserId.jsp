<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>사용자 아이디</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
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
    </style>
</head>
<body>

    <!-- HEADER -->
    <jsp:include page="/header.jsp"/>
    <!-- HEADER -->
    <div class="main-panel">
        <div class="content-wrapper">
		    <div class="container-scroller">
		        <div class="auth-form-light py-5 px-4 px-sm-5">
		            <h1>사용자 아이디</h1>
		            <p>아이디: ${userId}</p>
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
