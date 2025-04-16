# ⛽ Gasosa

Gasosa é um app mobile para controle de abastecimentos de veículos, feito com Flutter e Drift.  
O objetivo é eliminar o registro manual em papel, facilitando o acompanhamento de consumo, quilometragem e gastos com combustível.

---

## 🚀 Funcionalidades MVP

- Registro de múltiplos veículos
- Adição de abastecimentos com:
  - Data, KM total, tipo de combustível, litros, valor
  - Foto da nota fiscal
- Cálculo automático de consumo aproximado
- Armazenamento local (offline) com sincronização futura para nuvem
- Interface moderna com tema escuro e UX otimizada

---

## 📱 Tecnologias

- Flutter + Dart
- Drift (persistência local)
- BLoC/Cubit para gerenciamento de estado
- GetIt + Injectable (injeção de dependência)
- TDD com `mocktail` e `bloc_test`

---

## 📦 Estrutura

Organizado com base em Clean Architecture:

```bash
lib/
├── core/
├── data/ 
├── domain/
├── presentation/
├── theme/
└── main.dart
```

---

## 👨‍💻 Status

🚧 Em desenvolvimento — MVP funcional em construção  
🎯 Futuro: login com Firebase, sincronização e dashboard web

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.
