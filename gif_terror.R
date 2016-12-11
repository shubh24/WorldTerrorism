library(sp)
library(raster)
library(animation)

df = read.csv("globalterrorismdb_0616dist.csv", stringsAsFactors = TRUE)

generate_gif = function(start_year, country_code, country){
  
  country_map <- getData('GADM', country=country_code, level=1)
  country_df = df[df$country_txt == country,]

  i = start_year
  
  saveGIF(while (i<2016) {
    
    country_year = subset(country_df, country_df$iyear == i)
    
    cities <- data.frame(lon=country_year$lon, lat=country_year$lat)
    
    print( spplot(country_map, "NAME_1",
                  sp.layout=list("panel.points", cities$lon, cities$lat, col="red"),
                  main=paste(country, " -- Terrorist Incidents in ",i, sep = ""),
                  colorkey=FALSE,
                  scales=list(draw=TRUE)
    ))
    
    i = i+1
    
  }, movie.name = paste(country, "_terror.gif", sep=""), interval = 3.5, convert = "convert", ani.width = 1000, ani.height = 800)

}

generate_gif(2010, "SYR", "Syria")
generate_gif(2010, "AFG", "Afghanistan")
generate_gif(2010, "IND", "India")
generate_gif(2010, "GBR", "United Kingdom")