library(dplyr)
library(ggmap)
library(lubridate)
library(ggplot2)
library(stringr)
library(RgoogleMaps)




ggmap::register_google(key = "...")



function(input, output) {
  
  
  data_borough <- reactive(crashes_loc %>% filter(BOROUGH == input$origin))
  
  data_borough1 <- reactive(crashes_loc %>% filter(BOROUGH == input$origin1))
  
  hospitals_borough1 <- reactive(hospitals %>% filter(Borough == input$origin1) %>% select(Facility.Name,lat,lon))
  
  hospitals_borough2 <- reactive(hospitals %>% filter(Borough == input$origin2) %>% select(Facility.Name,lat,lon))
  hospitals_borough3 <- reactive(hospitals %>% filter(Borough == input$origin3) %>% select(Facility.Name,lat,lon))
  
  
  nyc_map_borough <- reactive(ggmap(get_map(location = c(lon = DF_COOR[DF_COOR$BOROUGH == input$origin,]$LON, lat = DF_COOR[DF_COOR$BOROUGH == input$origin,]$LAT), maptype = "terrain", zoom = 12)))

  nyc_map_borough1 <- reactive(ggmap(get_map(location = c(lon = DF_COOR[DF_COOR$BOROUGH == input$origin1,]$LON, lat = DF_COOR[DF_COOR$BOROUGH == input$origin1,]$LAT), maptype = "terrain", zoom = 12)))
  nyc_map_borough2 <- reactive(ggmap(get_map(location = c(lon = DF_COOR[DF_COOR$BOROUGH == input$origin2,]$LON, lat = DF_COOR[DF_COOR$BOROUGH == input$origin2,]$LAT), maptype = "terrain", zoom = 12)))
  nyc_map_borough3 <- reactive(ggmap(get_map(location = c(lon = DF_COOR[DF_COOR$BOROUGH == input$origin3,]$LON, lat = DF_COOR[DF_COOR$BOROUGH == input$origin3,]$LAT), maptype = "terrain", zoom = 12)))
  
  
  
  
  data_fatal_borough <- reactive(crashes_fatal %>% filter(BOROUGH == input$origin2))
  
  data_injury_borough <- reactive(crashes_inj %>% filter(BOROUGH == input$origin3))
  
  output$first <- renderPlot(
    
    ggplot(data1_b,aes(x = CRASH.YEAR,y = total_accident,color = BOROUGH))
    + geom_bar(stat = 'identity',aes(fill = BOROUGH),position = "dodge") + geom_smooth(method='lm', formula= y~x,se = FALSE) +
      
      xlab('Year') + 
      ylab('Total Num of Accident') +
      ggtitle("Total Yearly Accident Number in NYC Per Borough")
  )
  output$second <- renderPlot(
    ggplot(data2_b,aes(x = CRASH.YEAR,y = total))+ geom_bar(stat = 'identity')+
      
      xlab('Year') + 
      ylab('Total Num of Accident') +
      ggtitle("Total Number of Accidents per Year in NYC")
  )
  output$third <- renderPlot(
    ggplot(data3,aes(x = WEEK.DAY,y = total_acc,color = BOROUGH))+ 
      geom_bar(stat = 'identity',aes(fill = BOROUGH)) +
      xlab('Weekday') + 
      ylab('Total Num of Accident') +
      ggtitle("Total Num of accidents on Weekday in NYC")
  )
  output$fourth <- renderPlot(
    nyc_map_borough() +  geom_point(aes(x = LONGITUDE, y = LATITUDE), data = data_borough(), size = 0.25,alpha=0.1) + 
      theme(legend.position="bottom") +
      xlab('Longitude') + 
      ylab('Latitude') + ggtitle(paste("Accidents Distribution in ",input$origin))
  )
  output$fifth <- renderPlot(
    nyc_map_borough1() +
      stat_density2d(aes(x = LONGITUDE, y = LATITUDE, 
                                   fill = ..level.. , alpha = ..level..),size = 0.01, bins = 15,  alpha = 0.1,data = data_borough1(), geom = 'polygon') +
      xlab('Longitude') + 
      ylab('Latitude') +
      geom_point(aes(x = lon, y = lat), data = hospitals_borough1(), size = 2) + ggtitle(paste("Density Distibution of Accidents in ",input$origin1))
  )
  output$sixth <- renderPlot(
    nyc_map_borough2() +  stat_density2d(aes(x = LONGITUDE, y = LATITUDE, 
                                   fill =Total.killed , alpha = ..level..),size = 0.01, bins = 10,  alpha = 0.1,
                               data = data_fatal_borough(), geom = 'polygon') +
      xlab('Longitude') + 
      ylab('Latitude') +
      geom_point(aes(x = lon, y = lat), data = hospitals_borough2(), size = 2) +
      ggtitle(paste("Fatality Density map of ",input$origin2))
    
  )
  output$seventh <- renderPlot(
    nyc_map_borough3() +stat_density2d(aes(x = LONGITUDE, y = LATITUDE, 
                                          fill =Total.injured , alpha = Total.injured),size = 0.01, bins = 10,  alpha = 0.2,
                                      data = data_injury_borough(), geom = 'polygon') +
      xlab('Longitude') + 
      ylab('Latitude') +
      geom_point(aes(x = lon, y = lat), data = hospitals_borough3(), size = 2) +
      
      ggtitle(paste("Injury Density map of Brooklyn",input$origin3))
  )
  
  
  
}
