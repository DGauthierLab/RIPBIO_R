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

#1/17 pre-class quiz
diamonds

ggplot(
  data = diamonds,
  mapping = aes(x = carat, y = price, shape = clarity)
) +
  scale_shape_manual(values = c(1:8)) +
  geom_point()

#Rusty's solution
ggplot(
  data = diamonds,
  mapping = aes(x = carat, y = price)
) +
  geom_point(mapping=aes(color=clarity,shape=clarity))



