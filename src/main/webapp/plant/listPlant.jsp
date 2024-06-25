<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>List Plant</title>
  
  <style>
    .table-container {
      max-height: 600px; /* 원하는 높이 설정 */
      overflow-y: auto;
    }
    
    .table-container::-webkit-scrollbar {
      width: 12px;  /* 스크롤바의 너비 */
    }
    .table-container::-webkit-scrollbar-thumb {
      height: 30%; /* 스크롤바의 길이 */
      background: #4B49AC; /* 스크롤바의 색상 */
      border-radius: 10px;
    }
    .table-container::-webkit-scrollbar-track {
      background: rgba(33, 122, 244, .1);  /*스크롤바 뒷 배경 색상*/
    }
  </style>
</head>
<body>
  <jsp:include page="/header.jsp" flush="true" />
  <jsp:include page="/plant/plantSide.jsp" />
  <div class="main-panel">
    <div class="content-wrapper">
      <div class="row mt-5">
        <div class="col-lg-12 grid-margin stretch-card mx-auto">
          <div class="card">
            <div class="card-body">
              <h4 class="card-title">List Plant</h4>
              <p class="card-description">
                Add class <code>.table-striped</code>
              </p>
              <div class="table-container">
                <table class="table table-striped">
                  <thead>
                    <tr>
                      <th>Plant No</th>
                      <th>Plant Name</th>
                      <th>Plant Level</th>
                      <th>Plant Max Exp</th>
                      <th>Plant Min Exp</th>
                      <th>Plant Final Level</th>
                      <th>Plant Image</th>
                      <th></th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="plant" items="${map.list}" varStatus="status">
                      <tr>
                        <td>${plant.plantNo}</td>
                        <td>${plant.plantName}</td>
                        <td>${plant.plantLevl.plantLevl}</td>
                        <td>${plant.plantLevl.plantMaxExp}</td>
                        <td>${plant.plantLevl.plantMinExp}</td>
                        <td>${plant.plantLevl.plantFinalLevl}</td>
                        <td>${plant.plantLevl.levlImg}</td>
                        <td>
                        	<a href = "/plant/updatePlant" type = "button" class="badge badge-success">수정</a>
                        </td>
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
 
  <!-- FOOTER -->
  <jsp:include page="/footer.jsp" />
  <!-- FOOTER -->
</body>
</html>
