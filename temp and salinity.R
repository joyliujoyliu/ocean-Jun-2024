
library(ggplot2)
library(dplyr)
library(tidyverse)
require(maptools)
library(mapdata)
library(maps)
library(mapproj)

LTTSGP2022 <- read.csv("C:/Machine Files/Downloads/LTTSGP_1999_2023/LTTSGP2022.csv")




base_map <- ggplot() +
  borders("world", colour="gray50", fill = "gray90", 
          xlim = c(-73.53-1 ,-52.58+1), ylim = c(44.40 -1,50.08+1   )) +
  coord_map(xlim = c(-73.53-1 ,-52.58+1), ylim = c(44.40 -1,50.08 +1  )) +
  theme_bw() +
  scale_color_continuous(low = "white", high = "red") +
  scale_size_continuous(guide = FALSE) +
  theme(axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(), 
        legend.position = "bottom")


base_map + 
  geom_point(data = LTTSGP2022, aes(x=Longitude , y=Latitude, color = Temperature.Température.ºC.),
             shape = 20,size=0.1) +
  scale_color_gradientn(colours = rainbow(7),oob=scales::squish)+ labs(colour = "Surface temperature (°C)")