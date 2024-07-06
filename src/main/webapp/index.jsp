<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <jsp:include page="/header.jsp" flush="true" />
  <!-- 추가된 부분: Chart.js 및 jQuery 스크립트 -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    $(document).ready(function () {
      sendAjaxRequest("/app/group/getGroupRankingList", "Ranking", "", "groupRanking");
      fncMainBoardList();
      loadAirQualityData();

      $(".boardList").on("click", function () {
        self.location = "/board/listBoard?boardType=1";
      });
    });

    function sendAjaxRequest(url, searchCondition, searchKeyword, targetElementId) {
      $.ajax({
        url: url,
        type: "POST",
        async: true,
        cache: true,
        timeout: 3000,
        data: JSON.stringify({
          searchCondition: searchCondition,
          searchKeyword: searchKeyword,
          pageSize: 0
        }),
        processData: true,
        contentType: "application/json",
        dataType: "json",
        beforeSend: function () {
          // AJAX 요청 전에 실행되는 함수
        },
        success: function (data, status, xhr) {
          // AJAX 요청 성공 시 실행되는 함수
          var str = "";
          for (var i = 0; i < data.length; i++) {
            str += "<div class='swiper-slide ranking'>" + data[i].groupName + "</div>";
          }
          $('.' + targetElementId).html(str);

          // ranking Swiper 초기화
          var rankingSwiper = new Swiper('.swiper-container.ranking', {
            direction: 'vertical', // direction: 'vertical'로 변경할 수 있습니다.
            autoplay: {
              delay: 3000, // 자동 재생 지연 시간 (밀리초)
            },
            loop: true,
            navigation: {
              nextEl: '.swiper-button-next',
              prevEl: '.swiper-button-prev'
            }
          });

          rankingSwiper.update(); // Swiper 업데이트
        },
        error: function (xhr, status, error) {
          // AJAX 요청 실패 시 실행되는 함수
        },
        complete: function (xhr, status) {
          // AJAX 요청 완료 후 실행되는 함수
        }
      });
    }

    function fncMainBoardList() {
      $.ajax({
        url: "/app/board/listBoardMain",
        type: "POST",
        data: JSON.stringify({ boardType: 1 }),
        contentType: "application/json",
        dataType: "json",
        success: function (data) {
          var str = "";
          for (var i = 0; i < data.length; i++) {
            var file = data[i].fileName ? data[i].fileName : "/images/back.png";
            str += "<div class='swiper-slide'>"
              + "<a href='/board/getBoard?boardType=" + data[i].boardType + "&boardNo=" + data[i].boardNo + "' class='card-link'>"
              + "<div class='card mb-4 shadow-sm'>"
              + "<img class='bd-placeholder-img card-img-top' src='" + file + "' alt='Placeholder: Thumbnail'>"
              + "<div class='card-body'>"
              + "<h5 class='card-title'>" + data[i].title + "</h5>"
              + "<p class='card-text'>"
              + "<strong>" + data[i].nickName + "</strong><br>"
              + data[i].regDate + "<br>"
              + "<i class='mdi mdi-star'></i> " + data[i].bookmarkCnt
              + " <i class='mdi mdi-eye'></i> " + data[i].views
              + " <i class='mdi mdi-comment'></i> " + data[i].commentCnt
              + "</p>"
              + "</div></div></a></div>";
          }
          $('.boardListMain').html(str);
          var swiper = new Swiper('.swiper-container', {
            slidesPerView: 4, // 한 줄에 4개씩 보여줍니다.
            spaceBetween: 24, // 슬라이드 사이의 간격을 설정합니다.
            loop: true, // 마지막 슬라이드에서 첫 슬라이드로 순환합니다.
            navigation: {
              nextEl: '.custom-swiper-button-next',
              prevEl: '.custom-swiper-button-prev',
            },
          });
        },
        error: function (xhr, status, error) {
          alert('리스트 없음');
        }
      });
    }

    function loadAirQualityData() {
      $.ajax({
        url: "/graph/airquality",
        type: "GET",
        dataType: "json",
        success: function (data) {
          // 데이터 파싱
          var labels = [];
          var seoulData = [];
          var busanData = [];
          var daeguData = [];
          var incheonData = [];

          for (var i = 0; i < data.response.body.items.length; i++) {
            var item = data.response.body.items[i];
            labels.push(item.dataTime);
            seoulData.push(item.seoul);
            busanData.push(item.busan);
            daeguData.push(item.daegu);
            incheonData.push(item.incheon);
          }

          // Chart.js 생성
          var ctx = document.getElementById('airQualityChart').getContext('2d');
          new Chart(ctx, {
            type: 'line',
            data: {
              labels: labels,
              datasets: [
                {
                  label: 'Seoul',
                  data: seoulData,
                  borderColor: 'rgba(255, 99, 132, 1)',
                  borderWidth: 1,
                  fill: false
                },
                {
                  label: 'Busan',
                  data: busanData,
                  borderColor: 'rgba(54, 162, 235, 1)',
                  borderWidth: 1,
                  fill: false
                },
                {
                  label: 'Daegu',
                  data: daeguData,
                  borderColor: 'rgba(75, 192, 192, 1)',
                  borderWidth: 1,
                  fill: false
                },
                {
                  label: 'Incheon',
                  data: incheonData,
                  borderColor: 'rgba(153, 102, 255, 1)',
                  borderWidth: 1,
                  fill: false
                }
              ]
            },
            options: {
              responsive: true,
              scales: {
                x: {
                  beginAtZero: true,
                  ticks: {
                    font: {
                      size: 10 // x축 폰트 크기 조정
                    },
                    maxTicksLimit: 5, // x축에 표시되는 최대 틱 수
                    autoSkip: true // 자동으로 레이블 건너뛰기
                  }
                },
                y: {
                  beginAtZero: true
                }
              }
            }
          });
        },
        error: function (xhr, status, error) {
          console.error('Error fetching air quality data', error);
        }
      });
    }
  </script>
  <style>
    .card-body {
      background-color: #FBFBFB;
    }

    .main-panel {
      overflow: hidden; /* 불필요한 스크롤 제거 */
    }

    .card-myPlant {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 100%;
      text-align: center;
    }

    .jumbotron {
      position: relative;
      background: none;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      margin-bottom: 0;
    }

    .jumbotron img {
      width: 100%;
      height: auto;
    }

    .jumbotron-container {
      background-color: #FBFBFB;
      /* Change this to your desired background color */
      padding: 0;
      margin: 0;
      width: 100%;
    }

    .content-wrapper {
      background: #fff;
      padding: 0;
    }

    .bd-placeholder-img {
      width: 100%;
      height: 200px; /* Fixed height for the image */
      object-fit: cover; /* Cover the area, cropping if necessary */
    }

    .card-title {
      padding: 5px;
      white-space: nowrap; /* Prevent wrapping */
      overflow: hidden; /* Hide overflow */
      text-overflow: ellipsis; /* Show ellipsis (...) */
    }

    .card-myPlant img {
      width: 100%;
      height: auto;
      max-width: 150px; /* 최대 너비 설정 */
    }

    .card-myPlant {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 300px; /* 원하는 높이로 설정 */
      width: 300px; /* 원하는 너비로 설정 */
      border-radius: 50%; /* 원형으로 만들기 */
      overflow: hidden; /* 자식 요소가 컨테이너 밖으로 나가지 않도록 */
      text-align: center;
      background-color: #FBFBFB; /* 원형 컨테이너의 배경색 */
      border: 1px solid #00A06C; /* 테두리 색상과 두께 설정 */
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
    }

    .container-row {
      display: flex;
      flex-wrap: nowrap; /* 줄바꿈을 없앱니다. */
    }

    .container-column {
      flex: 1;
      padding: 10px;
    }

    .chart-container {
      width: 100%; /* Full width */
      max-width: 800px; /* 적절한 최대 너비 설정 */
      height: auto; /* 자동 높이 */
      margin: 0 auto; /* 가운데 정렬 */
      padding-bottom: 20px; /* 아래에 패딩 추가 */
    }

    #airQualityChart {
      width: 100% !important; /* Full width */
      height: 400px !important; /* 적절한 높이 설정 */
    }

    body {
      margin-bottom: 100px; /* 아래쪽에 여백 추가 */
    }
  </style>
