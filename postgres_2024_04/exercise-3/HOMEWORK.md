#  Настройка PostgreSQL
### 1\. Создал ВМ *otus-db-pg-vm-3* с Ubuntu 20.04 в ЯО

### 2\. Установил Postgres 15 по [документации](https://www.postgresql.org/download/linux/ubuntu/)

### 3\. Убедился, что Postgres запущен
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/db575f93-5d88-4bc6-b438-28740a59d544)

### 4\. Создал таблицу в БД *postgres* и заполнил ее некоторыми данными
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/3716012d-7f9d-42e6-8321-7fd9f76bf5e3)

### 5\. Выполнил остановку кластера с помощью *pg_ctlcluster*
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/2a8ca9d7-ab6f-4f2e-8568-eea0136fef1a)

### 6\. Создал и добавил диск размером 10 ГБ к ВМ *otus-db-pg-vm-3*
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/c0ae6390-e1ae-4199-9534-e0bff6f2535d)
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/7a77311f-2a9a-4cda-a1fe-6bf4618f7eb9)

### 7\. Создаю ФС по [мануалу](https://www.digitalocean.com/community/tutorials/how-to-partition-and-format-storage-devices-in-linux)
	7.1. Создаю таблицу партиций
	7.2. Создаю раздел и задаю область, которую будет занимать раздел на диске
	7.3. Проверяю что партиция создана, но на ней отсутствует ФС
	7.4. Создаю ФС с заголовком pg-data
	7.5. Проверяю еще раз, сейчас все ОК, можно монтировать
	7.6. Создаю каталог /mnt/data, куда буду монтировать раздел
	7.7. Выполняю монтирование
	7.8. Проверяю что с разделом можно работать
	7.9. Добавляю раздел в fstab
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/acc12427-07e5-4a78-8a8f-f9b5fb732953)
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/1e7f39a1-6377-46b4-ae12-e077d3486367)

### 8\. Делаю пользователя *postgres* владельцем */mnt/data*
`chown -R postgres:postgres /mnt/data/`

### 9\. Переношу содержимое */var/lib/postgresql/15* в */mnt/data*
`mv /var/lib/postgresql/15 /mnt/data`

### 10\. Пробую запустить Postgres
Получаю ошибку, что */var/lib/postgresql/15/main* не существует.
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/8c1f7b76-4341-4525-8c6a-dabc377337be)
Соответственно Postgres'у неоткуда брать данные, т.е. тут либо заново инициализировать пустой кластер с таблицами по умолчанию, либо менять в файле конфигурации */etc/postgresql/15/main/postgresql.conf* параметр *data_directory*.

### 11\. Вношу изменения в конфигурацию Postgres
	11.1. Создаю файл конфигурации /etc/postgresql/15/main/conf.d/myconfig.conf
	11.2. Добавляю в него значение data_directory = '/mnt/data/15/main'

### 12\. Выполняю попытку запуска и проверки наличия таблицы *test*
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/7a5c63ce-12ca-42c9-aa03-592c107b8d2f)

* * *
## Задание со * 
### 1\. Создал новую ВМ в ЯО с названием *otus-db-pg-vm-3-1*
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/c391b53c-6159-49d9-bbdb-9104bcc26f89)

### 2\. Установил Postgres 15 по [документации](https://www.postgresql.org/download/linux/ubuntu/)
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/4a4d707e-d712-488b-b669-c0be38669f0e)

### 3\. Остановил Postgres и вместо удаления изменил название каталога */var/lib/postgresql/15*
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/3595b783-0326-410d-bcc5-07cbdf302ecf)

### 4\. Выключил первую ВМ и отсоединил диск
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/9a4e4c40-9f3a-487f-8110-90bb23858bfc)
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/343cf079-07c0-44b3-9858-9d98c8249cf2)

### 5\. Присоединил диск к новой ВМ
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/793a2ee7-60f2-417d-aeaa-4ef9e2077219)
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/dfef62ae-79b3-4540-9604-43b716940554)

### 6\. Проверяю наличие раздела и ФС на нем
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/6b38cb99-6c5e-4bfe-a269-7bf5f567786d)

### 7\. Монтирую раздел
	7.1. Создаю каталог /mnt/data, куда буду монтировать раздел
	7.2. Выполняю монтирование
	7.3. Проверяю, что с разделом можно работать
	7.4. Создаю символическую ссылку, чтобы не менять конфигурацию
	7.5. Проверяю доступность каталога по ссылке
	7.6. Добавляю запись в fstab
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/04bb3021-5a9b-4023-9138-37f13556a0f5)
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/74ed96e3-522f-4788-b3fb-3a396c4f0b92)

### 8\. Выполняю попытку запустить Postgres
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/c6f23a09-11b2-4747-8845-5c4381cd7dc3)

### 9\. Проверяю наличие данных
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/e7dbd142-d766-44ff-b7ff-3950cf456f14)
