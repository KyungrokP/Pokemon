#### Preamble ####
# Purpose: Cleans the raw plane data recorded by Statistics Canada
# Author: Kyungrok Park
# Date: 1 April 2024
# Contact: kyungrok.park@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)

#### Clean and save data for R&D budget dataset ####
raw_data <- read_csv("data/raw_data/raw_research_budget.csv")
selected_data <- raw_data[1:24, c("REF_DATE", "VALUE")]
colnames(selected_data) <- c("year", "amount_in_mils")
write_csv(selected_data, "data/analysis_data/research_budget.csv")

### Clean and save data for GNI dataset ###
raw_data2 <- read_csv("data/raw_data/GNI_data.csv")
selected_data2 <- raw_data2[raw_data2$Estimates == "Real gross national income, volume index 2017=100", ]
selected_data2 <- selected_data2[c("REF_DATE", "VALUE")]
colnames(selected_data2) <- c("date", "gni_in_2017volume")
selected_data4$year <- substr(selected_data4$date, 1, 4)
selected_data4$gni_in_2017volume <- as.numeric(selected_data4$gni_in_2017volume)
yearly_sum <- aggregate(gni_in_2017volume ~ year, selected_data4, sum)
write_csv(yearly_sum, "data/analysis_data/yearly_GNI_data.csv")

### Clean and save data for GDP dataset ###
raw_data3 <- read_csv("data/raw_data/GDP_data.csv")
selected_data3 <- raw_data3[1:96, c("REF_DATE", "VALUE")]
colnames(selected_data3) <- c("date", "amount_in_mils")
write_csv(selected_data3, "data/analysis_data/GDP_data.csv")

selected_data3$year <- substr(selected_data3$date, 1, 4)
selected_data3$amount_in_mils <- as.numeric(selected_data3$amount_in_mils)
yearly_sum2 <- aggregate(amount_in_mils ~ year, selected_data3, sum)
write_csv(yearly_sum2, "data/analysis_data/yearly_GDP_data.csv")

