# Введение в Kubernetes. Часть 2

### 1. Установил Minikube

Выполняю установку по [документации](https://kubernetes.io/ru/docs/tasks/tools/install-minikube/)

**1.1. Т.к. у меня  Linux, проверяю поддерживает ли мой ПК виртуализацию. Судя по кол-ву строк, поддерживает.**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/b0d660b1-79c1-42a4-b5b2-fd3dcb4157d4)

**1.2. Выполняю установку kubectl по [документации](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/#%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-kubectl-%D0%B2-linux)**

Проверяю.

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/14597c25-1e57-420d-a2b2-767e86aaebfa)

**1.3. Пробую установить, [скачав](https://kubernetes.io/ru/docs/tasks/tools/install-minikube/#%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-minikube-%D1%81-%D0%BF%D0%BE%D0%BC%D0%BE%D1%89%D1%8C%D1%8E-%D0%BF%D1%80%D1%8F%D0%BC%D0%BE%D0%B9-%D1%81%D1%81%D1%8B%D0%BB%D0%BA%D0%B8) бинарник**

Проверяю.

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/b1f6e680-64a2-43be-8161-1e7dc7ceb042)

**Отлично! Идем дальше.**

### 2. Поднимаю Minikube

2.1. Стартую minikube

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/18703d38-a72a-43ad-bbec-fbb2af16bdaa)

2.2. Поднимаю UI

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/9176aee6-45cd-44a7-bb36-0de82115ac23)

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/f41368b2-3d7b-4905-8684-b052a88f8b14)

### 3. Подготавливаю Minikube

**3.1. Создаю namespace**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/ad17da9e-28ba-47b8-addd-3138108c0e02)

**3.2. Указываю его по умолчанию**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/286c492a-7e71-425d-b0fd-eef2e13688dd)

**3.3. Проверяю статус**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/ec3a13ff-c634-4bc9-bf54-a56f575377c1)

### 4. Пробую поднять сервис Postgres

**4.1. StatefulSet Postgres и Service для него в одном файле**

**4.2. Файл с секретами в переменных окружения**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/34a0ecad-6d5a-421f-b93b-3f3448f8a06c)

### 5. Решение проблем в процессе

**5.1. Выполняю *kubectl apply -f ...*, но сталкиваюсь с ошибкой**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/b5cfbd7c-55a7-44ea-b252-786f4f7d9026)

**Причину ошибки найти удалось, дело бы в этих минусах**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/4acd9a0c-4fe5-42b4-a76b-2595622d79d4)

**5.2. После их удаления, под, на первый взгляд, завелся**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/0bb823c3-8c33-4db6-b9de-055b1f8638b4)

**Но, нет, наткнулся на следующую ошибку:**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/42067fb5-c494-4479-89c2-590ee94ab12f)

**После изменения названий (в нижнем регистре и без "\_"), StatefulSet запустился**

**5.3. Далее, вижу что проблема с Pod'ом**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/af9c1052-c188-4941-9229-a9987a1ee627)

**А именно, Pod не может найти секрет**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/5529ed90-97c9-47b9-b1ae-da9f091f8a8c)

Понимаю, что я его не применил...

**При попытке применить секрет встречаю еще одну преграду на пути к успеху**

**5.3.1. kubectl не нравится что данные в secrets.yaml не в Base64, ОК, кодирую**

**5.3.2. УРА! Идем ловить новые ошибки...**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/576567c2-837e-4b1a-9c5a-2ef5d66498b1)

**5.4. Поды создались, но вижу, что снова что-то пошло не так** 

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/279da145-e147-47e8-805e-302e0736356c)

**5.4.1 Иду в логи**

Вероятно PG не нравится, что секреты я казал в кавычках.

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/c3c6f8b9-b659-4824-b943-62927ccbb77b)

**5.4.2 Пробую указать без них и кодирую еще раз:**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/030c75f4-9369-44c5-81b6-f708cfee5359)

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/e36f2b61-4ce6-42fe-9ede-ad429312fc90)

**Ну, магия!**

### 6. Пробую подключиться к PG

**6.1. Прошу Minikube дать доступ к сервису**

**6.2. Пробую подключаться через psql**

**6.3. Создаю тестовую БД**

**6.4. Проверяю**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/7d43cf73-798b-4663-a0b1-d275368107bc)

### 7. Попробовал также поудалять Pod'ы вручную.
**Итог:** успешно пересоздаются
