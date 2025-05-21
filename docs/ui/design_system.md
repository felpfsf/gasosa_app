# Design System — Gasosa App

Este documento define os padrões visuais e componentes reutilizáveis do Gasosa App, garantindo consistência, escalabilidade e facilidade de manutenção.

## 1. Tipografia

### Fontes

- **Principal:** Inter
- **Secundária (opcional):** Poppins

### Estilos base (definidos em `AppTypography`)

| Estilo             | Peso   | Tamanho | Uso                          |
|--------------------|--------|---------|------------------------------|
| `textSmRegular`    | 400    | 12px    | Descrições, ajuda            |
| `textMdRegular`    | 400    | 14px    | Textos padrão                |
| `textMdBold`       | 700    | 14px    | Ênfase em texto médio        |
| `titleMd`          | 600    | 16px    | Títulos de cards, seções     |
| `titleLg`          | 700    | 20px    | Headers de tela              |

---

## 2. Cores

Definidas em `AppColors`.

| Cor         | Hex         | Uso                                     |
|-------------|-------------|-----------------------------------------|
| `primary`   | #7C3AED   | Ações principais, ícones destacados     |
| `background`| #121212   | Fundo principal (tema escuro)           |
| `surface`   | #1E1E1E   | Cards, campos, appbars                  |
| `text`      | #FFFFFF   | Textos em geral                         |
| `error`     | #EF4444   | Erros, botões de exclusão               |

---

## 3. Espaçamentos e Bordas

Definidos em `AppSpacing`.

| Espaçamento        | Valor | Uso                                         |
|--------------------|-------|---------------------------------------------|
| `gap4`, `gap8`,... | 4px+  | Margens e espaçamentos entre elementos      |
| `radiusMd`         | 12px  | Borda padrão de cards e botões              |

---

## 4. Componentes Reutilizáveis

| Componente             | Descrição                                          |
|------------------------|----------------------------------------------------|
| `GasosaFormField`      | Campo de texto com label, hint e validações        |
| `GasosaDropdownField`  | Dropdown customizado com tipografia e espaçamento   |
| `GasosaDatePickerField`| Date picker integrado com input read-only          |
| `GasosaButton`         | Botão estilizado, com suporte a variantes          |
| `GasosaCard`           | Container com borda, padding e fundo               |
| `GasosaCheckbox`       | Checkbox estilizado com tema                       |
| `GasosaPhotoPicker`    | Widget para seleção de imagem com preview          |
| `GasosaAppbar`         | AppBar padronizado com título e ícones             |
| `GasosaConfirmDialog`   | Diálogo reutilizável para confirmação               |
| `GasosaAvatar`         | Avatar com borda em gradiente                      |

---

## 5. Feedback e UX

- Uso de `Messages.showSuccess()` e `Messages.showError()` para feedback visual e auditivo.
- Empty states personalizados com `GasosaEmptyStateWidget`.
- Loaders consistentes com `CustomLoader`.

---

## 6. Acessibilidade e Responsividade

- Textos com contraste adequado.
- Tamanhos de toque respeitam o mínimo de 48x48.
- Scrolls sempre encapsulados com `SingleChildScrollView` e `SafeArea`.

---

## 7. Futuras melhorias

- Suporte a tema claro
- Animações padronizadas com `Hero`, `FadeTransition`, etc.
- Componentização de ícones e tokens

---

**Última atualização:** 20/05/2025  
**Responsável:** [Felipe Ferreira](https://linkedin.com.br/in/felipefsf)
