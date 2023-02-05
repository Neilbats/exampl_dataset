#packages
library(leaflet)
library(dplyr)

#source_buildings
buildings <- read.table("https://raw.githubusercontent.com/Neilbats/exampl_dataset/main/temp6_2.txt", sep = ";", header = T)

head(buildings)

#source_walking_line
lines <- readOGR("https://raw.githubusercontent.com/Neilbats/exampl_dataset/main/lines6_1.kml")

#implement_into_leaflet
map<-leaflet(buildings) %>% 
addTiles() %>% 
  setView(lng = mean(buildings$Lat), lat = mean(buildings$Long), zoom = 10,5) %>% 
  addMarkers(lng = buildings$Lat, lat = buildings$Long,
             popup = paste(buildings$address, "<br>", buildings$adress),
             icon = makeIcon(iconUrl = buildings$IP,
                             iconWidth = 38, iconHeight = 50,
                             iconAnchorX = 0, iconAnchorY = 1))%>%
  addPolylines(data = lines, fillColor = "#ff0000", fillOpacity = 0.5)

#export_as_html
library(htmlwidgets)

# Export the map as an HTML file
saveWidget(map, file = "map.html")

