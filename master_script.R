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



#Data import via Google Sheets
msat1<-
  read_sheet("https://docs.google.com/spreadsheets/d/1legFKoXPIPQsNmkzSJ16VjrEzXqmFb2xVauIH8cZHYM/edit?usp=sharing", sheet = "amac_msat_deployment_2021_p1_20_91_112_103", col_names = TRUE) |>
  clean_names()

#Data import via Excel
msat1 <- read_excel("amac_msat_data.xlsx", 
                             sheet = "amac_msat_deployment_2021_p1_20") |>
  clean_names()

View(msat1)

msat1 <- msat1 |>
  filter(status == "PS") |>
  select(id, marker_name, allele_1, allele_2) |>
  unite("genotype", allele_1, allele_2)

#pivot wider
msat_data_wide <- msat1 |>
  pivot_wider(names_from = marker_name, 
              values_from = genotype) |>
  column_to_rownames(var="id")

msat_genind <- msat_data_wide |>
  df2genind(sep = '_', ploidy = 2,  ncode = 3, NA.char = NA)

sum_msat_genind <- (summary(msat_genind))
sum_msat_genind

#make genpop object

msat_genpop <- genind2genpop(msat_genind)

#make a frequency table using makefreq from adegenet

afreq <- makefreq(msat_genpop)

#rearrange frequency table to three columns (locus, allele, frequency)




