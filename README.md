Малыгин Артём Валерьевич
ЭФБО-09-23

Цели:

Подключить Flutter-приложение к локальной базе данных SQLite (пакет sqflite).
Создать таблицы и реализовать базовый CRUD: добавление, чтение, обновление, удаление.
Настроить класс-помощник для работы с БД и отделить слой данных от UI.
Отработать миграции схемы и диагностику частых ошибок.

Ход работы

Работа с базой данных

В файле data/db_helper.dart реализован класс DBHelper, отвечающий за взаимодействие с локальной базой данных.

Добавление

<img width="873" height="55" alt="Снимок экрана 2025-12-21 214553" src="https://github.com/user-attachments/assets/fbbfd038-0f13-4deb-b910-64434f380757" />
<img width="1199" height="49" alt="Снимок экрана 2025-12-21 214613" src="https://github.com/user-attachments/assets/a1c1ad11-252b-4db0-b214-d67a429d30a9" />
<img width="714" height="1336" alt="Снимок экрана 2025-12-21 214618" src="https://github.com/user-attachments/assets/459bb6e8-dc75-431f-bac4-4c3854382cbd" />
<img width="1017" height="57" alt="Снимок экрана 2025-12-21 214626" src="https://github.com/user-attachments/assets/310d819f-7376-4c2a-8212-cfcb002c8692" />
<img width="704" height="1282" alt="Снимок экрана 2025-12-21 214632" src="https://github.com/user-attachments/assets/10341399-b77f-47e7-9d49-2d33222500d9" />


редактирование




удаление


