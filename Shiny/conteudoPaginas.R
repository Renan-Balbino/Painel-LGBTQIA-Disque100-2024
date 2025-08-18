
# FUNCOES ================================================================================================================

# Cria cards personalizados no shiny:
person <- function(name, title, company, email = NULL, linkedin = NULL, github = NULL, clattes = NULL, orcid = NULL) {
  
  div(
    class = "person",
    h3(class = "name", name),
    div(class = "title", title),
    div(class = "company", company),
    
    if (!is.null(email) || !is.null(linkedin) || !is.null(github)) {
      div(
        class = "links",
        
        if (!is.null(email)) {
          a(
            href = paste0("mailto:", email), 
            bs_icon("envelope"), 
            class = "social-link",
            `data-bs-toggle` = "tooltip",
            `data-bs-placement` = "top",
            title = email )},
        
        if (!is.null(linkedin)) {
          a(
            href = linkedin, 
            target = "_blank", 
            bs_icon("linkedin"), 
            class = "social-link",
            `data-bs-toggle` = "tooltip",
            `data-bs-placement` = "top",
            title = linkedin )},
        
        if (!is.null(github)) {
          a(
            href = github, 
            target = "_blank", 
            bs_icon("github"), 
            class = "social-link",
            `data-bs-toggle` = "tooltip",
            `data-bs-placement` = "top",
            title = github )},
        
        if (!is.null(clattes)) {
          a(
            href = clattes, 
            target = "_blank", 
            HTML(readLines("www/lattes.svg")), 
            class = "social-link",
            `data-bs-toggle` = "tooltip",
            `data-bs-placement` = "top",
            title = clattes )},
        
        if (!is.null(orcid)) {
          a(
            href = orcid, 
            target = "_blank", 
            icon("orcid"), 
            class = "social-link",
            `data-bs-toggle` = "tooltip",
            `data-bs-placement` = "top",
            title = orcid )}
      )
    } 
  )
}


# Tema ===================================================================================================================

myTema <- bs_theme(
  bootswatch = "united", 
  fg = "#6B4C9A",
  bg = "white",
  # primary = "white",
  # secondary = "black"
) %>% 
  bs_add_rules(sass::sass_file("www/person.scss")) # cards personalizados (final da pagina)


# Estilos do texto =======================================================================================================

