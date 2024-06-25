<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=a75e5c0t0u&submodules=geocoder"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
    <form>
        <label for="postcode">우편번호</label>
        <input type="text" id="postcode" name="postcode" readonly>
        <button type="button" id="find-postcode" onclick="execDaumPostcode()">우편번호 찾기</button>
        <br>
        <label for="address">주소</label>
        <input type="text" id="address" name="address" readonly>
        <br>
        <label for="address_detail">상세주소</label>
        <input type="text" id="address_detail" name="address_detail">
        <br>
        <label for="reference">참고항목</label>
        <input type="text" id="reference" name="reference">
        <br>
        <button type="submit">회원가입</button>
    </form>

    <script>
        // 네이버 지도 API를 사용한 주소 찾기
        $(document).ready(function(){
            $('#find-zipcode').click(function(){
                var addressQuery = prompt("주소를 입력하세요:");
                if(addressQuery) {
                    naver.maps.Service.geocode({
                        query: addressQuery
                    }, function(status, response) {
                        if (status !== naver.maps.Service.Status.OK) {
                            return alert('Something wrong!');
                        }

                        var result = response.v2, // 검색 결과의 컨테이너
                            items = result.addresses; // 검색 결과의 배열

                        if (items.length > 0) {
                            var addressData = items[0];
                            $('#postcode').val(addressData.addressElements.find(element => element.types.includes('POSTAL_CODE')).longName);
                            $('#address').val(addressData.roadAddress);
                        } else {
                            alert("주소를 찾을 수 없습니다.");
                        }
                    });
                }
            });
        });

        // 다음 주소 API를 사용한 우편번호 찾기
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    var fullAddr = ''; // 최종 주소 변수
                    var extraAddr = ''; // 조합형 주소 변수

                    // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 도로명 주소 선택
                        fullAddr = data.roadAddress;
                    } else { // 지번 주소 선택
                        fullAddr = data.jibunAddress;
                    }

                    // 도로명 타입일 때 조합한다.
                    if(data.userSelectedType === 'R'){
                        if(data.bname !== ''){
                            extraAddr += data.bname;
                        }
                        if(data.buildingName !== ''){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('postcode').value = data.zonecode; // 5자리 새우편번호 사용
                    document.getElementById('address').value = fullAddr;

                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById('address_detail').focus();
                },
                theme: {
                    bgColor: "#ECECEC", // 바탕 배경색
                    searchBgColor: "#0B65C8", // 검색창 배경색
                    contentBgColor: "#FFFFFF", // 본문 배경색
                    pageBgColor: "#FAFAFA", // 페이지 배경색
                    textColor: "#333333", // 기본 글자색
                    queryTextColor: "#FFFFFF", // 검색창 글자색
                    postcodeTextColor: "#FA4256", // 우편번호 글자색
                    emphTextColor: "#008BD3", // 강조 글자색
                    outlineColor: "#E0E0E0" // 테두리
                }
            }).open();
        }
    </script>
</body>
</html>
