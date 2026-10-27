-- =====================================================================
-- DDL: Arquitetura de Dados em 3FN para Campeonato de Natação
-- =====================================================================

DROP TABLE IF EXISTS resultado CASCADE;
DROP TABLE IF EXISTS atleta_revezamento CASCADE;
DROP TABLE IF EXISTS equipe_revezamento CASCADE;
DROP TABLE IF EXISTS inscricao CASCADE;
DROP TABLE IF EXISTS etapa_bateria CASCADE;
DROP TABLE IF EXISTS prova CASCADE;
DROP TABLE IF EXISTS atleta CASCADE;
DROP TABLE IF EXISTS categoria CASCADE;
DROP TABLE IF EXISTS clube CASCADE;
DROP TABLE IF EXISTS campeonato CASCADE;

CREATE TABLE campeonato (
    id_campeonato SERIAL PRIMARY KEY,
    nome_campeonato VARCHAR(150) NOT NULL,
    ano_vigente INT NOT NULL
);

CREATE TABLE clube (
    id_clube SERIAL PRIMARY KEY,
    sigla VARCHAR(20) UNIQUE NOT NULL,
    nome_clube VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL
);

CREATE TABLE categoria (
    id_categoria SERIAL PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL,
    idade_minima INT NOT NULL,
    idade_maxima INT NOT NULL
);

CREATE TABLE atleta (
    id_atleta SERIAL PRIMARY KEY,
    id_clube INT REFERENCES clube(id_clube) ON DELETE CASCADE,
    id_categoria INT REFERENCES categoria(id_categoria),
    nome_completo VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    genero CHAR(1) CHECK (genero IN ('M', 'F'))
);

CREATE TABLE prova (
    id_prova SERIAL PRIMARY KEY,
    id_campeonato INT REFERENCES campeonato(id_campeonato) ON DELETE CASCADE,
    numero_prova INT NOT NULL,
    estilo VARCHAR(50) NOT NULL,
    distancia INT NOT NULL,
    genero_prova VARCHAR(20) NOT NULL
);

CREATE TABLE etapa_bateria (
    id_etapa_bateria SERIAL PRIMARY KEY,
    id_prova INT REFERENCES prova(id_prova) ON DELETE CASCADE,
    fase VARCHAR(50) NOT NULL,
    numero_bateria INT NOT NULL
);

CREATE TABLE inscricao (
    id_inscricao SERIAL PRIMARY KEY,
    id_atleta INT REFERENCES atleta(id_atleta) ON DELETE CASCADE,
    id_prova INT REFERENCES prova(id_prova) ON DELETE CASCADE,
    tempo_inscricao INTERVAL
);

CREATE TABLE resultado (
    id_resultado SERIAL PRIMARY KEY,
    id_inscricao INT REFERENCES inscricao(id_inscricao) ON DELETE CASCADE,
    id_etapa_bateria INT REFERENCES etapa_bateria(id_etapa_bateria),
    tempo_final INTERVAL,
    colocacao INT,
    pontos_obtidos NUMERIC(5,2),
    medalha VARCHAR(20) CHECK (medalha IN ('Ouro', 'Prata', 'Bronze', 'Nenhuma')),
    status_participacao VARCHAR(10) CHECK (status_participacao IN ('OK', 'DSQ', 'DNS', 'DNF'))
);