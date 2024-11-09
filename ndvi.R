# NDVI

library(dplyr)

ndvi <- readRDS("input_data/ndvi/tab7.rds") |>
  rename(
    cod_mun = cod6,
    yearmonth = tempo,
    value = valor
  ) |>
  mutate(
    year = as.numeric(substr(yearmonth, 1,4)),
    month = as.numeric(substr(yearmonth, 5,6)),
    value = round(value, 2)
  ) |>
  select(-yearmonth) |>
  relocate(value, .after = month) |>
  as_tibble()

saveRDS(ndvi, "output_data/ndvi.rds")