</head>

<body>
  <!-- 퀘스트사이드바 -->

  <!-- 퀘스트사이드바 -->
  <!-- partial -->

  <div class="main-panel">
    <div class="jumbotron">
      <div class="container ">
        <img src="/images/wewujumbo.jpg" alt="Background Image">
      </div>
    </div>
    <div class="container ranking">
      <div class="content-wrapper">
        <div class="row">
          <div class="col-md-8">
            <div class="justify-content-end d-flex">
              <div class="swiper-container ranking">
                <div class="swiper-wrapper groupRanking">
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="container">
        <div class="row mx-auto">
          <div class="col-md-8 grid-margin stretch-card">
            <div class="container" style=" height: auto;">
              <div id="naverMap">
                <c:import url="/active/map"></c:import>
              </div>
            </div>
          </div>
          <c:if test="${empty user}">
          <div class="card-myPlant">
           	<img src="/images/gogreen.png">
           	</div>
          </c:if>
          <c:if test="${!empty user}">
            <div class="col-md-4 grid-margin stretch-card">
              <div class="container">
                <div class="card-myPlant">
                  <P>나의 식물</P>
                  <img src="${myPlant.plantLevl.levlImg}" id="myPlantImg" style="display: block; margin: 0 auto;">
                  <p>${myPlant.plantLevl.plantLevl} 단계</p>
                  <p>" ${myPlant.myPlantName} "</p>
                  <p>현재경험치: ${myPlant.myPlantExp}</p>
                </div>
              </div>
            </div>
          </c:if>
        </div>
      </div>
      <!-- swiper -->
      <div class="container">
        <div class="row mx-auto">
          <div class="col-lg-12 slide">
            <h4 class="boardList"> 공지사항 </h4>
            <div class="swiper-container">
              <div class="swiper-wrapper boardListMain">
                <!-- Slides will be injected here by JavaScript -->
              </div>
              <div class="custom-swiper-button-next">
                <i class="fas fa-chevron-right custom-icon"></i>
              </div>
              <div class="custom-swiper-button-prev">
                <i class="fas fa-chevron-left custom-icon"></i>
              </div>
            </div>
          </div>
          <br>
          <br>
          <!-- content-wrapper ends -->
          <!-- main-panel ends -->
        </div>
      </div>
      <div class="container">
        <div class="row mx-auto">
          <div class="col-lg-12">
            <div class="container chart-container">
              <!-- 추가된 부분: 공기 질 데이터를 표시할 캔버스 -->
              <canvas id="airQualityChart"></canvas>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- footer.jsp -->
    <jsp:include page="footer.jsp" />
    <!-- footer.jsp -->
</body>

</html>