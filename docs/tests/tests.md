# Testes Automatizados — Gasosa App

Este documento descreve a estratégia de testes adotada no projeto Gasosa App, seguindo os princípios da Clean Architecture.

---

## 1. Estratégia Geral

- **Unitários**: foco em lógica pura (UseCases, Validators, Formatters)
- **De integração**: DAOs (com Drift), Cubits (com estados)
- **Manuais**: testes de interface em dispositivos físicos e emuladores

---

## 2. Cobertura de Testes

### ✅ UseCases

| Caso de uso                   | Status     |
|-------------------------------|------------|
| `AddVehicleUsecase`           | Testado    |
| `UpdateVehicleUsecase`        | Testado    |
| `DeleteVehicleUsecase`        | Testado    |
| `FindVehicleByIdUsecase`      | Testado    |
| `WatchAllVehiclesUsecase`     | Testado    |
| `AddRefuelUsecase`            | Testado    |
| `UpdateRefuelUsecase`         | Testado    |
| `DeleteRefuelUsecase`         | Testado    |
| `WatchRefuelByVehicleId`      | Testado    |

---

### ✅ Cubits

| Cubit          | Estados cobertos       |
|----------------|------------------------|
| `VehicleCubit` | Sucesso, erro, loading |
| `RefuelCubit`  | Sucesso, erro, loading |
| `AuthCubit`    | Login, logout, erros   |

---

### ✅ DAOs

| DAO            | Métodos testados                          |
|----------------|-------------------------------------------|
| `VehicleDao`   | insert, update, delete, findById, watchAll |
| `RefuelDao`    | insert, update, delete, watchByVehicleId  |
| `UserDao`      | insertOrReplace, findById, update          |

---

## 3. Bibliotecas e Frameworks

- `flutter_test`
- `mocktail`
- `dartz`
- `drift_test` (banco em memória)
- `bloc_test` (opcional para expansão futura)

---

## 4. Boas Práticas

- Testes organizados em `/test` com subpastas por camada
- `mocks/` centraliza classes fakes e helpers
- Fallbacks registrados no `setUpAll()`
- `Right` e `Left` validados com `expect(result, isA<Right>());`
- Testes de DAO usam banco em memória com `testLazyDatabase`

---

## 5. Futuras melhorias

- Testes de UI com `golden tests`
- Testes de integração com `integration_test`
- Cobertura de eventos relacionados a sincronização

---

**Última atualização:** 20/05/2025  
**Responsável:** [Felipe Ferreira](https://linkedin.com.br/in/felipefsf)
