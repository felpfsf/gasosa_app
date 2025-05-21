# Especificação do Projeto de Produto(PDS) - Gasosa App

## 1 - Identificação do Produto

**Nome:** Gasosa App
**Versão:** 1.0.0 (MVP)
**Plataforma:** Flutter (Mobile Android & iOS)
**Objetivo**: Aplicativo para controle de abastecimentos de veículos pessoais e cálculo de consumo médio de combustível.

## 2 - Visão Geral

O Gasosa App é um aplicativo voltado para motoristas que desejam controlar o abastecimento de forma simples, intuitiva e com valor agregado por meio de informações derivadas, como consumo médio e histórico técnico do veículo.

A versão 1.0(MVP) foca na entrega do núcleo funcional do produto, validando usabilidade e arquiteutra para futuras versões.

## 3 - Funcionalidades do MVP

### Veículos

* Cadastro, edição e exclusão de veículos
* Exibição do último abastecimento

### Abastecimentos

* Registro com:
  * Data, tipo de combustível, litros, valor total e odômetro
  * Partida a frio(opcional): litros e valor separado
  * Comprovante fiscal (opcional): foto da nota fiscal
* Edição e exclusão de abastecimentos
* Cálculo automático de consumo médio
* Validação e máscara de entrada

### Usuário

* Autenticação com o Firebase
  * Login com email e senha
  * Login com o Google
* Perfil com exibição de nome, email e foto.

### Interface e UX

* Splash Screen animada
* Design System próprio com:
  * Campos personalizados, botões, dropdowns, cards e checkboxes
  * Tipografia, cores, espaçamentos centralizados
* Feedback visual(loaders, erros, empty states)
* Navegaçao com `GoRouter` e `Router Observer`

### Persistência

* Banco de dados local com Drift (SQLite)
* Reatividade com `Streams`
* Migração de schema suportada
* Armazenamento local de imagens

### Testes

* Testes unitários para Cubits, UseCases e DAOs
* Cobertura de casos de erro e sucesso
* Helpers de testes reutilizáveis

## 4 - Tecnologias Utilizadas

* [Flutter](https://flutter.dev/)
* [Firebase Auth](https://firebase.google.com/)
* [Drift](https://pub.dev/packages/drift)
* [GoRouter](https://pub.dev/packages/go_router)
* [Bloc/Cubit](https://pub.dev/packages/bloc)
* [Freezed](https://pub.dev/packages/freezed)
* [GetIt + Injectable](https://pub.dev/packages/get_it)
* [Flutter Multiformatter](https://pub.dev/packages/flutter_multi_formatter)

## 5 - Restrições

* Sem sincronização com nuvem
* Dashboard e relatórios previsto para v2
* Upload para PlayStore/TestFlight após realização de testes internos

## 6 - Planejamento Futuro(v2)

* Sincronização com nuvem
* Estatísticas e relatórios
* Edição de perfil (incluindo avatar)
* Exportação de dados
* Dashboard

## 7 - Estado atual

* Produto pronto para testes fechados
