# DEFINICOES INICIAIS ====================================================================================================

# Diretorio:
setwd(r"(H:\Estudos\R\Shiny\Painel-LGBTQIAPN-Disque100-2024\BaseR)")


# Carregando pacotes:
# install.packages("pacman")
pacman::p_load(tidyverse, rio, geobr, sf, ggthemes, paletteer, scales, rvg, officer, rmapshaper)

# Tema:
theme_set(theme_hc())

# Retira notacao cientifica:
options(scipen = 999)


# FUNCOES ================================================================================================================

# Salvar graficos como imagem:
Salv.Graf <- function(NOME, DIMENSOES){
  
  LARGURA <- if_else(DIMENSOES == 1, 6.75, 12)
  
  ggsave(filename = NOME, 
         device = png, type = "cairo", dpi = 300, 
         width = LARGURA, height = 6.75, units = "in")
  
}


# Salvar grafico em formato power point:
Salv.pptx <- function(NOME, DIMENSOES){
  
  LARGURA <- if_else(DIMENSOES == 1, 6.75, 12)
  
  # Criando a apresentacao
  ppt <- officer::read_pptx()
  
  # Adicionando um slide em branco
  ppt <- officer::add_slide(ppt, layout = "Title and Content", master = "Office Theme")
  
  # Inserindo grafico como objeto vetorial (editavel)
  ppt <- officer::ph_with(ppt, dml(ggobj = last_plot(), bg = "transparent"), 
                          location = ph_location(width = LARGURA, 
                                                 height = 6.75, left = 0, top = 0))
  
  # Salvando a apresentacao
  print(ppt, target = NOME)
  
}


# IMPORTANDO DADOS =======================================================================================================

# Importando dados:
Dados4 <- import("DenunciasLGBTQIA2024.Rdata", trust = TRUE)
GeoEstado2 <- import("Geolocalizacoes.Rdata", trust = TRUE)

# Convertendo em sf:
GeoEstado2 <- st_as_sf(GeoEstado2)


# TABELAS E GRAFICOS =====================================================================================================

# Denuncias por Regiao e Orientacao sexual -------------------------------------------------------------------------------

# Tabela 1:
DenunciaRegiaoVitima <- Dados4 %>% 
  
  select(hash, Regiao, Orientação_sexual_da_vítima) %>% distinct() %>% 
  
  group_by(Regiao, Orientação_sexual_da_vítima) %>% count(name = "Total") %>% 
  
  mutate(Individuo = "Vítima") %>% 
  
  rename(`Orientação Sexual` = Orientação_sexual_da_vítima)


# Tabela 2:
DenunciaRegiaoSuspeito <- Dados4 %>% 
  
  select(hash, Regiao, Orientação_sexual_do_suspeito) %>% distinct() %>% 
  
  group_by(Regiao, Orientação_sexual_do_suspeito) %>% count(name = "Total") %>% 
  
  mutate(Individuo = "Suspeito") %>% 
  
  rename(`Orientação Sexual` = Orientação_sexual_do_suspeito)


# Tabela 3:
DenunciaRegiao <- bind_rows(DenunciaRegiaoVitima, DenunciaRegiaoSuspeito) %>% 
  
  dplyr::filter(Individuo == "Vítima") %>% group_by(Regiao) %>% 
  
  mutate(Percentual = round(100 * Total / sum(Total), 2))


# Grafico:
ggplot(DenunciaRegiao, aes(x = `Orientação Sexual`, 
                           y = Total, fill = `Orientação Sexual`)) +
  
  geom_bar(stat = "identity") + 
  
  scale_fill_paletteer_d("rcartocolor::Prism") +
  
  facet_wrap(~ Regiao, scales = "free") +
  
  scale_y_continuous(labels = label_comma(big.mark = ".", decimal.mark = ","),
                     expand = expansion(mult = c(0, 0.2))) +
  
  labs(x = "Região", y = "Quantidade total/percentual",
       fill = "Orientação sexual") +
  
  geom_text(aes(label = paste0(format(Percentual, nsmall = 2), "%")),
                        # fontface = "bold", 
                        vjust = -0.5, size = 3.2) +
  
  theme(axis.text.x = element_blank(), axis.ticks = element_blank(),
        
        axis.title.y = element_text(angle = 90,
                                    margin = margin(r = 0.3, unit = "cm")),
        axis.title.x = element_text(margin = margin(t = 0.3, unit = "cm")), 
        
        # axis.title = element_text(color = "#5e5e5e", face = "bold")
  )

