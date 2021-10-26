install.packages("tidyverse")
library(tidyverse)
install.packages("lubridate")
library(lubridate)
BikeSeoul <- read.csv("BikeSeoul.csv") %>%
  select(-Visibility..10m.,-Dew.point.temperature.C.,
         -Solar.Radiation..MJ.m2.,-Snowfall..cm.,-Rainfall.mm.) %>%
  filter(Functioning.Day == "Yes") %>%
  select(-Functioning.Day) %>%
  rename("Day/Month/Year" = Date, 
         "Number of bikes rented in that hour" = Rented.Bike.Count ,
         "Hour of the day" = Hour ,
         "Air temperature in degree Celsius" = Temperature.C. ,
         "Humidity as a % "= Humidity... ,
         "Wind.speed m/s" = Wind.speed..m.s.,
         "Winter, Spring, Summer, Autumn" = Seasons ,
         "Holiday/No holiday" = Holiday)  %>%
  mutate(`Day/Month/Year` = as.Date(`Day/Month/Year`,"%d/%m/%Y")) %>%
  mutate(FullDate = make_datetime(year(`Day/Month/Year`),
                                  month(`Day/Month/Year`),
                                  day(`Day/Month/Year`),
                                  BikeSeoul$`Hour of the day`)) %>%
  mutate(`Holiday/No holiday`= factor(`Holiday/No holiday`,
                                      levels = c("Holiday","No Holiday"),
                                      labels = c("Yes","No"),ordered = TRUE)) %>%
  mutate(`Winter, Spring, Summer, Autumn` = 
           factor(`Winter, Spring, Summer, Autumn`,
                 levels = c("Spring","Summer","Autumn","Winter"), ordered=TRUE))
           
         


