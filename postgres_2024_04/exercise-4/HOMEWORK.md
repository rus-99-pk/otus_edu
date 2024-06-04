#   Углубленный анализ производительности. Профилирование. Мониторинг. Оптимизация 
### 1\. Создал ВМ *otus-db-pg-vm-4* с Ubuntu 20.04 в ЯО
**vCPU:** 2
**RAM:** 2 ГБ
**HDD:** 20 ГБ
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/ed7f1c91-7643-4d1d-80b3-e0304bea9f87)

### 2\. Установил Postgres 15 по [документации](https://www.postgresql.org/download/linux/ubuntu/)

### 3\. Убедился, что Postgres запущен
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/d77f5d7e-7ebf-4799-a7e6-ce7af005b4a2)

### 4\. Инициализировал pgbench
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/4217d673-1c15-4d89-840e-feb9f01e7776)

### 5\. Выполнил первый тест
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/8b184843-ef39-4276-a2cb-df8879d1e28d)

### 6\. Пошел в [pgtune](https://pgtune.leopard.in.ua/), чтобы выставить оптимальные настройки под текущее железо
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/c197b825-23f1-4f40-b5a5-cfd158af849c)

### 7\. Проверил состояние каталога conf.d, чтобы расположить конфигурацию туда
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/7d9de361-6127-492f-9b67-07a1f2946cb2)

### 8\. Создал файл конфигурации */etc/postgresql/15/main/conf.d/pgtune.conf*
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/dc056601-1910-46b0-a08b-f48198654274)

### 9\. Решил проверить изменения
	1. Выполнил еще раз pgbench перед внесением изменений
	2. Перезапусти сервис Postgres
	3. Выполняю pgbench повторно, удивляюсь уменьшению средней задержки и уведичению кол-ва транзакций в секунду (увеличилось почти в 2 раза)
	4. Выполняю еще раз, для закрепления
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/d96fe818-3dcd-4a3d-91b3-1dd4eaebf22e)

### 10\. Подкрутил еще несколько параметров (с описанием)
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/e0a6c380-8842-4ca7-af52-6a84f3fe2d3a)
