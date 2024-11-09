# Health data

library(dplyr)

# Asma
tab2 <- readRDS("input_data/health/tab2.rds") |>
  select(yearmonth = anomes, cod_mun = cod_munic, age_group = fx_etaria, value = valor) |>
  mutate(
    year = as.numeric(substr(yearmonth, 0, 4)),
    month = as.numeric(substr(yearmonth, 5, 7)),
    indi = "Taxa de internação por asma"
  ) |>
  select(-yearmonth) |>
  relocate(indi, year, month, .before = cod_mun) 

# Dengue
tab4 <- readRDS("input_data/health/tab4.rds") |>
  select(yearmonth = anomes, cod_mun = cod_munic, age_group = fx_etaria, value = valor) |>
  mutate(
    year = as.numeric(substr(yearmonth, 0, 4)),
    month = as.numeric(substr(yearmonth, 5, 7)),
    indi = "Taxa de internação por dengue"
  ) |>
  select(-yearmonth) |>
  relocate(indi, year, month, .before = cod_mun) 

# DDA
tab5 <- readRDS("input_data/health/tab5.rds") |>
  select(yearmonth = anomes, cod_mun = cod_munic, age_group = fx_etaria, value = valor) |>
  mutate(
    year = as.numeric(substr(yearmonth, 0, 4)),
    month = as.numeric(substr(yearmonth, 5, 7)),
    indi = "Taxa de internação por diarréia"
  ) |>
  select(-yearmonth) |>
  relocate(indi, year, month, .before = cod_mun) 

#c(, ""De 10 a 19 anos", "De 20 a 64 anos", "De 65 a 99 anos")

health <- bind_rows(tab2, tab4, tab5) |>
  mutate(
    age_group = as.character(age_group),
    age_group = case_match(
      age_group,
      "4" ~ "De 0 a 4 anos",
      "509" ~ "De 5 a 9 anos",
      "1019" ~ "De 10 a 19 anos",
      "2064" ~ "De 20 a 64 anos",
      "6500" ~ "De 65 a 99 anos"
    )
  )

saveRDS(health, "output_data/health.rds")
