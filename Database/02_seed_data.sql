-- =====================================================================
-- SEED: Massa de Dados Oficial (Baseada no Quadro de Medalhas)
-- =====================================================================

-- Campeonato
INSERT INTO campeonato (nome_campeonato, ano_vigente) VALUES ('29º Troféu Alexandre Pussieldi 2025', 2025);

-- Clubes
INSERT INTO clube (sigla, nome_clube, estado) VALUES 
('PORTO-PE', 'PORTUGUÊS/PE', 'PE'),
('VILA-PB', 'VILA PARAHYBA', 'PB'),
('AABB-PE', 'AABB-RECIFE', 'PE'),
('SESI-RN', 'SESI/RN', 'RN'),
('BNB-CE', 'BNB CLUBE', 'CE');

-- Categoria oficial de base
INSERT INTO categoria (nome_categoria, idade_minima, idade_maxima) VALUES 
('Mirim', 9, 11);

-- Atletas por Clube (Conforme imagens oficiais)
INSERT INTO atleta (id_clube, id_categoria, nome_completo, data_nascimento, genero) VALUES 
(1, 1, 'JOAO HEITOR LIMA DE SANTANA', '2014-01-01', 'M'),
(1, 1, 'LUCAS RAPHAEL MENDES DA SILVA', '2014-01-01', 'M'),
(1, 1, 'MARIA CLARA SANTANA DA SILVA', '2014-01-01', 'F'),
(1, 1, 'VICTOR LUCAS DOS SANTOS SILVA', '2014-01-01', 'M'),
(1, 1, 'HELOISA SOBRAL VICTORINO DOS SANTOS', '2014-01-01', 'F'),
(1, 1, 'LUIS HENRIQUE VASCONCELOS COTIAS', '2014-01-01', 'M'),
(1, 1, 'LETICIA PAULA PASSOS DE OLIVEIRA', '2014-01-01', 'F'),

(2, 1, 'ISABELLA YOGUI EGYPTO', '2014-01-01', 'F'),
(2, 1, 'NYCOLAS KENNEDY DA SILVA MENDES', '2014-01-01', 'M'),
(2, 1, 'HEITOR CRISTOVAO NEGRAO', '2014-01-01', 'M'),
(2, 1, 'LARA BEATRIZ DA COSTA RODRIGUES', '2014-01-01', 'F'),

(3, 1, 'LUCAS LIRA MARQUES', '2014-01-01', 'M'),
(3, 1, 'ANA LUISA MARQUES LIMA', '2014-01-01', 'F'),
(3, 1, 'NICOLE PEIXOTO CARVALHO STUDART ROCHA', '2014-01-01', 'F'),
(3, 1, 'DAVI CORREIA SALES', '2014-01-01', 'M'),
(3, 1, 'BERNARDO DO O RABELO REGO', '2014-01-01', 'M'),

(4, 1, 'GUSTAVO ALVES SILVA', '2014-01-01', 'M'),
(4, 1, 'MARIA JULIA MOREIRA NELSON', '2014-01-01', 'F'),
(4, 1, 'JOAO BENICIO LUCENA DA ROCHA MELO', '2014-01-01', 'M'),

(5, 1, 'HELENA SÉRIO DIÓGENES DE PAULA', '2014-01-01', 'F'),
(5, 1, 'MARIA SOPHIA DE FIGUEIREDO ALVES AGUIAR', '2014-01-01', 'F');

-- Provas e Baterias
INSERT INTO prova (id_campeonato, numero_prova, estilo, distancia, genero_prova) VALUES (1, 1, 'Geral do Evento', 50, 'Misto');
INSERT INTO etapa_bateria (id_prova, fase, numero_bateria) VALUES (1, 'Final', 1);

-- Massa de Resultados para fechar os totais oficiais de medalhas
-- PORTUGUÊS/PE (6 Ouros, 9 Pratas, 6 Bronzes)
INSERT INTO inscricao (id_atleta, id_prova) SELECT 1, 1 FROM generate_series(1, 21);
INSERT INTO resultado (id_inscricao, id_etapa_bateria, medalha, status_participacao, pontos_obtidos)
SELECT id_inscricao, 1, CASE WHEN i <= 6 THEN 'Ouro' WHEN i <= 15 THEN 'Prata' ELSE 'Bronze' END, 'OK', 25.00
FROM (SELECT id_inscricao, row_number() over() as i FROM inscricao WHERE id_atleta = 1) t;

-- VILA PARAHYBA (6 Ouros, 7 Pratas, 5 Bronzes)
INSERT INTO inscricao (id_atleta, id_prova) SELECT 8, 1 FROM generate_series(1, 18);
INSERT INTO resultado (id_inscricao, id_etapa_bateria, medalha, status_participacao, pontos_obtidos)
SELECT id_inscricao, 1, CASE WHEN i <= 6 THEN 'Ouro' WHEN i <= 13 THEN 'Prata' ELSE 'Bronze' END, 'OK', 25.00
FROM (SELECT id_inscricao, row_number() over() as i FROM inscricao WHERE id_atleta = 8) t;

-- AABB-RECIFE (6 Ouros, 3 Pratas, 7 Bronzes)
INSERT INTO inscricao (id_atleta, id_prova) SELECT 12, 1 FROM generate_series(1, 16);
INSERT INTO resultado (id_inscricao, id_etapa_bateria, medalha, status_participacao, pontos_obtidos)
SELECT id_inscricao, 1, CASE WHEN i <= 6 THEN 'Ouro' WHEN i <= 9 THEN 'Prata' ELSE 'Bronze' END, 'OK', 25.00
FROM (SELECT id_inscricao, row_number() over() as i FROM inscricao WHERE id_atleta = 12) t;

-- SESI/RN (6 Ouros, 2 Pratas, 2 Bronzes)
INSERT INTO inscricao (id_atleta, id_prova) SELECT 17, 1 FROM generate_series(1, 10);
INSERT INTO resultado (id_inscricao, id_etapa_bateria, medalha, status_participacao, pontos_obtidos)
SELECT id_inscricao, 1, CASE WHEN i <= 6 THEN 'Ouro' WHEN i <= 8 THEN 'Prata' ELSE 'Bronze' END, 'OK', 25.00
FROM (SELECT id_inscricao, row_number() over() as i FROM inscricao WHERE id_atleta = 17) t;

-- BNB CLUBE (6 Ouros, 0 Pratas, 1 Bronze)
INSERT INTO inscricao (id_atleta, id_prova) SELECT 20, 1 FROM generate_series(1, 7);
INSERT INTO resultado (id_inscricao, id_etapa_bateria, medalha, status_participacao, pontos_obtidos)
SELECT id_inscricao, 1, CASE WHEN i <= 6 THEN 'Ouro' ELSE 'Bronze' END, 'OK', 25.00
FROM (SELECT id_inscricao, row_number() over() as i FROM inscricao WHERE id_atleta = 20) t;