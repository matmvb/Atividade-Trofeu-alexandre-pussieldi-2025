# 🏆 29º Troféu Alexandre Pussieldi 2025 - Sistema de Apuração (Fase Aquática)

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![pgAdmin](https://img.shields.io/badge/pgAdmin%204-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Mermaid](https://img.shields.io/badge/Mermaid-FF6700?style=for-the-badge&logo=diagramsdotnet&logoColor=white)

Projeto de engenharia de dados e modelagem relacional desenvolvido para a gestão, apuração de resultados e análise estatística do **29º Troféu Alexandre Pussieldi 2025**, em conformidade com as diretrizes e regulamentos oficiais da **FASE Aquática**.

---

## 👥 Integrantes do Grupo

* **MATHEUS DE VASCONCELLOS BARBOSA**
* **NICOLAS MOURA BATISTA DE LACERDA**
* **NICOLAS DE LAIA FERREIRA FONSECA**
* **LUCAS FELIPE DE FREITAS SOARES**
* **JOÃO PEDRO MENDES DE QUEIROZ**

---

## 📌 Visão Geral do Projeto

O sistema resolve os desafios de gestão de campeonatos de natação de alta complexidade, abordando:
- **Modelagem Relacional Normalizada (3FN):** Suporte a múltiplos campeonatos, categorias etárias regulamentares, baterias/fases de prova e controle de formações de revezamento.
- **Tratamento de Exceções de Prova:** Registros de ocorrências oficiais como desqualificações (*DSQ*), não comparecimento (*DNS*) e não conclusão (*DNF*).
- **Procedures e Funções Estatísticas (PL/pgSQL):** Geração automática do quadro de medalhas oficial por clube, desempenho pontuado por equipe e consolidado individual por atleta.
- **Engenharia de Prompt Reversa:** Documentação e correção de "alucinações" de IA referente às faixas etárias oficiais das categorias de base.

---

## 📐 Modelagem de Dados (Diagrama ER)

O diagrama abaixo ilustra a arquitetura do banco de dados desenvolvida em **Mermaid** na notação *Crow's Foot*:

```mermaid
erDiagram
    CAMPEONATO {
        int id_campeonato PK
        string nome_campeonato
        int ano_vigente
    }

    CLUBE {
        int id_clube PK
        string sigla UK
        string nome_clube
        string estado
    }

    CATEGORIA {
        int id_categoria PK
        string nome_categoria
        int idade_minima
        int idade_maxima
    }

    ATLETA {
        int id_atleta PK
        int id_clube FK
        int id_categoria FK
        string nome_completo
        date data_nascimento
        string genero
    }

    PROVA {
        int id_prova PK
        int id_campeonato FK
        int numero_prova
        string estilo
        int distancia
        string genero_prova
    }

    ETAPA_BATERIA {
        int id_etapa_bateria PK
        int id_prova FK
        string fase
        int numero_bateria
    }

    INSCRICAO {
        int id_inscricao PK
        int id_atleta FK
        int id_prova FK
        time tempo_inscricao
    }

    RESULTADO {
        int id_resultado PK
        int id_inscricao FK
        int id_etapa_bateria FK
        time tempo_final
        int colocacao
        decimal pontos_obtidos
        string medalha
        string status_participacao
    }

    EQUIPE_REVEZAMENTO {
        int id_equipe_revezamento PK
        int id_clube FK
        int id_prova FK
        string identificador_equipe
    }

    ATLETA_REVEZAMENTO {
        int id_atleta_revezamento PK
        int id_equipe_revezamento FK
        int id_atleta FK
        int ordem_nadador
    }

    CAMPEONATO ||--o{ PROVA : "contém"
    CLUBE ||--o{ ATLETA : "possui"
    CATEGORIA ||--o{ ATLETA : "classifica"
    ATLETA ||--o{ INSCRICAO : "realiza"
    PROVA ||--o{ INSCRICAO : "possui"
    PROVA ||--o{ ETAPA_BATERIA : "divide-se_em"
    INSCRICAO ||--o{ RESULTADO : "gera"
    ETAPA_BATERIA ||--o{ RESULTADO : "registra_em"
    CLUBE ||--o{ EQUIPE_REVEZAMENTO : "monta"
    PROVA ||--o{ EQUIPE_REVEZAMENTO : "envolve"
    EQUIPE_REVEZAMENTO ||--o{ ATLETA_REVEZAMENTO : "compõe-se_de"
    ATLETA ||--o{ ATLETA_REVEZAMENTO : "participa_como"