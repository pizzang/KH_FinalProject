<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>우리아파트 주변지도</title>
	<style>
		.wrap {width:100%;}
		#map{width:1000px;height:600px;margin:auto;}
		.chkoption{margin-left:100px; font-size: 18px;}
	</style>
</head>

<body>
	<jsp:include page="../common/header.jsp" />
	<br><br>
	<div class="wrap">
		<div id="map"></div>
		<p class="chkoption">
			<input style='zoom:1.5;' type="checkbox" id="chkBike" onclick="bikeMarkers();" /> 따릉이 정보 &nbsp; | &nbsp;
			<input style='zoom:1.5;' type="checkbox" id="chkPharm" onclick="pharmMarkers()" /> 약국 정보 &nbsp; | &nbsp;
			<input style='zoom:1.5;' type="checkbox" id="chkTraffic" onclick="setOverlayMapTypeId()" /> 교통 정보 &nbsp; | &nbsp;
			<input style='zoom:1.5;' type="checkbox" id="chkBicycle" onclick="setOverlayMapTypeId()" /> 자전거도로 정보
		</p>
		<jsp:include page="../common/footer.jsp" />
	</div>

		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d7a0d8fb50d86ba5e9d0d3d346e697ce">
		</script>
		<script>
			var container = document.getElementById('map');
			var mapOption = {
				center: new kakao.maps.LatLng(37.52446782011257, 126.8756965780569), // 지도의 중심좌표
				level: 3 // 지도의 확대 레벨
			};

			var map = new kakao.maps.Map(container, mapOption); // 지도를 생성합니다

			// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
			var mapTypeControl = new kakao.maps.MapTypeControl();

			// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
			// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
			map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
			var zoomControl = new kakao.maps.ZoomControl();
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

			var markersPharm = [];

			function setPharmMarkers(map) {
					for (var i = 0; i < markersPharm.length; i++) {
						markersPharm[i].setMap(map);
						}            
			}
			function pharmMarkers(){
				if(document.getElementById('chkPharm').checked){
					setPharmMarkers(map)    
				} else {
					setPharmMarkers(null);    
				}
			}
			
			var markersBike = [];

			function setBikeMarkers(map) {
					for (var i = 0; i < markersBike.length; i++) {
						markersBike[i].setMap(map);
						}            
			}
			function bikeMarkers(){
				if(document.getElementById('chkBike').checked){
					setBikeMarkers(map)    
				} else {
					setBikeMarkers(null);    
				}
			}


			// 지도 타입 정보를 가지고 있을 객체입니다
			// map.addOverlayMapTypeId 함수로 추가된 지도 타입은
			// 가장 나중에 추가된 지도 타입이 가장 앞에 표시됩니다
			// 이 예제에서는 지도 타입을 추가할 때 지적편집도, 지형정보, 교통정보, 자전거도로 정보 순으로 추가하므로
			// 자전거 도로 정보가 가장 앞에 표시됩니다
			var mapTypes = {
				traffic :  kakao.maps.MapTypeId.TRAFFIC,
				bicycle : kakao.maps.MapTypeId.BICYCLE,
			};

			// 체크 박스를 선택하면 호출되는 함수입니다
			function setOverlayMapTypeId() {
				var chkTraffic = document.getElementById('chkTraffic'),
					chkBicycle = document.getElementById('chkBicycle')
				
				
				// 지도 타입을 제거합니다
				for (var type in mapTypes) {
					map.removeOverlayMapTypeId(mapTypes[type]); 
				}
			
				// 교통정보 체크박스가 체크되어있으면 지도에 교통정보 지도타입을 추가합니다
				if (chkTraffic.checked) {
					map.addOverlayMapTypeId(mapTypes.traffic);    
				}
				
				// 자전거도로정보 체크박스가 체크되어있으면 지도에 자전거도로정보 지도타입을 추가합니다
				if (chkBicycle.checked) {
					map.addOverlayMapTypeId(mapTypes.bicycle);    
				}
				
			}
			

			var imageSrc = 'http://drive.google.com/uc?export=view&id=1jq8tnfKl2i3DKq2pKzBW3I3zgwTD9ES6', // 마커이미지의 주소입니다    
				imageSize = new kakao.maps.Size(70, 70) // 마커이미지의 크기입니다
				
			// 우리아파트 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize),
				markerPosition = new kakao.maps.LatLng(37.52633421714345, 126.87696052935834); // 마커가 표시될 위치입니다

			// 우리아파트 마커를 생성합니다
			var marker = new kakao.maps.Marker({
				position: markerPosition, 
				image: markerImage // 마커이미지 설정 

			});

			// 우리아파트 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);

			// 우리아파트 인포윈도우 내용
			var iwContent = '<div style="padding:5px;">'+ '우리아파트' +'</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

			// 우리아파트 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
				content : iwContent,
				removable : true
			});

			// 우리아파트 마커에 클릭이벤트를 등록합니다
			kakao.maps.event.addListener(marker, 'click', function() {
				// 우리아파트 마커 위에 인포윈도우를 표시합니다
				infowindow.open(map, marker);  
			});

			// 다각형을 구성하는 좌표 배열입니다. 이 좌표들을 이어서 다각형을 표시합니다 우리아파트 다각형위치
			var polygonPath = [
			new kakao.maps.LatLng(37.52598181550368, 126.87599385721951),
				new kakao.maps.LatLng(37.52751163059024, 126.87634203116995),
				new kakao.maps.LatLng(37.52725665109719, 126.87807900813584),
				new kakao.maps.LatLng(37.525990456715846, 126.87780107511111),
				new kakao.maps.LatLng(37.52571529710934, 126.87745931064488)
			];

			// 지도에 표시할 다각형을 생성합니다
			var polygon = new kakao.maps.Polygon({
				path:polygonPath, // 그려질 다각형의 좌표 배열입니다
				strokeWeight: 3, // 선의 두께입니다
				strokeColor: '#39DE2A', // 선의 색깔입니다
				strokeOpacity: 0.8, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
				strokeStyle: 'longdash', // 선의 스타일입니다
				fillColor: '#A2FF99', // 채우기 색깔입니다
				fillOpacity: 0.7 // 채우기 불투명도 입니다
			});

			// 지도에 다각형을 표시합니다
			polygon.setMap(map);


			
			$(function(){
				pharm();
				bike();
				loadBus();
				setInterval(loadBus, 5000);
			})
			


			function loadBus() {
				$.ajax({
					url: 'bus640.api',
					type: "GET",
					dataType: "text",
					success: function (data) {
						if (data) {
							$(data).find('itemList').each(function () {
								

								var tmX = $(this).find("tmX").text();
								var tmY = $(this).find("tmY").text();
								var plainNo = $(this).find("plainNo").text();
								var congetion = $(this).find("congetion").text();
								var stopFlag = $(this).find("stopFlag").text();
								
								if(congetion == 0){
									congetion = "정보없음";
								} else if(congetion == 3){
									congetion = "여유";
								} else if(congetion == 4){
									congetion = "보통";
								} else if(congetion == 5){
									congetion = "혼잡";
								} else if(congetion == 6){
									congetion = "매우혼잡";
								}

								if(stopFlag == 0){
									stopFlag = "운행중";
								} else if(stopFlag == 1){
									stopFlag = "도착";
								}

								var imageSrc = 'http://drive.google.com/uc?export=view&id=1ZsZzIM-_5QnTcSHM1obZGyOh6gqya7p4', // 마커이미지의 주소입니다    
									imageSize = new kakao.maps.Size(35, 35) // 마커이미지의 크기입니다

								// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
								var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize),
									markerPosition = new kakao.maps.LatLng(tmY, tmX); // 마커가 표시될 위치입니다

								// 마커를 생성합니다
								var marker = new kakao.maps.Marker({
									position: markerPosition,
									image: markerImage, // 마커이미지 설정
									clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
								});
									
								// 마커가 지도 위에 표시되도록 설정합니다
								marker.setMap(map);
								
								// 인포윈도우를 생성합니다
								var iwContent = '<div style="padding:5px;width:200px;height:80px;">' + plainNo + '<br>' + '혼잡도 : ' + congetion + '<br>' + 
												'정류소도착여부 : ' + stopFlag + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

								// 인포윈도우를 생성합니다
								var infowindow = new kakao.maps.InfoWindow({
								    content : iwContent,
									removable : true
								});

								// 마커에 클릭이벤트를 등록합니다
								kakao.maps.event.addListener(marker, 'click', function() {
									// 마커 위에 인포윈도우를 표시합니다
									infowindow.open(map, marker);  
								});

								// 4.995초뒤에 마커삭제
								setTimeout(function(){
									marker.setMap(null);
								}, 4995);
							});
						}
					}
				});

				$.ajax({
					url: 'bus6628.api',
					type: "GET",
					dataType: "text",
					success: function (data) {
						if (data) {
							$(data).find('itemList').each(function () {

								var tmX = $(this).find("tmX").text();
								var tmY = $(this).find("tmY").text();
								var plainNo = $(this).find("plainNo").text();
								var congetion = $(this).find("congetion").text();
								var stopFlag = $(this).find("stopFlag").text();
								
								if(congetion == 0){
									congetion = "정보없음";
								} else if(congetion == 3){
									congetion = "여유";
								} else if(congetion == 4){
									congetion = "보통";
								} else if(congetion == 5){
									congetion = "혼잡";
								} else if(congetion == 6){
									congetion = "매우혼잡";
								}

								if(stopFlag == 0){
									stopFlag = "운행중";
								} else if(stopFlag == 1){
									stopFlag = "도착";
								}

								var imageSrc = 'http://drive.google.com/uc?export=view&id=1G2PDkrFJShCBk-qz7xFFw0ljMzE_3d-W', // 마커이미지의 주소입니다    
									imageSize = new kakao.maps.Size(35, 35) // 마커이미지의 크기입니다

								// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
								var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize),
									markerPosition = new kakao.maps.LatLng(tmY, tmX); // 마커가 표시될 위치입니다

								// 마커를 생성합니다
								var marker = new kakao.maps.Marker({
									position: markerPosition,
									image: markerImage, // 마커이미지 설정
									clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
								});
									
								// 마커가 지도 위에 표시되도록 설정합니다
								marker.setMap(map);
								
								// 인포윈도우를 생성합니다
								var iwContent = '<div style="padding:5px;width:200px;height:80px;">' + plainNo + '<br>' + '혼잡도 : ' + congetion + '<br>' + 
												'정류소도착여부 : ' + stopFlag + '</div>' // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

								// 인포윈도우를 생성합니다
								var infowindow = new kakao.maps.InfoWindow({
								    content : iwContent,
									removable : true
								});

								// 마커에 클릭이벤트를 등록합니다
							kakao.maps.event.addListener(marker, 'click', function() {
								// 마커 위에 인포윈도우를 표시합니다
								infowindow.open(map, marker);  
							});
								// 4.995초뒤에 마커삭제
								setTimeout(function(){
									marker.setMap(null);
								}, 4995);
							});
						}
					}
				});

				


				
			}


			function bike(){
				var positions = [];
				$.ajax({
					type: "GET",
					url: "http://openapi.seoul.go.kr:8088/6d7657696e6861763739414950794f/json/bikeList/1/1000/",
					data: {},
					success: function(data){
						var bikeList = data["rentBikeStatus"]["row"]
						for(var i = 0; i < bikeList.length; i++){
							var stationName = bikeList[i]["stationName"]
							var parkingBikeTotCnt = bikeList[i]["parkingBikeTotCnt"]
							var stationLatitude = bikeList[i]["stationLatitude"]
							var stationLongitude = bikeList[i]["stationLongitude"]
							positions.push({content:'<div style="padding:5px;width:280px;height:60px;">' + stationName + '<br>' + '거치 대수 : ' + parkingBikeTotCnt + '</div>',
											latlng: new kakao.maps.LatLng(stationLatitude, stationLongitude)}) 
						}
						
						for (var i = 0; i < positions.length; i ++) {
							var imageSrc = 'http://drive.google.com/uc?export=view&id=1btfKJNyY1UEqieXMyEf6PWr-y9VL2Uh6', // 마커이미지의 주소입니다    
									imageSize = new kakao.maps.Size(30, 30) // 마커이미지의 크기입니다
								// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
								var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
								position: positions[i].latlng, // 마커의 위치
								image: markerImage,
								clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
							});

							// 생성된 마커를 배열에 추가합니다
							markersBike.push(marker);

							// 마커에 표시할 인포윈도우를 생성합니다 
							var infowindow = new kakao.maps.InfoWindow({
								content: positions[i].content, // 인포윈도우에 표시할 내용
								removable: true
							});
							// 이벤트 리스너로는 클로저를 만들어 등록합니다 
							// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
							kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
						}
							// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
							function makeOverListener(map, marker, infowindow) {
								return function() {
									infowindow.open(map, marker);
								};
							}
							// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
							function makeOutListener(infowindow) {
								return function() {
									infowindow.close();
								};
							}
					}
				})
			}
			function pharm(){
				
				var today = new Date();
				var locdate = []; // 올해의 공휴일들을 yyyymmdd형태로 담을 배열.
				var yyyymmdd = getFullToday();	// 오늘날짜를 yyyymmdd형태로 담는다.(공휴일인지 확인하기 위하여)
				var hours = today.getHours().toString();
				if(hours == '0'){
					hours = '24';
				} else if(hours == '1'){
					hours = '25';
				} // 약국 운영시간이 익일 새벽1시나 새벽2시까지의 경우 25,26시로 표기되기 때문에 현재시간이 00시일경우 24시, 01시일경우 25시로 바꿔준다.
				for(var i = 2; i < 10; i++){
					if(hours == i){
						hours = '0' + today.getHours().toString();
					}
				}	// 2시~9시까지는 앞에 0을 붙여준다.
				

				var minutes = today.getMinutes().toString();
				for(var i = 0; i < 10; i++){
					if(minutes == i){
						minutes = '0' + today.getMinutes().toString();
					}
				}	// minutes가 0분 ~ 9분까지일경우 앞에 0을붙여준다(01~09의 형태로 변환)

				var currTime = hours + minutes;	// 현재시간 hhmm 형식의 String으로 담긴다.
				//  currTime = '2200';
				// console.log(currTime);
				var yoil = today.getDay();	// 현재 요일
				
				
				function getFullToday(){
									var date = new Date();
									var year = date.getFullYear();
									var month = ("0" + (1 + date.getMonth())).slice(-2);
									var day = ("0" + date.getDate()).slice(-2);

									return year + month + day;
								}
				
					$.ajax({	// 올해의 공휴일을 공공데이터에서 가져오는 ajax
						type: "GET",
						url: "https://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo?serviceKey=3vbFSNBucTjUmlz76x3t%2FXHUxbPw4FBSuJfqY2xhH5n6sriEAxlGGP%2Fdqlhf2FiOxzA4PbMcX7GpGC%2FowflUrQ%3D%3D&numOfRows=100&_type=json&solYear=" + today.getFullYear(),
						data: {},
						success : function (data){
							var restDayList = data["response"]["body"]["items"]["item"]
							for(var i = 0; i < restDayList.length; i++){
								locdate.push(restDayList[i]["locdate"]);
							}

							for(var i = 0; i < locdate.length; i++){
									if(locdate[i] == yyyymmdd){
									yoil = 8;
									}
							}
						}
					})
				

				$.ajax({	// 약국을 지도에 marker 해주는 ajax
					type: "GET",
					url: "https://apis.data.go.kr/B552657/ErmctInsttInfoInqireService/getParmacyListInfoInqire?serviceKey=3vbFSNBucTjUmlz76x3t%2FXHUxbPw4FBSuJfqY2xhH5n6sriEAxlGGP%2Fdqlhf2FiOxzA4PbMcX7GpGC%2FowflUrQ%3D%3D&Q0=%EC%84%9C%EC%9A%B8%ED%8A%B9%EB%B3%84%EC%8B%9C&Q1=%EC%96%91%EC%B2%9C%EA%B5%AC&ORD=NAME&pageNo=1&numOfRows=300",
					data: "text",
					success: function (data) {
						if (data) {
							$(data).find('item').each(function () {
								var tmY = $(this).find("wgs84Lat").text();
								var tmX = $(this).find("wgs84Lon").text();
								var dutyName = $(this).find("dutyName").text();
								var dutyTel1 = $(this).find("dutyTel1").text();
								var dutyAddr = $(this).find("dutyAddr").text();

								var dutyTime1c;
								if($(this).find("dutyTime1c").text() !== "" ? dutyTime1c = $(this).find("dutyTime1c").text() : dutyTime1c = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
								
								var dutyTime1s;
								if($(this).find("dutyTime1s").text() !== "" ? dutyTime1s = $(this).find("dutyTime1s").text() : dutyTime1c = "휴무");
								
								var dutyTime2c;
								if($(this).find("dutyTime2c").text() !== "" ? dutyTime2c = $(this).find("dutyTime2c").text() : dutyTime2c = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

								var dutyTime2s;
								if($(this).find("dutyTime2s").text() !== "" ? dutyTime2s = $(this).find("dutyTime2s").text() : dutyTime2c = "휴무");
								
								var dutyTime3c;
								if($(this).find("dutyTime3c").text() !== "" ? dutyTime3c = $(this).find("dutyTime3c").text() : dutyTime3c = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

								var dutyTime3s;
								if($(this).find("dutyTime3s").text() !== "" ? dutyTime3s = $(this).find("dutyTime3s").text() : dutyTime3c = "휴무");

								var dutyTime4c;
								if($(this).find("dutyTime4c").text() !== "" ? dutyTime4c = $(this).find("dutyTime4c").text() : dutyTime4c = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

								var dutyTime4s;
								if($(this).find("dutyTime4s").text() !== "" ? dutyTime4s = $(this).find("dutyTime4s").text() : dutyTime4c = "휴무");

								var dutyTime5c;
								if($(this).find("dutyTime5c").text() !== "" ? dutyTime5c = $(this).find("dutyTime5c").text() : dutyTime5c = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

								var dutyTime5s;
								if($(this).find("dutyTime5s").text() !== "" ? dutyTime5s = $(this).find("dutyTime5s").text() : dutyTime5c = "휴무");

								var dutyTime6c;
								if($(this).find("dutyTime6c").text() !== "" ? dutyTime6c = $(this).find("dutyTime6c").text() : dutyTime6c = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

								var dutyTime6s;
								if($(this).find("dutyTime6s").text() !== "" ? dutyTime6s = $(this).find("dutyTime6s").text() : dutyTime6s = "휴무");

								var dutyTime7c;
								if($(this).find("dutyTime7c").text() !== "" ? dutyTime7c = $(this).find("dutyTime7c").text() : dutyTime7c = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

								var dutyTime7s;
								if($(this).find("dutyTime7s").text() !== "" ? dutyTime7s = $(this).find("dutyTime7s").text() : dutyTime7s = "휴무");

								var dutyTime8c;
								if($(this).find("dutyTime8c").text() !== "" ? dutyTime8c = $(this).find("dutyTime8c").text() : dutyTime8c = "");

								var dutyTime8s;
								if($(this).find("dutyTime8s").text() !== "" ? dutyTime8s = $(this).find("dutyTime8s").text() : dutyTime8s = "휴무");

								

								for(var i = 1; i < 9; i++){
									if(yoil == i){
										if(eval('dutyTime' + i + 's') < currTime && currTime < eval('dutyTime' + i + 'c')){
											var imageSrc = 'http://drive.google.com/uc?export=view&id=1zzt3UCNDqkjVbE2JggHTj9qk4Y6MPGn6', // 열려있는 약국 이미지
											imageSize = new kakao.maps.Size(30, 30) // 마커이미지의 크기입니다
										} else {
											var imageSrc = 'http://drive.google.com/uc?export=view&id=1Ppck2GSKy6W8wHI3psyN46GDoEzigrot', // 닫혀있는 약국 이미지
											imageSize = new kakao.maps.Size(30, 30) // 마커이미지의 크기입니다
										}
									}	
								}

								// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
								var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize),
								markerPosition = new kakao.maps.LatLng(tmY, tmX); // 마커가 표시될 위치입니다
								
								// 마커를 생성합니다
								var marker = new kakao.maps.Marker({
									position: markerPosition,
									image: markerImage, // 마커이미지 설정
									clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
								});

								// 생성된 마커를 배열에 추가합니다
								markersPharm.push(marker);

								// 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
								var iwContent = '<div style="padding:5px;width:400px;"><b>' + dutyName + '</b><br>' 
											  + '전화 : ' + dutyTel1 + '<br>'
											  + '주소 : ' + dutyAddr + '<br><hr>'
											  + '<b>월요일 : </b>' + dutyTime1s + ' ~ ' + dutyTime1c
											  + '<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;화요일 : </b>' + dutyTime2s + ' ~ ' + dutyTime2c + '<br>'
											  + '<b>수요일 : </b>' + dutyTime3s + ' ~ ' + dutyTime3c
											  + '<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목요일 : </b>' + dutyTime4s + ' ~ ' + dutyTime4c + '<br>'
											  + '<b>금요일 : </b>' + dutyTime5s + ' ~ ' + dutyTime5c
											  + '<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;토요일 : </b>' + dutyTime6s + ' ~ ' + dutyTime6c + '<br>'
											  + '<b>일요일 : </b>' + dutyTime7s + ' ~ ' + dutyTime7c
											  + '<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;공휴일 : </b>' + dutyTime8s + ' ~ ' + dutyTime8c + '</div>'

								// 인포윈도우를 생성합니다
								var infowindow = new kakao.maps.InfoWindow({
								    content : iwContent,
									removable : true
								});

								// 마커에 마우스클릭 이벤트를 등록합니다
								kakao.maps.event.addListener(marker, 'click', function() {
								// 마커에 마우스클릭 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
									infowindow.open(map, marker);
								});

							});
						}
					}
				});
				
			}






		</script>

	


	
</body>

</html>