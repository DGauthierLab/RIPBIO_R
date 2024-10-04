#library loadings
library(tidyverse)
library(ggthemes)
library(ggplot2)

msleep
View(msleep)

?msleep

#This is an updated and expanded version of the mammals sleep dataset. Updated sleep times and weights were taken from V. M. Savage and G. B. West. A quantitative, theoretical framework for understanding mammalian sleep. Proceedings of the National Academy of Sciences, 104 (3):1051-1056, 2007.



#generate a plot to explore the question "What effect does brain weight have on sleep total?"  Provide your code.
ggplot(
  data = msleep,
  mapping = aes(x = brainwt, y = sleep_total)
) +
  geom_point() 

#modify this plot to color-code each data point by what the animal eats and add a linear trendline for each type of vore
ggplot(
  data = msleep,
  mapping = aes(x = brainwt, y = sleep_total, color=vore)
) +
  geom_point() +
  geom_smooth(method="lm")

#now recreate this graph, instead applying the trendline to the entire dataset (not by vore)
ggplot(
  data = msleep,
  mapping = aes(x = brainwt, y = sleep_total)
) +
  geom_point(aes(color = vore)) +
  geom_smooth(method="lm")

#remove all trendlines, and instead produce a separate plot of sleep total vs. brain weight for each vore

ggplot(
  data = msleep,
  mapping = aes(x = brainwt, y = sleep_total)
) + 
  geom_point() +


#Create a plot to show how many of each vore are in the data set

ggplot(
  data = msleep,
  mapping = aes(x = vore)
) + geom_bar()

#Create a barplot to show the average sleep total for each vore
##Be careful here and look at your y axis to see if it is giving you what you expect.  This might require some additional research.

ggplot(
  data = msleep,
  mapping = aes(x = vore, y = sleep_total)
) + geom_bar(stat = "identity")

ggplot(
  data = msleep,
  mapping = aes(x = vore, y = sleep_total)
) + geom_bar(stat="summary")

#do the same thing, but with a boxplot

ggplot(
  data = msleep,
  mapping = aes(x = vore, y = sleep_total)
) + geom_boxplot()

#for your final question, ask an interesting question about these data and produce a beautiful graph with a Title and custom X and Y axis labels to answer it.
#provide your question (commented of course) first, then your code, then your conclusion 
