# PACOTES ===================================================================================================================================================

# install.packages("pacman")
pacman::p_load(tidyverse, rio, ggthemes, paletteer, scales, shiny, sf, 
               rsconnect, bslib, bsicons, Cairo, ggiraph, showtext, conflicted)


# DEFINICOES INICIAIS =======================================================================================================================================

# Fontes:
showtext_auto()
font_add_google("Open Sans", "opensans")


# Tema:
theme_set(theme_hc(base_family = "opensans"))


# Notacao cientifica e melhoria grafica:
options(scipen = 999, shiny.usecairo = TRUE)


# Importando dados:
Dados4 <- import("DenunciasLGBTQIA2024.Rdata", trust = TRUE)
GeoEstado2 <- import("Geolocalizacoes.Rdata", trust = TRUE)


# Convertendo em sf:
GeoEstado2 <- st_as_sf(GeoEstado2)


# CHAMANDO SCRIPTS ==========================================================================================================================================

# Scripts do shiny:
Scripts <- c("TabelasYGraficosDinamicos.R", "cards.R", "conteudoPaginas.R")


# Importando scripts:
map(Scripts, source)
