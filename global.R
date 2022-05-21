
#### Please download the accident files from this webaddress
## https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Crashes/h9gi-nx95


library(dplyr)
library(ggmap)
library(lubridate)
library(ggplot2)
library(stringr)

### coordination


DF_COOR = data.frame(BOROUGH = c("MANHATTAN","BRONX","STATEN ISLAND","BROOKLYN","QUEENS"),
                     LON = c(-74.00,-73.88,-74.16,-73.95,-73.85),
                     LAT = c(40.759,40.85,40.58,40.65,40.73),
                     ZOOM = c(12,12,12,12,12),stringsAsFactors = FALSE)




crashes = read.csv(file = "./Motor_Vehicle_Collisions_-_Crashes.csv",stringsAsFactors = FALSE)

crashes_loc = crashes %>% select(CRASH.DATE,CRASH.TIME,BOROUGH,ZIP.CODE,LATITUDE,LONGITUDE,LOCATION,ON.STREET.NAME,CROSS.STREET.NAME,OFF.STREET.NAME) %>%
  filter((!is.na(LONGITUDE)) & (!is.na(LATITUDE)) & BOROUGH != "") %>% mutate(CRASH.DATE=as.Date(CRASH.DATE,"%m/%d/%Y")) %>% 
  mutate(CRASH.MONTH=month(CRASH.DATE,label = TRUE,abbr = TRUE),CRASH.YEAR=year(CRASH.DATE),WEEK.DAY=wday(CRASH.DATE,label = TRUE,abbr = TRUE)) 

data1_b = crashes_loc %>% group_by(CRASH.YEAR,BOROUGH) %>% summarise(total_accident=sum(n()))

data2_b = data1_b %>% group_by(CRASH.YEAR) %>% summarise(total = sum(total_accident))


data2 = crashes_loc %>% group_by(CRASH.MONTH,BOROUGH) %>% summarise(total_acc =sum(n()))

data3 = crashes_loc %>% group_by(WEEK.DAY,BOROUGH) %>% summarise(total_acc =sum(n()))


##hospital
hospitals = read.csv("hospital.csv",stringsAsFactors = FALSE)
hospitals$coor = str_split_fixed(hospitals$Location.1,"\n",n=3)[,3]

hospitals$coor=gsub("[(,)]","",hospitals$coor)

hospitals_coor = str_split_fixed(hospitals$coor," ",n=2)

hospitals$lat = as.numeric(hospitals_coor[,1])

hospitals$lon = as.numeric(hospitals_coor[,2])
hospitals$Borough = toupper(hospitals$Borough)










########fatalities


crashes_fat_inj = crashes %>% select(CRASH.DATE,CRASH.TIME,BOROUGH,ZIP.CODE,LATITUDE,LONGITUDE,
                                 LOCATION,ON.STREET.NAME,CROSS.STREET.NAME,OFF.STREET.NAME,
                                 NUMBER.OF.PERSONS.INJURED,NUMBER.OF.PERSONS.KILLED,NUMBER.OF.PEDESTRIANS.INJURED,
                                 NUMBER.OF.PEDESTRIANS.KILLED,NUMBER.OF.CYCLIST.INJURED,NUMBER.OF.CYCLIST.KILLED,
                                 NUMBER.OF.MOTORIST.INJURED,NUMBER.OF.MOTORIST.KILLED) %>% filter((!is.na(LONGITUDE)) & (!is.na(LATITUDE)))


crashes_fatal = crashes_fat_inj  %>% mutate(Total.killed = NUMBER.OF.PERSONS.KILLED + 
                                                                                 NUMBER.OF.PEDESTRIANS.KILLED+
                                                                                 NUMBER.OF.CYCLIST.KILLED+
                                                                                 NUMBER.OF.MOTORIST.KILLED,
                                                                               Total.injured = NUMBER.OF.PERSONS.INJURED + 
                                                                                 NUMBER.OF.PEDESTRIANS.INJURED+
                                                                                 NUMBER.OF.CYCLIST.INJURED+
                                                                                 NUMBER.OF.MOTORIST.INJURED) %>% filter(Total.killed > 0)



################ injuries
crashes_inj = crashes_fat_inj %>% mutate(Total.killed = NUMBER.OF.PERSONS.KILLED + 
                                                                                  NUMBER.OF.PEDESTRIANS.KILLED+
                                                                                  NUMBER.OF.CYCLIST.KILLED+
                                                                                  NUMBER.OF.MOTORIST.KILLED,
                                                                                Total.injured = NUMBER.OF.PERSONS.INJURED + 
                                                                                  NUMBER.OF.PEDESTRIANS.INJURED+
                                                                                  NUMBER.OF.CYCLIST.INJURED+
                                                                                  NUMBER.OF.MOTORIST.INJURED) %>% filter(Total.injured > 0)




