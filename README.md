# 📊 Violência contra a população LGBTQIA+ no Brasil

O painel interativo foi desenvolvido com o objetivo de complementar a atividade final da disciplina **População, Sociedade e Ambiente**, ministrada pela professora **Mariana Andreotti**, e divulgar dados referentes às denúncias realizadas por pessoas LGBTQIA+ ao Disque 100 em 2024, com foco nas características das vítimas e dos suspeitos envolvidos nos casos de violações de direitos humanos.

🔗 **Acesse o painel online:** [Painel LGBTQIA+ Disque 100 – 2024](https://renan-balbino.shinyapps.io/Painel-LGBTQIA-Disque100-2024/)

---

## 🎯 Possibilidades fornecidas

- Analisar o volume de denúncias ao longo dos meses de 2024  
- Observar a distribuição por estado brasileiro  
- Verificar diferenças segundo cor/raça autodeclarada  
- Avaliar a presença ou não de deficiência entre as vítimas  
- Compreender a distribuição por faixa etária  
- Explorar o perfil religioso das vítimas e dos suspeitos  
- Analisar a relação entre suspeito e vítima  
- Identificar a motivação das denúncias  

---

## 🛠️ Script 1 – PadronizandoVariaveis

- Importação dos dados para o R  
- Análise inicial para melhor entendimento  
- Seleção de variáveis relevantes  
- Unificação dos semestres e filtro para selecionar apenas casos LGBTQIA+  
- Recodificação e reagrupamento de respostas  
- Criação de variáveis derivadas, como:  
  - `Mes`  
  - `Regiao`  
  - `Faixa_etária_da_vítima2`  
  - `Faixa_etária_do_suspeito2`  
  - `Relação_vítima_suspeito2`  
  - `Religião_da_vítima2`  
  - `Religião_do_suspeito2`  
  - `Deficiência_da_vítima2`  
  - `Deficiência_do_suspeito2`

### 📌 Agrupamentos realizados

**Relação vítima-suspeito**  
- **Núcleo Familiar Direto**: Pai, Mãe, Filho(a), Neto(a), Bisneto(a), Trisavô(ó), Avô(ó), Bisavô(ó), Irmão(ã), Esposa(o), Companheiro(a), Companheiro(a) da mãe/do pai, Namorado(a), Padrasto/Madrasta, Enteado(a), Genro/Nora, Sogro(a), Cunhado(a), Tio(a), Primo(a), Sobrinho(a), Ex-esposa(o), Ex-companheiro(a), Ex-namorado(a)  
- **Familiares Indiretos / Não Específicos**: Outros familiares, Pessoa com quem mantém/manteve convivência familiar, Padrinho/Madrinha  
- **Rede de Convivência Próxima**: Amigo(a), Amigo(a) da família, Vizinho(a), Mora na mesma residência mas não é familiar, Morou na mesma residência mas não é familiar, Aluno(a), Colega de trabalho (mesmo nível hierárquico), Cuidador(a)  
- **Relações de Poder / Hierarquia**: Diretor(a) de escola, Diretor(a) de unidade prisional, Diretor/Gestor de instituição, Professor(a), Outros profissionais da educação, Líder religioso(a), Treinador(a)/Técnico(a), Profissional de saúde, Empregador/Patrão (hierarquicamente superior), Empregado(a) doméstico, Empregado (hierarquicamente inferior), Funcionário/voluntário/prestador de serviço para instituição, Prestador(a) de serviço  
- **Outros**: Não se aplica, Outros  

**Religião**  
- **Religiões Católicas**: Católica apostólica romana, Católica apostólica brasileira, Católica ortodoxa  
- **Evangélicas / Protestantes**: Evangélica, Testemunhas de Jeová  
- **Outras Religiões Cristãs**: Outras religiosidades cristãs, Igreja de Jesus Cristo dos Santos dos Últimos Dias  
- **Religiões Afro-brasileiras**: Candomblé, Umbanda, Umbanda e Candomblé, Outras declarações de religiosidades afrobrasileiras  
- **Religiões Espiritualistas**: Espírita, Espiritualista  
- **Outros**: Outras religiosidades, Tradições indígenas, Não determinada e múltiplo pertencimento, Tradições esotéricas, Budismo, Hinduísmo, Igreja messiânica mundial, Islamismo, Judaísmo, Outras religiões orientais  

---

## 📊 Script 2 – TabelasYGraficosDinamicos

- Conforme o [Dicionário dos Dados do Disque 100](https://www.gov.br/mdh/pt-br/acesso-a-informacao/dados-abertos/DicionriodeDadosDisque100.xlsx), cada **hash** representa uma denúncia.  
- Uma mesma denúncia pode conter múltiplos registros para: grupo de violação, violação em um mesmo local, tipo de violação, espécie de violação, motivação, agravante, denúncia e denúncia emergencial.  
- Para obter o número real de denúncias, foi necessário:  
  - Selecionar apenas as variáveis relevantes para cada caso  
  - Eliminar linhas duplicadas  
  - Exemplo: Se uma denúncia possui 5 tipos de violações, ela é registrada 5 vezes, mas só existe uma vítima e um suspeito. Ao manter apenas as colunas `hash`, vítima e suspeito e eliminar duplicatas, obtém-se a contagem correta.

> **Nota 1:** Apesar de ser possível mensurar a quantidade de vítimas por denúncia usando `sl_quantidade_vitimas`, há alta subnotificação, o que compromete comparações. Os dados apresentados representam a **quantidade mínima** identificada.  
> **Nota 2:** Não é possível mensurar a quantidade de suspeitos.  
> **Nota 3:** Na variável *Relação vítima-suspeito*, foram excluídos casos em que a própria vítima foi classificada como autora.
