####Initialize####
library(ggplot2)
library(tidyverse)
library(pwr)
####Distributions####
x_dhyper <- seq(0, 4, by = 1)

# Apply dhyper function
y_dhyper <- dhyper(x_dhyper, m = 4, n = 4, k = 4)   

# Plot dhyper values
barplot(y_dhyper, ylab = "Probability", xlab = "Successes", names.arg = c(0,1,2,3,4)) 
abline (h=0.05, col="red")

#Create a sequence of 100 equally spaced numbers between -4 and 4
x <- seq(-4, 4, length=100)

#create a vector of values that shows the height of the probability distribution
#for each value in x
y <- dnorm(x)

#plot x and y as a scatterplot with connected lines (type = "l") and add
#an x-axis with custom labels
plot(x,y, type = "l", lwd = 2, axes = FALSE, xlab = "", ylab = "")
axis(1, at = -3:3, labels = c("-3s", "-2s", "-1s", "mean", "1s", "2s", "3s"))


#generate normally distributed random numbers
pop1=rnorm(100,19.5,1)
pop2=rnorm(100,20,2)

tickwts <- cbind(pop1,pop2)
View(tickwts)
tickwts <- as_tibble(tickwts)


tickwts <- as_tibble(tickwts) %>% 
  pivot_longer(
    everything(),
    names_to = "population",
    values_to = "weight_mg"
  ) %>%
  arrange(population)

plot <- tickwts %>% 
  ggplot(aes(x=population,
             y=weight_mg)) +
  geom_point(size = 3)

boxplot <- tickwts %>% 
  ggplot(aes(x=population,
             y=weight_mg)) +
  geom_boxplot()

histo <- tickwts %>% 
  ggplot(aes(y=weight_mg, color=population)) +
  geom_histogram() +
  coord_flip()
histo

ggplot(tickwts, aes(x = (weight_mg),
                    y = after_stat(density),
                    color=population)) + 
  geom_histogram(alpha =0.5) +
  geom_density( 
    size = 2) +
  geom_vline(xintercept=mean(pop1), color="red") +
  geom_vline(xintercept=mean(pop2), color="blue")


ttest <- t.test(pop1,pop2)
ttest
tstat <- ttest$statistic
tstat


pwr.t.test(100,0.1,0.05)


plot(function(x) dt(x, df = 3), -4, 4, ylim = c(0, 0.7),
     main = "t-distribution", yaxs = "i")
abline(v=-2, col="green")
abline(v=2,col="green")
       abline(v=tstat)
