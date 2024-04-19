#### Preamble ####
# Purpose: Covert the downloaded csv files from Statistics Canada to parquet files
# Author: Kyungrok Park
# Date: 17 April 2024
# Contact: kyungrok.park@mail.utoronto.ca
# License: MIT

library(arrow)
library(here)

### convert raw_data.csv to raw_data.parquet ###
GDP_data <- read.csv(here("data/raw_data/GDP_data.csv"))
arrow_table <- as_arrow_table(GDP_data)
write_parquet(arrow_table, here("data/raw_data/GDP_data.parquet"))

GNI_data <- read.csv(here("data/raw_data/GNI_data.csv"))
arrow_table2 <- as_arrow_table(GNI_data)
write_parquet(arrow_table2, here("data/raw_data/GNI_data.parquet"))

research_data <- read.csv(here("data/raw_data/raw_research_budget.csv"))
arrow_table3 <- as_arrow_table(research_data)
write_parquet(arrow_table3, here("data/raw_data/raw_research_budget.parquet"))
