getCenter <-
function(){
	center <- list(longitude = median(trackSample$longitude, na.rm = T),
	latitude = median(trackSample$latitude, na.rm = T))
}

speedAnalysis <-
function(minSpeed){
	filterFlag <- trackSample$Speed.km.h. >= minSpeed
	filterResult <- trackSample[filterFlag,c('longitude', 'latitude')]
	#Directly Generating Map in R

	#Using Google API to get base map
	#center <- c(median(trackSample$longitude, na.rm = T), median(trackSample$latitude, na.rm = T))
 	#base <- get_map(location = center, zoom = 12, source = "osm", crop = F)

	#Using OpenStreetMap to get base map
    #rangeLon <- range(trackSample$longitude, na.rm = T)
    #rangeLat <- range(trackSample$latitude, na.rm = T)
	#bbox <- c(left = rangeLon[1], bottom = rangeLat[1], right = rangeLon[2], top = rangeLat[2])
    #base <- get_openstreetmap(bbox = bbox, scale = 50000, format = 'png', color = 'color')
	#ggmap(base) + geom_point(aes(x = longitude, y = latitude , size = sqrt(Speed.km.h.)),
	#data = trackSample, alpha = .7, color="blue") + labs(x = 'Longitude', y = 'Latitude') + ggtitle('Simple Speed Analysis')
}

getProperties <-
function(){
	length <- length(trackSample)
	starttime <- trackSample$time[1]
	endtime <- trackSample$time[length]
    startpoint <- c(trackSample$longitude[1], trackSample$latitude[1])
	endpoint <- c(trackSample$longitude[length], trackSample$latitude[length])
	distance <- distHaversine(startpoint, endpoint)
	speedMean <- mean(trackSample$Speed.km.h., na.rm = T)
	altitudeMean <- mean(trackSample$GPS.Altitude.m., na.rm = T)
	rpmMean <- mean(trackSample$Rpm.u.min., na.rm = T)
	result <- list(starttime = starttime, endtime = endtime, distance = distance, speedMean = speedMean,
	altitudeMean = altitudeMean, rpmMean = rpmMean)
}
