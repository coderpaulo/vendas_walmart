-- Criação da Base de Dados
CREATE DATABASE vendas_walmart;
USE vendas_walmart;

-- Criação da tabela
CREATE TABLE vendas (
    id_fatura VARCHAR(30) NOT NULL PRIMARY KEY,
    filial VARCHAR(5)NOT NULL,
    cidade VARCHAR(30)NOT NULL,
    tipo_cliente VARCHAR(30)NOT NULL,
    genero VARCHAR(10)NOT NULL,
    linha_produto VARCHAR(100)NOT NULL,
    preco_uni DECIMAL(10,2)NOT NULL,
    quantidade INT NOT NULL,
    imposto_5 FLOAT NOT NULL,
    total DECIMAL(10,2)NOT NULL,
    data DATE NOT NULL,
    horario TIME NOT NULL, 
    metodo_p VARCHAR(30)NOT NULL,
    custo_pro DECIMAL(10,2) NOT NULL,
    percentual_margem_bruta FLOAT,
    lucro_bruto DECIMAL(10,2),
    avaliacao FLOAT
);

ALTER TABLE vendas ADD COLUMN periodo_dia VARCHAR(20);

UPDATE vendas
SET periodo_dia = (
    CASE
        WHEN TIME(STR_TO_DATE(horario, '%H:%i:%s')) BETWEEN '00:00:00' AND '12:00:00' THEN 'Manhã'
        WHEN TIME(STR_TO_DATE(horario, '%H:%i:%s')) BETWEEN '12:01:00' AND '16:00:00' THEN 'Tarde'
        ELSE 'Noite'
    END
);

-- Adiciona uma nova coluna chamada 'dia_semana' na tabela 'vendas'
ALTER TABLE vendas ADD COLUMN dia_semana VARCHAR(10);

UPDATE vendas
SET dia_semana = DAYNAME(data);

-- Adiciona uma nova coluna chamada 'mes' na tabela 'vendas'
ALTER TABLE vendas ADD COLUMN mes VARCHAR(10);

UPDATE vendas
SET mes = MONTHNAME(data);

-- Traduz os nomes dos dias da semana de inglês para português na coluna 'dia_semana'
UPDATE vendas
SET dia_semana = CASE DAYNAME(data)
    WHEN 'Monday' THEN 'Segunda'
    WHEN 'Tuesday' THEN 'Terça'
    WHEN 'Wednesday' THEN 'Quarta'
    WHEN 'Thursday' THEN 'Quinta'
    WHEN 'Friday' THEN 'Sexta'
    WHEN 'Saturday' THEN 'Sábado'
    WHEN 'Sunday' THEN 'Domingo'
END;

-- Traduz os nomes dos meses de inglês para português na coluna 'mes'
UPDATE vendas
SET mes = CASE MONTHNAME(data)
    WHEN 'January' THEN 'Janeiro'
    WHEN 'February' THEN 'Fevereiro'
    WHEN 'March' THEN 'Março'
    WHEN 'April' THEN 'Abril'
    WHEN 'May' THEN 'Maio'
    WHEN 'June' THEN 'Junho'
    WHEN 'July' THEN 'Julho'
    WHEN 'August' THEN 'Agosto'
    WHEN 'September' THEN 'Setembro'
    WHEN 'October' THEN 'Outubro'
    WHEN 'November' THEN 'Novembro'
    WHEN 'December' THEN 'Dezembro'
END;

-- ----------------------------------------------generico---------------------------------------------------------------- -- 		
-- Quantas cidades únicas temos?
SELECT 
	DISTINCT cidade
FROM vendas;

-- Em qual cidade fica cada fiial?
SELECT 
	DISTINCT cidade,
    filial
FROM vendas;			

-- ----------------------------------------------produtos---------------------------------------------------------------- -- 

-- Quantas linhas de produto únicas existem?
SELECT COUNT(DISTINCT linha_produto) AS total_linhas_produto
FROM vendas;

-- Qual é a linha de produto mais vendida (em quantidade)?
SELECT linha_produto, SUM(quantidade) AS total_vendida
FROM vendas
GROUP BY linha_produto
ORDER BY total_vendida DESC
LIMIT 1;

