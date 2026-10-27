-- =====================================================================
-- FUNÇÃO 1: sp_quatro_de_migalhas (Quadro de Medalhas por Clube)
-- =====================================================================
CREATE OR REPLACE FUNCTION sp_quatro_de_migalhas(p_id_campeonato INT)
RETURNS TABLE (
    sigla_clube VARCHAR,
    nome_clube VARCHAR,
    total_ouro BIGINT,
    total_prata BIGINT,
    total_bronze BIGINT,
    total_geral_medalhas BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.sigla,
        c.nome_clube,
        SUM(CASE WHEN r.medalha = 'Ouro' THEN 1 ELSE 0 END)::BIGINT,
        SUM(CASE WHEN r.medalha = 'Prata' THEN 1 ELSE 0 END)::BIGINT,
        SUM(CASE WHEN r.medalha = 'Bronze' THEN 1 ELSE 0 END)::BIGINT,
        COUNT(r.id_resultado)::BIGINT
    FROM resultado r
    JOIN inscricao i ON r.id_inscricao = i.id_inscricao
    JOIN prova p ON i.id_prova = p.id_prova
    JOIN atleta a ON i.id_atleta = a.id_atleta
    JOIN clube c ON a.id_clube = c.id_clube
    WHERE p.id_campeonato = p_id_campeonato
      AND r.medalha IN ('Ouro', 'Prata', 'Bronze')
    GROUP BY c.sigla, c.nome_clube
    ORDER BY total_ouro DESC, total_prata DESC, total_bronze DESC;
END;
$$ LANGUAGE plpgsql;


-- =====================================================================
-- FUNÇÃO 2: sp_atlas_e_cubos (Desempenho por Equipe e Categoria)
-- =====================================================================
CREATE OR REPLACE FUNCTION sp_atlas_e_cubos(p_id_campeonato INT, p_nome_categoria VARCHAR DEFAULT NULL)
RETURNS TABLE (
    sigla_clube VARCHAR,
    nome_clube VARCHAR,
    categoria_etaria VARCHAR,
    total_atletas BIGINT,
    total_provas_realizadas BIGINT,
    pontuacao_total_clube NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.sigla,
        c.nome_clube,
        cat.nome_categoria,
        COUNT(DISTINCT a.id_atleta)::BIGINT,
        COUNT(DISTINCT r.id_resultado)::BIGINT,
        COALESCE(SUM(r.pontos_obtidos), 0)
    FROM clube c
    JOIN atleta a ON c.id_clube = a.id_clube
    JOIN categoria cat ON a.id_categoria = cat.id_categoria
    JOIN inscricao i ON a.id_atleta = i.id_atleta
    JOIN prova p ON i.id_prova = p.id_prova
    JOIN resultado r ON i.id_inscricao = r.id_inscricao
    WHERE p.id_campeonato = p_id_campeonato
      AND (cat.nome_categoria = p_nome_categoria OR p_nome_categoria IS NULL)
      AND r.status_participacao = 'OK'
    GROUP BY c.sigla, c.nome_clube, cat.nome_categoria
    ORDER BY pontuacao_total_clube DESC;
END;
$$ LANGUAGE plpgsql;


-- =====================================================================
-- FUNÇÃO 3: sp_resultados_por_atleta (Desempenho Consolidado por Atleta)
-- =====================================================================
DROP FUNCTION IF EXISTS sp_resultados_por_atleta(INTEGER);

CREATE OR REPLACE FUNCTION sp_resultados_por_atleta(p_id_campeonato INT)
RETURNS TABLE (
    nome_atleta VARCHAR,
    sigla_clube VARCHAR,
    categoria VARCHAR,
    total_ouro BIGINT,
    total_prata BIGINT,
    total_bronze BIGINT,
    total_medalhas BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        a.nome_completo,
        c.sigla,
        cat.nome_categoria,
        SUM(CASE WHEN r.medalha = 'Ouro' THEN 1 ELSE 0 END)::BIGINT,
        SUM(CASE WHEN r.medalha = 'Prata' THEN 1 ELSE 0 END)::BIGINT,
        SUM(CASE WHEN r.medalha = 'Bronze' THEN 1 ELSE 0 END)::BIGINT,
        COUNT(r.id_resultado)::BIGINT
    FROM atleta a
    JOIN clube c ON a.id_clube = c.id_clube
    JOIN categoria cat ON a.id_categoria = cat.id_categoria
    JOIN inscricao i ON a.id_atleta = i.id_atleta
    JOIN prova p ON i.id_prova = p.id_prova
    JOIN resultado r ON i.id_inscricao = r.id_inscricao
    WHERE p.id_campeonato = p_id_campeonato
      AND r.medalha IN ('Ouro', 'Prata', 'Bronze')
    GROUP BY a.nome_completo, c.sigla, cat.nome_categoria
    ORDER BY total_medalhas DESC, a.nome_completo;
END;
$$ LANGUAGE plpgsql;