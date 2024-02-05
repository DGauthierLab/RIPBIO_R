##R master script for microsatellite analysis

#package loadings
if (!require('adegenet')) install.packages('adegenet')
if (!require('pegas')) install.packages('pegas')
if (!require('janitor')) install.packages('janitor')
if (!require('tidytext')) install.packages("tidytext")

##library loadings
library('adegenet')
library('ggplot2')
library('dplyr')
library('tidyverse')
library('readxl')
library('janitor')
library('pegas')
library('tidyverse')
library('tidyr')
library('tidytext')
library('googlesheets4')

#Sets working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


#Data import
msat1<-
  read_sheet("https://docs.google.com/spreadsheets/d/1legFKoXPIPQsNmkzSJ16VjrEzXqmFb2xVauIH8cZHYM/edit?usp=sharing", sheet = "amac_msat_deployment_2021_p1_20_91_112_103", col_names = TRUE) |>
  clean_names()