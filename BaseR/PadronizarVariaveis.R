# DEFINICOES INICIAIS ====================================================================================================

# Diretorio:
setwd(r"(H:\Estudos\R\Shiny\Painel-LGBTQIAPN-Disque100-2024)")


# Carregando pacotes:
# install.packages("pacman")
pacman::p_load(tidyverse, rio, geobr, rmapshaper)

# Retira notacao cientifica:
options(scipen = 999)


# FUNCOES ================================================================================================================

# Auxiliar na ordem dos fatores:
Orden.Fator <- function(VARIAVEL, VALORES) {
  
  TodosNiveis <- levels(VARIAVEL)
  OutrosNiveis <- setdiff(TodosNiveis, VALORES)
  NovaOrdem <- c(sort(OutrosNiveis), VALORES)
  
  fct_relevel(VARIAVEL, NovaOrdem)
  
}


# IMPORTANDO DADOS =======================================================================================================

# Obs: baixe os dados no site oficial e salve-os numa pasta para executar o resto do script
# Site: https://www.gov.br/mdh/pt-br/acesso-a-informacao/dados-abertos/disque100

# Dados Disque 100:
Dados2024.1 <- import("disque100-primeiro-semestre-2024.csv")
Dados2024.2 <- import("disque100-segundo-semestre-2024.csv")


# Geolocalizacoes estaduais:
GeoEstado <- read_state(code_state = "all", year = 2020) %>%
  
  mutate(abbrev_state = as.factor(abbrev_state))


# ESTRUTURA DOS DADOS ====================================================================================================

# Conhecendo variaveis ---------------------------------------------------------------------------------------------------

# Variaveis disponiveis:
names(Dados2024.1)
names(Dados2024.2)


# Total de respostas por variavel 2024.1:
table(is.na(Dados2024.1$hash))
levels(factor(Dados2024.1$UF))
levels(factor(Dados2024.1$UF_da_vítima))
levels(factor(Dados2024.1$Município))
levels(factor(Dados2024.1$Faixa_etária_da_vítima))
levels(factor(Dados2024.1$Gênero_da_vítima))
levels(factor(Dados2024.1$Orientação_sexual_da_vítima))
levels(factor(Dados2024.1$Raça_Cor_da_vítima))
levels(factor(Dados2024.1$Faixa_etária_do_suspeito))
levels(factor(Dados2024.1$Orientação_sexual_do_suspeito))
levels(factor(Dados2024.1$Gênero_do_suspeito))
levels(factor(Dados2024.1$Raça_Cor_do_suspeito))
levels(factor(Dados2024.1$Grupo_vulnerável))
levels(factor(Dados2024.1$Motivação))
levels(factor(Dados2024.1$Relação_vítima_suspeito))
levels(factor(Dados2024.1$Religião_da_vítima))
levels(factor(Dados2024.1$Religião_do_suspeito))
levels(factor(Dados2024.1$Natureza_Jurídica_do_Suspeito))
levels(factor(Dados2024.1$Deficiência_da_vítima))
levels(factor(Dados2024.1$Deficiência_do_suspeito))


# Total de respostas por variavel 2024.2:
table(is.na(Dados2024.2$hash))
levels(factor(Dados2024.2$UF))
levels(factor(Dados2024.2$UF_da_vítima))
levels(factor(Dados2024.2$Município))
levels(factor(Dados2024.2$Faixa_etária_da_vítima))
levels(factor(Dados2024.2$Sexo_da_vítima))
levels(factor(Dados2024.2$Orientação_sexual_da_vítima))
levels(factor(Dados2024.2$Raça_Cor_da_vítima))
levels(factor(Dados2024.2$Faixa_etária_do_suspeito))
levels(factor(Dados2024.2$Orientação_sexual_do_suspeito))
levels(factor(Dados2024.2$Sexo_do_suspeito))
levels(factor(Dados2024.2$Raça_Cor_do_suspeito))
levels(factor(Dados2024.2$Grupo_vulnerável))
levels(factor(Dados2024.2$Motivação))
levels(factor(Dados2024.1$Relação_vítima_suspeito))
levels(factor(Dados2024.1$Religião_da_vítima))
levels(factor(Dados2024.1$Religião_do_suspeito))
levels(factor(Dados2024.1$Natureza_Jurídica_do_Suspeito))
levels(factor(Dados2024.1$Deficiência_da_vítima))
levels(factor(Dados2024.1$Deficiência_do_suspeito))


