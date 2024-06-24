# Работа с большим объемом реальных данных

### 1. Создал ВМ с Ubuntu 20.04 в ЯО

**На этот раз собрал ВМ с большим кол-вом ресурсов, т.к.:**
**1.1. Из-за двух СУБД нагрузка на ОЗУ и Процессор будет чуть выше**
**1.2. На сервере будут лежать 2 объемные БД**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/70d9c833-9e22-4757-a688-c512df5a4ff0)

### 2. Установил Postgres по [документации](https://www.postgresql.org/download/linux/ubuntu/)

**2.1. Создаю скрипт, с его помощью устанавливаю**

**2.2. Проверяю статус установки**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/19fc1585-b0be-4ffa-9479-20400bc0664c)

### 3. Установил Clickhouse по [документации](https://clickhouse.com/docs/en/install)

Выполняю аналогичные установке Postgres действия.

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/076966ca-6e26-410c-8ef3-a9a2314439d1)

### 4. Пробую настроить Postgres на максимальную производительность

**4.1. Выполняю тесты pgbench**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/eb70f9d4-c29e-48ca-93ea-63b55853d0d2)

**4.2. Кручу параметры из pgtune под мое железо**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/af623728-d6f8-4aff-91dc-2329c19604a7)

**4.3. Провожу повторный тест**

Стало получше

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/720cf204-3bcb-47ae-ba86-013605aeed08)

### 5. Создаю БД и заполняю ее данными

**5.1. Создаю БД *otus_test***

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/8229f413-9b16-4908-a228-5afdf9bdc00f)

**5.2. Подключаюсь и создаю таблицу *large_test***

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/1eaa47e0-e2ab-4889-ae40-e51dbd8c656c)

**5.3. Заполняю ее данными**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/6d5fe38b-b23e-431c-9035-0d0360d36429)

**5.4. Проверяю размер БД**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/9ec19f39-aac0-4855-852c-94424c1e4dac)

### 6. Заполняю ClickHouse аналогичными данными

**6.1. Подключаюсь к ClickHouse**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/a11ea9b8-e12a-49fe-8c92-576cadeff691)

**6.2. Создаю БД и таблицу с аналогичным PG названием**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/190c61f3-1b4c-4d82-b73e-eb9a92674c39)

**6.3. Заполняю ее аналогичыми данными**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/3e129a0a-da9a-4ef7-ab8a-3608205e359b)

### 7.  Сравниваю скорость заполнения таблиц данными между СУБД

**Postgres:**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/523540fb-d73a-4b88-aa46-1ef7dfba3eeb)

**ClickHouse:**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/60bedf14-93a6-42d6-9c81-33753b97bf2c)

### 8. Проверяю результат скорости выборки данных между СУБД

**Postgres:**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/2668970e-1ea2-4dac-a01e-0e9637d22957)

**ClickHouse:**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/ac2500a0-7adc-409b-b9d7-b777f989bd36)
