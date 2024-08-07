# Массивно параллельные кластера PostgreSQL 

# Установку каждой СУБД планирую выполнять в Docker

## Установка ванильного Postgres

### 1. Проверяю статус установленного ранее Docker

![изображение](https://github.com/user-attachments/assets/6b8faeb9-8b7f-418e-9f3a-c23b7ff8e2bf)

### 2. Поднимаю контейнер

**2.1. Запускаю контейнер с именем *postgres***
**2.2. Проверяю статус контейнера**
**2.3. Выполняю тестовое подключение**

![изображение](https://github.com/user-attachments/assets/c79279fd-10e7-4a9b-844b-46bc91200cc6)

## Установка Greenplum

### 3. Поднимаю контейнер по [документации](https://vldb.gitbook.io/vldb-greenplum-demo/docker-installation/installing-container)

**3.1. Запускаю контейнер с именем *greenplum***

**3.2. Проверяю статус контейнера**

**3.3. Выполняю тестовое подключение. Неудачно...**

**3.4. Иду внутрь контейнера**

**3.5. Пробую запустить кластер Greenplum. Ловлю ошибку отсутствия команды *sudo***

**3.6. Переключаюсь под пользователя *gpadmin***

**3.7. Пробую повторно запустить кластер Greenplum**

**3.8. Проверяю статус кластера**

**3.9. Выхожу из контейнера**

**3.10. Пробую подключиться под *gpadmin*, но такой таблицы не существует**

**3.11. Пробую подключиться к БД *postgres***

**3.12. Проверяю существующие БД**

![изображение](https://github.com/user-attachments/assets/310d9972-26f1-4dd9-bc89-45223ca3d32e)

![изображение](https://github.com/user-attachments/assets/19c6bb11-fb76-488c-9ec0-16b4048d530b)

## Установка Yugabyte

### 4. Поднимаю контейнер по [документации](https://docs.yugabyte.com/preview/quick-start/docker/)

**4.1. Запускаю контейнер с именем *yugabyte***

**4.2. Проверяю статус контейнера**

**4.3. Подключаюсь к контейнеру и проверяю статус СУБД**

**4.4. Далее мне понадобилось 3 команды чтобы понять, что нужен другой порт**

**4.5. Выполняю тестовое подключение. Ура!**

![изображение](https://github.com/user-attachments/assets/c80dbd06-75c8-49de-8142-a8274b32f0f0)

**Ого, даже UI есть...**	

![изображение](https://github.com/user-attachments/assets/a86d4ea7-e902-4cb5-96e9-cca2141fa02e)

## Разворачиваю БД на каждой СУБД

### 5. Еще раз проверяю статусы контейнеров

GOOD!
![изображение](https://github.com/user-attachments/assets/5726a033-3a8c-4023-9d4a-7cee3c7598e4)

### 6. Создаю в каждой СУБД БД, куда буду производить восстановление из заготовленного ранее дампа

**6.1. Postgres**

**6.2. Greenplum**

**6.3. Yugabyte**

![изображение](https://github.com/user-attachments/assets/93d4f27f-870c-4c71-956e-4bd4667d28db)

### 7. Выполняю восстановление из дампа

**7.1. Postgres**

Восстановление заняло около 10-15 минут.

![изображение](https://github.com/user-attachments/assets/38ca1732-9137-48d4-a1ba-fc6f254b3340)
![изображение](https://github.com/user-attachments/assets/e01ff9e0-75da-41db-851a-66025bd60883)

**7.2. Greenplum**

Восстановление заняло около 20-30 минут.

Уже на этом этапе есть ряд отличий, вероятно связанных с версией PG в том числе. Но в итоге удалось поднять БД.

![изображение](https://github.com/user-attachments/assets/09f5cb3e-8eea-4dfa-88db-0e9ba941b2fe)
![изображение](https://github.com/user-attachments/assets/78303a51-8598-493f-83ed-2f84f67688e2)

Итоговая БД весит больше, чем в Postgres, вероятно, из-за доп. столбцов

![изображение](https://github.com/user-attachments/assets/ae81a5ad-d681-4381-8fd1-fb3ae41ef177)

Также обратил внимание, что при восстановлении очень сильно выросла нагрузка на диск, I/OWait вырос до 80, что мне очень не понравилось. Но посмотрим что будет со скоростью выполнения запросов

**7.3. Yugabyte**

Восстановление заняло больше двух часов...

![изображение](https://github.com/user-attachments/assets/6124f80e-d71c-4267-9b76-c72192dd5a30)

На этот раз I/OWait вырос до 30, что уже лучше по сравнению с Greenplum. Но это очень сурово из-за времени восстановления...

**7.3.1. Иду смотреть размер БД, но его нет...**

**7.3.2. Еще разок... тоже нет**

**7.3.3. Ок, ну а сейчас то получится? Тоже нет...**

**7.3.4. Как скажете, схожу в UI**

![изображение](https://github.com/user-attachments/assets/5286de77-985e-4cd7-bdfb-cf4dc39955d4)
![изображение](https://github.com/user-attachments/assets/36382297-06af-4cf6-bc52-5dd3f5e79248)

### 8. Провожу тесты на каждой СУБД

Ранее я уже поставил пакет *postgresql-contrib*, предоставляющий утилиту *pgbench*. С ее помощью, в общем-то и буду выполнять тесты.

**8.1. Postgres**

![изображение](https://github.com/user-attachments/assets/5e960800-0d3c-49df-ad08-452e72b66951)

**8.2. Greenplum**

![изображение](https://github.com/user-attachments/assets/01006641-3504-4010-9e2c-1d86e90c1949)

**8.3. Yugabyte**

![изображение](https://github.com/user-attachments/assets/38c25bfc-c98b-481f-ba3b-b4b71a994822)

### 9. Итоги тестов

**Postgres**

![изображение](https://github.com/user-attachments/assets/dd12816a-7b58-4ec8-a933-1b386c7014d6)

**Greenplum**

![изображение](https://github.com/user-attachments/assets/44f0b375-31f0-4f89-bc56-f9483a39d227)

**Yugabyte**

![изображение](https://github.com/user-attachments/assets/68eeae3b-dec2-4a17-8fe6-a35c86cd96dc)
* * *
**Итог:** по скорости оказался на первом месте *Postgres*, на втором *Yugabyte* и на третьем *Greenplum*. По скорости восстановления *Yugabyte* очень неприятно удивил. Но не смотря на скорость, в массивно параллельных кластерах важна не столько скорость, сколько надежность.
