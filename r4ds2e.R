#test
#R4DS script
#modified 1/9/24

#package loadings
if (!require('tidyverse')) install.packages('tidyverse')
if (!require('palmerpenguins')) install.packages('palmerpenguins')
if (!require('ggthemes')) install.packages('ggthemes')

#library loadings
library(tidyverse)
library(palmerpenguins)
library(ggthemes)

#different ways to visualize data set
penguins
glimpse(penguins)
View(penguins)
?penguins

##creating a ggplot (see 1.2.2)

#empty graph
ggplot(data = penguins)

#map variables to x and y axes
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
)

#add data to the plot with geoms
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point()

#map species to color aesthetic 
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point()

#adding a layer (smoothed line)
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point() +
  geom_smooth(method = "lm")

#apply the smoothed line to the entire data set, not to individual species
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species)) +
  geom_smooth(method = "lm")

#map species to both color and shape aesthetics
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm")

#Improve labeling of plot
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()
