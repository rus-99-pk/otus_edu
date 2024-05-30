# Postgres & Docker
### 1\. Создал ВМ с Ubuntu 20.04 в ЯО

![be88484dade4e460d0e54ec79dcce213.png](:/7ad4258a60ec44d5b821a7e7969b28aa)

### 2\. Установил Docker по [документации](https://docs.docker.com/engine/install/ubuntu/)

![9f7cda606111edc69c6da5b1d74a1e86.png](:/3c35289cfc2f401081dce67116e1372d)
![39d7a6e993dfaeb3e9dabe0ff3a22d87.png](:/6c621782f40b482aba64bf4362ca22e9)
![fd6b06f1e0359d06ad292717abcedc0e.png](:/e740ef23de284c4a9a32a236e900f5b0)
### 3\. Создал каталог */var/lib/postgres*
### 4\. При попытке создать контейнер столкнулся с [проблемой](https://habr.com/ru/news/818177/)
Поэтому пришлось перейти на свою ВМ под управлением VBox (также на Ubuntu 20.04) и подключиться по VPN.

Поэтому дальнейшие манипуляции буду выполнять оттуда.
### 5\. Скачал официальный образ *postgres:14.12-alpine3.20*
![d8dfc8a5765111b8ca3b1e90fc6f7aee.png](:/d912c529175a4d3699d0aba7dcc64d50)
![33b4c32393da8ad3c56c6e639ff03ed8.png](:/12fd32256e784e2eba43f852219b7e3d)
### 6\. Запустил контейнер с именем *pg_server*
**Запуск выполнил командой:**
`docker run -d -e POSTGRES_PASSWORD=mypass -v /var/lib/postgres:/var/lib/postgresql --name pg_server ${image_id}`
![30ce6c236e1c5de11d44ad41e9c2c59f.png](:/dea91cce563e4dad99cfd45f6e930de9)
**Проверил подключение:**
![98d66e8d15a56512de455b98bc5f2a59.png](:/f9d2ee76c59f4069b3baca270fca92f0)
### 7\. Запустил контейнер с именем *pg_client*
**Запуск выполнил командой:**
`docker run -d -e POSTGRES_PASSWORD=mypass  --name pg_client ${image_id}`
**И проверил состояние состояние контейнеров командой:**
`docker ps`
![eade485d98d55983f9798e7f3fd991b9.png](:/0ebcde01c3b4423f85bb164a3d658657)
### 8\. Выполнил подключение с *pg_client* к *pg_server*
    8.1. Узнал IP сервера Postgres
	8.2. Выполнил подключение
	8.3. Создал БД - otus_edu
	8.4. Проверил результат прошлой команды
	8.5. Заполнил созданную таблицу данными
![80cdb5d1a27fc83678570a906d270bdc.png](:/4dd07eb934dc4a3ca5806dfffa04a5f7)
### 9\. Удалил контейнер с сервером, чтобы пробросить порт, создав новый контейнер
В процессе выяснил что на основной машине создался пустой каталог **data** при указании опции `-v /var/lib/postgres:/var/lib/postgresql`, т.е. данные стерлись. Думал что Docker пробросит директории рекурсивно, но нет.

**Переделал команду, заодно указал несколько доп. опций:**
`docker run --rm -d -e POSTGRES_PASSWORD=mypass -p 5432:5432 -v /var/lib/postgres/data:/var/lib/postgresql/data --name pg_server ${image_id}`
На этот раз данные есть и сохраняются после пересоздания контейнера.

**Далее наблюдаю, что порт пробросился:**
![1071b776c7136e68f311de2feec8bc92.png](:/aab6f0d9271d4ead85f9335c945a90fb)
**После, установил Postgres-клиент на свою основную машину и подключился к ВМ с проброшенным из Docker портом**
![cb35ca414663d3269eaf52b3dc02c76a.png](:/8d3b95e659314fd382fc18185b1b4eba)
### 10\. Еще раз  остановил контейнер с сервером, проверил что данные сохранились
![57fbb6da5429d7c80d6e5906e8d36d57.png](:/5665d194279c49d190bb42b0d7c715da)
### 11\. Запустил контейнер (на этот раз без проброса порта во вне) и проверил наличие данных, подключившись с контейнера-клиента
![1d1e2d7b7269571b9e51079b357e8464.png](:/a3dfef66988d4db7b6e32e90cadc7eed)
