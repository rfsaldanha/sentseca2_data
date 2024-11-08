# Map

# Packages
library(sf)
library(rmapshaper)
library(janitor)
library(dplyr)

# Import shapefile
geo <- st_read(dsn = "input_data/map/delimitacao_seca.shp") |>
  clean_names() |>
  select(-geocodig_m) |>
  rename(
    cod_uf = uf,
    name_uf = sigla,
    cod_mun = cod6,
    name_mun = nome_munic,
    name_meso = nome_meso,
    cod_micro = microrregi,
    name_micro = nome_micro
  ) |>
  ms_simplify(
    keep = 0.001,
     keep_shapes = TRUE
  )

saveRDS(
  object = geo,
  file = "output_data/geo.rds",
  compress = FALSE
)