# Salvar imagem:
Salv.Graf("Denúncias por Região e Orientação sexual.png", 2)

# Salvar power point:
Salv.pptx("Denúncias por Região e Orientação sexual.pptx", 2)


# Denuncias por Mes e Orientacao sexual ----------------------------------------------------------------------------------

# Tabela 1:
DenunciaMesVitima <- Dados4 %>% 
  
  select(hash, Mes, Orientação_sexual_da_vítima) %>% distinct() %>% 
  
  group_by(Mes, Orientação_sexual_da_vítima) %>% count(name = "Total") %>% 
  
  mutate(Individuo = "Vítima") %>% 
  
  rename(`Orientação Sexual` = Orientação_sexual_da_vítima)


# Tabela 2:
DenunciaMesSuspeito <- Dados4 %>% 
  
  select(hash, Mes, Orientação_sexual_do_suspeito) %>% distinct() %>% 
  
  group_by(Mes, Orientação_sexual_do_suspeito) %>% count(name = "Total") %>% 
  
  mutate(Individuo = "Suspeito") %>% 
  
  rename(`Orientação Sexual` = Orientação_sexual_do_suspeito)


# Tabela 3:
DenunciaMes <- bind_rows(DenunciaMesVitima, DenunciaMesSuspeito) %>% 
  
  dplyr::filter(Individuo == "Vítima") %>% group_by(Mes) %>% 
  
  mutate(Percentual = round(100 * Total / sum(Total), 2))


# Grafico:
ggplot(DenunciaMes, aes(x = Mes, y = Total, 
                        group = `Orientação Sexual`, 
                        fill = `Orientação Sexual`)) +
  
  geom_bar(stat = "identity") + scale_fill_paletteer_d("rcartocolor::Prism") +
  
  scale_y_continuous(labels = label_comma(big.mark = ".", decimal.mark = ",")) +
  
  labs(x = "Mês", y = "Quantidade total/percentual", fill = "Orientação sexual") +
  
  geom_text(aes(label = paste0(format(Percentual, nsmall = 2), "%")),
            # fontface = "bold", 
            color = "white", position = position_stack(vjust = 0.5), size = 3.2) +
  
  theme(axis.ticks = element_blank(),
        axis.title.y = element_text(angle = 90,
                                    margin = margin(r = 0.3, unit = "cm")),
        axis.title.x = element_text(margin = margin(t = 0.3, unit = "cm")), 
        
        # text = element_text(color = "#5e5e5e", face = "bold")
  )

# Salvar imagem:
Salv.Graf("Denúncias por Mês e Orientação sexual.png", 2)

# Salvar power point:
Salv.pptx("Denúncias por Mês e Orientação sexual.pptx", 2)


# Denuncias por Cor/Raca e Orientacao sexual -----------------------------------------------------------------------------

# Tabela 1:
DenunciaCorRacaVitima <- Dados4 %>% 
  
  select(hash, Raça_Cor_da_vítima, Orientação_sexual_da_vítima) %>% 
  
  distinct() %>% 
  
  group_by(Raça_Cor_da_vítima, Orientação_sexual_da_vítima) %>% 
  
  count(name = "Total") %>% mutate(Individuo = "Vítima") %>% 
  
  rename(`Cor/Raça` = Raça_Cor_da_vítima,
         `Orientação Sexual` = Orientação_sexual_da_vítima)


# Tabela 2:
DenunciaCorRacaSuspeito <- Dados4 %>% 
  
  select(hash, Raça_Cor_do_suspeito, Orientação_sexual_do_suspeito) %>% 
  
  distinct() %>% 
  
  group_by(Raça_Cor_do_suspeito, Orientação_sexual_do_suspeito) %>% 
  
  count(name = "Total") %>% mutate(Individuo = "Suspeito") %>% 
  
  rename(`Cor/Raça` = Raça_Cor_do_suspeito,
         `Orientação Sexual` = Orientação_sexual_do_suspeito)


# Tabela 3:
DenunciaCorRaca <- bind_rows(DenunciaCorRacaVitima, DenunciaCorRacaSuspeito) %>% 
  
  dplyr::filter(Individuo == "Vítima") %>% group_by(`Cor/Raça`) %>% 
  
  mutate(Percentual = round(100 * Total / sum(Total), 2))