# Variaveis utilizadas:
Dados2024.1_2 <- Dados2024.1 %>% select(hash, sl_quantidade_vitimas, 
                                        Data_de_cadastro, UF, Município, 
                                        Faixa_etária_da_vítima, 
                                        Gênero_da_vítima, 
                                        Orientação_sexual_da_vítima, 
                                        Raça_Cor_da_vítima, Religião_da_vítima, 
                                        Deficiência_da_vítima, 
                                        Relação_vítima_suspeito, 
                                        Faixa_etária_do_suspeito, 
                                        Gênero_do_suspeito, 
                                        Orientação_sexual_do_suspeito, 
                                        Raça_Cor_do_suspeito, Religião_do_suspeito, 
                                        Deficiência_do_suspeito, 
                                        Natureza_Jurídica_do_Suspeito, 
                                        Grupo_vulnerável, Motivação)


Dados2024.2_2 <- Dados2024.2 %>% select(hash, sl_quantidade_vitimas, 
                                        Data_de_cadastro, UF, Município, 
                                        Faixa_etária_da_vítima, 
                                        Sexo_da_vítima, 
                                        Orientação_sexual_da_vítima, 
                                        Raça_Cor_da_vítima, Religião_da_vítima, 
                                        Deficiência_da_vítima, 
                                        Relação_vítima_suspeito, 
                                        Faixa_etária_do_suspeito, 
                                        Sexo_do_suspeito, 
                                        Orientação_sexual_do_suspeito, 
                                        Raça_Cor_do_suspeito, Religião_do_suspeito, 
                                        Deficiência_do_suspeito, 
                                        Natureza_Jurídica_do_Suspeito, 
                                        Grupo_vulnerável, Motivação)


# Padronizando variaveis -------------------------------------------------------------------------------------------------

# Renomeando variaveis:
Dados2024.2_2 <- Dados2024.2_2 %>% rename(Gênero_da_vítima = Sexo_da_vítima, 
                                          Gênero_do_suspeito = Sexo_do_suspeito)


# Juntando dados:
Dados <- bind_rows(Dados2024.1_2, Dados2024.2_2)


# Apenas vitimas LGBTQIA+:
Dados2 <- Dados %>% dplyr::filter(!Orientação_sexual_da_vítima 
                                  %in% c("NÃO", "NÃO INFORMADO", "NULL"))


# Recodificando respostas:
Dados3 <- Dados2 %>% rename(Data = Data_de_cadastro) %>% 
  
  mutate(Ano = str_sub(Data, 1, 4), 
         Data = as.character(Data), 
         
         sl_quantidade_vitimas = as.character(sl_quantidade_vitimas), 
         
         Orientação_sexual_do_suspeito = 
           if_else(Orientação_sexual_do_suspeito == "NÃO", 
                   "Heterossexual", Orientação_sexual_do_suspeito), 
         
         Motivação = str_replace_all(Motivação, "\\.", " "), 
         
         across(-Data, ~ if_else(str_detect(.x, "\\."), 
                                 str_extract(.x, "(?<=\\.).*"), .x)), 
         
         across(everything(), ~ 
                  if_else(str_detect(.x, "N/D|NULL|INTERROMPIDO|NÃO INFORMAD|NÃO SOUBE INFORMAR|NÃO SABE"), 
                          "Não identificado", .x)), 
         
         across(-Data, ~ if_else(nchar(.x) > 2, str_to_sentence(.x), .x)), 
         
         across(-Data, ~ str_replace_all(.x, "(?<=/)(\\p{L})", ~ toupper(.x))), 
         
         Natureza_Jurídica_do_Suspeito = 
           if_else(Natureza_Jurídica_do_Suspeito 
                   %in% c("Órgão público", "Pessoa física"), 
                   str_to_title(Natureza_Jurídica_do_Suspeito), 
                   Natureza_Jurídica_do_Suspeito), 
         
         Natureza_Jurídica_do_Suspeito = 
           if_else(str_detect(Natureza_Jurídica_do_Suspeito, 
                              "Pessoa jurídica de direito privado"), 
                   "Pessoa Jurídica de direito privado", 
                   Natureza_Jurídica_do_Suspeito), 
         
         across(-c(hash, Data), ~ as.factor(.x)), 
         
         across(c(Deficiência_da_vítima, Deficiência_do_suspeito), ~
                  fct_relevel(.x, "Não", "Não identificado", after = Inf)), 
         
         across(c(Orientação_sexual_da_vítima, Orientação_sexual_do_suspeito), ~ 
                  fct_relevel(.x, "Outro", "Não identificado", after = Inf)), 
         
         across(c(Raça_Cor_da_vítima, Raça_Cor_do_suspeito), ~
                  fct_relevel(.x, "Não identificado", after = Inf)), 
         
         Motivação = fct_relevel(Motivação, "Não identificado", after = Inf), 
         
         Município = str_to_title(Município), 
         
         sl_quantidade_vitimas = as.numeric(sl_quantidade_vitimas))