# Barra de navegacao:
barraNavPag <- 
  tags$style(HTML("
  .navbar > .container-fluid {
    height: 50px;
    max-width: 1080px;
    margin: 0 auto;
    padding-left: 1rem;
    padding-right: 1rem;
  }
  
  @media (max-width: 991.98px) {
    .navbar-default .navbar-collapse {
      background-color: #5E213F !important;
      padding-left: 0 !important;
      padding-right: 0 !important;
      margin-left: -15px !important;
      margin-right: -15px !important;
    }
    .navbar-nav {
      margin-left: 0 !important;
    }
    .navbar-default .navbar-nav > li > a {
      color: white !important;
      padding: 12px 20px !important;
    }
  }
"))


# Cor da pagina e barra de rolagem:
corpoPag <- 
  tags$style(HTML("
      body {
        padding-top: 50px !important;
        background-color: #F4F0F8 !important;
        color: black !important;
        overflow-y: auto !important;
        height: 100% !important;
      }
      .div-title-secao{
      background-color: #6B4C9A; 
      color: white; 
      padding: 8px; 
      text-align: left; 
      border-radius: 5px; 
      margin-bottom: 20px;
      }
      @media (max-width: 991.98px) {
      body {
        padding-top: 50px !important;
      }
    "))


# Rolar para o inicio da pagina:
rolagemPag <- tags$script(HTML("
    $(document).on('shiny:inputchanged', function(event) {
      if (event.name === 'pagina') {
        $('html, body').scrollTop(0);
      }
    });
  "))


# Tooltip dos icones .person:
tooltip.person <- tags$script(HTML("
  $(function () {
    $('[data-bs-toggle=\"tooltip\"]').tooltip({
      trigger: 'hover',
      html: true
    });
  })
"))


# Conteudo das paginas ===================================================================================================

# Cards pessoais:
Colab <- div(
  
  div(
    style = "display: flex; align-items: center; text-align: center; width: 100%; margin: 1.2rem 0;",
    
    # Linha a esquerda
    tags$hr(style = "flex-grow: 1; border: none; border-top: 1px solid #8970ae; margin: 0 10px;"),
    
    # Título centralizado
    tags$h5(
      "Colaboradores do estudo",
      style = "margin: 0; font-weight: bold; color: #8970ae;"
    ),
    
    # Linha a direita
    tags$hr(style = "flex-grow: 1; border: none; border-top: 1px solid #8970ae; margin: 0 10px;")
  ),
  
  # Container dos colaboradores
  div(
    style = "
      width: 100%;
      margin: 0 auto;
      display: flex;
      flex-wrap: wrap;
      gap: 1rem;
      justify-content: center;
    ",
    person("Joás Medeiros", "Graduando em Atuária", 
           "Universidade Federal do Rio Grande do Norte", 
           "joasjj@hotmail.com", 
           "https://www.linkedin.com/in/jo%C3%A1s-medeiros-7a5109a0", 
           orcid = "https://orcid.org/0009-0008-4743-0629"), 
    person("Kleber Soares", "Graduando em Atuária", 
           "Universidade Federal do Rio Grande do Norte", 
           "abath_soares@hotmail.com", 
           "https://br.linkedin.com/in/kleber-soares-510641110"), 
    person("Mariana Andreotti", "Pós-doutoranda em Demografia", 
           "Universidade Federal do Rio Grande do Norte", 
           "mariana_andreotti_d@hotmail.com", 
           clattes = "http://lattes.cnpq.br/0076588033576486", 
           orcid = "https://orcid.org/my-orcid?orcid=0000-0002-9220-8057"), 
    person("Renan Balbino", 
           "Graduando em Atuária", 
           "Universidade Federal do Rio Grande do Norte", 
           "renan.dmbalbino@gmail.com", 
           "https://br.linkedin.com/in/renan-de-melo-balbino", 
           "https://github.com/Renan-Balbino", 
           "https://lattes.cnpq.br/9741799948855362", 
           "https://orcid.org/0009-0003-7665-9928"), 
    person("Talita Cardoso", "Graduando em Atuária", 
           "Universidade Federal do Rio Grande do Norte", 
           "talitacardoso1989@gmail.com", 
           "https://www.linkedin.com/in/talita-silva-b26482100/", 
           clattes = "", 
           orcid = "https://orcid.org/0009-0001-7004-8590")
  )
)


# Disque 100:
tagDisque100 <- tagList(
  
  div(
    style = "max-width: 1080px; margin: 0 auto; padding: 20px;", 
    
    # O que e?
    h5(
      div(class = "div-title-secao", 
          bs_icon("telephone-fill"), 
          span("Disque 100 – O que é?"))
    ),
    div(style = "font-size: 17px; text-align: justify;", 
        
        HTML("<p>O Disque Direitos Humanos – Disque 100 é um serviço público gratuito 
             do <strong>Ministério dos Direitos Humanos e da Cidadania</strong>. 
             Ele recebe denúncias de violações de direitos humanos, especialmente 
             contra pessoas em situação de vulnerabilidade, como:</p>
        <ul>
          <li>Crianças e adolescentes</li>
          <li>Idosos</li>
          <li>Pessoas com deficiência</li>
          <li>População LGBTQIA+</li>
          <li>Pessoas em situação de rua</li>
          <li>Indígenas, quilombolas, ciganos, entre outros</li>
        </ul>")
        # )
        
        ),
    
    br(),
    
    # Funcoes do servico
    h5(
      div(class = "div-title-secao", 
          bs_icon("shield-lock-fill"),
          span("Funções do serviço"))
    ),
    div(style = "font-size: 17px;", 
        tags$ul(
          tags$li("Receber, analisar e encaminhar denúncias"),
          tags$li("Acionar autoridades competentes em casos graves e urgentes"),
          tags$li("Orientar e informar sobre direitos, programas e serviços públicos")
        )),
    
    br(), 
    
    # Como denunciar?
    h5(
      div(class = "div-title-secao", 
          bs_icon("chat-dots-fill"),
          span("Como denunciar?"))
    ),
    div(style = "font-size: 17px;", 
        p("O serviço funciona 24 horas por dia, todos os dias da semana, inclusive feriados. ",
          "Qualquer pessoa pode denunciar:"),
        strong("Canais disponíveis:"),
        tags$ul(
          tags$li(bs_icon("telephone"), "Disque 100 (ligação gratuita de qualquer telefone)"),
          tags$li(bs_icon("whatsapp"), "+55 61 99611-0100"),
          tags$li(
            bs_icon("globe"),
            a("Site do Ministério", href = "https://www.gov.br/mdh/pt-br/ondh", target = "_blank"),
            "com chat e aqui", 
            a("videochamada em Libras", href = "https://atendelibras.mdh.gov.br/acesso", target = "_blank")
          ),
          tags$li(bs_icon("envelope"), 
                  a("ouvidoria@mdh.gov.br", href = "mailto:ouvidoria@mdh.gov.br")),
          tags$li(bs_icon("send"), 'Telegram: Buscar por "Direitoshumanosbrasil"'),
          tags$li(bs_icon("phone"), strong('"Sabe"'), ": aplicativo informativo e educativo"),
          tags$li(bs_icon("geo-alt"), "Presencial: Brasília/DF, na Ouvidoria Nacional")
        )),
    
    br(), 
    
    # Informacoes adicionais
    h5(
      div(class = "div-title-secao", 
          bs_icon("info-circle-fill"),
          span("Para mais informações"))
    ),
    div(style = "font-size: 17px;", 
        p(
          "Acesse o portal oficial em: ",
          a("https://www.gov.br/pt-br/servicos/denunciar-violacao-de-direitos-humanos",
            href = "https://www.gov.br/pt-br/servicos/denunciar-violacao-de-direitos-humanos",
            target = "_blank")
        ))
  )
  
)


# Sobre:
tagSobre <- tagList(
  
  div(
    style = "max-width: 1080px; margin: 0 auto; padding: 20px;", 
    
    # Topico 1
    h5(
      div(class = "div-title-secao", 
          bs_icon("heart-pulse-fill"), 
          span("Violência contra a população LGBTQIA+ no Brasil"))
    ),
    div(style = "font-size: 17px; text-align: justify;", 
        HTML("<p>O painel foi desenvolvido com o objetivo de complementar a atividade final da disciplina <strong>População, 
             Sociedade e Ambiente</strong> ministrada pela professora <strong>Mariana Andreotti</strong> no curso de <strong>Ciências 
             Atuariais</strong> da <strong>UFRN</strong>. Além disso, busca divulgar dados referentes às denúncias realizadas ao <strong>Disque 
             100 em 2024</strong> que possuem <strong>vítimas LGBTQIA+</strong>, dando ênfase nas características das vítimas e dos suspeitos envolvidos nos 
             casos de violações de direitos humanos.</p>")),
    
    br(), 
    
    # Topico 2
    h5(
      div(class = "div-title-secao", 
          bs_icon("search"),
          span("Possibilidades fornecidas"))
    ),
    div(style = "font-size: 17px;", 
        HTML(
          "<ul>
              <li>Analisar o volume de denúncias ao longo dos meses de 2024</li>
              <li>Observar a frequência por estado brasileiro</li>
              <li>Verificar diferenças segundo cor/raça autodeclarada</li>
              <li>Avaliar a presença ou não de deficiência entre as vítimas</li>
              <li>Compreender a distribuição por faixa etária</li>
              <li>Explorar o perfil religioso das vítimas e dos suspeitos</li>
              <li>Investigar a relação entre suspeito e vítima</li>
              <li>Analisar as motivações atribuídas às denúncias</li>
          </ul>"
        )),
    
    br(), 
    
    # Topico 3
    h5(
      div(class = "div-title-secao", 
          bs_icon("people-fill"),
          span("Contribuições do painel"))
    ),
    div(style = "font-size: 17px;", 
        tags$ul(
          tags$li("Dar visibilidade à realidade enfrentada pela população LGBTQIA+ no Brasil"),
          tags$li("Apoiar políticas públicas com base em dados concretos"),
          tags$li("Estimular pesquisas, debates e ações sociais focadas na redução das violações de direitos humanos"),
          tags$li("Promover o acesso aberto à informação, de forma clara e interativa")
        )),
    
  ) #div
  
)

