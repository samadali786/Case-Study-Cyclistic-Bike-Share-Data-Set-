library(tidyverse)
install.packages("lubridate")
library(lubridate)
install.packages("ggplot2")
library(ggplot2)


setwd("C:/Users/samad/Desktop/R_studio_Cyclist_data_sets/Cyclist_Data_Sets_R")
getwd()




month_Jan_Mar_2020 <- read.csv("Divvy_Trips_Jan_2020_March_2020.csv")
month_Apr_2020 <- read.csv("Divvy-Tripdata_April_2020.csv")
month_May_2020 <- read.csv("Divvy-tripdata_May_2020.csv")
month_June_2020 <- read.csv("Divvy-tripdata_June_2020.csv")
month_July_2020 <- read.csv("Divvy-tripdata_July_2020.csv")
month_August_2020 <- read.csv("Divvy-tripdata_Aug_2020.csv")
month_September_2020 <- read.csv("Divvy-tripdata_Sept_2020.csv")
month_October_2020 <- read.csv("Divvy-tripdata_Oct_2020.csv")
month_November_2020 <- read.csv("Divvy_Trips_Nov_2020.csv")
month_December_2020 <- read.csv("Divvy_Trips_Dec_2020.csv")



install.packages("readxl")
library("readxl")

#read_excel("my_file.xlsx") for xls files

month_Jan_Mar_2020 <- read_xlsx("Divvy_Trips_Jan_2020_March_2020.XLSX")
month_Apr_2020 <- read_xlsx("Divvy-Tripdata_April_2020.xlsx")
month_May_2020 <- read_xlsx("Divvy-tripdata_May_2020.xlsx")
month_June_2020 <- read_xlsx("Divvy-tripdata_June_2020.xlsx")
month_July_2020 <- read_xlsx("Divvy-tripdata_July_2020.xlsx")
month_August_2020 <- read_xlsx("Divvy-tripdata_Aug_2020.xlsx")
month_September_2020 <- read_xlsx("Divvy-tripdata_Sept_2020.xlsx")
month_October_2020 <- read_xlsx("Divvy-tripdata_Oct_2020.xlsx")
month_November_2020 <- read_xlsx("Divvy_Trips_Nov_2020.xlsx")
month_December_2020 <- read_xlsx("Divvy_Trips_Dec_2020.xlsx")








# remove start_station_name, start_station_id, end_station_name, end_station_id) using piping
install.packages("dplyr")
library(dplyr)
mth_Jan_Mar_2020 <- month_Jan_Mar_2020 %>% select(-c(start_station_name, start_station_id, end_station_name, end_station_id))
mth_Apr_2020 <- month_Apr_2020 %>% select(-c(start_station_name, start_station_id, end_station_name, end_station_id))
mth_May_2020 <- month_May_2020 %>% select(-c(start_station_name, start_station_id, end_station_name, end_station_id))
mth_Jun_2020 <- month_June_2020 %>% select(-c(start_station_name, start_station_id, end_station_name, end_station_id))
mth_Jul_2020 <- month_July_2020 %>% select(-c(start_station_name, start_station_id, end_station_name, end_station_id))
mth_Aug_2020 <- month_August_2020 %>% select(-c(start_station_name, start_station_id, end_station_name, end_station_id))
mth_Sep_2020 <- month_September_2020 %>% select(-c(start_station_name, start_station_id, end_station_name, end_station_id))
mth_Oct_2020 <- month_October_2020 %>% select(-c(start_station_name, start_station_id, end_station_name, end_station_id))
mth_Nov_2020 <- month_November_2020 %>% select(-c(start_station_name, start_station_id, end_station_name, end_station_id))
mth_Dec_2020 <- month_December_2020 %>% select(-c(start_station_name, start_station_id, end_station_name, end_station_id))



full_yrs_trips <- bind_rows(mth_Jan_Mar_2020,mth_Apr_2020,mth_May_2020,mth_Jun_2020,mth_Jul_2020,mth_Aug_2020,mth_Sep_2020,mth_Oct_2020,mth_Nov_2020,mth_Dec_2020)



#table(full_yr_trips$member_casual) #rslt in either member or casual
#table(full_yr_trips$rideable_type) #rslt in either "classic bike", "docked bike", "electric bike"


full_yrs_trips$date <- as.Date(full_yrs_trips$started_at)
full_yrs_trips$month <- format(as.Date(full_yrs_trips$date), "%m")
full_yrs_trips$day <- format(as.Date(full_yrs_trips$date), "%d")
full_yrs_trips$year <- format(as.Date(full_yrs_trips$date), "%Y")

full_yrs_trips$day_of_week <- format(as.Date(full_yrs_trips$date), "%A")
full_yrs_trips$ride_length <- difftime(full_yrs_trips$ended_at, full_yrs_trips$started_at)

View(full_yrs_trips)
# have all the data frame with ride_length and day_of_week



# ommiting all the docked bikes in a data frame in many various trips for the docked_bike where ride_length is negative durration 
full_yrs_trips_v2 <- full_yrs_trips[!(full_yrs_trips$rideable_type == "docked_bike" | full_yrs_trips$ride_length<0),]
View(full_yrs_trips_v2)



# Analysis seps:




#install.packages("chron")
#library(chron)

full_yrs_trips_v2 %>% 
  group_by(member_casual) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length))



full_yrs_trips_v2 %>% 
  group_by(member_casual, rideable_type) %>% 
  summarise(number_of_rides = n())





#install.packages('writexl')

library(writexl)

#write_xlsx(full_yr_trips,"C:/Users/samad/Desktop/R_studio_Cyclist_data_sets/Cyclist_Data_Sets_R")

write_xlsx(full_yrs_trips_v2,"C:/Users/samad/Desktop/R_studio_Cyclist_data_sets/Cyclist_Data_Sets_R/full_yrs_tripdata.xlsx" )
write_csv(full_yrs_trips_v2,"C:/Users/samad/Desktop/R_studio_Cyclist_data_sets/Cyclist_Data_Sets_R/full_yrs_tripdata.csv")

install.packages("rmarkdown")
install.packages("tinytex")

library("rmarkdown")
library("tinytex")
tinytex::install_tinytex()
