<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Image Popup</title>
</head>
<body>
  <div class="popup-content">
    <img src="https://via.placeholder.com/200x200" class="rounded mx-auto d-block" alt="Popup Image">
    <p>여기에 원하는 글씨를 입력하세요.</p>
  </div>
<form id="selectRandomPlantForm" method="post" action="/plant/selectRandomPlant">
     <input type="hidden" name="plantNo" value="1">
     <button type="submit">Select Random Plant</button>
</form>
</body>
</html>