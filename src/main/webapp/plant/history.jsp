<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="UTF-8">
     <style>
    /* input 필드의 너비를 조정 */
    .input-small {
      width: 40px;
    }
  </style>
  </head>
  <body>
    <!-- HEADER -->
    <jsp:include page="/header.jsp" />
    <!-- HEADER -->
    <form action="/plant/inventory" method="POST">
      <!-- GetMyPlant -->
        <div class="main-panel">
    <div class="content-wrapper">
      <div class="row mt-5">
        <div class="col-lg-10 grid-margin stretch-card mx-auto">
          <div class="card">
            <div class="card-body">
              <h4 class="card-title">HISTORY</h4>
              <p class="card-description">
                나의 식물들 
              </p>
              <div class="table-container">
                <table class="table table-striped">
                  <thead>
                    <tr>
                      <th>과거 나의 식물들</th>
                      <td>최신순 과거순 경험치 높은 순 경험치 낮은 순</td>
                    </tr>
                  </thead>
                  <tbody>
                      <tr>
                      </tr>
                      <c:forEach var="myPlant" items="${allList}" varStatus="status">
                      <tr class="plantName">
                        <c:if test="${myPlant.myPlantState eq 'N'}">
                          <td>${myPlant.plantLevl.levlImg}</td>
                          <td>${myPlant.plantLevl.levlImg}</td>
                          <td>${myPlant.plantLevl.levlImg}</td>
                          <td>${myPlant.plantLevl.levlImg}</td>
                          <td>${myPlant.plantLevl.levlImg}</td>
                        </c:if>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  </form>
    <!-- FOOTER -->
    <jsp:include page="/footer.jsp" />
    <!-- FOOTER -->
  </body>

  </html>