# Grafico:
ggplot(DenunciaCorRaca, aes(x = `Orientação Sexual`, y = Total, 
                            fill = `Orientação Sexual`)) +
  
  geom_bar(stat = "identity") + scale_fill_paletteer_d("rcartocolor::Prism") +
  
  facet_wrap(~ `Cor/Raça`, scales = "free") +
  
  scale_y_continuous(labels = label_comma(big.mark = ".", decimal.mark = ","),
                     expand = expansion(mult = c(0, 0.2))) +
  
  labs(x = "Cor/Raça", y = "Quantidade total/percentual",
       fill = "Orientação sexual") +
  
  geom_text(aes(label = paste0(format(Percentual, nsmall = 2), "%")),
            # fontface = "bold", 
            # color = "#3e3e3e", 
            vjust = -0.5, size = 3.2) +
  
  theme(axis.text.x = element_blank(), axis.ticks = element_blank(),
        
        axis.title.y = element_text(angle = 90,
                                    margin = margin(r = 0.3, unit = "cm")),
        axis.title.x = element_text(margin = margin(t = 0.3, unit = "cm")), 
        
        # axis.title = element_text(color = "#5e5e5e", face = "bold")
  )
  
# Salvar imagem:
Salv.Graf("Denúncias por Cor ou Raça e Orientação sexual.png", 2)

# Salvar power point:
Salv.pptx("Denúncias por Cor ou Raça e Orientação sexual.pptx", 2)


# Denuncias por Faixa Etaria e Orientacao sexual -------------------------------------------------------------------------

# Tabela 1:
DenunciaFaixaEtariaVitima <- Dados4 %>% 
  
  select(hash, Faixa_etária_da_vítima2, Orientação_sexual_da_vítima) %>% 
  
  distinct() %>% 
  
  dplyr::filter(Faixa_etária_da_vítima2 != "Não identificado") %>% 
  
  group_by(Faixa_etária_da_vítima2, Orientação_sexual_da_vítima) %>% 
  
  count(name = "Total") %>% mutate(Individuo = "Vítima") %>% 
  
  rename(`Faixa Etária` = Faixa_etária_da_vítima2,
         `Orientação Sexual` = Orientação_sexual_da_vítima)


# Tabela 2:
DenunciaFaixaEtariaSuspeito <- Dados4 %>% 
  
  select(hash, Faixa_etária_do_suspeito2, Orientação_sexual_do_suspeito) %>% 
  
  distinct() %>% 
  
  dplyr::filter(Faixa_etária_do_suspeito2 != "Não identificado") %>% 
  
  group_by(Faixa_etária_do_suspeito2, Orientação_sexual_do_suspeito) %>% 
  
  count(name = "Total") %>% mutate(Individuo = "Suspeito") %>% 
  
  rename(`Faixa Etária` = Faixa_etária_do_suspeito2,
         `Orientação Sexual` = Orientação_sexual_do_suspeito)


# Para auxiliar na ordem dos fatores:
FatoresFE <- c("0 a 4 anos",  "5 a 9 anos", "10 a 14 anos", "12 a 14 anos", 
               "15 a 19 anos", "20 a 24 anos", "25 a 29 anos", "30 a 34 anos", 
               "35 a 39 anos", "40 a 44 anos", "45 a 49 anos", "50 a 54 anos", 
               "55 a 59 anos", "60 a 64 anos", "65 a 69 anos", "70 a 74 anos", 
               "75 a 79 anos", "80 a 84 anos", "85 a 89 anos", "90+")


# Tabela 3:
DenunciaFaixaEtaria <- bind_rows(DenunciaFaixaEtariaVitima, 
                                 DenunciaFaixaEtariaSuspeito) %>% 
  
  mutate(`Faixa Etária` = factor(`Faixa Etária`, levels = FatoresFE)) %>% 
  
  dplyr::filter(Individuo == "Vítima")


# Percentual por Faixa Etaria (total de cada faixa):
PercentualFaixaEtaria <- DenunciaFaixaEtaria %>% 
  
  dplyr::filter(Individuo == "Vítima") %>% group_by(`Faixa Etária`) %>% 
  
  summarise(TotalFaixa = sum(Total)) %>% 
  
  mutate(Percentual = round(100 * TotalFaixa / sum(TotalFaixa), 2))


