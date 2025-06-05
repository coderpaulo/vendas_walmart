# Análise de Vendas - Walmart (Projeto SQL)

Este projeto consiste na análise exploratória de uma base de dados de vendas de um supermercado, com o objetivo de gerar insights sobre o comportamento dos clientes, desempenho dos produtos e tendências de vendas.

## 📊 Base de Dados

A base de dados utilizada neste projeto foi obtida no [Kaggle](https://www.kaggle.com/), contendo registros de vendas, incluindo informações como data, hora, produto, filial, cliente, gênero, método de pagamento, avaliação e mais.

## 🛠️ Ferramentas Utilizadas

* **MySQL Workbench**: para criação da base de dados, manipulação e análise com SQL.
* **Microsoft Excel**: para renomear colunas e preparar o arquivo `.csv` para importação.

## 📂 Estrutura do Projeto

* `WalmartSalesData.csv`: base de dados em formato CSV.
* `consultas.sql`: script contendo todas as queries SQL utilizadas no projeto.
* `README.md`: explicação do projeto, perguntas exploradas e insights obtidos.

## 🧠 Perguntas de Negócio Respondidas

### 🏙️ Informações Geográficas

* Quantas cidades únicas existem na base de dados?
* Qual cidade pertence a cada filial?

### 🛒 Produtos

* Quantas linhas de produto únicas existem?
* Qual é a linha de produto mais vendida (em quantidade)?
* Qual é a receita total por mês?
* Qual linha de produto gerou a maior receita?
* Qual cidade teve a maior receita?
* Qual linha de produto teve maior valor médio de imposto (imposto_5)?
*  Quais filiais venderam mais que a média do que a média de produtos?  
*  Produto mais comum por gênero?
*  Avaliação média por linha de produto?

### 🧍 Clientes

* Quantos tipos únicos de cliente existem?
* Quantos métodos de pagamento diferentes existem?
* Qual tipo de cliente é mais comum?
* Qual tipo de cliente mais compra?
* Qual gênero é mais frequente?
* Qual distribuição de gênero por filial?

### 💸 Receita e Impostos

* Número de vendas por período do dia (em um dia da semana específico)?
* Tipo de cliente que gera mais receita?
* Cidade com maior média de imposto (5%)?
* Tipo de cliente que mais paga imposto?


## 📅 Colunas Criadas com SQL

Foram adicionadas as colunas:

* `periodo_dia`: com base no horário da venda (manhã, tarde, noite).
* `dia_semana`: traduzido para português com base na data.
* `mes`: nome do mês em português com base na data.


## 📌 Conclusão

Este projeto demonstrou como utilizar SQL para realizar uma análise exploratória detalhada de uma base de dados de vendas. Com o suporte do ChatGPT, foi possível construir, revisar e otimizar as queries, além de traduzir e contextualizar os insights extraídos.

---

📁 Sinta-se à vontade para clonar este repositório, explorar os dados e utilizar os scripts para fins educacionais ou como base para novos projetos!
