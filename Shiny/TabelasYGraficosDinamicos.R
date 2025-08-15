
# FUNCOES ================================================================================================================

# Salvar graficos como imagem:
Salv.Graf <- function(NOME, DIMENSOES, PLOT){

  # Desativar showtext temporariamente
  showtext_auto(FALSE)
  
  LARGURA <- if_else(DIMENSOES == 1, 6.75, 12)

  ggsave(filename = NOME, plot = PLOT,
         device = png, type = "cairo", dpi = 300,
         width = LARGURA, height = 6.75, units = "in")
  
  # Reativar showtext
  showtext_auto(TRUE)

}


# TABELAS E GRAFICOS =====================================================================================================

# Opcoes gerais dos graficos ---------------------------------------------------------------------------------------------

OptionsGirafe <- list(
  opts_sizing(rescale = TRUE),      # Torna o gráfico responsivo
  opts_toolbar(saveaspng = TRUE),   # Exibe botão salvar
  opts_zoom(max = 5),               # Zoom interativo
  opts_sizing(rescale = TRUE),      # Importante para escalabilidade
  opts_toolbar(saveaspng = FALSE),  # Retirar opcao nativa de download
  opts_tooltip(css = "background-color: #5E213F; color: white; padding: 4px; border-radius: 5px; font-size: 14px;"))


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
DenunciaRegiao <- bind_rows(DenunciaRegiaoVitima, DenunciaRegiaoSuspeito)


# Grafico:
GDenunciaRegiao <- function(.){

  GRAF <- 
  ggplot(., aes(x = `Orientação Sexual`, 
                tooltip = paste0("Total: ", comma(Total, big.mark = ".", decimal.mark = ",")), 
                y = Total, fill = `Orientação Sexual`)) +

    geom_bar_interactive(stat = "identity") + scale_fill_paletteer_d("rcartocolor::Prism") +

    facet_wrap_interactive(~ Regiao, scales = "free") +

    scale_y_continuous(labels = label_comma(big.mark = ".", decimal.mark = ","),
                       expand = expansion(mult = c(0, 0.2))) +

    labs(x = "Região", y = "Quantidade total/percentual",
         fill = "Orientação sexual") +

    geom_text_interactive(aes(label = paste0(format(Percentual, nsmall = 2), "%")),
              # fontface = "bold", 
              vjust = -0.5, size = 3.2) +

    theme(axis.text.x = element_blank(), axis.ticks = element_blank(),
          
          axis.title.y = element_text(angle = 90,
                                      margin = margin(r = 0.3, unit = "cm")),
          axis.title.x = element_text(margin = margin(t = 0.3, unit = "cm")), 
          
          # axis.title = element_text(color = "#5e5e5e", face = "bold")
          )
  
  # girafe(ggobj = GRAF, 
  #        options = OptionsGirafe, 
  #        height_svg = 6, width_svg = 10.67)

}


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
DenunciaMes <- bind_rows(DenunciaMesVitima, DenunciaMesSuspeito)


# Grafico:
GDenunciaMes <- function(.){

  GRAF <- 
  ggplot(., aes(x = Mes, y = Total, 
                tooltip = paste0("Total: ", comma(Total, big.mark = ".", decimal.mark = ",")), 
                group = `Orientação Sexual`,
                fill = `Orientação Sexual`)) +

    geom_bar_interactive(stat = "identity") + scale_fill_paletteer_d("rcartocolor::Prism") +

    scale_y_continuous(labels = label_comma(big.mark = ".", decimal.mark = ",")) +

    labs(x = "Mês", y = "Quantidade total/percentual", fill = "Orientação sexual") +

    geom_text_interactive(aes(label = paste0(format(Percentual, nsmall = 2), "%")),
              # fontface = "bold", 
              color = "white", position = position_stack(vjust = 0.5), size = 3.2) +

    theme(axis.ticks = element_blank(),
          axis.title.y = element_text(angle = 90,
                                      margin = margin(r = 0.3, unit = "cm")),
          axis.title.x = element_text(margin = margin(t = 0.3, unit = "cm")), 
          
          # text = element_text(color = "#5e5e5e", face = "bold")
          )
  
  # girafe(ggobj = GRAF, height_svg = 6, width_svg = 10.67)
  
}


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
DenunciaCorRaca <- bind_rows(DenunciaCorRacaVitima, DenunciaCorRacaSuspeito)


