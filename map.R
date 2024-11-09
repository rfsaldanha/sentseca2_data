# Map

# Packages
library(sf)
library(geobr)
library(rmapshaper)
library(janitor)
library(dplyr)

# Import shapefile
geo_old <- st_read(dsn = "input_data/map/delimitacao_seca.shp")
geo <- read_municipality() |>
  filter(code_muni %in% geo_old$GEOCODIG_M) |>
  mutate(
    cod_mun = as.numeric(substr(code_muni, 0, 6))
  ) |>
  rename(
    name_mun = name_muni,
    name_uf = abbrev_state
  ) |>
  select(cod_mun, name_mun, name_uf) |>
  ms_simplify(
    keep = 0.90,
     keep_shapes = TRUE
  ) |>
  st_set_crs(4326) |>
  st_sf()

saveRDS(
  object = geo,
  file = "output_data/geo.rds",
  compress = TRUE
)
