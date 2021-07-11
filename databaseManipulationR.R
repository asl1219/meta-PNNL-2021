#necessary libraries
library(tidyr)
library(dplyr)

#read in data
srdbData = read.csv("srdb-master/srdb-data.csv")

#choose relevant categories
srdbManagable = srdbData%>% select(Latitude, Longitude, Study_midyear, Ecosystem_type, Manipulation, Rs_annual, RC_annual)