# Grafico:
GDenunciaCorRaca <- function(.){

  GRAF <- ggplot(., aes(x = `Orientação Sexual`, y = Total, 
                        tooltip = paste0("Total: ", comma(Total, big.mark = ".", decimal.mark = ",")), 
                        fill = `Orientação Sexual`)) +
    
    geom_bar_interactive(stat = "identity") + scale_fill_paletteer_d("rcartocolor::Prism") +
    
    facet_wrap_interactive(~ `Cor/Raça`, scales = "free") +
    
    scale_y_continuous(labels = label_comma(big.mark = ".", decimal.mark = ","),
                       expand = expansion(mult = c(0, 0.2))) +
    
    labs(x = "Cor/Raça", y = "Quantidade total/percentual",
         fill = "Orientação sexual") +
    
    geom_text_interactive(aes(label = paste0(format(Percentual, nsmall = 2), "%")),
              # fontface = "bold", 
              # color = "#3e3e3e", 
              vjust = -0.5, size = 3.2) +
    
    theme(axis.text.x = element_blank(), axis.ticks = element_blank(),

          axis.title.y = element_text(angle = 90,
                                      margin = margin(r = 0.3, unit = "cm")),
          axis.title.x = element_text(margin = margin(t = 0.3, unit = "cm")), 
          
          # axis.title = element_text(color = "#5e5e5e", face = "bold")
          )
  
  # girafe(ggobj = GRAF, height_svg = 6, width_svg = 10.67)

}


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
  
  mutate(`Faixa Etária` = factor(`Faixa Etária`, levels = FatoresFE))


# Grafico:
GDenunciaFaixaEtaria <- function(., PercentualFaixaEtaria){

  GRAF <- ggplot(., aes(x = `Faixa Etária`, y = Total, 
                        tooltip = paste0("Total: ", comma(Total, big.mark = ".", decimal.mark = ",")), 
                        fill = `Orientação Sexual`, group = `Orientação Sexual`)) +
    
    geom_bar_interactive(stat = "identity") + scale_fill_paletteer_d("rcartocolor::Prism") +
    
    coord_flip() +
    
    scale_y_continuous(labels = label_comma(big.mark = ".", decimal.mark = ","),
                       expand = expansion(mult = c(0, 0.1))) +
    
    labs(x = "Faixas etárias", y = "Quantidade total/percentual",
         fill = "Orientação sexual") +
    
    geom_text(data = PercentualFaixaEtaria,
              aes(x = `Faixa Etária`, y = TotalFaixa,
                  label = paste0(format(Percentual, nsmall = 2), "%")),
              # fontface = "bold",
              color = "#3e3e3e",
              inherit.aes = FALSE, hjust = -0.1, size = 3.2) +
    
    theme(axis.ticks = element_blank(),
          axis.title.y = element_text(angle = 90,
                                      margin = margin(r = 0.3, unit = "cm")),
          axis.title.x = element_text(margin = margin(t = 0.3, b = 0.2, unit = "cm")),
          
          panel.grid.major.y = element_blank(),
          panel.grid.major.x = element_line(color = "#D8D8D8"), 
          
          # axis.title = element_text(color = "#5e5e5e", face = "bold")
          )
  
  # girafe(ggobj = GRAF, height_svg = 6, width_svg = 10.67)

}


# Religiao ---------------------------------------------------------------------------------------------------------------

# Tabela 1:
DenunciaReligiaoVitima <- Dados4 %>%

  select(hash, Religião_da_vítima2) %>% distinct() %>% 

  group_by(Religião_da_vítima2) %>% 

  count(name = "Total") %>% mutate(Individuo = "Vítima") %>% 

  rename(Religião = Religião_da_vítima2)


# Tabela 2:
DenunciaReligiaoSuspeito <- Dados4 %>% 

  select(hash, Religião_do_suspeito2) %>% distinct() %>% 

  group_by(Religião_do_suspeito2) %>% 

  count(name = "Total") %>% mutate(Individuo = "Suspeito") %>% 

  rename(Religião = Religião_do_suspeito2)


# Tabela 3:
DenunciaReligiao <- bind_rows(DenunciaReligiaoVitima, DenunciaReligiaoSuspeito)


# Grafico:
GDenunciaReligiao <- function(.){

  GRAF <- 
  ggplot(., aes(x = fct_rev(Religião), y = Total, 
                tooltip = paste0("Total: ", comma(Total, big.mark = ".", decimal.mark = ",")))) +

    geom_bar_interactive(stat = "identity", fill = "#1d6996") +

    scale_fill_paletteer_d("rcartocolor::Prism") + coord_flip() +

    scale_y_continuous(labels = label_comma(big.mark = ".", decimal.mark = ","),
                       expand = expansion(mult = c(0, 0.1))) +

    labs(x = "Religião", y = "Quantidade total/percentual", fill = "") +

    geom_text(aes(label = paste0(format(Percentual, nsmall = 2), "%")),
              hjust = -0.1, size = 3.2) +

    theme(axis.ticks = element_blank(), legend.position = "none",

          axis.title.y = element_text(angle = 90,
                                      margin = margin(r = 0.3, unit = "cm")),
          axis.title.x = element_text(margin = margin(t = 0.3, b = 0.2, unit = "cm")),

          panel.grid.major.y = element_blank(),
          panel.grid.major.x = element_line(color = "#D8D8D8"), 
          
          # axis.title = element_text(face = "bold", color = "#5e5e5e")
          )
  
  # girafe(ggobj = GRAF, height_svg = 3.913, width_svg = 6.96)

}


