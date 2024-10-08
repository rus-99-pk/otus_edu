# PostgreSQL и Яндекс Облако 2

### 1. Открываю консоль ЯО

![изображение](https://github.com/user-attachments/assets/9edc4139-b623-44f6-af3e-40832ec28cd0)


### 2. Создаю Managed Service for PostgreSQL

> Нажимаю на `Managed Service for PostgreSQL`

> Нажимаю `Создать кластер`

### 2.1. Задаю необходимые параметры

* * *
**Базовые параметры**
* * *

**2.1.1. Имя кластера**

> otus-pg-ex-22

**2.1.2. Окружение**

> PRESTABLE

**2.1.3. Версия**

> 16

**2.1.4. Тип**

> cpu-optimized (2 cores, 4 ГБ ОЗУ)

**2.1.5. Размер хранилища**

> network-ssd, 30 ГБ

* * *
**База данных**
* * *

**2.1.6. Имя БД, Имя пользователя, Пароль**

> otus-pg-ex-22

**2.1.7. Локаль сортировки, Локаль набора символов**

> ru_RU.UTF-8

* * *
**Сетевые настройки**
* * *

> Нажимаю `Создать сеть`

**2.1.8. Создание сети**

> otus-pg-ex-22-net

> - [x] Создать подсети

**2.1.9. Группы безопасности**

> Кликаю на `—` > `Добавить группу безопасности`

**2.1.10. Создание группы безопасности**

> Имя: otus-pg-ex-22-secgroup

> Иду в `Virtual Private Cloud` > `Группы безопасности` > `otus-pg-ex-22-secgroup` > `Редактировать` > `Правила (Входящий трафик)` > `Добавить правило`

**2.1.11. Добавление правила для входящего трафика**

**2.1.11.1. Описание**

> Allow IN from my IP

**2.1.11.2. Источник**

> CIDR

**2.1.11.3. CIDR блоки**

> Выполняю в терминале `curl icanhazip.com`

> xx.xx.xxx.0/24

> Нажимаю `Сохранить`

**2.1.12. Добавление правила для исходящего трафика**

**2.1.12.1. Описание**

> Allow OUT

**2.1.12.2. Источник**

> CIDR

**2.1.12.3. CIDR блоки**

> Выполняю в терминале `curl icanhazip.com`

> 0.0.0.0/0

> Нажимаю `Сохранить`

> Возвращаюсь снова на страницу создания кластера

**2.1.13. Группы безопасности**

> Кликаю на `otus-pg-ex-22-secgroup`

**2.1.14. Кликаю `Создать кластер`**

> Дожидаюсь, пока кластер не будет в состоянии `Alive`

![изображение](https://github.com/user-attachments/assets/753beb74-10cc-4a86-a179-df08269ac38b)


### 3. Выполняю подключение

### 3.1. Нажимаю на `...` > `Подключиться`

### 3.2. Устанавливаю сертификат

![изображение](https://github.com/user-attachments/assets/c066617d-699b-41cd-bb27-3f61c1e7a848)


> Т.к. `psql` у меня уже установлен, пропускаю шаг с его установкой

### 3.3. Пробую подключиться

> Но при попытке подключиться доменные имена по какой-то причине не разрешаются

![изображение](https://github.com/user-attachments/assets/7413d84c-61c1-4abd-80b2-a90d4332a3e8)


> Чуть позже понимаю публичный доступ отсутствует

![изображение](https://github.com/user-attachments/assets/4c627f80-ccc6-4e78-8b47-a337a3051e7d)


 **3.3.1. Нажимаю `...` обоих хостов > и выставляю `Публичный доступ [x]`**
 
 > Сейчас вроде бы в порядке

![изображение](https://github.com/user-attachments/assets/494a539f-eef2-4e9b-9610-dfcba9c44946)

**3.3.2. Пробую подключиться на мастер**

![изображение](https://github.com/user-attachments/assets/c319a123-17f9-4d6a-891d-55cb943bb4bb)


> Успешно

**3.3.3. Пытаюсь создать таблицу**

![изображение](https://github.com/user-attachments/assets/43a70dd5-b8d6-42ec-b1a8-8648212404aa)


> Здесь тоже удачно

**3.3.4. Попробую подключиться на реплику и удалить таблицу**

**3.3.4.1. Выполняю подключение на FQDN реплики**

**3.3.4.2. Postgres не разрешает подключиться**

**3.3.4.3. Удаляю `target_session_attrs` и пробую еще раз, на этот раз удачно**

**3.3.4.4. Пробую удалить таблицу, но это не заканчивается успехом, отлично** 

![изображение](https://github.com/user-attachments/assets/f58afc09-5836-45fd-99d1-26d0782fd3bf)


### 3.4. Пробую теперь подключиться с другого IP

**3.4.1. Подключаю VPN**

![изображение](https://github.com/user-attachments/assets/043ba8b7-4376-4c0d-9794-5df510d2c05c)


**3.4.2. Пробую подключиться**

> И... файерволл работает

![изображение](https://github.com/user-attachments/assets/3a7630ea-8fa1-4a0c-a9fc-55aaef06a350)

