StyleCardHF <- "background-color: #5E213F; color: white; border: none;"
StyleButton <- "background-color: transparent; border: none; box-shadow: none;"
TCardFooter <- div("Fonte: ", tags$a(href = "https://www.gov.br/mdh/pt-br/acesso-a-informacao/dados-abertos/disque100", 
                                     style = "color: white", target = "_blank", "Disque Direitos Humanos"))

# Denuncias por Regiao e Orientacao sexual -------------------------------------------------------------------------------

cardRegiao <- function(HEIGHT = NULL){
  
  card(
  card_header(uiOutput("TituloPlotRegiao"), 
              
              # tooltip(bs_icon("question-circle"), 
              #         "VOCÊ TEM DÚVIDAS?",
              #         placement = "right"), 
              
              
              div(class = "ms-auto d-flex align-items-center gap-0", 
                  
                  popover(bs_icon("funnel-fill"),
                          
                          selectInput("selectInputRegiao", strong("Pessoa"), 
                                      c("Vítima", "Suspeito")), 
                          
                          checkboxGroupInput("CheckBoxRegiao", 
                                             strong("Orientação Sexual"), 
                                             choices = unique(DenunciaRegiao$`Orientação Sexual`),
                                             selected = unique(DenunciaRegiao$`Orientação Sexual`))), 
                  
                  downloadButton("downloadButtonRegiao", label = NULL, 
                                 icon = icon("download"), style = StyleButton)), 
              
              style = StyleCardHF, 
              
              class = "d-flex align-items-center"), 
  
  # full_screen = TRUE,
  
  girafeOutput("PlotOutputRegiao", width = "100%", height = "auto"), 
  
  style = paste0("max-width: ", HEIGHT, "; width: 100%; margin: 0 auto; border: none;"), 
  
  card_footer(TCardFooter, 
              style = StyleCardHF, class = "d-flex align-items-center", 
              
              actionButton("actionButtonRegiao", label = NULL, class = "ms-auto", 
                           icon = icon("expand-alt"), style = StyleButton)))

}


# Denuncias por Mes e Orientacao sexual ----------------------------------------------------------------------------------

cardMes <- function(HEIGHT = NULL){
  
  card(
    card_header(uiOutput("TituloPlotMes"), 
                
                div(class = "ms-auto d-flex align-items-center gap-0", 
                    
                    popover(bs_icon("funnel-fill"),
                            
                            selectInput("selectInputMes", strong("Pessoa"),
                                        c("Vítima", "Suspeito")),
                            
                            checkboxGroupInput("CheckBoxMes",
                                               strong("Orientação Sexual"),
                                               choices = unique(DenunciaMes$`Orientação Sexual`),
                                               selected = unique(DenunciaMes$`Orientação Sexual`))), 
                    
                    downloadButton("downloadButtonMes", label = NULL, icon = icon("download"),
                                   style = StyleButton)),
                
                
                style = StyleCardHF, 
                
                class = "d-flex align-items-center"), 
    
    # full_screen = TRUE, 
    
    girafeOutput("PlotOutputMes", width = "100%", height = "auto"),
    
    style = paste0("max-width: ", HEIGHT, "; width: 100%; margin: 0 auto; border: none;"), 
    
    card_footer(TCardFooter, 
                style = StyleCardHF, class = "d-flex align-items-center", 
                
                actionButton("actionButtonMes", label = NULL, class = "ms-auto", 
                             icon = icon("expand-alt"), style = StyleButton)))
  
}


# Denuncias por Cor/Raca e Orientacao sexual -----------------------------------------------------------------------------

cardCorRaca <- function(HEIGHT = NULL){
  
  card(
  card_header(uiOutput("TituloPlotCorRaca"),
              
              # tooltip(bs_icon("question-circle"),
              #         "VOCÊ TEM DÚVIDAS?",
              #         placement = "right"),
              
              div(class = "ms-auto d-flex align-items-center gap-0", 
                  
                  popover(bs_icon("funnel-fill"),
                          
                          selectInput("selectInputCorRaca", strong("Pessoa"),
                                      c("Vítima", "Suspeito")),
                          
                          checkboxGroupInput("CheckBoxCorRaca",
                                             strong("Orientação Sexual"),
                                             choices = unique(DenunciaCorRaca$`Orientação Sexual`),
                                             selected = unique(DenunciaCorRaca$`Orientação Sexual`))), 
                  
                  downloadButton("downloadButtonCorRaca", label = NULL, 
                                 icon = icon("download"), style = StyleButton)), 
              
              style = StyleCardHF, 
              
              class = "d-flex align-items-center"), 
  
  
  girafeOutput("PlotOutputCorRaca", width = "100%", height = "auto"), 
  
  style = paste0("max-width: ", HEIGHT, "; width: 100%; margin: 0 auto; border: none;"), 
  
  
  card_footer(TCardFooter, 
              style = StyleCardHF, class = "d-flex align-items-center", 
              
              actionButton("actionButtonCorRaca", label = NULL, class = "ms-auto", 
                           icon = icon("expand-alt"), style = StyleButton)))

}


