<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
          <!-- NAVI -->
          <div class="navibotton text-center">
            <button type="button" class="btn btn-warning btn-rounded btn-fw">나의식물</button>
            <button type="button" class="btn btn-danger btn-rounded btn-fw">인벤토리</button>
            <button type="button" class="btn btn-success btn-rounded btn-fw">HISTORY</button>
          </div>
          <br>
          <br>
          <br>
          <div class="container text-center">
            <div class="row justify-content-center mt-5">
              <div class="col-lg-10 grid-margin stretch-card">
			  <div class="card mx-auto">
                <div class="card-body">
                  <h4 class="card-title">Hoverable Table</h4>
                  <p class="card-description">
                    Add class <code>.table-hover</code>
                  </p>
                  <div class="table-responsive">
                    <table class="table table-hover">
                      <thead>
                        <tr>
                          <th>종류</th>
                          <th>효과</th>
                          <th>수량</th>
                          <th>사용하기</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>${inventory.itemType}</td>
                          <td>${inventory.itemExp}</td>
                          <td>${inventory.itemNum}</td>
                          <td>
							<input type="number" class="form-control" name="useItem">
						  </td>
						  <td>
						  <button type="button" class="btn btn-outline-warning btn-fw">사용</button>
						  </td>                        
                        </tr>
                      </tbody>
                    </table>
                  </div>
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