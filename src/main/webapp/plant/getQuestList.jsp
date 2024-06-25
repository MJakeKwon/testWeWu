<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<script>
function getQuestList(){
	
	$.ajax({
		url : "/app/plant/getQuestList",
		type : "POST",
		data : JSON,stringify({
			questNo:'${questNo}'
		}),
		contentType : "application/json",
		dataType : "json",
		success : function () {
			퀘스트완료된퀘스트는 밑으로 내린다음 줄긋기로 마무
		},
			
		error: function (xhr, status, error) {
		         // 응답을 받지 못하거나, 정상 응답이지만 데이터 형식을 확인할 수 없는 경우
	    },
	    complete: function (xhr, status) {
	        // success와 error 콜백이 호출된 후에 반드시 호출, finally 구문과 동일
	    }
	}
	});
}
</script>
</head>
<body>
      <div id="right-sidebar" class="settings-panel">
        <i class="settings-close ti-close"></i>
        <ul class="nav nav-tabs border-top" id="setting-panel" role="tablist">
          <li class="nav-item">
            <a class="nav-link active" id="todo-tab" data-toggle="tab" href="#todo-section" role="tab" aria-controls="todo-section" aria-expanded="true">Quest</a>
          </li>
        </ul>
        <div class="tab-content" id="setting-content">
          <div class="tab-pane fade show active scroll-wrapper" id="todo-section" role="tabpanel" aria-labelledby="todo-section">
            <h4 class="px-5 text-muted mt-5 font-weight-light mb-0">Quest</h4>
            <c:forEach var="quest" items="${map.list}">
            <div class="events pt-4 px-3">
              <div class="wrapper d-flex mb-2">
                <i class="ti-control-record text-primary mr-2"></i>
                <span>${quest.regDate}</span>
              </div>
              <p class="mb-0 font-weight-thin text-gray">${quest.questContents}</p>
              <p class="text-gray mb-0"></p>
              <c:if test = "${quest.questState eq 'N'}">퀘스트완료</c:if>
              <c:if test = "${quest.questState eq 'Y'}">진행중</c:if>             
            </div>
            </c:forEach>
          </div>
          <!-- To do section tab ends -->
        </div>
      </div>
</body>
</html>