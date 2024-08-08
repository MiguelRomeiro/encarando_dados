#Carregando e plotando dados iniciais

#Carregar shapefiles do mapa global
world <- ne_countries(scale = "medium", returnclass = "sf")

#Selecionando apenas o shapefile do Brasil
brazil <- world[world$admin == "Brazil", ]

#Carregando seus dados - o códico considera um arquivo bruto no formato .csv e que contenha, pelo menos, duas colunas com as coordenadas dos pontos de interesse/amostragem - "lat" e "lon". Uma terceira coluna (id), com as identificações de cada ponto também é prevista pelo código. Caso não seja este seu caso, adapte o código de forma adequada.
data_raw <- read.csv(here("your", "path", "to", "raw", "data"))

#Criando um objeto separado para que os dados brutos não sejam alterados diretamente
coords <- data.frame(lat = data_raw$lat, lon = data_raw$long, id =  data_raw$name)
#Omissão de observações sem coordenadas 
coords_clean <- na.omit(coords)

#Transforma os pontos fornecidos em objetos do tipo "sf" (simple feature), a fim de serem utilizados como pontos espaciais
coords_sf <- st_as_sf(coords_clean, coords = c("lon", "lat"), crs = 4326)

#Plot simples dos pontos ao longo do Brasil
ggplot() +
  geom_sf(data = brazil, fill = "white", color = "black") +
  geom_sf(data = coords_sf, color = "red", size = 1) +
  labs(title = "Points along in Brazil",
       x = "Longitude",
       y = "Latitude")

# Obtendo os dados do WorldClim
# O argumento 'var' requer uma das seguintes opções:

  # tmean = average monthly mean temperature (°C * 10)
  # tmin = average monthly minimum temperature (°C * 10)
  # tmax = average monthly maximum temperature (°C * 10)
  # prec = average monthly precipitation (mm)
  # bio = bioclimatic variables derived from the tmean, tmin, tmax and prec
  # alt = altitude (elevation above sea level) (m) (from SRTM)
  # m = month of the year, from 1 (January) to 12 (December)
  # x = code for the bioclimatic variable

# O argumento 'res' indica qual a resolução espacial (tamanho do píxel, em minutos) que o raster será baixado. Atenção: imagens de alta resolução podem demorar para serem baixadas e, portanto, tomar um tempo. As opções disponíveis para este argumento são: 

  # 0.5
  # 1
  # 2.5
  # 5
  # 10

# Aqui, as imagens (.tif) são baixadas para o diretório especificado
climate <- worldclim_global(var = "bio", res = 0.5 , version = "2.1", path = here("your", "path", "to", "raw", "data"))

# Aqui, são extraídos os dados das coordenadas fornecidas
climate_data <- raster::extract(climate, coords_sf)

# Aqui, os dados climáticos são colados a tabela com as coordenadas
result <- cbind(st_coordinates(coords_sf), climate_data)
result$id <- coords_sf$id
result$id <-as.factor(result$name)

data_processed <- merge(result, data_raw, by = "id", all.x = TRUE)

data <- data_processed[order(-data_processed$lat), ]

names(data_processed)[names(data_processed) == "X.x"] <- "lon"
names(data_processed)[names(data_processed) == "Y"] <- "lat"
