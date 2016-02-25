speedAnalysis <-
function(minSpeed){
	filterFlag <- trackSample$Speed.km.h. >= minSpeed
	filterResult <- trackSample[filterFlag,]
	with(filterResult, text2D(x = longitude, y = latitude, colvar = Speed.km.h., xlab = 'longitude', ylab = 'latitude', clab = 'Speed(km/h)', main = paste("Track Dataset Size:" ,length(rownames(filterResult)), sep = " "), font = 3, labels = rownames(filterResult)))
}
