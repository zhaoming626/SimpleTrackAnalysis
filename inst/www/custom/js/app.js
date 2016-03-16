var app = angular.module('simpleTrackAnalysisApp', []);

app.controller("simpleTrackAnalysisController", function ($scope) {

	$scope.minSpeed = 0;
	$scope.maxSpeed = 100;
	$scope.overview = new Object();
	$scope.statistical = new Object();
	$scope.map = new Object();
	$scope.polylinePoints = new Array();
	$scope.dataSize = 0;

	$scope.polylineOptions = {
		color: 'blue',
		weight: 15,
		opacity: 0.5
	};

	var setParametersForMap = function(){
		var reqCenter = ocpu.rpc("getCenter",{}
			, function(output) {
				var center = new L.LatLng(output['latitude'][0], output['longitude'][0]);
				// Using Google Tile
				//$scope.map = new L.Map('map', {center: center, zoom: 12});
				//var googleLayer = new L.Google('ROADMAP');
				//$scope.map.addLayer(googleLayer);
				$scope.map = new L.Map('map', {center: center, zoom: 12});
				L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
					attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors',
					maxZoom: 15
				}).addTo($scope.map);
				$scope.map.attributionControl.setPrefix('');
			});

		reqCenter.fail(function(){
			alert("Server error: " + reqCenter.responseText);
		});
	};

	var setParametersForTrackStatisticalDetail = function(){
		var req = ocpu.rpc("getProperties",{}
			, function(output) {
				$scope.$apply(function () {
					var starttime = new Date(output.starttime[0]);
					var endtime = new Date(output.endtime[0]);
					$scope.overview.starttime = starttime.toLocaleDateString() + starttime.toLocaleTimeString();
					$scope.overview.endtime = endtime.toLocaleDateString() + endtime.toLocaleTimeString();
					$scope.overview.duration = ((endtime - starttime) / 60000).toFixed(2);
					$scope.overview.distance = (output.distance[0]).toFixed(2);
					$scope.statistical.speedmean = (output.speedMean[0]).toFixed(2);
					$scope.statistical.altitudemean = (output.altitudeMean[0]).toFixed(2);
					$scope.statistical.rpmmean = (output.rpmMean[0]).toFixed(2);
				});
			})

		//if R returns an error, alert the error message
		req.fail(function(){
			alert("Server error: " + req.responseText);
		});
	};

	var clearMap =function (){
		for(var i in $scope.map._layers) {
			if($scope.map._layers[i]._path != undefined) {
				try {
					$scope.map.removeLayer($scope.map._layers[i]);
				}
				catch(e) {
					console.log("problem with " + e + $scope.map._layers[i]);
				}
			}
		}
	}

	var initialization = function (){
		setParametersForMap();
		setParametersForTrackStatisticalDetail();
	};

	$(document).ready(function(){

		initialization();

		$("#submitbutton").on("click", function(){

			clearMap();

			$scope.dataSize = 0;
			$scope.polylinePoints.length = 0;

			//disable the button to prevent multiple clicks
			$("#submitbutton").attr("disabled", "disabled");

			//get track points satisfying the filter
			var req = ocpu.rpc("speedAnalysis", {
				minSpeed : $scope.minSpeed,
				maxSpeed : $scope.maxSpeed
			}, function(output){
				output.forEach(function(element, index, array) {

					if($scope.dataSize == 0){
						$scope.$apply(function(){
							$scope.dataSize = array.length;
						});
					};

					if($scope.dataSize != 0 && index == $scope.dataSize - 1) {
						var polyline = new L.Polyline($scope.polylinePoints, $scope.polylineOptions);
						$scope.map.addLayer(polyline);
						// zoom the map to the polyline
						$scope.map.fitBounds(polyline.getBounds());
					};

					$scope.polylinePoints.push(new L.LatLng(element['latitude'], element['longitude']));
				});
			});

			//if R returns an error, alert the error message
			req.fail(function(){
				alert("Server error: " + req.responseText);
			});

			//after request complete, re-enable the button
			req.always(function(){
				$("#submitbutton").removeAttr("disabled")
			});
		});

	});
});