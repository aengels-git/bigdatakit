usethis::use_description()
usethis::use_readme_rmd() 
library(devtools)
document()
library(tidyverse)
walk(c("arrow","DT","fs","rlang","dplyr","glue","readr"),function(current_package){
  usethis::use_package(current_package)
})
usethis::use_package("stringr")

devtools::build_readme() 
load_all()

# Example:



glimpse_files("big_diamonds.csv")

grab_paths(".")
devtools::install_github("aengels-git/bigdatakit")
library(devtools)
library(bigdatakit)
grab_paths(".","csv$")


library(viskit)
color_fct(diamonds$cut)
