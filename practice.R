library(tidyverse)
library(palmerpenguins)
library(ggthemes)

#r4ds2e 1.2.5
#How many rows are in penguins? How many columns?
# 344 rows, 8 columns
penguins


#add data to the plot with geoms
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = bill_depth_mm)
) +
  geom_point(na.rm = TRUE)