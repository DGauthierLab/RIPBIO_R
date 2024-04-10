
###The Related package requires an install of gfortran on your system.  Before you run the code below, you will need to do the following:

####Mac:  If you don't already have it, install Homebrew:
#in terminal:
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/dgauthie/.zprofile
#eval "$(/opt/homebrew/bin/brew shellenv)". ***REPLACE /Users/dgauthie/.zprofile with your own username***
#brew update
#brew install gcc
#which gfortran
#mkdir -p ~/.R
#touch ~/.R/Makevars
#nano ~/.R/Makevars 
## within the ~/.R/Makevars file, enter the following:
#FC      = /opt/homebrew/bin/gfortran
#F77     = /opt/homebrew/bin/gfortran
#FLIBS   = -L/usr/local/opt/gcc/lib
#you may need to modify the above paths depending on where gfortran installed.  Check this with %which gfortran

####Windows and Linux:  See https://fortran-lang.org/learn/os_setup/install_gfortran/

library('related')

df <- msat_data_wide_genind_5tick |>
  rownames_to_column(var = "id")

f = function(x) { df %>% select_("id", x) %>% separate_(x, paste0(x, c(".1",".2"))) }

related <- names(df)[3:9] %>%             # get names of columns you want to separate
  map(f) %>%                   # apply the function above to each name (will create a list of dataframes)
  reduce(left_join, by="id") %>%
  replace(is.na(.), 0)

input <- readgenotypedata(related)

#estimator comparison
compest <- compareestimators(input, 100)
save(compest, file = "data/compest.Rdata")
pdf(file = "images/Estimators.pdf")
compest
dev.off()

#generate relatedness data
rel <- coancestry(input$gdata, trioml = 2, wang = 2, allow.inbreeding = TRUE)
save(rel, file="data/rel.Rdata")

#simulations
sim <- familysim(input$freqs, 100)
simoutput <- coancestry(sim, wang=2, trioml = 2)
simrel <- cleanuprvals ( simoutput$relatedness , 100)
save(simrel, file = "data/simrel.Rdata")

#load related data objects
load("data/rel.Rdata")
load("data/simrel.Rdata")
load("data/compest.Rdata")

#Plot relatedness data
#basic scatterplot

wang_rel <- ggplot(data = rel$relatedness, aes(x=group, y=wang)) +
  geom_point(shape=1)
wang_rel

trioml_rel <- ggplot(data = rel$relatedness, aes(x=group, y=trioml)) +
  geom_point(shape=1)
trioml_rel

pdf(file = "images/Wang_scatter.pdf")
wang_rel
dev.off()