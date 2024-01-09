####Initialize####
library(ggplot2)
library(tidyverse)
library(pwr)
library(car)
library(MASS)
library(lmtest)
library(tseries)
library(ggfortify)
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

####generate tibble of 3 tick populations####
#generate normally distributed random numbers
pop1=rnorm(100,18.2,1)
pop2=rnorm(100,20.2,2)
pop3=rnorm(100,21.7,1.5)

tickwts <- cbind(pop1,pop2,pop3)
View(tickwts)
tickwts <- as_tibble(tickwts)


tickwts <- as_tibble(tickwts) %>% 
  pivot_longer(
    everything(),
    names_to = "population",
    values_to = "weight_mg"
  ) %>%
  mutate(pop.f = as.factor(population)) %>%
  mutate(pop.f=case_match(pop.f, "pop1" ~ "1", "pop2" ~ "2", "pop3" ~ "3")) %>%
  mutate(pop.f=as.numeric(pop.f)) %>%
  arrange(population)

pop.f <- as.factor(tickwts$population)
case_match(pop.f, "pop1" ~ "1", "pop2" ~ "2", "pop3" ~ "3")

####make scatterplot, boxplot, histograms####
plot2 <- tickwts %>% 
  filter(population=="pop1" | population =="pop2") %>%
  ggplot(aes(x=population,
             y=weight_mg)) +
  geom_point(size = 3) 
plot2




plot3 <- tickwts %>% 
  ggplot(aes(x=population,
             y=weight_mg)) +
  geom_point(size = 3)
plot3


population.f <- factor(tickwts$population)
recode_factor(population.f, pop1="1", pop2="2",pop3="3")
reg<-lm(formula = weight_mg ~ pop.f,
        data=tickwts)                      

#get intercept and slope value
coeff<-coefficients(reg)          
intercept<-coeff[1]
slope<- coeff[2]

# add the regression line
plot3+geom_abline(intercept = intercept, slope = slope, color="red", 
                  linetype="dashed", linewidth=1.5)


boxplot2 <- tickwts %>% 
  filter(population == "pop1" | population == "pop2") %>%
  ggplot(aes(x=population,
             y=weight_mg)) +
  geom_boxplot()
boxplot2

boxplot3 <- tickwts %>% 
  ggplot(aes(x=population,
             y=weight_mg)) +
  geom_boxplot()
boxplot3

histo2 <- tickwts %>% 
  filter(population == "pop1" | population == "pop2") %>%
  ggplot(aes(y=weight_mg, color=population)) +
  geom_histogram() +
  coord_flip()
histo2

histo3 <- tickwts %>% 
  ggplot(aes(y=weight_mg, color=population)) +
  geom_histogram() +
  coord_flip()
histo3

####T-test and T-statistic for pop1,pop2####
ttest <- t.test(pop1,pop2)
ttest
tstat <- ttest$statistic
tstat

####power calculation####
pwr.t.test(100,0.5,0.05)

####t-distribution graphic####
plot(function(x) dt(x, df = 198), -4, 4, ylim = c(0, 0.7),
     main = "t-distribution", yaxs = "i", xlab= "stdev")
abline(v=1, col="darkgreen")
abline(v=-1, col="darkgreen")
abline(v=-2, col="green")
abline(v=2,col="green", )
       abline(v=tstat, col="red",lty = 4)
       
####regression example####
       set.seed(1234)
       
       ##Linear Regression
       #Generate the independent variable and the error
       x1=rnorm(100,50,9)
       x2=rnorm(100,200,64)
       error=rnorm(100,0,16)
       #Generate the dependent variable (b0=150, b1=-4, b2=2.5)
       y1=150-(4*x1)+(2.5*x2)+error
       #create the model
       m1=lm(y1~x2)
       summary(m1)
       plot(x1,y1)
       abline(lm(y1~x1))
       #autoplot(m1)
