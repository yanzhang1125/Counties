library(ggplot2)
library(dplyr)

race = readRDS("data/counties.rds")
counties_map = map_data("county")

#don't seperate the column in race, because some have the same name

counties_map = counties_map %>%
  mutate(name = paste(region, subregion, sep = ","))

counties = left_join(counties_map, race, by = "name")

#if different names by = c("nam1" = "name2")

ggplot(counties, aes(x = long, 
                     y = lat,
                     group = group,
                     fill = white)) +
  geom_polygon() +
  scale_fill_gradient(low = "white", high = "darkred") +
  theme_void()

####switch

text = "Hilary"

switch(text,
       "Lily" = print("I am Lily"),
       "Hilary" = print("I am Hilary"))


