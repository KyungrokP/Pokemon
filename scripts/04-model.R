#### Preamble ####
# Purpose: Models linear regression model for GNI/GDP/Nominal share and R&D expenditure
# Author: Kyungrok Park
# Date: 14 April 2024
# Contact: kyungrok.park@mail.utoronto.ca
# License: MIT
# Pre-requisites: Follow the workspace setup to use the required packages


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
research_budget <- read_csv(here("data/analysis_data/research_budget.csv"))
GDP_data <- read_csv(here("data/analysis_data/yearly_GDP_data.csv"))
GNI_data <- read_csv(here("data/analysis_data/yearly_GNI_data.csv"))


### Make a new column for change in rate by year for GNI_data ###
GNI_data <- mutate(GNI_data, change_in_gni = 
                     c(NA, diff(gni_in_2017volume)))

# Calculate the change rate in GNI by year
GNI_data <- mutate(GNI_data, change_rate = 
                     ifelse(is.na(change_in_gni), NA,
                            change_in_gni / lag(gni_in_2017volume) * 100))

# Create a table for the change rate in GNI by year
rate_table <- select(GNI_data, year, change_rate)

research_budget <- arrange(research_budget, year)

# Calculate the change in research budget amount by year
research_budget <- mutate(research_budget, change_in_amount = c(NA, diff(amount_in_mils)))

# Calculate the change rate in research budget amount by year
research_budget <- mutate(research_budget, change_rate = ifelse(is.na(change_in_amount), NA, change_in_amount / lag(amount_in_mils) * 100))

# Create a table for the change rate in research budget amount by year
rate_table2 <- select(research_budget, year, change_rate)

rate_table2 <- rate_table2 |>
  rename(change_rate_in_research_budget = change_rate)


### make merged_tables for change in rate of GNI and research budget and perform regression ###
merged_rates <- merge(rate_table, rate_table2, by = "year", all = TRUE)

# Remove rows with missing values
merged_rates <- na.omit(merged_rates)

# Perform linear regression
model1 <- lm(change_rate ~ change_rate_in_research_budget, data = merged_rates)
modelsummary(model1)
saveRDS(model1, "models/first_model.rds")

GDP_data <- mutate(GDP_data, change_in_amount = c(NA, diff(amount_in_mils)))

# Calculate the change rate in GNI amount by year
GDP_data <- mutate(GDP_data, change_rate = ifelse(is.na(change_in_amount), NA, change_in_amount / lag(amount_in_mils) * 100))

rate_table3 <- select(GDP_data, year, change_rate)

merged_rates2 <- merge(rate_table3, rate_table2, by = "year", all = TRUE)

# Remove rows with missing values
merged_rates2 <- na.omit(merged_rates2)

# Perform linear regression
model2 <- lm(change_rate ~ change_rate_in_research_budget, data = merged_rates2)

saveRDS(model2, "models/second_model.rds")


### calculate the nominal share by year and perform linear regression for change in GDP and nominal share

GDP_data <- GDP_data |>
  mutate(change_in_nominal_share = c(NA, diff(nominal_share)))
model3 <- lm(change_rate~change_in_nominal_share, data = GDP_data)
summary(model3)
saveRDS(model3, here("models/third_model.rds"))
