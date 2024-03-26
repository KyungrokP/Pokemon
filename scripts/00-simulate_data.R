#### Preamble ####
# Purpose: Simulates an analysis dataset about Pokemon level and weaknesses
# Author: Kyungrok Park 
# Date: 26 Mar 2024
# Contact: kyungrok.park@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# Any other information needed?


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
data <-
  tibble(
    level = rnorm(n = 1000, mean = 100, sd = 10) |> floor(),
    weakness = sample(c("dire, not fire"), size = 1000, replace = TRUE)
  )



