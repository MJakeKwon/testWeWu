<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">

<title>모임 활동 지도</title>
<!-- 필요한 메타 데이터 및 CSS/JS 링크 포함 -->
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=${clientId}&submodules=panorama,geocoder"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/vendors/mdi/css/materialdesignicons.min.css">
<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
<link rel="stylesheet" href="/css/datepicker.css">

<style>

	.btn_mylct i {
        font-size: 50px; /* 아이콘 크기를 키웁니다 */
    }
    
    .text-center {
        text-align: center;
    }

    #map {
        width: 100%;
        height: 500px;
    }
    
    .search { position:absolute;z-index:1000;top:20px;left:20px; }
	.search #address { width:150px;height:20px;line-height:20px;border:solid 1px #555;padding:5px;font-size:12px;box-sizing:content-box; }
	.search #searchBtn { height:30px;line-height:30px;padding:0 10px;font-size:12px;border:solid 1px #555;border-radius:3px;cursor:pointer;box-sizing:content-box; }
    
</style>

</head>
<body>

	<!-- HEADER -->
	<jsp:include page="/header.jsp"/>
	<!-- HEADER -->

	<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
	<script type="text/javascript">
	
	$.datepicker.setDefaults({
		dateFormat: 'yy-mm-dd',
		prevText: '이전 달',
		nextText: '다음 달',
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear: true,
		yearSuffix: '년'
	});
	
	$(function () {
		$('.datepicker').datepicker({
		});
	});
	
	$(document).ready(function() {
		
		var location;
		
		var activeMarker = null;
		
		//$('.time').val(new Date().toISOString().slice(11, 16));
		
		var map_x = ${active.activeX};
		var map_y = ${active.activeY};
	
		var map = new naver.maps.Map("map", {
		    center: new naver.maps.LatLng(map_x, map_y),
		    zoom: 15,
		    mapTypeControl: true
		});
		
		var markerOptions = {
		    position: new naver.maps.LatLng(map_x, map_y),
		    map: map,
		    icon: {
		        url: '${active.activeShortUrl}',
		        size: new naver.maps.Size(50, 50), // 원래 이미지 크기
		        scaledSize: new naver.maps.Size(50, 50), // 조정된 이미지 크기
		        origin: new naver.maps.Point(0, 0), // 이미지의 원점
		        anchor: new naver.maps.Point(25, 50) // 마커 이미지의 앵커 포인트
		    }
		};
		
		activeMarker = new naver.maps.Marker(markerOptions);
		
		var locationBtnHtml = '<a href="#" class="btn_mylct"><i class="mdi mdi-target"></i></a>';
		//var map = new naver.maps.Map('map', {zoom: 13});
		
		naver.maps.Event.once(map, 'init', function() {
		    //customControl 객체 이용하기
		    /* var customControl = new naver.maps.CustomControl(locationBtnHtml, {
		        position: naver.maps.Position.TOP_LEFT
		    });
	
		    customControl.setMap(map); */
	
		    /* naver.maps.Event.addDOMListener(customControl.getElement(), 'click', function() {
		        map.setCenter(new naver.maps.LatLng(37.3595953, 127.1053971));
		    }); */
	
		    //Map 객체의 controls 활용하기
		    var $locationBtn = $(locationBtnHtml),
		        locationBtnEl = $locationBtn[0];
	
		    map.controls[naver.maps.Position.RIGHT_BOTTOM].push(locationBtnEl);
	
		    naver.maps.Event.addDOMListener(locationBtnEl, 'click', function() {
		    	var markerLocation = new naver.maps.LatLng(map_x,map_y);
		    	
		    	if(activeMarker) {
		    		activeMarker.setMap(null);
		        }
		    	
		    	var markerOptions = {
	    		    position: new naver.maps.LatLng(map_x,map_y),
	    		    map: map,
	    		    icon: {
	    		        url: '${active.activeShortUrl}',
	    		        size: new naver.maps.Size(50, 50), // 원래 이미지 크기
	    		        scaledSize: new naver.maps.Size(50, 50), // 조정된 이미지 크기
	    		        origin: new naver.maps.Point(0, 0), // 이미지의 원점
	    		        anchor: new naver.maps.Point(25, 50) // 마커 이미지의 앵커 포인트
	    		    }
	    		};
		    	
		    	$('.activeX').val('${active.activeX}');
		    	$('.activeY').val('${active.activeY}');
		    	$('.activeLocal').val('${active.activeLocal}');
		    	
		    	console.log('activeX: ' + $('.activeX').val());
		        console.log('activeY: ' + $('.activeY').val());
		        console.log('activeLocal: ' + $('.activeLocal').val());
	    		
	    		activeMarker = new naver.maps.Marker(markerOptions);
		    	
		    	map.setCenter(markerLocation);
		    });
		});
	
		var infoWindow = new naver.maps.InfoWindow({
		    anchorSkew: true
		});
	
		map.setCursor('pointer');
	
		/* function searchCoordinateToAddress(latlng) {
	
		    //infoWindow.close();
	
		    /* naver.maps.Service.reverseGeocode({
		        coords: latlng,
		        orders: [
		            naver.maps.Service.OrderType.ADDR,
		            naver.maps.Service.OrderType.ROAD_ADDR
		        ].join(',')
		    }, function(status, response) {
		        if (status === naver.maps.Service.Status.ERROR) {
		            return alert('Something Wrong!');
		        }
	
		        var items = response.v2.results,
		            address = '',
		            htmlAddresses = [];
	
		        for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
		            item = items[i];
		            address = makeAddress(item) || '';
		            addrType = item.name === 'roadaddr' ? '[도로명 주소]' : '[지번 주소]';
	
		            htmlAddresses.push((i+1) +'. '+ addrType +' '+ address);
		        } */
	
		        /* infoWindow.setContent([
		            '<div style="padding:10px;min-width:200px;line-height:150%;">',
		            '<h4 style="margin-top:5px;">검색 좌표</h4><br />',
		            htmlAddresses.join('<br />'),
		            '</div>'
		        ].join('\n')); */
	
		        //infoWindow.open(map, latlng);
		    //});
		//} */
	
		async function searchAddressToCoordinate(address) {
			
			var url = 'http://localhost:8080/app/active/searchLocal?query=' + address;
			
			var local;
			
			await $.ajax({
				url: url,
				method: 'GET',
				success: function(response) {
					
					console.log(response);
					//console.log(response.mapX);
					//console.log(response.address);
					
					local = response.address;
					
					//var point = new naver.maps.Point(response.mapX, response.mapY);
					
					//map.setCenter(point);
					
				},
			    error: function(xhr, status, error) {
			        // 서버 목록을 가져오는 데 실패했을 때의 처리
			        console.error('Failed to fetch server list:', error);
			    }
			});
			
		    naver.maps.Service.geocode({
		        query: local
		    }, function(status, response) {
		    	
		        /* if (status === naver.maps.Service.Status.ERROR) {
		            return alert('Something Wrong!');
		        }
	
		        if (response.v2.meta.totalCount === 0) {
		            return alert('totalCount' + response.v2.meta.totalCount);
		        } */
	
		        var htmlAddresses = [],
		            item = response.v2.addresses[0],
		            point = new naver.maps.Point(item.x, item.y);
	
		        if (item.roadAddress) {
		            htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
		        }
	
		        if (item.jibunAddress) {
		            htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
		        }
	
		        if (item.englishAddress) {
		            htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
		        }
	
		        map.setCenter(point);
		        //infoWindow.open(map, point);
		    });
		    
		}
	
		function initGeocoder() {
			
			var latlng = map.getCenter();
		    var utmk = naver.maps.TransCoord.fromLatLngToUTMK(latlng); // 위/경도 -> UTMK
		    var tm128 = naver.maps.TransCoord.fromUTMKToTM128(utmk);   // UTMK -> TM128
		    var naverCoord = naver.maps.TransCoord.fromTM128ToNaver(tm128); // TM128 -> NAVER
		    
		    map.addListener('click', function(e) {
		        var latlng = e.coord,
		            utmk = naver.maps.TransCoord.fromLatLngToUTMK(latlng),
		            tm128 = naver.maps.TransCoord.fromUTMKToTM128(utmk),
		            naverCoord = naver.maps.TransCoord.fromTM128ToNaver(tm128);
	
		        utmk.x = parseFloat(utmk.x.toFixed(1));
		        utmk.y = parseFloat(utmk.y.toFixed(1));
		        
		        console.clear();
		        
		        naver.maps.Service.reverseGeocode({
			        coords: latlng,
			        orders: naver.maps.Service.OrderType.ADDR
			    }, function(status, response) {
			        if (status === naver.maps.Service.Status.ERROR) {
			            return alert('Something Wrong!');
			        }
	
			        var items = response.v2.results,
			            address = '',
			            htmlAddresses = [];
	
			        for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
			            item = items[i];
			            address = makeAddress(item);
			            //addrType = item.name === 'roadaddr' ? '[도로명 주소]' : '[지번 주소]';
	
			            //htmlAddresses.push((i+1) +'. '+ addrType +' '+ address);
			        }
			        
			        console.log(address);
			        
			        $('.activeLocal').val(address);
			        
			        
	
			        //infoWindow.open(map, latlng);
			    });
		        
		        if(activeMarker) {
		    		activeMarker.setMap(null);
		        }
		        
		        var markerOptions = {
	    		    position: latlng,
	    		    map: map,
	    		    icon: {
	    		        url: '${active.activeShortUrl}',
	    		        size: new naver.maps.Size(50, 50), // 원래 이미지 크기
	    		        scaledSize: new naver.maps.Size(50, 50), // 조정된 이미지 크기
	    		        origin: new naver.maps.Point(0, 0), // 이미지의 원점
	    		        anchor: new naver.maps.Point(25, 50) // 마커 이미지의 앵커 포인트
	    		    }
	    		};
	    		
	    		activeMarker = new naver.maps.Marker(markerOptions);
		        
		        
		        
		        console.log('LatLng: ' + latlng.toString());
		        console.log('UTMK: ' + utmk.toString());
		        console.log('TM128: ' + tm128.toString());
		        console.log('NAVER: ' + naverCoord.toString());
		        
		        $('.activeX').val(latlng.lat());
		        $('.activeY').val(latlng.lng());
		        
		        console.log('activeX: ' + $('.activeX').val());
		        console.log('activeY: ' + $('.activeY').val());
		        console.log('activeLocal: ' + $('.activeLocal').val());
		        
		        
		    });
	
		    $('#address').on('keydown', function(e) {
		        var keyCode = e.which;
	
		        if (keyCode === 13) { // Enter Key
		        	
		            searchAddressToCoordinate($('#address').val());
		        }
		    });
	
		    $('#searchBtn').on('click', function(e) {
		    	
		        e.preventDefault();
	
		        searchAddressToCoordinate($('#address').val());
		    });
			
		    if (!navigator.geolocation) {
		    	searchAddressToCoordinate('강남');
		    }
		    
		}
	
		function makeAddress(item) {
		    if (!item) {
		        return;
		    }
	
		    var name = item.name,
		        region = item.region,
		        land = item.land,
		        isRoadAddress = name === 'roadaddr';
	
		    var sido = '', sigugun = '', dongmyun = '', ri = '', rest = '';
	
		    if (hasArea(region.area1)) {
		        sido = region.area1.name;
		    }
	
		    if (hasArea(region.area2)) {
		        sigugun = region.area2.name;
		    }
	
		    if (hasArea(region.area3)) {
		        dongmyun = region.area3.name;
		    }
	
		    if (hasArea(region.area4)) {
		        ri = region.area4.name;
		    }
	
		    if (land) {
		        if (hasData(land.number1)) {
		            if (hasData(land.type) && land.type === '2') {
		                rest += '산';
		            }
	
		            rest += land.number1;
	
		            if (hasData(land.number2)) {
		                rest += ('-' + land.number2);
		            }
		        }
	
		        if (isRoadAddress === true) {
		            if (checkLastString(dongmyun, '면')) {
		                ri = land.name;
		            } else {
		                dongmyun = land.name;
		                ri = '';
		            }
	
		            if (hasAddition(land.addition0)) {
		                rest += ' ' + land.addition0.value;
		            }
		        }
		    }
	
		    //return [sido, sigugun, dongmyun, ri, rest].join(' ');
		    return sigugun;
		}
	
		function hasArea(area) {
		    return !!(area && area.name && area.name !== '');
		}
	
		function hasData(data) {
		    return !!(data && data !== '');
		}
	
		function checkLastString (word, lastString) {
		    return new RegExp(lastString + '$').test(word);
		}
	
		function hasAddition (addition) {
		    return !!(addition && addition.value);
		}
	
		naver.maps.onJSContentLoaded = initGeocoder;
	    
	});
	
	</script>
	
	<!-- SIDE -->
	<jsp:include page="/activeSide.jsp"></jsp:include>
	<!-- SIDE -->
	
	<div class="main-panel">
	
       	<div class="content-wrapper">
       	
       		<form class="update-form" id="updateForm" encType="multipart/form-data" >
       		
	       		<div class="row" >
	       		
	       			<div class="col-md-12 grid-margin" >
	       				<h4>활동 수정하기</h4>
	       			</div>
	       			
					<div class="col-md-5 grid-margin" >
					
						<div class="row">
						
							<div class="col-md-6 grid-margin" >
								<div class="form-group">
			                      <label>활동 이름</label>
			                      <input type="text" name="activeName" class="form-control" value="${active.activeName}" placeholder="활동 이름">
			                      <input type="hidden" name="activeNo" value="${active.activeNo}">
			                      <input type="hidden" name="groupNo" value="${active.groupNo}" >
			                      <input type="hidden" class="activeLocal" name="activeLocal" value="${active.activeLocal}" >
			                      <input type="hidden" class="activeX" name="activeX" value="${active.activeX}" >
			                      <input type="hidden" class="activeY" name="activeY" value="${active.activeY}" >
			                    </div>
		                    </div>
		                    <div class="col-md-5 grid-margin" >
			                    <div class="form-group">
			                      <label>그룹장 닉네임</label>
			                      <input type="text" name="leaderNick" disabled="disabled" class="form-control" value="${active.leaderNick}">
			                    </div>
			               	</div>
			               	
	                    </div>
	                    
	                    <div class="form-group">
	                    	
	                   		<label>모임시간</label>
	                   		
	                   		<div class="row">
	                   		
	                    		<div class="col-md-5 grid-margin" >
	                    			<input type="time" name="activeStartTime" class="time form-control" value="${active.activeStartTime}" >
	                    		</div>
	                    		<div class="col-md-1 grid-margin" >
	                    			<br/>
	                    			<span style="display: flex; justify-content: center; align-items: center;" >~</span>
	                    		</div>
	                    		<div class="col-md-5 grid-margin" >
	                    			<input type="time" name="activeEndTime" class="time form-control" value="${active.activeEndTime}" >
	                    		</div>
	                    		
	                   		</div>
	                   		
	                   		<div class="row">
	                   		
	                    		<div class="col-md-6 grid-margin" >
	                    			<label>활동 시작일</label>
	                    			<input type="text" name="activeStartDate" class="datepicker form-control" value="${active.activeStartDate}" placeholder="활동 시작일" >
	                    		</div>
	                    		<div class="col-md-6 grid-margin" >
	                    			<label>활동 종료일</label>
	                    			<input type="text" name="activeEndDate" class="datepicker form-control" value="${active.activeEndDate}" placeholder="활동 종료일" >
	                    		</div>
	                    		
	                   		</div>
	                   		
	                   		
	                      
	                    </div>
	                    
					</div>
					
					<div class="col-md-7 grid-margin" >
						<div class="row">
						
							<div id="map">
							    <div class="search" style="">
							        <input id="address" type="text" placeholder="검색할 주소" value="강남" />
							        <input id="searchBtn" type="button" value="주소 검색" />
							    </div>
							</div>
						
						</div>
						
						<div class="row">
							<button type="button" onclick="upload()" class="upload-btn btn btn-outline-danger btn-icon-text">
		                      <i class="ti-upload btn-icon-prepend"></i>                                                    
		                      변경할 마커 사진 upload
		                    </button>
		                    <input class="file" type="file" hidden="true" name="file" accept=".jpg,.jpeg,.png,.gif" >
						</div>
						
						<script type="text/javascript">
						
							function upload() {
								
								$('.file').click();
								
							};
							
							$('.file').on('change', function() {
							
								if($('.file').val() != null || $('.file').val() != '') {
									
									$('.upload-btn').html('<i class="ti-upload btn-icon-prepend"></i>'+$('.file').val());
									
								}else {
									$('.upload-btn').html('변경할 마커 사진 upload');
								}
								
							});
							
						
						</script>
					
					</div>
					
					<div class="col-md-12 grid-margin" >
					
						<div class="row">
	                   		
	                   				<div class="col-md-6 grid-margin" >
			                   			<label>해쉬 태그</label>
			                      		<input type="hidden" name="hash" class="form-control hash" placeholder="해쉬 태그">
		                      		</div>
	                      		
	                   		</div>
	                   		
	                   		<div class="row">
	                   			<c:set var="i" value="1" ></c:set>
	                   			<c:if test="${active.hashList.size() != 0}">
	                   			<c:forEach var="hash" items="${active.hashList}">
	                   				<div class="col-md-2 grid-margin" >
		                   				<input id="hash${i}" type="text" value="${hash.hashName}" class="form-control" >
		                   			</div>
		                   		<c:set var="i" value="${i + 1}" ></c:set>
	                   			</c:forEach>
	                   			</c:if>
	                   			
	                   			<c:forEach begin="${i}" end="5" >
	                   				<div class="col-md-2 grid-margin" >
		                   				<input id="hash${i}" type="text" class="form-control" >
		                   			</div>
		                   		<c:set var="i" value="${i + 1}" ></c:set>
	                   			</c:forEach>
	               			</div>
	                      	
	                      	<div class="row">
	                      		<label>활동 코멘트</label>
	                      		<textarea name="activeInfo" class="form-control info" rows="10" placeholder="주의 사항이나 첨부링크를 자유롭게 작성해 주세요." ></textarea>
	                      	</div>
	                      	
	                      	<script type="text/javascript">
	                      	
	                      		var active_info = "${active.activeInfo}";
	                      		
	                      		console.log(active_info);
	                      	
	                      		$('.info').val(active_info);
	                      	
	                      	</script>
	                      	
	                      	<div class="row">
	                      		<button type="button" onclick="updateActive()" class="btn btn-primary btn-lg btn-block">
		                      		수정하기
			                    </button>
	                      	</div>
	                      	
	                      	<script type="text/javascript">
	                      	
		                      	//submit함수
		                    	function updateActive() {
		                    		
		                    		alert('수정');
		                    		
									var hashString = '';
		                    		
		                    		if($('.activeName').val() == ''){
		                    			alert('활동 이름을 입력해 주세요.');
		                    			return;
		                    		}
		                    		
		                    		if($('.activeX').val() == '' || $('.activeY').val() == ''){
		                    			alert('활동 마커를 지도에 찍어주세요.');
		                    			return;
		                    		}
		                    		
		                    		if($('.activeStartDate').val() == '' || $('.activeEndDate').val() == ''){
		                    			alert('활동 기간을 입력해 주세요.');
		                    			return;
		                    		}
		                    		
		                    		for(let i = 1; i <= 5; i++) {
		                    			
		                    			if(i == 1 && $('#hash'+i).val() != '') {
		                    				hashString += $('#hash'+i).val();
		                    				console.log($('#hash'+i).val());
		                    			}else if($('#hash'+i).val() != '') {
		                    				hashString += ',' + $('#hash'+i).val();
		                    				console.log($('#hash'+i).val());
		                    			}
		                    			
		                    		}
		                    		
		                    		console.log(hashString);
		                    		
		                    		$('.hash').val(hashString);
		                    		
		                    		var activeNo = ${active.activeNo};
		                    		
		                    		$('form').attr('method', 'post');
		                    		$('form').attr('action', '/active/updateActive');
		                    		
		                    		//document.getElementById("updateForm").submit();
		                    		$('#updateForm')[0].submit();
		                    		
		                    	}
	                      	
	                      	</script>
					
					</div>
					
				</div>
				
			</form>
			
       	</div>
       	
       	<!-- FOOTER -->
	    <jsp:include page="/footer.jsp" />
	    <!-- FOOTER -->
	    
	    <script type="text/javascript">
	    	$('footer').removeClass('fixed-bottom');
	    </script>
       	
    </div>

</body>
</html>
