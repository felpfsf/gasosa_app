# ⛽ Gasosa App

**Gasosa** é um app mobile para controle de abastecimentos de veículos, desenvolvido com Flutter e Drift.  
Seu objetivo é eliminar o uso de planilhas e anotações manuais, permitindo o acompanhamento preciso de consumo, quilometragem e gastos com combustível — tudo com uma interface moderna e arquitetura escalável.

---

## 🚀 Funcionalidades (MVP)

- 📍 Registro de múltiplos veículos
- ⛽ Cadastro e edição de abastecimentos com:
  - Data, hodômetro (KM), tipo de combustível
  - Litros abastecidos, valor total
  - Partida a frio (gasolina auxiliar)
  - Foto da nota fiscal
- 📊 Cálculo automático de consumo médio (km/L)
- 🧠 Visualização contextual e amigável dos dados
- 💾 Armazenamento local com banco offline (Drift)
- 👤 Autenticação com e-mail/senha e Google (Firebase)
- 🌙 Tema escuro padronizado com identidade visual própria
- 📡 Estrutura pronta para sincronização futura

---

## 🧱 Arquitetura

Organizado com base nos princípios de **Clean Architecture** + **DDD**:

```bash
lib/
├── core/         # Helpers, configs, validators, errors, DI
├── data/         # DAO, mappers, repositórios, implementações
├── domain/       # Entidades, interfaces, usecases
├── presentation/ # Cubits, páginas, formulários, widgets
├── theme/        # Tipografia, espaçamentos, cores
├── assets/       # Ícones, imagens, fontes
└── main.dart
```

---

## 🧪 Testes

- Cobertura de testes de:
  - Cubits
  - UseCases
  - DAOs
- Utilização de `mocktail`, `bloc_test` e `flutter_test`
- Cobertura parcial documentada no [Guia de Testes](docs/tests/tests.md)

---

## 📄 Documentação

> Toda as documentações estão disponíveis na pasta `/docs` do projeot.

- [Especificação do Projeto](docs/specs/pds.md)
- [ADR 001: Arquitetura Base do Gasosa App](docs/adr/001-base-architecture.md)
- [Design System](docs/ui/design_system.md)
- [Guia de Testes](docs/tests/tests.md)
  
---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.
