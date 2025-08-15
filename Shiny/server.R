server <- function(input, output, session) {
  
  estado <- reactiveValues(expandido = NULL)
  
  # Observadores para expandir/recolher ------------------------------------------------------------------------------------
  
  observeEvent(input$actionButtonRegiao, {
    estado$expandido <- if (identical(estado$expandido, "Regiao")) NULL else "Regiao"
  })
  
  observeEvent(input$actionButtonMes, {
    estado$expandido <- if (identical(estado$expandido, "Mes")) NULL else "Mes"
  })
  
  observeEvent(input$actionButtonCorRaca, {
    estado$expandido <- if (identical(estado$expandido, "CorRaca")) NULL else "CorRaca"
  })
  
  observeEvent(input$actionButtonFaixaEtaria, {
    estado$expandido <- if (identical(estado$expandido, "FaixaEtaria")) NULL else "FaixaEtaria"
  })
  
  observeEvent(input$actionButtonReligiao, {
    estado$expandido <- if (identical(estado$expandido, "Religiao")) NULL else "Religiao"
  })
  
  observeEvent(input$actionButtonMotivacao, {
    estado$expandido <- if (identical(estado$expandido, "Motivacao")) NULL else "Motivacao"
  })
  
  observeEvent(input$actionButtonClassiSuspeito, {
    estado$expandido <- if (identical(estado$expandido, "ClassiSuspeito")) NULL else "ClassiSuspeito"
  })
  
  observeEvent(input$actionButtonDeficiencia, {
    estado$expandido <- if (identical(estado$expandido, "Deficiencia")) NULL else "Deficiencia"
  })
  
  observeEvent(input$actionButtonMapa, {
    estado$expandido <- if (identical(estado$expandido, "Mapa")) NULL else "Mapa"
  })
  
  observeEvent(input$voltar, {
    estado$expandido <- NULL
  })
  
  
  # Painel dinamico --------------------------------------------------------------------------------------------------------
  
  output$Painel <- renderUI({
    
    if (is.null(estado$expandido)) {
      
      tagList(
        
        br(), 
        
        h5(strong("Violência contra a população LGBTQIA+ no Brasil: Painel das denúncias realizadas ao Disque 100 em 2024"), 
                          style = "background-color: #6B4C9A; color: white; max-width: 1080px; padding: 15px; text-align: center; margin: 0 auto; border-radius: 5px;"), 
        
        HTML(rep("<br>", 5)), 
        
      layout_columns(
        col_widths = c(6, 6), 
        cardRegiao("770px"), 
        cardMes("770px")),
      
      HTML(rep("<br>", 2)), 
      
      layout_columns(
        col_widths = c(6, 6), 
        cardCorRaca("770px"), 
        cardFaixaEtaria("770px")), 
      
      HTML(rep("<br>", 2)), 
      
      layout_columns(
        col_widths = c(6, 6), 
        cardReligiao("770px"), 
        cardMotivacao("770px")), 
      
      HTML(rep("<br>", 2)), 
      
      layout_columns(
        col_widths = c(6, 6), 
        cardClassiSuspeito("770px"), 
        cardDeficiencia("770px")), 
      
      HTML(rep("<br>", 2)), 
      
      cardMapa("770px"))
      
    } else if (estado$expandido == "Regiao") { br(); cardRegiao("1080px")
      
    } else if (estado$expandido == "Mes") { cardMes("1080px")
      
    } else if (estado$expandido == "CorRaca") { cardCorRaca("1080px")
      
    } else if (estado$expandido == "FaixaEtaria") { cardFaixaEtaria("1080px")
      
    } else if (estado$expandido == "Religiao") { cardReligiao("1080px")
      
    } else if (estado$expandido == "Motivacao") { cardMotivacao("1080px")
      
    } else if (estado$expandido == "ClassiSuspeito") { cardClassiSuspeito("1080px")
      
    } else if (estado$expandido == "Deficiencia") { cardDeficiencia("1080px")
      
    } else if (estado$expandido == "Mapa") { cardMapa("1080px")
    }
  })
  
  
  # Denuncias por Regiao e Orientacao sexual -------------------------------------------------------------------------------
  
  # Dados reativos e filtrados:
  ReativoRegiao <- reactive({ DenunciaRegiao %>% dplyr::filter(Individuo %in% input$selectInputRegiao) })
  
  
  # Opcoes reativas das caixas de selecao:
  observeEvent(input$selectInputRegiao, {
    
    opcoes <- sort(unique(ReativoRegiao()$`Orientação Sexual`))
    
    updateCheckboxGroupInput(session, 
                             inputId = "CheckBoxRegiao", 
                             choices = opcoes, selected = opcoes) })
  
  
  # Titulo reativo:
  TitleGrafRegiao <- reactive({ 
    
    if (input$selectInputRegiao == "Vítima") {
      "Percentual de denúncias por região geográfica e pela orientação sexual das vítimas LGBTQIA+"
    } else {"Percentual de suspeitos por região geográfica e pela orientação sexual"} })
  
  
  # Titulo no card:
  output$TituloPlotRegiao <- renderUI({ TitleGrafRegiao() })

  
  # Grafico reativo:
  GrafRegiao <- reactive({
    
    ReativoRegiao() %>% dplyr::filter(`Orientação Sexual` %in% input$CheckBoxRegiao) %>% 
      
      ungroup() %>% group_by(Regiao) %>% 
      
      mutate(Percentual = round(100 * Total / sum(Total), 2)) %>% 
      
      GDenunciaRegiao() })
  
  
  # Plotar grafico:
  output$PlotOutputRegiao <- renderGirafe({ 
    
    girafe(ggobj = GrafRegiao(), 
           options = OptionsGirafe, 
           height_svg = 6, width_svg = 10.67) })
  

  # Baixar grafico:
  output$downloadButtonRegiao <- downloadHandler(

    filename = function() {

      paste0(TitleGrafRegiao(), ".png")

      }, content = function(file) { Salv.Graf(file, 2, GrafRegiao()) })
  
  
  # Denuncias por Mes e Orientacao sexual ----------------------------------------------------------------------------------

  # Dados reativos e filtrados:
  ReativoMes <- reactive({ DenunciaMes %>% dplyr::filter(Individuo %in% input$selectInputMes) })


  # Opcoes reativas das caixas de selecao:
  observeEvent(input$selectInputMes, {

    opcoes <- sort(unique(ReativoMes()$`Orientação Sexual`))

    updateCheckboxGroupInput(session,
                             inputId = "CheckBoxMes",
                             choices = opcoes, selected = opcoes) })
  
  
  # Titulo reativo:
  TitleGrafMes <- reactive({ 
    
    if (input$selectInputMes == "Vítima") {
      "Percentual de denúncias por mês e pela orientação sexual das vítimas LGBTQIA+"
    } else {"Percentual de suspeitos por mês e pela orientação sexual"} })


  # Titulo no card:
  output$TituloPlotMes <- renderUI({ TitleGrafMes() })


  # Grafico reativo:
  GrafMes <- reactive({

    ReativoMes() %>% dplyr::filter(`Orientação Sexual` %in% input$CheckBoxMes) %>%

      ungroup() %>% group_by(Mes) %>%

      mutate(Percentual = round(100 * Total / sum(Total), 2)) %>%

      GDenunciaMes() })

  # Plotar grafico:
  output$PlotOutputMes <- renderGirafe({ 
    
    girafe(ggobj = GrafMes(), 
           options = OptionsGirafe, 
           height_svg = 6, width_svg = 10.67) })


  # Baixar grafico:
  output$downloadButtonMes <- downloadHandler(

    filename = function() {

      paste0(TitleGrafMes(), ".png")

    }, content = function(file) { Salv.Graf(file, 2, GrafMes()) })


  # Denuncias por Cor/Raca e Orientacao sexual -----------------------------------------------------------------------------

  # Dados reativos e filtrados:
  ReativoCorRaca <- reactive({ DenunciaCorRaca %>% dplyr::filter(Individuo %in% input$selectInputCorRaca) })


  # Opcoes reativas das caixas de selecao:
  observeEvent(input$selectInputCorRaca, {

    opcoes <- sort(unique(ReativoCorRaca()$`Orientação Sexual`))

    updateCheckboxGroupInput(session,
                             inputId = "CheckBoxCorRaca",
                             choices = opcoes, selected = opcoes) })


  # Titulo reativo:
  TitleGrafCorRaca <- reactive({ 
    if (input$selectInputCorRaca == "Vítima") {
      "Percentual de denúncias por mês e pela orientação sexual das vítimas LGBTQIA+"
    } else {"Percentual de suspeitos por mês e pela orientação sexual"} })
  
  
  # Titulo no card:
  output$TituloPlotCorRaca <- renderUI({ TitleGrafCorRaca() })


  # Grafico reativo:
  GrafCorRaca <- reactive({

    ReativoCorRaca() %>% dplyr::filter(`Orientação Sexual` %in% input$CheckBoxCorRaca) %>%

      ungroup() %>% group_by(`Cor/Raça`) %>%

      mutate(Percentual = round(100 * Total / sum(Total), 2)) %>%

      GDenunciaCorRaca() })


  # Plotar grafico:
  output$PlotOutputCorRaca <- renderGirafe({ 
    
    girafe(ggobj = GrafCorRaca(), 
           options = OptionsGirafe, 
           height_svg = 6, width_svg = 10.67) })


  # Baixar grafico:
  output$downloadButtonCorRaca <- downloadHandler(

    filename = function() {

      paste0(TitleGrafCorRaca(), ".png")

    }, content = function(file) { Salv.Graf(file, 2, GrafCorRaca()) })


  # Denuncias por Faixa Etaria e Orientacao sexual -------------------------------------------------------------------------

  # Dados reativos e filtrados:
  ReativoFaixaEtaria <- reactive({ DenunciaFaixaEtaria %>% dplyr::filter(Individuo %in% input$selectInputFaixaEtaria) })


  # Opcoes reativas das caixas de selecao:
  observeEvent(input$selectInputFaixaEtaria, {

    opcoes <- sort(unique(ReativoFaixaEtaria()$`Orientação Sexual`))

    updateCheckboxGroupInput(session,
                             inputId = "CheckBoxFaixaEtaria",
                             choices = opcoes, selected = opcoes) })


  # Titulo reativo:
  TitleGrafFaixaEtaria <- reactive({ 
    if (input$selectInputFaixaEtaria == "Vítima") {
      "Percentual de denúncias por faixa etária e pela orientação sexual das vítimas LGBTQIA+"
    } else {"Percentual de suspeitos por faixa etária e pela orientação sexual"}
  })
  
  
  # Titulo no card:
  output$TituloPlotFaixaEtaria <- renderUI({ TitleGrafFaixaEtaria() })

  
  # Grafico reativo:
  GrafFaixaEtaria <- reactive({

    # Percentual por Faixa Etaria (total de cada faixa):
    PercentualFaixaEtaria <- ReativoFaixaEtaria() %>% 
      
      dplyr::filter(`Orientação Sexual` %in% input$CheckBoxFaixaEtaria) %>% 

      ungroup() %>% group_by(`Faixa Etária`) %>%

      summarise(TotalFaixa = sum(Total)) %>%

      mutate(Percentual = round(100 * TotalFaixa / sum(TotalFaixa), 2))


    ReativoFaixaEtaria() %>% 
      
      dplyr::filter(`Orientação Sexual` %in% input$CheckBoxFaixaEtaria) %>%

      ungroup() %>% group_by(`Faixa Etária`) %>%
      
      GDenunciaFaixaEtaria(., PercentualFaixaEtaria) })


  # Plotar grafico:
  output$PlotOutputFaixaEtaria <- renderGirafe({ 
    
    girafe(ggobj = GrafFaixaEtaria(), 
           options = OptionsGirafe, 
           height_svg = 6, width_svg = 10.67) })


  # Baixar grafico:
  output$downloadButtonFaixaEtaria <- downloadHandler(

    filename = function() {

      paste0(TitleGrafFaixaEtaria(), ".png")

    }, content = function(file) { Salv.Graf(file, 2, GrafFaixaEtaria()) })


  # Religiao ---------------------------------------------------------------------------------------------------------------

  # Dados reativos e filtrados:
  ReativoReligiao <- reactive({ DenunciaReligiao %>%

      dplyr::filter(Individuo %in% input$selectInputReligiao) })


  # Opcoes reativas das caixas de selecao:
  observeEvent(input$selectInputReligiao, {

    opcoes <- sort(unique(ReativoReligiao()$Religião))

    updateCheckboxGroupInput(session,
                             inputId = "CheckBoxReligiao",
                             choices = opcoes, selected = opcoes) })


  # Titulo reativo:
  TitleGrafReligiao <- reactive({ 
    if (input$selectInputReligiao == "Vítima") {
      "Percentual de denúncias por religião das vítimas LGBTQIA+"
    } else {"Percentual de suspeitos por religião"}
  })
  
  
  # Titulo no card:
  output$TituloPlotReligiao <- renderUI({ TitleGrafReligiao() })


  # Grafico reativo:
  GrafReligiao <- reactive({

    ReativoReligiao() %>% dplyr::filter(Religião %in% input$CheckBoxReligiao) %>%

      ungroup() %>% #group_by(Religião) %>%

      mutate(Percentual = round(100 * Total / sum(Total), 2)) %>%

      GDenunciaReligiao() })


  # Plotar grafico:
  output$PlotOutputReligiao <- renderGirafe({ 
    
    girafe(ggobj = GrafReligiao(), 
           options = OptionsGirafe, 
           height_svg = 4.5, width_svg = 8) })


  # Baixar grafico:
  output$downloadButtonReligiao <- downloadHandler(

    filename = function() {

      paste0(TitleGrafReligiao(), ".png")

    }, content = function(file) { Salv.Graf(file, 2, GrafReligiao()) })


  # Denuncias por Motivacao ------------------------------------------------------------------------------------------------

  # Dados reativos e filtrados:
  ReativoMotivacao <- reactive({ DenunciaMotivacao })


  # Opcoes reativas das caixas de selecao:
  observeEvent(input$selectInputMotivacao, {

    opcoes <- sort(unique(ReativoMotivacao()$Motivação))

    updateCheckboxGroupInput(session,
                             inputId = "CheckBoxMotivacao",
                             choices = opcoes, selected = opcoes) })


  # Titulo reativo:
  TitleGrafMotivacao <- reactive({ 
    "Percentual de denúncias pela motivação"
  })
  
  
  # Titulo no card:
  output$TituloPlotMotivacao <- renderUI({ TitleGrafMotivacao() })


  # Grafico reativo:
  GrafMotivacao <- reactive({

    ReativoMotivacao() %>% dplyr::filter(Motivação %in% input$CheckBoxMotivacao) %>%

      ungroup() %>% #group_by(Religião) %>%

      mutate(Percentual = round(100 * Total / sum(Total), 2)) %>%

      GDenunciaMotivacao() })


  # Plotar grafico:
  output$PlotOutputMotivacao <- renderGirafe({ 
    
    girafe(ggobj = GrafMotivacao(), 
           options = OptionsGirafe, 
           height_svg = 4.5, width_svg = 8) })


  # Baixar grafico:
  output$downloadButtonMotivacao <- downloadHandler(

    filename = function() {

      paste0(TitleGrafMotivacao(), ".png")

    }, content = function(file) { Salv.Graf(file, 2, GrafMotivacao()) })


  # Classificacao do suspeito ----------------------------------------------------------------------------------------------

  # Dados reativos e filtrados:
  ReativoClassiSuspeito <- reactive({ DenunciaClassiSuspeito })


  # Opcoes reativas das caixas de selecao:
  observeEvent(input$selectInputClassiSuspeito, {

    opcoes <- sort(unique(ReativoClassiSuspeito()$`Classificação do Suspeito`))

    updateCheckboxGroupInput(session,
                             inputId = "CheckBoxClassiSuspeito",
                             choices = opcoes, selected = opcoes) })


  # Titulo reativo:
  TitleGrafClassiSuspeito <- reactive({ 
    "Percentual de denúncias por relação de proximidade com a vítima"
  })
  
  
  # Titulo no card:
  output$TituloPlotClassiSuspeito <- renderUI({ TitleGrafClassiSuspeito() })


  # Grafico reativo:
  GrafClassiSuspeito <- reactive({

    ReativoClassiSuspeito() %>% dplyr::filter(`Classificação do Suspeito` %in% input$CheckBoxClassiSuspeito) %>%

      ungroup() %>% #group_by(Religião) %>%

      mutate(Percentual = round(100 * Total / sum(Total), 2)) %>%

      GDenunciaClassiSuspeito() })


  # Plotar grafico:
  output$PlotOutputClassiSuspeito <- renderGirafe({ 
    
    girafe(ggobj = GrafClassiSuspeito(), 
           options = OptionsGirafe, 
           height_svg = 4.5, width_svg = 8) })


  # Baixar grafico:
  output$downloadButtonClassiSuspeito <- downloadHandler(

    filename = function() {

      paste0(TitleGrafClassiSuspeito(), ".png")

    }, content = function(file) { Salv.Graf(file, 2, GrafClassiSuspeito()) })


  # Deficiencia da vitima --------------------------------------------------------------------------------------------------

  # Dados reativos e filtrados:
  ReativoDeficiencia <- reactive({ DenunciaDeficiencia %>%

      dplyr::filter(Individuo %in% input$selectInputDeficiencia) })


  # Opcoes reativas das caixas de selecao:
  observeEvent(input$selectInputDeficiencia, {

    opcoes <- sort(unique(ReativoDeficiencia()$Condição))

    updateCheckboxGroupInput(session,
                             inputId = "CheckBoxDeficiencia",
                             choices = opcoes, selected = opcoes) })


  # Titulo reativo:
  TitleGrafDeficiencia <- reactive({ 
    if (input$selectInputDeficiencia == "Vítima") {
      "Percentual de denúncias das vítimas LGBTQIA+ que possuem deficiência"
    } else {"Percentual de suspeitos que possuem deficiência"}
  })
  
  
  # Titulo no card:
  output$TituloPlotDeficiencia <- renderUI({ TitleGrafDeficiencia() })


  # Grafico reativo:
  GrafDeficiencia <- reactive({

    ReativoDeficiencia() %>% dplyr::filter(Condição %in% input$CheckBoxDeficiencia) %>%

      ungroup() %>% #group_by(Religião) %>%

      mutate(Percentual = round(100 * Total / sum(Total), 2)) %>%

      GDenunciaDeficiencia() })


  # Plotar grafico:
  output$PlotOutputDeficiencia <- renderGirafe({ 
    
    girafe(ggobj = GrafDeficiencia(), 
           options = OptionsGirafe, 
           height_svg = 4.5, width_svg = 8) })


  # Baixar grafico:
  output$downloadButtonDeficiencia <- downloadHandler(

    filename = function() {

      paste0(TitleGrafDeficiencia(), ".png")

    }, content = function(file) { Salv.Graf(file, 2, GrafDeficiencia()) })

  # Denuncias por Estado ---------------------------------------------------------------------------------------------------

  # Dados reativos e filtrados:
  ReativoMapa <- reactive({ DenunciasEstadoFull2 })


  # Opcoes reativas das caixas de selecao:
  observeEvent(input$selectInputMapa, {

    opcoes <- sort(unique(ReativoMapa()$`Classificação do Suspeito`))

    updateCheckboxGroupInput(session,
                             inputId = "CheckBoxMapa",
                             choices = opcoes, selected = opcoes) })


  observeEvent(input$actionButtonMapa, {
    
    page_navbar(title = "teste")
    
  })
  
  
  # Titulo no card:
  output$TituloPlotMapa <- renderUI({

    "Percentual de denúncias por estado das vítimas LGBTQIA+" })


  # Grafico reativo:
  GrafMapa <- reactive({

    ReativoMapaFilter <- ReativoMapa() %>%
    
      dplyr::filter(name_region %in% input$CheckBoxMapa) %>%

      ungroup()
    
    PercentualEstado <- ReativoMapaFilter %>% 

      mutate(Percentual = round(100 * Total / sum(Total), 2), 
             
             latFim = if (length(input$CheckBoxMapa) == length(unique(ReativoMapa()$name_region))) lat2 else lat,
             lonFim = if (length(input$CheckBoxMapa) == length(unique(ReativoMapa()$name_region))) lon2 else lon)

      GDenunciaMapa(PercentualEstado) })


  # Plotar grafico:
  output$PlotOutputMapa <- renderGirafe({ 
    
    girafe(ggobj = GrafMapa(), 
           options = OptionsGirafe, 
           height_svg = 6.75, width_svg = 6.75) })


  # Baixar grafico:
  output$downloadButtonMapa <- downloadHandler(

    filename = function() {

      "Percentual de denúncias por estado das vítimas LGBTQIA+"

    }, content = function(file) { Salv.Graf(file, 1, GrafMapa()) })
  
}

# runGadget(ui, server, viewer = dialogViewer("", width = 1000, height = 610))

# shinyApp(ui, server)
