library(tidyverse)

x<-1

x <- as.character("Also (and I know I’ve asked this of some already), when you send me your github username, please include a self-ranking of your current awesomeness with R and Tidyverse.") 

x|>
str_match(".*([TICKS!]).*([a-z]{2})e,.*(?:rr).{4}([a-z]{7}).*")