# Grafico:
ggplot(DenunciaFaixaEtaria, aes(x = `Faixa Etária`, y = Total, 
                                fill = `Orientação Sexual`, 
                                group = `Orientação Sexual`)) +
  
  geom_bar(stat = "identity") + scale_fill_paletteer_d("rcartocolor::Prism") +
  
  coord_flip() +
  
  scale_y_continuous(labels = label_comma(big.mark = ".", decimal.mark = ","),
                     expand = expansion(mult = c(0, 0.1))) +
  
  labs(x = "Faixas etárias", y = "Quantidade total/percentual",
       fill = "Orientação sexual") +
  
  geom_text(data = PercentualFaixaEtaria,
            aes(x = `Faixa Etária`, y = TotalFaixa,
                label = paste0(format(Percentual, nsmall = 2), "%")),
            color = "#3e3e3e",
            inherit.aes = FALSE, hjust = -0.1, size = 3.2) +
  
  theme(axis.ticks = element_blank(),
        axis.title.y = element_text(angle = 90,
                                    margin = margin(r = 0.3, unit = "cm")),
        axis.title.x = element_text(margin = margin(t = 0.3, b = 0.2, unit = "cm")),
        
        panel.grid.major.y = element_blank(),
        panel.grid.major.x = element_line(color = "#D8D8D8",), 
        
        # axis.title = element_text(size = 15), 
        # axis.text = element_text(size = 13), 
  )


# Salvar imagem:
Salv.Graf("Denúncias por Faixa Etária e Orientação sexual2.png", 2)

# Salvar power point:
Salv.pptx("Denúncias por Faixa Etária e Orientação sexual.pptx", 2)


# Denuncias por Estado ---------------------------------------------------------------------------------------------------

# Denuncias por estado:
DenunciasEstado <- Dados4 %>% 
  
  select(hash, UF) %>% distinct() %>% 
  
  dplyr::filter(UF != "Não identificado") %>% 
  
  group_by(UF) %>% count(name = "Total") %>% ungroup() %>% 
  
  mutate(Percentual = round(100 * Total / sum(Total), 2))


# Juntando denuncias com geolocalizacao:
DenunciasEstadoFull <- left_join(GeoEstado2, DenunciasEstado,
                                 by = c("abbrev_state" = "UF"))


# Manipulando posicao dos rotulos:
DenunciasEstadoFull2 <- DenunciasEstadoFull %>%
  
  mutate(centroid = sf::st_centroid(geom)) %>%
  mutate(lat = sf::st_coordinates(centroid)[,1],
         lon = sf::st_coordinates(centroid)[,2],
         
         lat2 = case_when(abbrev_state %in%
                            c("RN", "PB", "PE", "AL", "SE",
                              "ES", "RJ", "SC") ~ lat + 1.8,
                          abbrev_state == "DF" ~ lat + 1.5,
                          abbrev_state == "GO" ~ lat - 0.8, TRUE ~ lat),
         
         lon2 = case_when(abbrev_state == "RN" ~ lon + 0.3,
                          abbrev_state == "SE" ~ lon - 0.8,
                          abbrev_state == "AL" ~ lon - 0.5,
                          abbrev_state == "PE" ~ lon - 0.3,
                          abbrev_state == "DF" ~ lon + 0.4,
                          abbrev_state == "GO" ~ lon - 1.3, TRUE ~ lon))


# Grafico:
ggplot(DenunciasEstadoFull2, aes(fill = Total)) +
  
  geom_sf(color = "#434343", linewidth = 0.01) +
  
  geom_label(
    aes(x = lat2, y = lon2,
        label = paste0(abbrev_state, ": ",
                       format(Percentual, nsmall = 2), "%")),
    size = 4, color = "black", fill = "white", alpha = 0.9,
    fontface = "bold"
  ) +
  
  scale_fill_distiller(
    palette = "Reds",
    direction = 1,
    breaks = scales::pretty_breaks(n = 5),
    labels = scales::label_comma(decimal.mark = ",", big.mark = "."),
    guide = guide_legend(
      label.theme = element_text(size = 13), 
      title.theme = element_text(size = 15), 
      keyheight = unit(3, units = "mm"),
      keywidth = unit(12, units = "mm"),
      title.position = "top",         
      title.hjust = 0, 
      label.position = "bottom",
      label.hjust = 0.5,
      nrow = 1
    )
  ) +
  
  labs(x = "", y = "", fill = "Escala de denúncias") + 
  
  theme(text = element_text(face = "bold", size = 15), 
        panel.border = element_blank(), 
        axis.text = element_blank(), 
        axis.ticks = element_blank(), 
        legend.title = element_text(size = 12), 
        legend.text = element_text(size = 10), 
        legend.position = c(0.80, 0.10), 
        plot.margin = unit(c(0, 0, 0, 0), "cm")
  ) + 
  
  coord_sf(expand = FALSE)


# Salvar imagem:
# Salv.Graf("Gráfico Mapa - Denúncias por estado.png", 1)

# Salvar power point:
Salv.pptx("Gráfico Mapa - Denúncias por estado.pptx", 1)
