<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>UpdateQuest</title>
  <style>
    /* h1 요소에 앞 여백 추가 */
    .custom-title-space {
      padding-left: 20px;
      /* 20px의 왼쪽 여백을 설정 */
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script>
      $(function () {
      $("button[name='cancel']").on("click", function () {
        $("form")[0].reset();
      });
    });
  </script>

<body>
  <jsp:include page="/header.jsp" flush="true" />
  <jsp:include page="/plant/plantSide.jsp" />
  <div class="main-panel">
    <div class="content-wrapper">
      <form name = "addQuest">
        <div class="row mt-5">
          <div class="col-lg-6 grid-margin stretch-card mx-auto">
            <div class="card">
              <div class="card-body">
                <h4 class="card-title">퀘스트 수정</h4>
                <p class="card-description">Basic form elements</p>
                <div class="form-group">
                <input type="hidden" name="questNo" value="${quest.questNo}">
                  <label for="questContents">Quest Contents ( 퀘스트 내용)</label>
                  <input type="text" class="form-control" name="questContents" value="${quest.questContents}" placeholder="${quest.questContents}">
                </div>
                <div class="form-group">
                  <label for="questTarget">Quest Target ( 퀘스트 목표 )</label>
                  <input type="text" class="form-control" name="questTarget" value="${quest.questTarget}" placeholder="${quest.questTarget}">
                </div>
                <div class="form-group">
                  <label for="questReward">Quest Reward ( 퀘스트 보상 )</label>
                  <input type="text" class="form-control" name="questReward" value="${quest.questReward}" placeholder="${quest.questReward}">
                </div>
                <div class="form-group">
                  <label for="questState">Quest Count ( 퀘스트 목표치)</label>
                  <input type="text" class="form-control" name="questState" value="${quest.questTargetCnt}" placeholder="${quest.questTargetCnt}">
                </div>
                <input type="submit" class="btn btn-primary mr-2" value="수정">
                <button type="button" class="btn btn-light" name="cancel">취소</button>
              </div>
            </div>
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