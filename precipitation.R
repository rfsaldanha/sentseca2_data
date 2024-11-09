# Precipitation

library(dplyr)
library(tidyr)

prec <- readRDS("input_data/precipitation/tab1.rds") |>
  pivot_longer(cols = `200001`:`202312`) |>
  mutate(
    year = as.numeric(substr(name, 1,4)),
    month = as.numeric(substr(name, 5,6))
  ) |>
  select(-name) |>
  rename(cod_mun = cod6) |>
  relocate(value, .after = month)

saveRDS(prec, "output_data/prec.rds")


