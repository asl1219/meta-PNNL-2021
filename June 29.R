#requiredlibraries
library(tidyr)
library(dplyr)

#read in files and rename
fluxes = readr::read_csv("fluxes.csv")
collar_map = readr::read_csv("collar_map.csv")

#reshape/cleanup data
fluxesTidy = 
  (fluxes %>% 
    gather(date, value, 2:7))
#LI8100A is empty so remove it
collarMapTidy = 
  collar_map %>% select(-LI8100A_Port, -Group) %>%
    unite("Treatment", 2:3, sep = ", ")
      
#joining metadata and column cleanup and remove "N/A"
collarInfo = 
  collarMapTidy %>% left_join(fluxesTidy, "Collar") %>%
    filter(!is.na(value))


#print dataset summary by treatment
collarInfo %>% group_by(Treatment) %>% summarize(mean(value), sd(value), n()) 

