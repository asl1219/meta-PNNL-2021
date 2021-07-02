#requiredlibraries
library(tidyr)
library(dplyr)

#read in files and rename
fluxes = readr::read_csv("fluxes.csv")
collar_map = readr::read_csv("collar_map.csv")

#reshape/cleanup data
fluxesTidy = 
  (fluxes %>% 
    gather(date, value, 2:7) %>% 
      filter(!is.na(value)))
collarMapTidy = 
  collar_map %>% select(-LI8100A_Port) %>%
    unite("Treatment", 2:4, sep = ", ")
      
