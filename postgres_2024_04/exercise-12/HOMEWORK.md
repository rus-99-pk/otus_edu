# Работа с кластером высокой доступности

## Управлять кластером k8s планирую со своей основной машины на Linux, а подключаться попробую и с нее, и с клиентских ВМ в каждом регионе

### 1\. Проверяю статус установленного ранее kubectl

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/b5d64c5c-b4de-44f7-b804-fe38bc55256e)


### 2\. Проверяю статус установленного ранее yc-cli

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/ced29661-2e6c-4fd3-8afe-acb9580341f0)


### 3\. Подготавливаю инфраструктуру в YC

**3.1\. Инициализирую инфраструктуру**  

**3.2\. Выбираю дефолтный профиль, т.к. смысла создавать новый нет**  

**3.3\. Говорю использовать ранее заданный OAuth-токен**  

**3.4\. Хочу создать новую директорию для своих сервисов**  

**3.5\. Задаю ей имя**  

**3.6\. Отказываюсь от настройки Compute zone**  

**3.7\. Проверяю что я в только что созданной директории**  

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/7a0f0c2b-d076-4427-b76f-d3b382d17658)

**Как это выглядит в интерфейсе:**  

Сервисы и ресурсы отсутствуют, как и должно быть  

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/5abf1983-b4a4-4294-a71b-0a96f0286ccc)

### 4\. Создаю сервисный аккаунт и выдаю ему необходимые роли для управления кластером

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/bb1d7877-c4cf-4b8c-8128-e0182e822278)

### 5\. Создаю сеть и подсети в ней, для геораспределения узлов

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/2a03d606-033d-4b72-8927-948ef55adc43)

### 6\. На основе созданных объектов создаю кластер

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/337b2488-ef78-4475-9dc8-5903aee3fe12)

### 7\. Проверяю статус кластера в CLI

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/d6d96495-50f4-4016-abf0-f48c8cb05e0f)

### 8\. Создаю группы узлов

Убеждаюсь, что кластер в статусе RUNNING, иначе узлы создать не удастся  

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/3adbbd24-02d8-4d77-bf9f-5821792d7108)


### 9\. Создаю 2 группы узлов, одна для primary, другая для standby

**3 primary**, для отказоустойчивости  

**2 standby**, потому что ЯО больше ресурсов не захотело давать :D  

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/18ae659c-58d1-49d3-8c9c-9339e66d2528)

### 10\. Подключаю и проверяю статус узлов

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/03469b76-e291-48ab-a73e-a992ec720a6e)

### 11\. Устанавливаю Helm для управления версионированием и разными версиями инсталляций

**Ставлю по [документации](https://helm.sh/ru/docs/intro/install/)**  

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/e8b88843-4df7-4a6f-80a9-fe8800dcfbca)

### 12\. Устанавливаю архив с Helm-чартом postgresql-ha

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/54295344-e2fe-46a5-9b1f-adc15cde8027)

**В общем-то, получилось то, что проходили на практическом уроке. Но это pg-pool, это не то, к чему я шел изначально. Мне нужен Patroni**

## Иду делать Patroni! Для реализации мне понадобится утилита [Kind](https://kind.sigs.k8s.io/)

### 13. Устанавливаю Go-модуль Kind (Go у меня уже есть)

**13.1. Выполняю установку**

**13.2. Проверяю путь до установленного модуля**

**13.3. Пробую запустить, но мне это не удается**

**13.4. Редакатирую *~/.bashrc*, добавив alias для *kind***

**13.5. Логинюсь еще раз, для тестов**

**13.6. Сейчас в порядке**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/2e137c43-8f01-47a8-9201-0057670dc215)

**Потом понимаю, что с sudo доступа все равно нет, и пришлось сделать симлинк в */usr/local/bin***

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/1a53a8c3-d18f-4eed-a560-1add4da3e74c)

**Так лучше : )**

### 14. Создаю кластер *kind*

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/6d6c2190-5936-4a41-9c8e-34e9e7cb9aac)

### 15. Пробую выводить информацию о кластере

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/2bde8e97-bf5f-479e-b628-86055fe89c26)

### 16. Вытягиваю из Git'а пример кластера Patroni и выполняю подготовительные действия

**Пробую воспользоваться [инсталляцией Patroni](https://github.com/patroni/patroni/tree/master/kubernetes) для k8s**

**16.1. Для чистоты эксперимента удаляю сеществующий каталог и делаю *git clone***

**16.2. Вижу что есть *patroni_k8s.yaml*, кажется то что нужно**

**16.3. Иду его редактировать** 

**16.4. Меняю *image* на мой будущий docker-image и выставляю кол-во реплик: 5**

**16.5. Иду собирать образ *otus-patroni-k8s***

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/c067a41c-c107-4b7e-86ce-be480c24725f)

### 17. Пробую деплоить то что получилось

**17.1. Гружу только что собранный образ в инфраструктуру k8s**

**17.2. Пробую применить конфиг**

**17.3. Пробую получить список pod'ов**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/19995ae9-6644-422c-9f37-599e55aedf63)

### 18. Проверяю работу кластера

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/f1fbaef1-1a76-4b03-b647-7a28c7bbc8e8)

**Вроде бы все в порядке. Но так не очень удобно, поэтому пробую бросить порт на свою машину:**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/bf07a0e2-0106-48b1-81f7-3d36342e3ad3)

### 19. Эксперементирую

**19.1. Удаляю текущие pod'ы 0 и 1**

**19.2. Прверяю что они действительно удалились**

**19.3. Пробую подключиться к pod'е 3**

**19.4. Вижу, что лидером стала нода 4,  и  БД сохранилась, отлично**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/a6b68f29-5372-4460-8000-3f3b06bbbcbc)

***
![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/a78e5138-f364-4321-96bf-0ba2d27e3279)