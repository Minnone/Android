# 🛍️ Flutter Shopping App

Красивое и современное мобильное приложение для шопинга с продуманным UI/UX и плавными переходами между экранами.

## Скриншоты экранов

### аутентификации
<img width="250" height="300" alt="image" src="https://github.com/user-attachments/assets/677ed227-6c58-4f1a-b029-02e25c7d7aa0" />
<img width="250" height="300" alt="image" src="https://github.com/user-attachments/assets/8951640f-1e00-4a85-b310-14520e76fd3a" />
<img width="250" height="300" alt="image" src="https://github.com/user-attachments/assets/28a16ed4-e7f2-4ddd-bcfd-bf5cec3d3929" />
<img width="250" height="300" alt="image" src="https://github.com/user-attachments/assets/da0c94c1-7a85-4c02-bbf1-54323c0bb4be" />




### 🏪 Основные экраны приложения

| Shop Screen | Favourites | Cart Screen |
|-------------|------------|-------------|
<img width="250" height="300" alt="image" src="https://github.com/user-attachments/assets/0b206a4d-9e88-4ba8-9acd-7a817fc379e4" />
<img width="250" height="300" alt="image" src="https://github.com/user-attachments/assets/fd074689-5163-4a30-a648-df925cc4c7cf" />
<img width="250" height="300" alt="image" src="https://github.com/user-attachments/assets/abab9d50-8d56-4010-afff-f9d1dccb2751" />

### Аутентификация Flow:
`Splash Screen → Create Account → Login → Password → Main App`

### Основное приложение:
`Shop ↔ Favourites ↔ Cart (через Bottom Navigation)`

## Краткий отчет

### Сверстанные экраны:

1. **Splash Screen** - Экран загрузки с логотипом
2. **Create Account Screen** - Регистрация с полями email, пароль, телефон
3. **Login Screen** - Вход с email и паролем
4. **Password Screen** - Подтверждение пароля
5. **Shop Screen** - Главный экран с товарами
6. **Favourites Screen** - Избранные товары
7. **Cart Screen** - Корзина покупок

###  Использованные элементы UI:

**Навигация:**
- `Bottom Navigation Bar` с бейджами
- `AppBar` с заголовками
- `Stack` для наложения элементов

**Карточки товаров:**
- `GridView` с адаптивной сеткой
- Кастомные карточки с тенями
- Иконки избранного и корзины поверх изображений

**Формы:**
- `TextField` с кастомной стилизацией
- Кнопки с градиентами и анимациями
- Валидация полей ввода

**Состояния:**
- Empty states для пустых списков
- Loading states
- Error handling


## 🛠Технический стек

- **Flutter** - основной фреймворк
- **Dart** - язык программирования
- **Provider** - управление состоянием
- **Custom Widgets** - кастомные UI компоненты

##  Установка и запуск

```bash
# Клонирование репозитория
git clone https://github.com/your-username/madshop-ui.git

# Переход в директорию
cd madshop-ui

# Установка зависимостей
flutter pub get

# Запуск приложения
flutter run