# Denuncias por Faixa Etaria e Orientacao sexual -------------------------------------------------------------------------

cardFaixaEtaria <- function(HEIGHT = NULL){
  
  card(
  card_header(uiOutput("TituloPlotFaixaEtaria"),
              
              # tooltip(bs_icon("question-circle"),
              #         "VOCÊ TEM DÚVIDAS?",
              #         placement = "right"),
              
              div(class = "ms-auto d-flex align-items-center gap-0", 
                  
                  popover(bs_icon("funnel-fill"),
                          
                          selectInput("selectInputFaixaEtaria", strong("Pessoa"),
                                      c("Vítima", "Suspeito")),
                          
                          checkboxGroupInput("CheckBoxFaixaEtaria",
                                             strong("Orientação Sexual"),
                                             choices = unique(DenunciaFaixaEtaria$`Orientação Sexual`),
                                             selected = unique(DenunciaFaixaEtaria$`Orientação Sexual`))), 
                  
                  downloadButton("downloadButtonFaixaEtaria", label = NULL, 
                                 icon = icon("download"), style = StyleButton)), 
              
              style = StyleCardHF, 
              
              class = "d-flex align-items-center"), 
  
  girafeOutput("PlotOutputFaixaEtaria", width = "100%", height = "auto"), 
  
  style = paste0("max-width: ", HEIGHT, "; width: 100%; margin: 0 auto; border: none;"), 
  
  card_footer(TCardFooter, 
              style = StyleCardHF, class = "d-flex align-items-center", 
              
              actionButton("actionButtonFaixaEtaria", label = NULL, class = "ms-auto", 
                           icon = icon("expand-alt"), style = StyleButton)))

}


# Religiao ---------------------------------------------------------------------------------------------------------------

cardReligiao <- function(HEIGHT = NULL){
  
  card(
  card_header(uiOutput("TituloPlotReligiao"),
              
              # tooltip(bs_icon("question-circle"),
              #         "VOCÊ TEM DÚVIDAS?",
              #         placement = "right"),
              
              div(class = "ms-auto d-flex align-items-center gap-0", 
                  
                  popover(bs_icon("funnel-fill"),
                          
                          selectInput("selectInputReligiao", strong("Pessoa"),
                                      c("Vítima", "Suspeito")),
                          
                          checkboxGroupInput("CheckBoxReligiao",
                                             strong("Orientação Sexual"),
                                             choices = unique(DenunciaReligiao$Religião),
                                             selected = unique(DenunciaReligiao$Religião))), 
                  
                  downloadButton("downloadButtonReligiao", label = NULL, 
                                 icon = icon("download"), style = StyleButton)), 
               
              
              style = StyleCardHF, 
              
              class = "d-flex align-items-center"), 
  
  girafeOutput("PlotOutputReligiao", width = "100%", height = "auto"), 
  
  style = paste0("max-width: ", HEIGHT, "; width: 100%; margin: 0 auto; border: none;"), 
  
  card_footer(TCardFooter, 
              style = StyleCardHF, class = "d-flex align-items-center", 
              
              actionButton("actionButtonReligiao", label = NULL, class = "ms-auto", 
                           icon = icon("expand-alt"), style = StyleButton)))

}


# Denuncias por Motivacao ------------------------------------------------------------------------------------------------

cardMotivacao <- function(HEIGHT = NULL){
  
  card(
  card_header(uiOutput("TituloPlotMotivacao"),
              
              # tooltip(bs_icon("question-circle"),
              #         "VOCÊ TEM DÚVIDAS?",
              #         placement = "right"),
              
              div(class = "ms-auto d-flex align-items-center gap-0", 
                  
                  popover(bs_icon("funnel-fill"), 
                          
                          checkboxGroupInput("CheckBoxMotivacao",
                                             strong("Orientação Sexual"),
                                             choices = unique(DenunciaMotivacao$Motivação),
                                             selected = unique(DenunciaMotivacao$Motivação))), 
                  
                  downloadButton("downloadButtonMotivacao", label = NULL, 
                                 icon = icon("download"), style = StyleButton)), 
              
              
              style = StyleCardHF, 
              
              class = "d-flex align-items-center"), 
  
  girafeOutput("PlotOutputMotivacao", width = "100%", height = "auto"), 
  
  style = paste0("max-width: ", HEIGHT, "; width: 100%; margin: 0 auto; border: none;"), 
  
  card_footer(TCardFooter, 
              style = StyleCardHF, class = "d-flex align-items-center", 
              
              actionButton("actionButtonMotivacao", label = NULL, class = "ms-auto", 
                           icon = icon("expand-alt"), style = StyleButton)))

}


