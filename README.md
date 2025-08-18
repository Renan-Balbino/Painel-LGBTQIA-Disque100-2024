## Violência contra a população LGBTQIA+ no Brasil

O painel interativo foi desenvolvido com o objetivo de complementar a atividade final da disciplina **População, Sociedade e Ambiente**, ministrada pela professora **Mariana Andreotti** no curso de **Ciências Atuariais** da **UFRN**. Além disso, busca 
divulgar dados referentes às denúncias realizadas ao **Disque 100 em 2024** que possuem **vítimas LGBTQIA+**, dando ênfase nas características das vítimas e dos suspeitos envolvidos nos casos de violações de direitos humanos.

**Acesse o painel online:** [Painel LGBTQIA+ Disque 100 – 2024](https://renan-balbino.shinyapps.io/Painel-LGBTQIA-Disque100-2024/)  

<br>

## BaseR – PadronizandoVariaveis

É o script de base. Nele os [dados do Disque 100](https://www.gov.br/mdh/pt-br/acesso-a-informacao/dados-abertos/disque100) são organizados adequadamente para diversos tipos de análises.  
Em resumo, são realizados:

- Importação dos dados para o R;  
- Análise inicial para melhor entendimento;  
- Seleção de variáveis relevantes;  
- Unificação dos semestres e filtro para selecionar apenas casos LGBTQIA+;  
- Recodificação e reagrupamento de respostas;  
- Criação de algumas variáveis:  
  - `Mes`  
  - `Regiao`  
  - `Faixa_etária_da_vítima2`  
  - `Faixa_etária_do_suspeito2`  
  - `Relação_vítima_suspeito2`  
  - `Religião_da_vítima2`  
  - `Religião_do_suspeito2`  
  - `Deficiência_da_vítima2`  
  - `Deficiência_do_suspeito2`

<br>

### Agrupamentos realizados

**Relação entre suspeito e vítima:**  
- **Núcleo Familiar Direto**: Pai, Mãe, Filho(a), Neto(a), Bisneto(a), Trisavô(ó), Avô(ó), Bisavô(ó), Irmão(ã), Esposa(o), Companheiro(a), Companheiro(a) da mãe/do pai, Namorado(a), Padrasto/Madrasta, Enteado(a), Genro/Nora, Sogro(a), Cunhado(a), Tio(a), Primo(a), Sobrinho(a);  
- **Familiares Indiretos / Não Específicos**: Outros familiares, Pessoa com quem mantém/manteve convivência familiar, Padrinho/Madrinha, Ex-esposa(o), Ex-companheiro(a), Ex-namorado(a);  
- **Rede de Convivência Próxima**: Amigo(a), Amigo(a) da família, Vizinho(a), Mora na mesma residência mas não é familiar, Morou na mesma residência mas não é familiar;  
- **Relações de Poder / Hierarquia**: Diretor(a) de escola, Diretor(a) de unidade prisional, Diretor/Gestor de instituição, Professor(a), Outros profissionais da educação, Líder religioso(a), Treinador(a)/Técnico(a), Profissional de saúde, Empregador/Patrão (hierarquicamente superior);  
- **Outras Relações:** Empregado(a) doméstico, Empregado (hierarquicamente inferior), Funcionário/voluntário/prestador de serviço para instituição, Prestador(a) de serviço, Aluno(a), Colega de trabalho (mesmo nível hierárquico), Cuidador(a);  
- **Outros**: Não se aplica, Outros.  

> **Nota:** Antes da realização dos cálculos para a variável *Relação_vítima_suspeito2*, no script *TabelasYGraficosDinamicos*, foram removidos casos em que a própria vítima foi classificada como autora.  

<br>

**Religião:**  
- **Religiões Católicas**: Católica apostólica romana, Católica apostólica brasileira, Católica ortodoxa;  
- **Evangélicas / Protestantes**: Evangélica, Testemunhas de Jeová;  
- **Outras Religiões Cristãs**: Outras religiosidades cristãs, Igreja de Jesus Cristo dos Santos dos Últimos Dias;  
- **Religiões Afro-brasileiras**: Candomblé, Umbanda, Umbanda e Candomblé, Outras declarações de religiosidades afrobrasileiras;  
- **Religiões Espiritualistas**: Espírita, Espiritualista;  
- **Outros**: Outras religiosidades, Tradições indígenas, Não determinada e múltiplo pertencimento, Tradições esotéricas, Budismo, Hinduísmo, Igreja messiânica mundial, Islamismo, Judaísmo, Outras religiões orientais.

<br>

## Shiny – TabelasYGraficosDinamicos

- Conforme o [Dicionário dos Dados do Disque 100](https://www.gov.br/mdh/pt-br/acesso-a-informacao/dados-abertos/DicionriodeDadosDisque100.xlsx), cada **hash** representa uma denúncia.  
- Uma mesma denúncia pode conter múltiplos registros para: grupo de violação, violação em um mesmo local, tipo de violação, espécie de violação, motivação, agravante, denúncia e denúncia emergencial.  
- Para obter o número real de denúncias, foi necessário:  
  - Selecionar apenas as variáveis relevantes para cada caso  
  - Eliminar linhas duplicadas  
  - Exemplo: Se uma denúncia possui 5 tipos de violações, ela é registrada 5 vezes, mas só existe uma vítima e um suspeito. Ao manter apenas as colunas `hash`, vítima e suspeito e eliminar duplicatas, obtemos o número real de denúncias. 

> **Nota:** Apesar de ser possível metrificar a quantidade de vítimas por denúncia através da variável `sl_quantidade_vitimas`, o número de subnotificações ainda é grande, prejudicando demais comparações. Os dados expostos representam a *quantidade mínima* identificada nas circunstâncias apresentadas. Além disso, não é possível metrificar a quantidade de suspeitos.  