# Denuncias por Motivacao ------------------------------------------------------------------------------------------------

# Tabela:
DenunciaMotivacao <- Dados4 %>%

  select(hash, Motivação) %>% distinct() %>%  
  
  group_by(Motivação) %>% count(name = "Total")


# Grafico:
GDenunciaMotivacao <- function(.){

  GRAF <- 
  ggplot(., aes(x = fct_rev(Motivação), y = Total, 
                tooltip = paste0("Total: ", comma(Total, big.mark = ".", decimal.mark = ",")), )) +

    geom_bar_interactive(stat = "identity", fill = "#1d6996") +

    scale_fill_paletteer_d("rcartocolor::Prism") + coord_flip() +

    scale_y_continuous(labels = label_comma(big.mark = ".", decimal.mark = ","),
                       expand = expansion(mult = c(0, 0.2))) +

    labs(x = "Motivação", y = "Quantidade total/percentual", fill = "") +

    geom_text(aes(label = paste0(format(Percentual, nsmall = 2), "%")),
              hjust = -0.1, size = 3.2) +

    theme(axis.ticks = element_blank(), legend.position = "none",

          axis.title.y = element_text(angle = 90,
                                      margin = margin(r = 0.3, unit = "cm")),
          axis.title.x = element_text(margin = margin(t = 0.3, b = 0.2, unit = "cm")),

          panel.grid.major.y = element_blank(),
          panel.grid.major.x = element_line(color = "#D8D8D8"), 
          
          # axis.title = element_text(color = "#5e5e5e", face = "bold")
          )
  
  # girafe(ggobj = GRAF, height_svg = 6, width_svg = 10.67)

}


# Classificacao do suspeito ----------------------------------------------------------------------------------------------

# Tabela:
DenunciaClassiSuspeito <- Dados4 %>% 
  
  select(hash, Relação_vítima_suspeito2) %>% distinct() %>% 

  dplyr::filter(Relação_vítima_suspeito2 != "Própria vítima") %>% 

  group_by(Relação_vítima_suspeito2) %>% count(name = "Total") %>% 

  rename(`Classificação do Suspeito` = Relação_vítima_suspeito2)


# Grafico:
GDenunciaClassiSuspeito <- function(.){

  GRAF <- 
  ggplot(., aes(x = fct_rev(`Classificação do Suspeito`), y = Total, 
                tooltip = paste0("Total: ", comma(Total, big.mark = ".", decimal.mark = ",")), )) +

    geom_bar_interactive(stat = "identity", fill = "#1d6996") +

    scale_fill_paletteer_d("rcartocolor::Prism") + coord_flip() +

    scale_y_continuous(labels = label_comma(big.mark = ".", decimal.mark = ","),
                       expand = expansion(mult = c(0, 0.12))) +

    labs(x = "Classificação do suspeito", y = "Quantidade total/percentual", fill = "") +

    geom_text(aes(label = paste0(format(Percentual, nsmall = 2), "%")),
              hjust = -0.1, size = 3.2) +

    theme(axis.ticks = element_blank(), legend.position = "none",

          axis.title.y = element_text(angle = 90,
                                      margin = margin(r = 0.3, unit = "cm")),
          axis.title.x = element_text(margin = margin(t = 0.3, b = 0.2, unit = "cm")),

          panel.grid.major.y = element_blank(),
          panel.grid.major.x = element_line(color = "#D8D8D8"), 
          
          # axis.title = element_text(color = "#5e5e5e", face = "bold")
          )
  
  # girafe(ggobj = GRAF, options = OptionsGirafe,  
  #        height_svg = 3.913, width_svg = 6.96)

}


# Deficiencia da vitima --------------------------------------------------------------------------------------------------

# Tabela 1:
DenunciaDeficienciaVitima <- Dados4 %>% 

  select(hash, Deficiência_da_vítima2) %>% distinct() %>% 

  group_by(Deficiência_da_vítima2) %>% count(name = "Total") %>% 
  
  mutate(Individuo = "Vítima") %>% rename(Condição = Deficiência_da_vítima2)


