library(ggplot2)
library(ggmap)
library(mapdata)
library(animation)

df = read.csv("globalterrorismdb_0616dist.csv", stringsAsFactors = TRUE)

generate_gif = function(start_year, country){
  
  # country_map = get_map(country, zoom = zoom_val, maptype = "toner-lite")
  
  country_df = df[df$country_txt == country,]

  i = start_year
  
  saveGIF(while (i<2016) {
    
    country_year = subset(country_df, country_df$iyear == i)
    
    cities <- data.frame(lon=country_year$lon, lat=country_year$lat)
    
    # print(ggmap(country_map)+geom_point(aes(x = lon, y = lat), data = cities, col = "red", alpha = .5)+ggtitle(paste(country, "-- Terror Strikes in ", i, sep="")))
    
    map("world2Hires", country)
    points(cities$lon, cities$lat, col="red", pch=18)
    title(paste(country, " -- Terror Strikes in ", i, sep=""))
    
    i = i+1
    
  }, movie.name = paste(country, "_terror.gif", sep=""), interval = 3.5, convert = "convert", ani.width = 1000, ani.height = 800)

}

generate_gif(2010, "Syria")
generate_gif(2010, "Afghanistan")
generate_gif(2010, "India")
generate_gif(2010, "Israel")
