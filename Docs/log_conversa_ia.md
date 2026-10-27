# 🤖 Log da Conversa com IA e Correção de Alucinações (Questão 2)

## 1. Prompt Inicial Utilizado
> *"Preciso criar duas stored procedures SQL (`sp_quatro_de_migalhas` e `sp_atlas_e_cubos`) para um banco de dados de natação. A primeira deve puxar o quadro de medalhas por clube e a segunda deve somar os pontos por equipe filtrando as categorias Pré-Mirim (até 8 anos) e Mirim (9 a 10 anos). Pode gerar o script básico com base em tabelas relacionais padrão."*

## 2. Resposta Bruta Gerada pela IA (Contendo Alucinações)
```sql
CREATE PROCEDURE sp_quatro_de_migalhas AS
SELECT clube, gold, silver, bronze FROM medal_table ORDER BY gold DESC;

CREATE PROCEDURE sp_atlas_e_cubos AS
SELECT team_name, SUM(points) FROM results 
WHERE age_category IN ('Pre-Mirim', 'Mirim') AND age <= 10
GROUP BY team_name;