# Tabela 2:
DenunciaDeficienciaSuspeito <- Dados4 %>%
  
  select(hash, Deficiência_do_suspeito2) %>% distinct() %>% 
  
  group_by(Deficiência_do_suspeito2) %>% count(name = "Total") %>% 
  
  mutate(Individuo = "Suspeito") %>% rename(Condição = Deficiência_do_suspeito2)


# Tabela 3:
DenunciaDeficiencia <- bind_rows(DenunciaDeficienciaVitima, DenunciaDeficienciaSuspeito)


# Grafico:
GDenunciaDeficiencia <- function(.){

  GRAF <- 
  ggplot(., aes(x = fct_rev(Condição), y = Total, 
                tooltip = paste0("Total: ", comma(Total, big.mark = ".", decimal.mark = ",")), )) +

    geom_bar_interactive(stat = "identity", fill = "#1d6996") +

    scale_fill_paletteer_d("rcartocolor::Prism") + coord_flip() +

    scale_y_continuous(labels = label_comma(big.mark = ".", decimal.mark = ","),
                       expand = expansion(mult = c(0, 0.12))) +

    labs(x = "Pessoa com deficiência", y = "Quantidade total/percentual", fill = "") +

    geom_text(aes(label = paste0(format(Percentual, nsmall = 2), "%")),
              hjust = -0.1, size = 3.2) +

    theme(axis.ticks = element_blank(), legend.position = "none",

          axis.title.y = element_text(angle = 90,
                                      margin = margin(r = 0.3, unit = "cm")),
          axis.title.x = element_text(margin = margin(t = 0.3, b = 0.2, unit = "cm")),

          panel.grid.major.y = element_blank(),
          panel.grid.major.x = element_line(color = "#D8D8D8"), 
          
          # axis.title = element_text(face = "bold", color = "#5e5e5e")
          )
  
  # girafe(ggobj = GRAF, height_svg = 3.913, width_svg = 6.96)

}


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
                              "ES", "RJ", "SC") ~ lat + 2.5,
                          abbrev_state == "DF" ~ lat + 2.0,
                          abbrev_state == "GO" ~ lat - 0.8, TRUE ~ lat),

         lon2 = case_when(abbrev_state == "RN" ~ lon + 0.3,
                          abbrev_state == "SE" ~ lon - 0.8,
                          abbrev_state == "AL" ~ lon - 0.5,
                          abbrev_state == "PE" ~ lon - 0.3,
                          abbrev_state == "DF" ~ lon + 0.6,
                          abbrev_state == "GO" ~ lon - 1.3, TRUE ~ lon))


# Grafico:
GDenunciaMapa <- function(.){

  # DenunciasEstadoFull2 %>%

  GRAF <- 
    ggplot(., aes(fill = Total)) +
    
    geom_sf_interactive(aes(tooltip = paste0("Total: ", comma(Total, big.mark = ".", decimal.mark = ","))),
                        color = "black") +
    
    geom_label_interactive(aes(x = latFim, y = lonFim,
                               label = paste0(abbrev_state, ": ",
                                              format(Percentual, nsmall = 2), "%")),
                           size = 2.5, color = "black", fill = "white", alpha = 0.9,
                           fontface = "bold") +

    scale_fill_distiller_interactive(
      palette = "Reds",
      direction = 1,

      breaks = scales::pretty_breaks(n = 5),
      labels = scales::label_comma(decimal.mark = ",", big.mark = "."),

      guide = guide_legend(
        keyheight = unit(3, units = "mm"),
        keywidth = unit(12, units = "mm"),
        title.position = "top",         
        title.hjust = 0, 
        label.position = "bottom",
        label.hjust = 0.5, 
        # override.aes = list(size = 1.2), 
        nrow = 1)) +

    labs(x = "", y = "", fill = "Escala de denúncias") + 
    
    theme(text = element_text(face = "bold",
                              size = 15),
          panel.border = element_blank(),

          axis.title.x = element_text(margin =
                                        margin(t = 0.6,
                                               b = 0.3,
                                               unit = "cm")),

          axis.title.y = element_text(margin =
                                        margin(r = 0.6,
                                               l = 0.3,
                                               unit = "cm")),

          axis.text = element_blank(),
          axis.ticks = element_blank(),

          legend.position = "bottom",
          legend.justification = "right",
          legend.title = element_text(size = 12),
          legend.text = element_text(size = 10),
          # legend.position = c(0.80, 0.10),
          )
  
  # girafe(ggobj = GRAF, height_svg = 6.75, width_svg = 6.75)

}
