# Postgres & Docker
### 1\. Создал ВМ с Ubuntu 20.04 в ЯО
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/9ccab377-4687-4b7d-b5bc-e028c5ddac89)

### 2\. Установил Docker по [документации](https://docs.docker.com/engine/install/ubuntu/)
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/b5298798-1ead-44d4-bed2-f96885a88d10)
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/c1308b4d-2bda-475f-a7b4-aff6b86d34c4)
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/23a5ab5f-9e74-494f-a4cc-d29e8017e879)

### 3\. Создал каталог */var/lib/postgres*
### 4\. При попытке создать контейнер столкнулся с [проблемой](https://habr.com/ru/news/818177/)
Поэтому пришлось перейти на свою ВМ под управлением VBox (также на Ubuntu 20.04) и подключиться по VPN.

Поэтому дальнейшие манипуляции буду выполнять оттуда.

### 5\. Скачал официальный образ *postgres:14.12-alpine3.20*
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/71570037-e89d-4512-9cea-adc27a7b8651)
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/2f05eab5-acff-483c-b11f-0714b5e9e66d)

### 6\. Запустил контейнер с именем *pg_server*
**Запуск выполнил командой:**

`docker run -d -e POSTGRES_PASSWORD=mypass -v /var/lib/postgres:/var/lib/postgresql --name pg_server ${image_id}`
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/ae43fb09-64a4-4f7d-b1ca-4aa59bffd15f)
**Проверил подключение:**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/00d3b534-f3c1-4610-b964-bb6111ed6a23)

### 7\. Запустил контейнер с именем *pg_client*
**Запуск выполнил командой:**
`docker run -d -e POSTGRES_PASSWORD=mypass  --name pg_client ${image_id}`

**И проверил состояние состояние контейнеров командой:**
`docker ps`
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/35a7ac5c-4426-4fa1-b1bd-bdc8b343a370)

### 8\. Выполнил подключение с *pg_client* к *pg_server*
    8.1. Узнал IP сервера Postgres
	8.2. Выполнил подключение
	8.3. Создал БД - otus_edu
	8.4. Проверил результат прошлой команды
	8.5. Заполнил созданную таблицу данными
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/7ae7c7f5-61bf-439b-897e-e59310faaea7)

### 9\. Удалил контейнер с сервером, чтобы пробросить порт, создав новый контейнер

В процессе выяснил что на основной машине создался пустой каталог **data** при указании опции `-v /var/lib/postgres:/var/lib/postgresql`, т.е. данные стерлись.
Думал что Docker пробросит директории рекурсивно, но нет.

**Переделал команду, заодно указал несколько доп. опций:**

`docker run --rm -d -e POSTGRES_PASSWORD=mypass -p 5432:5432 -v /var/lib/postgres/data:/var/lib/postgresql/data --name pg_server ${image_id}`

На этот раз данные есть и сохраняются после пересоздания контейнера.

**Далее наблюдаю, что порт пробросился:**
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/b245d790-0982-4dde-878d-b81705a16760)

**После, установил Postgres-клиент на свою основную машину и подключился к ВМ с проброшенным из Docker портом**
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/1aced8a3-4a83-451a-94cf-747427063738)

### 10\. Еще раз  остановил контейнер с сервером, проверил что данные сохранились
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/2057c528-8025-49e8-8516-a4a6af93c6b8)

### 11\. Запустил контейнер (на этот раз без проброса порта во вне) и проверил наличие данных, подключившись с контейнера-клиента
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/b378d4a0-1a4b-456a-bb2f-1533ba24a10c)
