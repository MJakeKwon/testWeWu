<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>AddPlant</title>
  <style>
    /* h1 요소에 앞 여백 추가 */
    .custom-title-space {
      padding-left: 20px;
      /* 20px의 왼쪽 여백을 설정 */
    }
    .flex-container {
      display: flex;
      gap: 20px;
      /* 요소 사이의 간격을 설정 */
      justify-content: center;
      /* 수평 가운데 정렬 */
      align-items: center;
      /* 수직 가운데 정렬 */
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script>
    $(document).ready(function () {
      $('.file-upload-browse').on('click', function () {
        var file = $(this).closest('.input-group').prev('.file-upload-default');
        file.trigger('click');
      });

      $('.file-upload-default').on('change', function () {
        var fileName = $(this).val().replace(/C:\\fakepath\\/i, '');
        $(this).next('.input-group').find('.file-upload-info').val(fileName);
      });
    });

    $(function () {
      $("button[name='cancel']").on("click", function () {
        $("form")[0].reset();
      });
    });
  </script>
</head>

<body>
  <jsp:include page="/header.jsp" flush="true" />
  <jsp:include page="/plant/plantSide.jsp" />

  <div class="main-panel">
    <div class="content-wrapper title-card">
      <form name="addPlant">
        <div class="flex-container">
          <div class="col-lg-2 grid-margin stretch-card">
            <div class="card">
              <div class="card-body">
              	<h5>식물 수정</h5>
                <h4 class="card-title">1단계</h4>
                <p class="card-description">Basic form elements</p>
                <div class="form-group">
                  <label for="plantName">식물이름</label> <input type="text" class="form-control" name="plantName"
                    id="plantName" placeholder="plantName">
                </div>
                <div class="form-group">
                  <label for="plantMinExp">최소경험치</label> <input type="number" class="form-control" name="plantMinExp"
                    id="plantMinExp" placeholder="plantMinExp">
                </div>
                <div class="form-group">
                  <label for="plantMinExp">최대경험치</label> <input type="number" class="form-control" name="plantMaxExp"
                    id="plantMaxExp" placeholder="plantMaxExp">
                </div>
                <div class="form-group">
                  <label for="plantLevl">식물단계</label> <input type="text" class="form-control" name="plantLevl"
                    id="plantLevl" placeholder="plantLevl">
                </div>
                <div class="form-group">
                  <label for="plantFinalLevl">식물최종단계</label> <input type="text" class="form-control"
                    name="plantFinalLevl" id="plantFinalLevl" placeholder="plantFinalLevl">
                </div>
                <div class="form-group">
                  <label>식물단계이미지</label> <input type="file" name="img[]" class="file-upload-default">
                  <div class="input-group col-xs-12">
                    <input type="text" class="form-control file-upload-info" disabled placeholder="Upload Image">
                    <span class="input-group-append">
                      <button class="file-upload-browse btn btn-primary" type="button">Upload</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-2 grid-margin stretch-card">
            <div class="card">
              <div class="card-body">
              <br>
                <h4 class="card-title">2단계</h4>
                <p class="card-description">Basic form elements</p>
                <div class="form-group">
                  <label for="questContents">식물이름</label> <input type="text" class="form-control" name="plantName"
                    id="plantName" placeholder=plantName>
                </div>
                <div class="form-group">
                  <label for="questTarget">최소경험치</label> <input type="number" class="form-control" name="plantMinExp"
                    id="plantMinExp" placeholder="plantMinExp">
                </div>
                <div class="form-group">
                  <label for="questReward">최대경험치</label> <input type="number" class="form-control" name="plantMaxExp"
                    id="plantMaxExp" placeholder="plantMaxExp">
                </div>
                <div class="form-group">
                  <label for="questState">식물단계</label> <input type="text" class="form-control" name="plantLevl"
                    id="plantLevl" placeholder="plantLevl">
                </div>
                <div class="form-group">
                  <label for="questState">식물최종단계</label> <input type="text" class="form-control" name="plantFinalLevl"
                    id="plantFinalLevl" placeholder="plantFinalLevl">
                </div>
                <div class="form-group">
                  <label>식물단계이미지</label> <input type="file" name="levlImg" class="file-upload-default">
                  <div class="input-group col-xs-12">
                    <input type="text" class="form-control file-upload-info" disabled placeholder="levlImg"> <span
                      class="input-group-append">
                      <button class="file-upload-browse btn btn-primary" type="button">Upload</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-2 grid-margin stretch-card">
            <div class="card">
              <div class="card-body">
               <br>
                <h4 class="card-title">3단계</h4>
                <p class="card-description">Basic form elements</p>
                <div class="form-group">
                  <label for="questContents">식물이름</label> <input type="text" class="form-control" name="plantName"
                    id="plantName" placeholder=plantName>
                </div>
                <div class="form-group">
                  <label for="questTarget">최소경험치</label> <input type="number" class="form-control" name="plantMinExp"
                    id="plantMinExp" placeholder="plantMinExp">
                </div>
                <div class="form-group">
                  <label for="questReward">최대경험치</label> <input type="number" class="form-control" name="plantMaxExp"
                    id="plantMaxExp" placeholder="plantMaxExp">
                </div>
                <div class="form-group">
                  <label for="questState">식물단계</label> <input type="text" class="form-control" name="plantLevl"
                    id="plantLevl" placeholder="plantLevl">
                </div>
                <div class="form-group">
                  <label for="questState">식물최종단계</label> <input type="text" class="form-control" name="plantFinalLevl"
                    id="plantFinalLevl" placeholder="plantFinalLevl">
                </div>
                <div class="form-group">
                  <label>식물단계이미지</label> <input type="file" name="levlImg" class="file-upload-default">
                  <div class="input-group col-xs-12">
                    <input type="text" class="form-control file-upload-info" disabled="" placeholder="levlImg"> <span
                      class="input-group-append">
                      <button class="file-upload-browse btn btn-primary" type="button">Upload</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-2 grid-margin stretch-card">
            <div class="card">
              <div class="card-body">
               <br>
                <h4 class="card-title">4단계</h4>
                <p class="card-description">Basic form elements</p>
                <div class="form-group">
                  <label for="questContents">식물이름</label> <input type="text" class="form-control" name="plantName"
                    id="plantName" placeholder=plantName>
                </div>
                <div class="form-group">
                  <label for="questTarget">최소경험치</label> <input type="number" class="form-control" name="plantMinExp"
                    id="plantMinExp" placeholder="plantMinExp">
                </div>
                <div class="form-group">
                  <label for="questReward">최대경험치</label> <input type="number" class="form-control" name="plantMaxExp"
                    id="plantMaxExp" placeholder="plantMaxExp">
                </div>
                <div class="form-group">
                  <label for="questState">식물단계</label> <input type="text" class="form-control" name="plantLevl"
                    id="plantLevl" placeholder="plantLevl">
                </div>
                <div class="form-group">
                  <label for="questState">식물최종단계</label> <input type="text" class="form-control" name="plantFinalLevl"
                    id="plantFinalLevl" placeholder="plantFinalLevl">
                </div>
                <div class="form-group">
                  <label>식물단계이미지</label> <input type="file" name="levlImg" class="file-upload-default">
                  <div class="input-group col-xs-12">
                    <input type="text" class="form-control file-upload-info" disabled="" placeholder="levlImg"> <span
                      class="input-group-append">
                      <button class="file-upload-browse btn btn-primary" type="button">Upload</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-2 grid-margin stretch-card">
            <div class="card">
              <div class="card-body">
               <br>
                <h4 class="card-title">5단계</h4>
                <p class="card-description">Basic form elements</p>
                <div class="form-group">
                  <label for="questContents">식물이름</label> <input type="text" class="form-control" name="plantName"
                    id="plantName" placeholder=plantName>
                </div>
                <div class="form-group">
                  <label for="questTarget">최소경험치</label> <input type="number" class="form-control" name="plantMinExp"
                    id="plantMinExp" placeholder="plantMinExp">
                </div>
                <div class="form-group">
                  <label for="questReward">최대경험치</label> <input type="number" class="form-control" name="plantMaxExp"
                    id="plantMaxExp" placeholder="plantMaxExp">
                </div>
                <div class="form-group">
                  <label for="questState">식물단계</label> <input type="text" class="form-control" name="plantLevl"
                    id="plantLevl" placeholder="plantLevl">
                </div>
                <div class="form-group">
                  <label for="questState">식물최종단계</label> <input type="text" class="form-control" name="plantFinalLevl"
                    id="plantFinalLevl" placeholder="plantFinalLevl">
                </div>
                <div class="form-group">
                  <label>식물단계이미지</label> <input type="file" name="levlImg" class="file-upload-default">
                  <div class="input-group col-xs-12">
                    <input type="text" class="form-control file-upload-info" disabled="" placeholder="levlImg"> <span
                      class="input-group-append">
                      <button class="file-upload-browse btn btn-primary" type="button">Upload</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="container">
          <div class="d-flex justify-content-center mb-5">
            <input type="submit" class="btn btn-primary mr-2" value="수정">
            <button type = "button" class="btn btn-white" name="cancel">취소</button>
          </div>
        </div>
      </form>
    </div>
  </div>
  <!-- FOOTER -->
  <jsp:include page="/footer.jsp" />
  <!-- FOOTER -->
</body>

</html>