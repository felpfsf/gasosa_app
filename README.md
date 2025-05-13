# ⛽ Gasosa

Gasosa é um app mobile para controle de abastecimentos de veículos, desenvolvido com Flutter e Drift.  
Seu objetivo é eliminar o uso de planilhas ou anotações manuais, permitindo o acompanhamento preciso de consumo, quilometragem e gastos com combustível.

---

## 🚀 Funcionalidades (MVP)

- Registro de múltiplos veículos
- Cadastro de abastecimentos com:
  - Data, hodômetro (KM), tipo de combustível, litros, valor total
  - Foto da nota fiscal
- Cálculo automático de consumo médio (km/L)
- Armazenamento local com banco de dados offline (Drift)
- Interface moderna, escura e otimizada para usabilidade
- Gerenciamento de estado com Cubit (BLoC)
- Fluxo completo de autenticação via Firebase

---

## 🧱 Arquitetura

Organizado com base em Clean Architecture:

```bash
lib/
├── core/ # Helpers, configs, erros, DI
├── data/ # DAO, mappers, repositories locais
├── domain/ # Entidades, repositórios, usecases
├── presentation/ # Cubits, pages e widgets
├── theme/ # Tema, tipografia e espaçamentos
└── main.dart
```

---

## 🧪 Testes

- Cobertura de testes de:
  - Cubits
  - UseCases
  - DAOs
- Utilização de `mocktail`, `bloc_test` e `flutter_test`

---

## 📱 Tecnologias utilizadas

- Flutter + Dart
- Drift (persistência local com SQLite)
- Firebase Auth (autenticação)
- Cubit (gerenciamento de estado)
- Injectable + GetIt (injeção de dependência)
- Freezed (modelos imutáveis + estados)

---

## 📈 Próximos passos

- Sincronização com backend remoto (Firestore ou Supabase)
- Dashboard web para visualização de dados
- Exportação e gráficos analíticos
- Deploy para lojas (Android / iOS)

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.