# Работа с горизонтально масштабируемым кластером 

> Сначала необходимо инициализировать профиль Yandex Cloud

### 1. Выполняю инициализацию и подключение к ЯО

![изображение](https://github.com/user-attachments/assets/e67cc9fc-113b-4f4f-8fc5-bdb05f26d481)


### 2. Создаю сетевую инфраструктуру

### 2.1. Создаю сеть

![изображение](https://github.com/user-attachments/assets/378fbe69-c34c-4ea5-b912-06a62d3138d1)


### 2.2. Создаю в ней подсети

> Три подсети в трех разных зонах

![изображение](https://github.com/user-attachments/assets/a8809ff8-eb07-4f4a-9e07-459996c5cd33)


### 3. Создаю инстанс ВМ

![изображение](https://github.com/user-attachments/assets/7fe38240-611f-4033-b715-b9c6a1c2808c)


![изображение](https://github.com/user-attachments/assets/ce5fc211-29ef-4186-8409-fb34ecb2dd3f)


> Иду в [документацию](https://yandex.cloud/ru/docs/troubleshooting/managed-kubernetes/how-to/adding-and-changing-ssh-keys-for-linux-users-on-node-groups) и понимаю что нужно немного поменять формат

![изображение](https://github.com/user-attachments/assets/896aa5e9-33e3-43f1-a435-8096e6a6125d)


> После этого успешно удается подключиться

![изображение](https://github.com/user-attachments/assets/96c64dfe-6de0-4a4f-9ffc-d93545e8f3d4)


### 4. Устанавливаю Postgres по [документации](https://www.postgresql.org/download/linux/ubuntu/)

### 5. Конфигурирую и перезапускаю Postgres

![изображение](https://github.com/user-attachments/assets/25769f4c-86f5-419b-907d-9745b20dc8ac)


### 6. Загружаю датасет с банковскими транзакциями

> Т.к. датасет с Чикагским такси отсутствовал, загрузил с Операциями клиентов банка

![изображение](https://github.com/user-attachments/assets/ed736d34-ead0-407a-a03b-0ff9505906d6)


### 7. Создаю БД и таблицу

![изображение](https://github.com/user-attachments/assets/5b3d22c5-d3a3-47f6-959b-bc53070a7648)


### 8. Заполняю ее данными

![изображение](https://github.com/user-attachments/assets/42c4c62a-5d2d-4ae6-abb9-522b21ed67fa)


> И тут же сталкиваюсь с тем, что числа, содержащие запятую не импортируются в Postgres

![изображение](https://github.com/user-attachments/assets/2c9c9734-d11f-4d0f-a1fc-2eaad8357642)


> Приходится писать скрипт для удаления запятых

![изображение](https://github.com/user-attachments/assets/c7fae11a-42f3-4a00-8b0d-e89b5125819b)


> После того как скрипт отработал, сверяю данные

![изображение](https://github.com/user-attachments/assets/716a2e90-8d8e-4ed0-bd32-ede2a69dbf41)


> Запускаю еще раз, но на уже обработанном файле

> На этот раз вроде бы успешно

> В процессе проверяю процесс заливки данных

![изображение](https://github.com/user-attachments/assets/feb0faaa-7f5b-4243-9434-88060444aaeb)


![изображение](https://github.com/user-attachments/assets/b5179fbd-3622-4bb6-9a15-bf9827de005e)


### 9. Выполняю `ANALYZE` и создаю индексы

![изображение](https://github.com/user-attachments/assets/cb22047c-cdaf-4841-b8bd-de68a1a62a43)


### 10. Выполняю тестовые запросы

### 10.1. Включаю тайминги

### 10.2. Выбираю случайную запись по индексам

### 10.3. Выбираю случайную запись вне индекса

### 10.4. Вывожу кол-во записей в таблице

![изображение](https://github.com/user-attachments/assets/bb7d2248-9927-48d2-8b5c-dfbd5fc26a35)


### 11. Поднимаю CockroachDB

### 11.1. Поочередно поднимаю три ВМ в трех разных зонах

![изображение](https://github.com/user-attachments/assets/7dbb5cf7-8c09-4bf1-81e8-6226c29710de)

![изображение](https://github.com/user-attachments/assets/c2d63e70-5c78-4fc4-bf9e-fad82bb12285)


### 11.2. Циклом устанавливаю на хостах Cockroach

![изображение](https://github.com/user-attachments/assets/d55b348a-677f-4e41-a4b6-a115a7fd3e4b)


### 11.3. Генерирую сертификаты на первой ноде

**11.3.1. Иду в каталог СУБД**

**11.3.2. Генерирую сертификаты**

**11.3.3. Проверяю их наличие, для переноса на другие ноды**

![изображение](https://github.com/user-attachments/assets/565398ba-75a8-4386-8b52-ac8c0d958c89)


### 11.4. Переношу сертификаты на остальные ноды

![изображение](https://github.com/user-attachments/assets/90ed31c6-8e55-445e-9411-6a5d9db82b95)


### 11.5. Запускаю ноды кластера

> Выполнил команду `start` поочередно на каждой ноде, но это ни к чему не привело

> Даже к записи в системный лог... При этом PID'ы есть.

![изображение](https://github.com/user-attachments/assets/5e061558-6b0b-4dcd-b1ef-957dcff47d32)


> Пока команды повисли и чего-то ждут, параллельно пробую инициализировать кластер

![изображение](https://github.com/user-attachments/assets/f54aa1c2-7f96-423c-b0b6-9b1125fd76f9)


> На удивление получилось... (странная какая-то СУБД)

> После успешной инициализации дропнул соединения с командой `start`

### 11.6. Проверяю состояние нод

> Почему то только мастер инициализировался (вероятно, потому что только на нем выполнил `init`)

![изображение](https://github.com/user-attachments/assets/3d99f050-d656-4fd6-9155-1f950b7a93a6)


> С кластером явно проблемы, пошел искать решение...

### 11.7. Пересоздаю сертификаты

> Везде

**11.7.1. Удаляю созданные ранее сертификаты**

> На первой ноде

**11.7.2. Пересоздаю CA сертификаты и отправляю их на реплики**

![изображение](https://github.com/user-attachments/assets/d51a1f5c-b9b3-4a84-9c53-66df0532b689)


> На всех нодах

**11.7.3. Создаю клиентские сертификаты**

![изображение](https://github.com/user-attachments/assets/9e8a1fdd-4db7-4db7-a53a-4fbe1b770527)


> На первой ноде

**11.7.4. Запускаю кластер и инициализирую ноду**

![изображение](https://github.com/user-attachments/assets/1a30d365-fff4-4cf0-a392-5abb266dcf47)


> На второй и третьей ноде

**11.7.5. Добавляю ноды в кластер**

![изображение](https://github.com/user-attachments/assets/61db3a7d-6af3-4562-af09-b1682c92e098)


![изображение](https://github.com/user-attachments/assets/8c2e8a07-01e2-44de-9422-531fa061f9d7)


> На первой ноде

**11.7.6. Проверяю статус**

> На этот раз хотя бы 2 ноды

![изображение](https://github.com/user-attachments/assets/c53234a6-9cff-4afe-a4f8-305135f16800)


> Пробую зайти в веб-интерфейс, может хоть там будет что-то полезное

![изображение](https://github.com/user-attachments/assets/4ddc349e-cb95-4404-aafe-bca22bd9acf2)


> Но к сожалению, ничего нового

![изображение](https://github.com/user-attachments/assets/d7fd7ac7-c6f1-4533-9d59-756e257ed034)


> При попытке запустить вторую ноду без `--background` вижу ожидаемый результат

![изображение](https://github.com/user-attachments/assets/a478bc21-02a6-46c0-bd11-370b71f8adb1)


> Если сделать тоже самое с третьей, то результат не очень предсказуемый

![изображение](https://github.com/user-attachments/assets/25dea907-b49f-447f-9298-3c7199fddb0d)


> Пробую выполнить `init` и пересоздать ноду

![изображение](https://github.com/user-attachments/assets/7cd7d20a-69eb-4cf7-9178-208803a8f998)


![изображение](https://github.com/user-attachments/assets/f2b3fc77-9292-4e5b-ba97-360375fa9645)


> В конечном итоге так и не удалось разобраться, пересоздав ноду с нуля

![изображение](https://github.com/user-attachments/assets/5dfe58c2-be60-4a3a-9fda-855d06a7f6c9)


> Поэтому продолжу как есть

### 12. Создаю таблицу, аналогичную Postgres

![изображение](https://github.com/user-attachments/assets/ba94e6e9-78a3-4c9e-a29f-6559ec5030c1)


### 13. Качаю тот же самый датасет и прогоняю через упомянутые ранее скрипт

### 14. Загружаю CSV в хранилище userfile

> Интересная особенность

![изображение](https://github.com/user-attachments/assets/f2ea434e-4959-49c3-84d9-834a4e5ea62d)


### 15. Выполняю импорт

![изображение](https://github.com/user-attachments/assets/10e23680-9827-42fa-b828-635299e64c1b)


> Чем-то ему не понравился мой файл, ок...

> Пробую ему "скормить" необработанный под PG файл.
> Но это ни к чему не привело.

![изображение](https://github.com/user-attachments/assets/6c06be1a-2c45-4c5c-a16d-5a77c8ccf096)


> Иду вытаскивать данные из Postgres, в надежде что это поможет

![изображение](https://github.com/user-attachments/assets/36455174-d90c-4aaf-a05b-30fb73790170)


> Пробую затащить в СУБД

![изображение](https://github.com/user-attachments/assets/a48ad85d-3ab3-4b21-b8e1-71168df0f815)


> УРА! Даже что-то поменялось в GUI

![изображение](https://github.com/user-attachments/assets/853d78c4-4f33-48cb-a0f3-3a5c7b4553ee)



### 16. Создаю аналогичные PG индексы

![изображение](https://github.com/user-attachments/assets/0083bd44-0b34-4dc1-9b29-748914bc9a7d)



### 17. Делаю аналогичные PG запросы

### 17.1. Выбираю случайную запись по индексам

### 17.2. Выбираю случайную запись вне индекса

### 17.3. Вывожу кол-во записей в таблице

![изображение](https://github.com/user-attachments/assets/322288c0-a146-4498-829f-4766be8fcefc)


* * *

## Итог: Postgres оказался быстрее в 3 раза, очередное доказательство того, что шардирование - это про OLAP, а не про OLTP. Хотя, если предположение, что Postgres + Citus быстрее, нужно тестировать.
