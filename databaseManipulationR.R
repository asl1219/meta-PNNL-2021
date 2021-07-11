#necessary libraries
library(tidyr)
library(dplyr)

#read in data
srdbData = read.csv("srdb-master/srdb-data.csv")

#choose relevant categories
srdbManagable = srdbData%>% select(Latitude, Longitude, Study_midyear, Ecosystem_type, Manipulation, Rs_annual, RC_annual)

#number of observations (rows) by ecosystem type
#get rid of whitespace first
srdbManagable$Ecosystem_type = srdbManagable$Ecosystem_type %>% trimws(c("both"))
numberByEcoType = srdbManagable %>% group_by(Ecosystem_type) %>% summarize(n())


#print/report
numberByEcoType