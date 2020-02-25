#Author: Josh
#Professor: Frenzel
#Student Id: 2355145
#Date: 1/20/2020
#Ver: 1.0
#Subject: Plotly Package

# Plotly Introduction.
# The homepage: https://plotly-r.com/

# Load the plotly package
library(plotly)
library(ggplot2)
getwd()
# Reading the NYC flight database. Required the nycflight is the same
# directory with r script
nycflight <- read.csv(file='nycflight.csv')
#head(nycflight)

#nycflight[1, ]
#nycflight[3, ]

# Process the database
# Some time we need to shape the database. Need the library dplyr
library(dplyr)

# Filter cancelled delayed fly
cancelled_delayed <- 
  nycflight %>%
  mutate(cancelled = (is.na(arr_delay) | is.na(dep_delay))) %>%
  group_by(year, month, day) %>%
  summarise(prop_cancelled = mean(cancelled),
            avg_dep_delay = mean(dep_delay, na.rm = TRUE))
cancelled_delayed


ggplot(cancelled_delayed, aes(x = avg_dep_delay, prop_cancelled)) +
  geom_point() +
  geom_smooth()

# Using plotly package to draw

line_plots <- plot_ly(data = cancelled_delayed, x = ~avg_dep_delay, y = ~prop_cancelled,
             marker = list(size = 10,
                           color = 'rgba(255, 182, 193, .9)',
                           line = list(color = 'rgba(152, 0, 0, .8)',
                                       width = 2))) %>%
  layout(title = 'Styled Scatter',
         yaxis = list(zeroline = FALSE),
         xaxis = list(zeroline = FALSE))
line_plots

# 3D line
data$month <- as.factor(cancelled_delayed$month)  
line_3d <- plot_ly(cancelled_delayed, x = ~avg_dep_delay, y = ~prop_cancelled, z = ~day, type = 'scatter3d', mode = 'lines',
             opacity = 1, line = list(width = 6, color = ~month, reverscale = FALSE))

line_3d
