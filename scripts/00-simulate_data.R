#### Preamble ####
# Purpose: Simulates an analysis dataset about yearly_GDP_data and research_budget
# Author: Kyungrok Park 
# Date: 18 April 2024
# Contact: kyungrok.park@mail.utoronto.ca
# License: MIT



#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Simulate data ####
set.seed(222) # set a seed number to assign the simulated data 
simulated_gdp_data <- 
  # make a tibble which includes two columns, year and amount for GDP  
  # between 1000 and 10000
  tibble(
    year = 2000:2023, # make year column from 2000 to 2023
    GDP_amount = sample(1000:10000, size=24, replace = TRUE), 
    # Assign the random number between 1000 and 10000
    )
simulated_research_budget <-
  # make a tibble which includes two columns, year and amount for R&D budget
  # between 100 and 1000
  tibble(
    year = 2000:2023, # make year column from 2000 to 2023
    research_amount = sample(100:1000, size=24, replace = TRUE), 
    # Assign the random number between 100 and 1000
  )


merged_simulated_data <-# merge the two simulated datasets by year
  merge(
    x = simulated_gdp_data, 
    y = simulated_research_budget,
    by.x = "year",
    by.y = "year",
    all = T
  )

simulated_model <- # perform linear regression for GDP amount and research amount
  lm(GDP_amount~research_amount, data = merged_simulated_data)
summary(simulated_model)
