#R4DS script
#modified 1/9/24

#package loadings
if (!require('tidyverse')) install.packages('tidyverse')
if (!require('palmerpenguins')) install.packages('palmerpenguins')
if (!require('ggthemes')) install.packages('ggthemes')
if (!require('nycflights13')) install.packages('nycflights13')

#library loadings
library(tidyverse)
library(palmerpenguins)
library(ggthemes)

#different ways to visualize data set
penguins
glimpse(penguins)
View(penguins)
?penguins

##creating a ggplot (see Section 1.2.2)

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
  geom_smooth(method="lm")

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

##Section 1.3

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point()

#more concise specification

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

#with a "pipe"

penguins |> 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

##Section 1.4

#categorical variable and a new geom
ggplot(penguins, aes(x = species)) +
  geom_bar()

#reordered factors
ggplot(penguins, aes(x = fct_infreq(species))) +
  geom_bar()

#numerical variable and geom_histogram
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200)

ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 20)

ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 2000)


#geom_density
ggplot(penguins, aes(x = body_mass_g)) +
  geom_density() 

#1.4.3 exercises

# 1) Make a bar plot of species of penguins, where you assign species to the y aesthetic. How is this plot different?
#   
# 2)  How are the following two plots different? Which aesthetic, color or fill, is more useful for changing the color of bars?
#   
#     ggplot(penguins, aes(x = species)) +
#       geom_bar(color = "red")
# 
#     ggplot(penguins, aes(x = species)) +
#       geom_bar(fill = "red")
# 
# 3) What does the bins argument in geom_histogram() do?
#   
# 4) Make a histogram of the carat variable in the diamonds dataset that is available when you load the tidyverse package. 
#     Experiment with different binwidths. What binwidth reveals the most interesting patterns?
# 

##Section 1.5

#Relationship between numerical and categorical variable with different geoms
ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()

ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_point()

ggplot(penguins, aes(x = body_mass_g, color = species)) +
  geom_density(linewidth = 0.75)

#mapping variable species to both color and fill aesthetics
#setting fill aesthetic to a value (0.5)
ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) +
  geom_density(alpha = .1)

#stacked barplot
ggplot(penguins, aes(x = island)) +
  geom_bar()

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()

#using position argument to change behavior of stacked barplot
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

#getting complicated.  Three or more variables
#basic plot
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()
#adding mappings for species and island
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = island))
#cleaner way to do this with faceting
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_grid(~species)

##Section 3: Data Manipulation

library(nycflights13)
library(tidyverse)

flights

#The first tidyverse row function: filter

#filter operates on ROWS and filters IN (includes matching rows)

flights |> 
  filter(dep_delay > 120)

# Flights that departed on January 1
flights |> 
  filter(month == 1 & day == 1)

# Flights that departed in January or February
flights |> 
  filter(month == 1 | month == 2)

# multiple operations in a pipe

flights |> 
  filter(dep_delay > 120) |>
  filter(month == 1 & day == 1)

# A shorter way to select flights that departed in January or February
# note the %in% operator.  this includes anything in the following list.  Note that the Boolean OR is invoked here.  

flights |> 
  filter(month %in% c(1, 2))

#saving to a variable
jan1 <- flights |> 
  filter(month == 1 & day == 1)
#calling the variable
jan1

##Section 3.2.2: Common Mistakes

flights |> 
  filter(month = 1)

flights |> 
  filter(month == 1 | 2)

#3.2.3 our next row function: arrange
#changes order of rows based on column values

flights |> 
  arrange(dep_delay,year, month, day)

#change sort order to descending (ascending is default)
flights |> 
  arrange(desc(dep_delay))

#3.2.4 distinct

# Remove duplicate rows, if any
flights |> 
  distinct()

# Find all unique origin and destination pairs
flights |> 
  distinct(origin, dest)

#as above, keeping all columns
flights |> 
  distinct(origin, dest, .keep_all = TRUE)

#Section 3.3: Column functions

#mutate (you'll probably use this one more than any other)

new_flights <- flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .after = day
  )

View(new_flights)

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before = 1
  )

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .after = day
  )

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours,
    .keep = "used"
  )

#select: filters by column instead of row
#just like filter, select selects IN, not OUT

flights |> 
  select(year, month, day)

flights |> 
  select(year:day)

flights |> 
  select(!year:day)

flights |> 
  select(where(is.numeric))

#one way to rename a column
#syntax for this is select(<new_value> = <old_value>)

new_flights <- flights |> 
  select(tail_num = tailnum)

#rename can also be used for this
new_flights <- flights |> 
  rename(tail_num = tailnum)

#relocate

flights |> 
  relocate(time_hour, air_time)

flights |> 
  relocate(year:dep_time, .after = time_hour)

flights |> 
  relocate(starts_with("arr"), .before = dep_time)

##Section 3.5: group_by() and summarize()

flights |> 
  group_by(month)

flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay)
  )

flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE)
  )

flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    sd_delay = sd(dep_delay, na.rm = TRUE),
    max_delay = max(dep_delay, na.rm = TRUE),
    min_delay = min(dep_delay, na.rm = TRUE)
  )

#try this with slice_head, slice_tail, slice_min, slice_sample

flights |> 
  group_by(dest) |> 
  slice_min(arr_delay, n = 1) |>
  relocate(dest)

#grouping by multiple variables

daily <- flights |>  
  group_by(year, month, day)
daily

daily_flights <- daily |> 
  summarize(n = n())
daily_flights

## Section 5: Data tidying and pivoting

#table 1 is tidy

table2 |>
  mutate(rate = cases / population * 10000)

table1 |> 
  group_by(country) |> 
  summarize(total_cases = sum(cases))

ggplot(table1, aes(x = year, y = cases)) +
  geom_line(aes(group = country), color = "grey50") +
  geom_point(aes(color = country, shape = country)) +
  scale_x_continuous(breaks = c(1999, 2000)) 

#table 2 has variables as values

table2

#what's untidy about table 3?

table3 

#lengthening data 

df <- tribble(
  ~id,  ~bp1, ~bp2,
  "A",  100,  120,
  "B",  140,  115,
  "C",  120,  125
)

df |> 
  pivot_longer(
    cols = bp1:bp2,
    names_to = "measurement",
    values_to = "value"
  )

#making data wider

df <- tribble(
  ~id, ~measurement, ~value,
  "A",        "bp1",    100,
  "B",        "bp1",    140,
  "B",        "bp2",    115, 
  "A",        "bp2",    120,
  "A",        "bp3",    105
)

df |> 
  pivot_wider(
    names_from = measurement,
    values_from = value
  )

##Regular Expressions (Section 15)

#literal matches
str_view(fruit, "berry")

#any character (.)
str_view(fruit, "a...e")

#quantifiers (?, +, *)
str_view(c("a", "ab", "abb"), "ab?")

str_view(c("a", "ab", "abb"), "ab+")

str_view(c("a", "ab", "abb"), "ab*")

#character classes ([])

str_view(words, "[aeiou]x[aeiou]")

#negated character class ([^])

str_view(words, "[^aeiou]y[^aeiou]")

#alternation (|)
str_view(fruit, "apple|melon|nut")
str_view(fruit, "aa|ee|ii|oo|uu")

str_view(fruit, "o{2}")

