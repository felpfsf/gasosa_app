# ADR 001: Arquitetura Base do Gasosa App

**Status**: Aprovado
**Data**: 06/04/2025

## Contexto

O Gasosa App é um aplicativo voltado para o registro e abastecimento de veículos pessoais. Durante a fase de definição da versão 1.0 (MVP) era necessário adotar uma arquitetura que:

* Facilitasse a manutenção e escalabilidade do projeto
* Separasse as responsabilidades em camadas
* Permitir testes unitários de forma clara e consistente
* Suportasse a reativade com banco de dados local
* Fosse flexível para adicionar funcionalidades futuras como sincronização com nuvem

## Decisão

A arquitetura escolhida foi a de Clean Architecture, que separa as responsabilidades em camadas, facilitando a manutenção e escalabilidade do projeto.

* Camadas separadas: `domain`, `data`, `presentation`, `core`, `theme`
* Gerenciamento de estado com `Cubit` e `Freezed`
* Persistência local com Drift, utilizando `watch` + `customSelect` para reatividade
* Injeção de dependência com `Injectable` + `GetIt`
* Formulários desacoplados e validados com helpers reutilizáveis
* DTOs e mappers para isolar entidades de domínio da persistência

## Justificativa

* Clean Architecture permite que regras de negócio sejam independentes de UI e infraestrutura
* Drift oferece suporte ótima integração com SQLite e suporte a reatividade sem boilerplate excessivo
* A abordagem com Cubits mantém o controle de estado separado do código de UI, tornando o código mais legível e testável
* A estrutura em modulos torna o projeto mais escalável e facilita a manutenção

## Consequências

* Maior tempo de setup, mas com alto ganho em organização e testabilidade
* Facilita inclusão de funcionalidades futuras como:
  * Sincronização com nuvem
  * Exportação de dados
  * Estatísticas e relatórios
  * Dashboard
* Possibildiade de reuso dos casos de uso para uma futura API
