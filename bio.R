
library(ggplot2)
library(dplyr)
library(tidyverse)
require(maptools)
library(mapdata)
library(maps)
library(mapproj)


CRIB_TechRep_PrpRisk_PerCell <- read.csv("C:/Users/jy441064/Downloads/ocean-Jun-2024/CRIB_TechRep_PrpRisk_PerCell.csv")
CRIB_TechRep_PrpRisk_PerCell=CRIB_TechRep_PrpRisk_PerCell[CRIB_TechRep_PrpRisk_PerCell$lon>=-75.53& CRIB_TechRep_PrpRisk_PerCell$lon<=-45.58 & CRIB_TechRep_PrpRisk_PerCell$lat>=40.4 & CRIB_TechRep_PrpRisk_PerCell$lat<=52.08,]



base_map + 
  geom_point(data = CRIB_TechRep_PrpRisk_PerCell, aes(x=lon , y=lat, color = hi.vuln),
             shape = 20,size=1) +
  scale_color_gradientn(colours = rainbow(7),oob=scales::squish)+ labs(colour = "Percentage of species assessed at high climate risk.")

base_map + 
  geom_point(data = CRIB_TechRep_PrpRisk_PerCell, aes(x=lon , y=lat, color = crit.vuln),
             shape = 20,size=1) +
  scale_color_gradientn(colours = rainbow(7),oob=scales::squish)+ labs(colour = "Percentage of species assessed at critical climate risk.")

riskcomp <- data.frame(
  "lon"=CRIB_TechRep_PrpRisk_PerCell$lon,
  "lat"=CRIB_TechRep_PrpRisk_PerCell$lat,
  "Critical"=CRIB_TechRep_PrpRisk_PerCell$crit.vuln,
  "High"=CRIB_TechRep_PrpRisk_PerCell$hi.vuln
) %>%
  tidyr::gather(type,risk,-lon,-lat) %>%
  mutate(type = factor(type, ordered = T))

base_map  +facet_wrap(type ~ ., ncol = 1)+
  geom_point(data = riskcomp, aes(x=lon , y=lat, color = risk),
             shape = 20,size=1) +
  scale_color_gradientn(colours = rainbow(7),oob=scales::squish)+ labs(colour = "Percentage of species assessed at risk.")

