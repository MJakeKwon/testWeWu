<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head>

</head>

<body>
<jsp:include page="/header.jsp" flush="true" />
<!-- partial -->
<div class="main-panel">
	<div class="content-wrapper">
		<div class="row">
			<div class="col-md-12 grid-margin">
				<div class="row">
					<div class="col-12 col-xl-8 mb-4 mb-xl-0">
						<h3 class="font-weight-bold">Welcome Aamir</h3>
						<h6 class="font-weight-normal mb-0">
							All systems are running smoothly! You have <span class="text-primary">3 unread
								alerts!</span>
						</h6>
					</div>
					<div class="col-12 col-xl-4">
						<div class="justify-content-end d-flex">
							<div class="dropdown flex-md-grow-1 flex-xl-grow-0">
								<button class="btn btn-sm btn-light bg-white dropdown-toggle" type="button"
									id="dropdownMenuDate2" data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="true">
									<i class="mdi mdi-calendar"></i> Today (10 Jan 2021)
								</button>
								<div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuDate2">
									<a class="dropdown-item" href="#">January - March</a> <a class="dropdown-item"
										href="#">March - June</a> <a class="dropdown-item" href="#">June - August</a>
									<a class="dropdown-item" href="#">August - November</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6 grid-margin stretch-card">
				<div class="card tale-bg">
					<div class="card-people mt-auto">
						<img src="images/dashboard/people.svg" alt="people">
						<div class="weather-info">
							<div class="d-flex">
								<div>
									<h2 class="mb-0 font-weight-normal">
										<i class="icon-sun mr-2"></i>31<sup>C</sup>
									</h2>
								</div>
								<div class="ml-2">
									<h4 class="location font-weight-normal">Bangalore</h4>
									<h6 class="font-weight-normal">India</h6>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-6 grid-margin stretch-card">
				<div class="card tale-bg">
					<div class="card-people mt-auto">
						<img src="images/dashboard/people.svg" alt="people">
						<div class="weather-info">
							<div class="d-flex">
								<div>
									<h2 class="mb-0 font-weight-normal">
										<i class="icon-sun mr-2"></i>31<sup>C</sup>
									</h2>
								</div>
								<div class="ml-2">
									<h4 class="location font-weight-normal">Bangalore</h4>
									<h6 class="font-weight-normal">India</h6>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- swiper -->
		<div class="container">
			<div class="row mx-auto">
				<div class="col-lg-12 slide">
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<div class="swiper-slide">
								<img src="https://via.placeholder.com/1000x300" alt="Plant 1">
								<div class="slide-content">
									<h3>Philodendron</h3>
									<p>The Philodendron White Princess Has Been Around For Some
										Time In Private Collections. But They Have Hit The Market...</p>
								</div>
							</div>
							<div class="swiper-slide">
								<img src="https://via.placeholder.com/1000x300" alt="Plant 2">
								<div class="slide-content">
									<h3>Monstera Obliqua Peruvian</h3>
									<p>AS It Is A Small Species, Monstera Obliqua Is Uncommon.
										Another Reason For Its Scarcity Is That It Grows Slowly And
										Has Short...</p>
								</div>
							</div>
							<div class="swiper-slide">
								<img src="https://via.placeholder.com/1000x300" alt="Plant 2">
								<div class="slide-content">
									<h3>Monstera Obliqua Peruvian</h3>
									<p>AS It Is A Small Species, Monstera Obliqua Is Uncommon.
										Another Reason For Its Scarcity Is That It Grows Slowly And
										Has Short...</p>
								</div>
							</div>
							<div class="swiper-slide">
								<img src="https://via.placeholder.com/1000x300" alt="Plant 3">
								<div class="slide-content">
									<h3>Norfolk Island Pine</h3>
									<p>Although A Lively Addition To Your Home All Year
										Round—The Norfolk Island Pine Shines As A Live Holiday Tree
										During The Winter...</p>
								</div>
							</div>
						</div>
						<div class="swiper-button-next"></div>
						<div class="swiper-button-prev"></div>
					</div>
				</div>
			</div>
			<br>
			<!-- 추가 슬라이드 -->
		<div class="container ">
			<div class="row ">
				<div class="col-lg-12 slide mb-5">
					<div class="swiper-container ">
						<div class="swiper-wrapper">
							<div class="swiper-slide">
								<img src="https://via.placeholder.com/1000x300" alt="Plant 1">
								<div class="slide-content">
									<h3>Philodendron</h3>
									<p>The Philodendron White Princess Has Been Around For Some
										Time In Private Collections. But They Have Hit The Market...</p>
								</div>
							</div>
							<div class="swiper-slide">
								<img src="https://via.placeholder.com/1000x300" alt="Plant 2">
								<div class="slide-content">
									<h3>Monstera Obliqua Peruvian</h3>
									<p>AS It Is A Small Species, Monstera Obliqua Is Uncommon.
										Another Reason For Its Scarcity Is That It Grows Slowly And
										Has Short...</p>
								</div>
							</div>
							<div class="swiper-slide">
								<img src="https://via.placeholder.com/1000x300" alt="Plant 2">
								<div class="slide-content">
									<h3>Monstera Obliqua Peruvian</h3>
									<p>AS It Is A Small Species, Monstera Obliqua Is Uncommon.
										Another Reason For Its Scarcity Is That It Grows Slowly And
										Has Short...</p>
								</div>
							</div>
							<div class="swiper-slide">
								<img src="https://via.placeholder.com/1000x300" alt="Plant 3">
								<div class="slide-content">
									<h3>Norfolk Island Pine</h3>
									<p>Although A Lively Addition To Your Home All Year
										Round—The Norfolk Island Pine Shines As A Live Holiday Tree
										During The Winter...</p>
								</div>
							</div>
						</div>
						<div class="swiper-button-next"></div>
						<div class="swiper-button-prev"></div>
					</div>
				</div>
			</div>
			<br>
		<!-- content-wrapper ends -->
		<!-- main-panel ends -->
					</div>
				</div>
			</div>
		</div>

<!-- footer.jsp -->
<jsp:include page="footer.jsp" />
<!-- footer.jsp -->
</body>

</html>