# Classificacao do suspeito ----------------------------------------------------------------------------------------------

cardClassiSuspeito <- function(HEIGHT = NULL){
  
  card(
  card_header(uiOutput("TituloPlotClassiSuspeito"),
              
              
              # tooltip(bs_icon("question-circle"),
              #         "VOCÊ TEM DÚVIDAS?",
              #         placement = "right"),
              
              div(class = "ms-auto d-flex align-items-center gap-0", 
                  
                  popover(bs_icon("funnel-fill"),
                          
                          checkboxGroupInput("CheckBoxClassiSuspeito",
                                             strong("Orientação Sexual"),
                                             choices = unique(DenunciaClassiSuspeito$`Classificação do Suspeito`),
                                             selected = unique(DenunciaClassiSuspeito$`Classificação do Suspeito`))), 
                  
                  downloadButton("downloadButtonClassiSuspeito", label = NULL, 
                                 icon = icon("download"), style = StyleButton)),
              
              
              style = StyleCardHF, 
              
              class = "d-flex align-items-center"), 
  
  # full_screen = TRUE, 
  
  girafeOutput("PlotOutputClassiSuspeito", width = "100%", height = "auto"), 
  
  style = paste0("max-width: ", HEIGHT, "; width: 100%; margin: 0 auto; border: none;"), 
  
  card_footer(TCardFooter, 
              style = StyleCardHF, class = "d-flex align-items-center", 
              
              actionButton("actionButtonClassiSuspeito", label = NULL, class = "ms-auto", 
                           icon = icon("expand-alt"), style = StyleButton)))

}


# Deficiencia da vitima --------------------------------------------------------------------------------------------------

cardDeficiencia <- function(HEIGHT = NULL){
  
  card(
  card_header(uiOutput("TituloPlotDeficiencia"),
              
              
              # tooltip(bs_icon("question-circle"),
              #         "VOCÊ TEM DÚVIDAS?",
              #         placement = "right"),
              
              div(class = "ms-auto d-flex align-items-center gap-0", 
                  
                  popover(bs_icon("funnel-fill"),
                          
                          selectInput("selectInputDeficiencia", strong("Pessoa"),
                                      c("Vítima", "Suspeito")),
                          
                          checkboxGroupInput("CheckBoxDeficiencia",
                                             strong("Orientação Sexual"),
                                             choices = unique(DenunciaDeficiencia$Condição),
                                             selected = unique(DenunciaDeficiencia$Condição))),
                  
                  downloadButton("downloadButtonDeficiencia", label = NULL, 
                                 icon = icon("download"), style = StyleButton)),
              
              
              style = StyleCardHF,
              
              class = "d-flex align-items-center"), 
  
  # full_screen = TRUE, 
  
  girafeOutput("PlotOutputDeficiencia", width = "100%", height = "auto"), 
  
  style = paste0("max-width: ", HEIGHT, "; width: 100%; margin: 0 auto; border: none;"), 
  
  card_footer(TCardFooter, 
              style = StyleCardHF, class = "d-flex align-items-center", 
              
              actionButton("actionButtonDeficiencia", label = NULL, class = "ms-auto", 
                           icon = icon("expand-alt"), style = StyleButton)))

}


# Denuncias por Estado ---------------------------------------------------------------------------------------------------

cardMapa <- function(HEIGHT = NULL){
  
  card(
  card_header(uiOutput("TituloPlotMapa"),
              
              # tooltip(bs_icon("question-circle"),
              #         "VOCÊ TEM DÚVIDAS?",
              #         placement = "right"),
              
              div(class = "ms-auto d-flex align-items-center gap-0", 
                  
              popover(bs_icon("funnel-fill"),

              # selectInput("selectInputMapa", strong("Pessoa"),
              #             c("Vítima", "Suspeito")),

              checkboxGroupInput("CheckBoxMapa",
                                 strong("Orientação Sexual"),
                                 choices = unique(DenunciasEstadoFull2$name_region),
                                 selected = unique(DenunciasEstadoFull2$name_region))), 
              
              downloadButton("downloadButtonMapa", label = NULL, 
                             icon = icon("download"), style = StyleButton)), 
              
              style = StyleCardHF, 
              
              class = "d-flex align-items-center"), 
  
  # full_screen = T,
  
  girafeOutput("PlotOutputMapa", width = "100%", height = "100%"),
  
  style = paste0("max-width: ", HEIGHT, "; width: 100%; margin: 0 auto; border: none;"), 
  
  card_footer(TCardFooter, 
              style = StyleCardHF, class = "d-flex align-items-center", 
              
              actionButton("actionButtonMapa", label = NULL, class = "ms-auto", 
                           icon = icon("expand-alt"), style = StyleButton)))

}
