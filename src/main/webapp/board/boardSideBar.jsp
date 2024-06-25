<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" href="/vendors/feather/feather.css">
  <link rel="stylesheet" href="/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="/vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <link rel="stylesheet" href="/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" type="/text/css" href="/js/select.dataTables.min.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="/css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="/images/favicon.png" />
<title>Insert title here</title>
</head>
<body>

	<nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">
          <li class="nav-item active">
            <a class="nav-link" href="/board/listBoard?boardType=1">
              <i class="icon-grid menu-icon"></i>
              <span class="menu-title">공지 사항</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
              <i class="icon-layout menu-icon"></i>
              <span class="menu-title">문의</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="ui-basic">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="/board/listQuestion?questionType=자주">FAQ</a></li>
                <li class="nav-item"> <a class="nav-link" href="/board/listQuestion?questionType=문의">1:1문의</a></li>
              </ul>
            </div>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="/board/listBoard?boardType=2">
              <i class="icon-grid menu-icon"></i>
              <span class="menu-title">모임 홍보</span>
            </a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="/board/listBoard?boardType=3">
              <i class="icon-grid menu-icon"></i>
              <span class="menu-title">모임 후기</span>
            </a>
          </li>
          
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
              <i class="icon-layout menu-icon"></i>
              <span class="menu-title">후원</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="ui-basic">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item"> <a class="nav-link" href="/board/listBoard?boardType=4">후원 하기</a></li>
                <li class="nav-item"> <a class="nav-link" href="/board/listDonation?payType=1">후원 내역 보기</a></li>
              </ul>
            </div>
          </li>
          
        </ul>
      </nav>

</body>
</html>