#### Preamble ####
# Purpose: Tests the analysis data used located in the analysis_data file
# Author: Kyungrok Park
# Date: 18 February 2024
# Contact: Kyungrok Park 
# License: MIT
# Pre-requisites: Make sure to have research_budget.csv, yearly_GDP_data.csv and
# and yearly_GNI_data.csv


#### Workspace setup ####
library(tidyverse)
library(here)
#### Test data ####
research_budget <- 
  read_csv(here("data/analysis_data/research_budget.csv"))
GDP_data.csv <- 
  read_csv(here("data/analysis_data/yearly_GDP_data.csv"))
GNI_data.csv <- 
  read_csv(here("data/analysis_data/yearly_GNI_data.csv"))

#### Test data ####
# test whether the year starts from 2000 for all three datasets
research_budget$year |> min() == 2000 
GDP_data$year |> min() == 2000
GNI_data$year |> min() == 2000
# test whether the year ends at 2023 for all three datasets
research_budget$year |> max() == 2023 
GDP_data$year |> max() == 2023
GNI_data$year |> max() == 2023

# tests whether the amount of GDP, GNI and research budget is numeric
research_budget$amount_in_mils |> class() == "numeric"  
GDP_data$amount_in_mils |> class() == "numeric"
GNI_data$gni_in_2017volume |> class() == "numeric"


