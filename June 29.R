#requiredlibraries
library(tidyr)
library(dplyr)
library(ggplot2)

#read in files and rename
fluxes = readr::read_csv("fluxes.csv")
collar_map = readr::read_csv("collar_map.csv")

#reshape/cleanup data
fluxesTidy = 
  (fluxes %>% 
    gather(date, value, 2:7))
#LI8100A is empty so remove it
collarMapTidy = 
  collar_map %>% select(-LI8100A_Port, -Group, -Plot)
      
#joining metadata and column cleanup and remove "N/A"
#also pull out collars that get filtered out
  collarInfoPreFilter = 
  collarMapTidy %>% left_join(fluxesTidy, "Collar")

collarsNotIncluded = collarInfoPreFilter %>% filter(is.na(value)) %>% select(-value)

collarInfo = collarInfoPreFilter  %>%
  filter(!is.na(value))

#print dataset summary by treatment
collarInfo %>% group_by(Treatment) %>% summarize(mean(value), sd(value), n()) 
print(collarInfo)

#boxplot by treatment with dots
boxplotGraph = collarInfo %>% ggplot(aes(value, Treatment)) + geom_boxplot() + geom_jitter(height = 0) + ggtitle("Boxplots of Flux by Treatment")



#line graph of mean fluxes by treatment and date by error bars
#mean and s.d. by date/treatment (similar to printing info by treatment)
meansByBoth = collarInfo %>% group_by(date, Treatment) %>% summarize(means = mean(value))
StDevByBoth = collarInfo %>% group_by(date, Treatment) %>% summarize(stDevds = sd(value))

lineMeanBothGraph = meansByBoth %>% ggplot(aes(date, means, group = Treatment, color = Treatment)) + geom_line() + ggtitle("Mean Flux by Date and Treatment") + xlab("Date") + ylab("Mean Flux")

#print the information on collars not included (later to be included in report)
print(collarsNotIncluded)

#save graphs