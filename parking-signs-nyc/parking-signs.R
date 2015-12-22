data = read.csv('./parking_regulation.csv')

library(proj4)
proj4string <- "+proj=lcc +lat_1=40.66666666666666 +lat_2=41.03333333333333 +lat_0=40.16666666666666 +lon_0=-74 +x_0=300000 +y_0=0 +ellps=GRS80 +datum=NAD83 +to_meter=0.3048006096012192 +no_defs"
latlong_list<-list()
calculate_long_lat <- function(x,y) {
  
  # Source data
  xy <- data.frame(x=x, y=y)
  
  # Transformed data
  pj <- project(xy, proj4string, inverse=TRUE)
  latlon <- data.frame(lat=pj$y, lon=pj$x)
  latlong_list[['latlong']] <- latlon
}

apply(data[,c('x','y')], 1, function(y) calculate_long_lat(y['x'], y['y']))
rbind(data, latlong_list)