-- Qual é a receita total por mês? 
SELECT mes, SUM(total) AS receita_total
FROM vendas
GROUP BY mes
ORDER BY FIELD(mes, 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');

-- Qual linha de produto gerou a maior receita?
SELECT linha_produto, SUM(total) AS receita_total
FROM vendas
GROUP BY linha_produto
ORDER BY receita_total DESC
LIMIT 1;

-- Qual cidade teve a maior receita?
SELECT filial, cidade, SUM(total) AS receita_total
FROM vendas
GROUP BY cidade, filial
ORDER BY receita_total DESC
LIMIT 1;

--  Qual linha de produto teve maior valor médio de imposto (imposto_5)?
SELECT linha_produto, AVG(imposto_5) AS media_imposto
FROM vendas
GROUP BY linha_produto
ORDER BY media_imposto DESC
LIMIT 1;

-- Quais filiais venderam mais que a média do que a média de produtos?  
SELECT 
	filial, 
    SUM(quantidade) AS total_vendido
FROM vendas
GROUP BY filial
HAVING total_vendido > (SELECT AVG(quantidade) FROM vendas);

-- Produto mais comum por gênero?
SELECT
	genero,
	linha_produto,
	COUNT(*) AS total
FROM vendas
GROUP BY genero, linha_produto
ORDER BY total DESC;

-- Avaliação média por linha de produto?
SELECT
	linha_produto,
    ROUND(AVG(avaliacao), 2) AS media_avaliacao
FROM vendas
GROUP BY linha_produto
ORDER BY media_avaliacao DESC;

-- -----------------------------------------------Clientes---------------------------------------------------------------- --

-- Quantos tipos únicos de cliente existem?
SELECT DISTINCT tipo_cliente FROM vendas;

-- Quantos métodos de pagamento diferentes existem?
SELECT DISTINCT metodo_p FROM vendas;

-- Tipo de cliente mais comum?
SELECT tipo_cliente, COUNT(*) AS total
FROM vendas
GROUP BY tipo_cliente
ORDER BY total DESC;

-- Qual tipo de cliente compra mais?
SELECT tipo_cliente, COUNT(*) 
FROM vendas
GROUP BY tipo_cliente;

-- Qual gênero é mais frequente?
SELECT genero, COUNT(*) AS total
FROM vendas
GROUP BY genero
ORDER BY total DESC;

-- Distribuição de gênero por filial (exemplo: filial C)?
SELECT genero, COUNT(*) AS total
FROM vendas
WHERE filial = "C"
GROUP BY genero
ORDER BY total DESC;

-- ------------------------------------------------Vendas---------------------------------------------------------------- --

--  Número de vendas por período do dia (em um dia da semana específico)?
SELECT
	periodo_dia,
	COUNT(*) AS total_vendas
FROM vendas
WHERE dia_semana = "Domingo"
GROUP BY periodo_dia
ORDER BY total_vendas DESC;
-- Objetivo: Ver qual período (manhã, tarde ou noite) tem mais vendas em determinado dia da semana 
-- (Domingo, no exemplo). Pode repetir para outros dias.

-- Tipo de cliente que gera mais receita?
SELECT
	tipo_cliente,
	SUM(total) AS receita_total
FROM vendas
GROUP BY tipo_cliente
ORDER BY receita_total DESC;
-- Objetivo: Avaliar qual tipo de cliente (por exemplo, “Membro” ou “Normal”) gera maior faturamento.

-- Cidade com maior média de imposto (5%)?
SELECT
	cidade,
    ROUND(AVG(imposto_5), 2) AS media_imposto
FROM vendas
GROUP BY cidade
ORDER BY media_imposto DESC;
-- Objetivo: Ver onde os clientes estão pagando mais imposto em média (pode indicar maior volume de compras).

-- Tipo de cliente que mais paga imposto?
SELECT
	tipo_cliente,
	AVG(imposto_5) AS media_imposto
FROM vendas
GROUP BY tipo_cliente
ORDER BY media_imposto DESC;
-- Objetivo: Ver se membros ou clientes comuns estão comprando mais (pelo imposto médio pago).