# Criando variaveis:
Dados4 <- Dados3 %>% 
  mutate(Semestre = if_else(
    str_sub(Data, 6, 7) %in% c("01", "02", "03", "04", "05", "06"), 
    paste0(Ano, ".1"), paste0(Ano, ".2")), 
    
    
    Mes = fct_recode(factor(str_sub(Data, 6, 7)), 
                     Jan = "01", Fev = "02", Mar = "03", Abr = "04", Mai = "05", 
                     Jun = "06", Jul = "07", Ago = "08", Set = "09", Out = "10", 
                     Nov = "11", Dez = "12"), 
    
    
    Regiao =
      Orden.Fator(
        fct_collapse(UF, 
                     Norte = c("AC", "AP", "AM", "PA", "RO", "RR", "TO"),
                     Nordeste = c("AL", "BA", "CE", "MA", "PB", "PE", "PI", "RN", "SE"),
                     `Centro-Oeste` = c("DF", "GO", "MT", "MS"),
                     Sudeste = c("ES", "MG", "RJ", "SP"),
                     Sul = c("PR", "RS", "SC")), "Não identificado"), 
    
    
    MunicipioCod = as.numeric(str_extract(Município, ".*(?=\\|)")), 
    
    
    Faixa_etária_da_vítima2 = 
      fct_collapse(Faixa_etária_da_vítima, 
                   `0 a 4 anos` = c("Recém-nascido (até 28 dias)", 
                                    "Menos de 01 ano", "01 ano", 
                                    "02 anos", "03 anos", "04 anos"), 
                   `5 a 9 anos` = c("05 anos", "06 anos", "07 anos", 
                                    "08 anos", "09 anos"), 
                   `10 a 14 anos` = c("10 anos", "11 anos", "12 anos", 
                                      "13 anos", "14 anos"), 
                   `15 a 19 anos` = c("15 anos", "16 anos", "17 anos", 
                                      "18 a 19 anos")), 
    
    
    Faixa_etária_do_suspeito2 = 
      fct_collapse(Faixa_etária_do_suspeito, 
                   `12 a 14 anos` = c("12 anos", "13 anos", "14 anos"), 
                   `15 a 19 anos` = c("15 anos", "16 anos", "17 anos", 
                                      "18 a 19 anos")), 
    
    
    Relação_vítima_suspeito2 = 
      Orden.Fator(
        fct_collapse(
          Relação_vítima_suspeito, 
          
          `Núcleo Familiar Direto` = 
            c("Pai", "Mãe", "Filho(a)", "Neto(a)", "Bisneto(a)", "Trisavô(ó)", 
              "Avô(ó)", "Bisavô(ó)", "Irmão(ã)", "Esposa(o)", "Companheiro(a)", 
              "Companheiro(a) da mãe/Do pai", "Namorado(a)", "Padrasto/Madrasta", 
              "Enteado(a)", "Genro/Nora", "Sogro(a)", "Cunhado(a)", "Tio(a)", 
              "Primo(a)", "Sobrinho(a)", "Ex-esposa(o)", "Ex-companheiro(a)", 
              "Ex-namorado(a)"), 
          
          `Familiares Indiretos/Não Específicos` = 
            c("Outros familiares", 
              "Pessoa com quem mantém/Manteve convivência familiar", 
              "Padrinho/Madrinha"), 
          
          `Rede de Convivência Próxima` = 
            c("Amigo(a)", "Amigo(a) da família", "Vizinho(a)", 
              "Mora na mesma residência mas não é familiar", 
              "Morou na mesma residência mas não é familiar", 
              "Aluno(a)", "Colega de trabalho (mesmo nível hierárquico)", 
              "Cuidador(a)"), 
          
          `Relações de Poder/Hierarquia` = 
            c("Diretor(a) de escola", "Diretor(a) de unidade prisional", 
              "Diretor/Gestor de instituição", "Professor(a)", 
              "Outros profissionais da educação", "Líder religioso(a)", 
              "Treinador(a)/Técnico(a)", "Profissional de saúde", 
              "Empregador/Patrão (hierarquicamente superior)", 
              "Empregado(a) doméstico", "Empregado (hierarquicamente inferior)", 
              "Funcionário, voluntário ou prestador de serviço para instituição", 
              "Prestador(a) de serviço"), 
          
          Outros = c("Não se aplica", "Outros")), 
        
        c("Outros", "Não identificado")), 
    
    
    Religião_da_vítima2 = 
      Orden.Fator(
        fct_collapse(
          Religião_da_vítima, 
          
          `Religiões Católicas` = c("Católica apostólica romana", 
                                    "Católica apostólica brasileira", 
                                    "Católica ortodoxa"), 
          
          `Evangélicas/Protestantes` = c("Evangélica", "Testemunhas de jeová"), 
          
          `Outras religiões cristãs` = c("Outras religiosidades cristãs", 
                                         "Igreja de jesus cristo dos santos dos últimos dias"), 
          
          `Religiões Afro-brasileiras` = c("Candomblé", "Umbanda", 
                                           "Umbanda e candomblé", 
                                           "Outras declarações de religiosidades afrobrasileira"), 
          
          `Religiões Espiritualistas` = c("Espírita", "Espiritualista"), 
          
          Outros = c("Outras religiosidades", "Tradições indígenas", 
                     "Não determinada e multiplo pertencimento", 
                     "Tradições esotéricas", "Budismo", "Hinduísmo", 
                     "Igreja messiânica mundial", "Islamismo", "Judaísmo", 
                     "Outras religiões orientais")), 
        
        c("Outras religiões cristãs", "Outros", "Não identificado")), 
    
    
    Religião_do_suspeito2 = 
      Orden.Fator(fct_collapse(
        Religião_do_suspeito,
        
        `Religiões Católicas` = c("Católica apostólica romana", 
                                  "Católica apostólica brasileira", 
                                  "Católica ortodoxa"), 
        
        `Evangélicas/Protestantes` = c("Evangélica", "Testemunhas de jeová"), 
        
        `Outras religiões cristãs` = c("Outras religiosidades cristãs", 
                                       "Igreja de jesus cristo dos santos dos últimos dias"), 
        
        `Religiões Afro-brasileiras` = c("Candomblé", "Umbanda", 
                                         "Umbanda e candomblé", 
                                         "Outras declarações de religiosidades afrobrasileira"), 
        
        `Religiões Espiritualistas` = c("Espírita", "Espiritualista"), 
        
        Outros = c("Outras religiosidades", "Tradições indígenas", 
                   "Não determinada e multiplo pertencimento", 
                   "Tradições esotéricas", "Budismo", "Hinduísmo", 
                   "Igreja messiânica mundial", "Islamismo", "Judaísmo", 
                   "Outras religiões orientais")), 
        
        c("Outras religiões cristãs", "Outros", "Não identificado")), 
    
    
    Deficiência_da_vítima2 =
      fct_collapse(
        Deficiência_da_vítima,
        Sim = c("Auditiva/Surdez", "Autismo", "Física/Motora",
                "Mental/Intelectual", "Visual")), 
    
    
    Deficiência_do_suspeito2 =
      fct_collapse(
        Deficiência_do_suspeito,
        Sim = c("Auditiva/Surdez", "Autismo", "Física/Motora",
                "Mental/Intelectual", "Visual"))) %>% 
  
  select(hash, Ano, Semestre, Mes, Regiao, UF, Município, MunicipioCod, everything(), -Data)

# Obs: as mensagens de aviso dizem que algumas categorias incluidas nao foram encontradas, 
# como as faixas etarias 03 anos e 09 em `Faixa_etária_da_vítima2. Nada que atrapalhe


# Simplificando geolocalizacoes:
GeoEstado2 <- ms_simplify(GeoEstado, keep = 0.05, keep_shapes = TRUE)


# EXPORTANDO DADOS =======================================================================================================

# Exportando dados:
export(Dados4, "DenunciasLGBTQIA2024.Rdata")
export(GeoEstado2, "Geolocalizacoes.Rdata")
