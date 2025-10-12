Практическое занятие №5. Работа со списками и передача данных между модулями
Студент: ЭФБО-09-23 Малыгин Артём Валерьевич

Цели работы
Освоить отображение коллекций данных с использованием ListView.builder
Изучить базовую навигацию между экранами (Navigator.push / Navigator.pop)
Научиться передавать данные через конструктор
Реализовать функционал добавления, редактирования и удаления элементов списка

Ход работы
Шаг 1. Модель данных
В файле lib/models/note.dart создан класс Note для хранения информации о заметках:

```dart
class Note {
  final String id;
  String title;
  String body;

  Note({required this.id, required this.title, required this.body});

  Note copyWith({String? title, String? body}) => Note(
    id: id,
    title: title ?? this.title,
    body: body ?? this.body,
  );
}
```
Шаг 2. Главный экран со списком заметок
В main.dart реализован экран NotesPage с отображением списка заметок через ListView.builder. Каждый элемент представлен в виде карточки с закругленными углами, отступами и иконкой удаления.

Основные элементы:

ListView.builder для эффективного отображения списка

Dismissible для реализации свайп-удаления

Card и ListTile для оформления элементов

Шаг 3. Добавление и редактирование заметок
Создан экран EditNotePage (edit_note_page.dart) с формой для создания и редактирования заметок:

Для новых заметок генерируется уникальный ID

Для существующих заметок используется метод copyWith для обновления

Валидация формы перед сохранением

Шаг 4. Удаление заметок
Реализовано два способа удаления:

Кнопка удаления в виде иконки корзины

Свайп-жест с анимацией удаления

Шаг 5. Поиск по заметкам
Добавлен функционал поиска через SearchDelegate с фильтрацией по заголовкам заметок. Поиск вызывается через иконку в AppBar.

Результат
Разработано полнофункциональное приложение для управления заметками с возможностями:

Просмотра списка заметок

<img width="713" height="1274" alt="image" src="https://github.com/user-attachments/assets/1d955155-7dba-4756-8832-9f0ede89164c" />

Добавления новых заметок

<img width="707" height="1273" alt="image" src="https://github.com/user-attachments/assets/0ebf0dea-1b40-4627-8018-686bf1b05c65" />

Редактирования существующих записей

<img width="707" height="1273" alt="image" src="https://github.com/user-attachments/assets/bb751d17-03ea-48c5-94b3-bcd5e33643b0" />

Удаления элементов

<img width="704" height="1140" alt="image" src="https://github.com/user-attachments/assets/45587444-fe72-42a9-a1de-403d8b97550e" />

Поиска по содержимому

<img width="707" height="1267" alt="image" src="https://github.com/user-attachments/assets/2b4e1449-6d7c-41cf-bca3-1d9f496e7f61" />
