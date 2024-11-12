# PostgreSQL и VKcloud

### 1. Выполняю установку Terraform по [документации](https://developer.hashicorp.com/terraform/install)

**1.1. Добавляю репозиторий. Понимаю, что без VPN сделать это не удастся**  

**1.2. Подключаю VPN и пробую еще раз. УРА, репозиторий есть**  

**1.3. Устанавливаю Terraform**  

**1.4. Проверяю статус установки**  

![изображение](https://github.com/user-attachments/assets/fcf33d6c-519f-4f5d-9d40-0c8556c66b44)

![изображение](https://github.com/user-attachments/assets/1eabac13-4b8e-437a-a8d5-49d86bb535a5)

* * *
## Выполняю деплой ВМ с помощью Terraform в VK Cloud

### 2. Подготовливаю каталоги под инфраструктуру TF

![изображение](https://github.com/user-attachments/assets/24114651-86d7-49f0-a5a8-29124ca245aa)

### 3. Активирую работу сервисов, привязав карту

### 4. Выполняю подготовительные шаги ([документация](https://cloud.vk.com/docs/tools-for-using-services/terraform/quick-start#965-tabpanel-1))

**4.1. Включаю 2FA и Доступ по API**

![изображение](https://github.com/user-attachments/assets/b44382b9-4b52-4843-969f-6edac062b5c3)

**4.2. На главной странице иду в настройки проекта**

![изображение](https://github.com/user-attachments/assets/22b50bbd-87ec-4935-b865-18641904d972)

**4.3. Иду по вкладку Terraform и качаю оттуда файлы конфигурации Terraform и зеркала Terraform**

![изображение](https://github.com/user-attachments/assets/f80eb2f8-111b-4f93-ae71-dad4fba4ce9a)

**4.4. Иду в каталог с созданным проектом и раскидываю необходимые файлы**

![изображение](https://github.com/user-attachments/assets/c2321a7f-a3f1-43a6-ab6a-165697b957e7)

### 5. Выполняю инициализацию Terraform

![изображение](https://github.com/user-attachments/assets/4d416a38-75ac-4c1f-b2c0-6c9a24bdab14)

### 6. Создаю инфраструктуру под ВМ ([документация](https://cloud.vk.com/docs/tools-for-using-services/terraform/how-to-guides/iaas/create))

**6.1. Устанавливаю OpenStack по [документации](https://cloud.vk.com/docs/tools-for-using-services/cli/openstack-cli#154-tabpanel-1)**

Осознаю, что  с добавлением рапозитория не работает, поэтому иду в DNF.

![изображение](https://github.com/user-attachments/assets/93915199-fd3d-451d-93d1-5640b08794c3)


![изображение](https://github.com/user-attachments/assets/2bc24e84-69d1-4687-a0db-aa5f8afb11b3)


**6.2. Прохожу аутентификацию в проекте по [документации](https://cloud.vk.com/docs/tools-for-using-services/cli/openstack-cli#3_proydite_autentifikaciyu)**

**6.2.1 Иду в настройки проекта -> Доступ по API -> скачиваю сформированный VK Cloud файл *otus-test-openrc.sh***

**6.2.2. Выполняю экспорт переменных окружения**

![изображение](https://github.com/user-attachments/assets/2c656296-e8d9-4eee-9192-bf4e9a7112b0)


**6.2.3. Првоеряю версию OpenStack и делаю тестовый запрос**

![изображение](https://github.com/user-attachments/assets/7c177d71-7ca7-4086-aaec-7eb85a621842)


**6.2.4. Радуюсь**

**6.3. Предварительно выбрав то что мне нужно, задаю это в конфигурации с переменными**

![изображение](https://github.com/user-attachments/assets/3428eac8-1349-4a13-86d8-c28203a45217)


![изображение](https://github.com/user-attachments/assets/d19a7e6e-7a3b-4a6a-a80d-e1fdef85136f)


**6.3.1. Создаю ключевую пару**

![изображение](https://github.com/user-attachments/assets/a5f06914-593a-44e6-b7bd-fd8c526c111e)


![изображение](https://github.com/user-attachments/assets/4e4e97cd-ade0-4c4d-9e40-bceb7442e3a1)


В этом файле объявляются следующие переменные:

- **image_name**: имя образа виртуальной машины;
- **compute_flavor**: имя шаблона конфигурации виртуальной машины;
- **key_pair_name**: имя ключевой пары, которая будет использоваться для подключения к виртуальной машине по SSH;
- **availability_zone_name**: имя зоны доступности, где будет размещена виртуальная машина.

**6.4. Задаю пароль в ранее скачанном файле vkcs_provider.tf**

![изображение](https://github.com/user-attachments/assets/cef52fa7-c6ff-403e-a032-edfc6507ce1f)


**6.5. Проверяю лимиты не ресурсы**

![изображение](https://github.com/user-attachments/assets/f7b8800c-5eb7-40ce-9982-c303f2da85e6)


**6.6. Создаю сетевую инфраструктуру по [документации](https://cloud.vk.com/docs/tools-for-using-services/terraform/how-to-guides/vnet/network#2233-tabpanel-1)**

![изображение](https://github.com/user-attachments/assets/c0b92f7f-b2f5-4324-8fab-05807b04d367)


**6.6.1. Проверяю корректность конфигурационных файлов**

Судя по выводу, все прошло успешно.

![изображение](https://github.com/user-attachments/assets/7ead36c3-3fd7-4b22-aaa6-03dbfa9dee1b)


**6.6.2. Пробую применить созданную конфигурацию**

![изображение](https://github.com/user-attachments/assets/8baf78f6-7163-49f9-8874-bb1c8c0fb3b1)


![изображение](https://github.com/user-attachments/assets/63f72bd1-1243-4e0b-86ee-5c4fa76d8b22)


В интерфейсе нашел созданные сети, отлично!

![изображение](https://github.com/user-attachments/assets/edd1b249-8e04-4911-8220-432c16afd18c)


**6.7. Создаю файл с описанием ВМ**

![изображение](https://github.com/user-attachments/assets/9a192201-e77a-4498-b24d-f5268a96febf)


**6.8. Создаю ресурсы с помощью Terraform**

**6.8.1. Проверяю наличие необходимых для инфраструктуры файлов**

**6.8.2. Инициализирую ресурсы. Успешно!**

**6.8.3. Применяю ресурсы**

![изображение](https://github.com/user-attachments/assets/c2cf1340-c0ab-4574-8ba2-398b7d0b713b)


**И... Terraform ругается на неописанные ресурсы.**

**Разбор исключений и их исправления опишу далее**

### 7. Исправляю исключения

![изображение](https://github.com/user-attachments/assets/4c1d35bf-968e-47b6-9345-4eb3d624ba13)

**7.1. Исключение выше попробовал исправить, изменив все вхождения *vkcs_networking_network.network* на *vkcs_networking_network.example***

![изображение](https://github.com/user-attachments/assets/82cf21d9-964c-40a0-af57-cf456d2a92bb)


**7.2. Словил еще одно исключение, кажется связано с группой безопасности**

![изображение](https://github.com/user-attachments/assets/9748ab60-f2f4-42a9-bb17-cc19f82f9b7f)

**Для его решения:**

**7.2.1. Создал файл *secgroup.tf* с группой безопасности (лишним не будет)**  

**7.2.2. Изменил в *main.tf* значение переменной *security_group* с *\["default","ssh"\]***  

**7.2.3. На *\["default"\]* (и это будет моей ошибкой)**

![изображение](https://github.com/user-attachments/assets/e93598fe-2d83-466d-8620-8b087b6e4e06)

**7.3. И еще одно исключение. На этот раз, полагаю, из-за размера блочного устройства**

**7.3.1. Изменил в *main.tf* значение переменной *volume_size* с 8 до 25 (судя по ошибке, значение указывается в ГБ)**

![изображение](https://github.com/user-attachments/assets/b2a7ac1b-69f3-40b4-85a1-db6a4d2d3a12)

**7.4. Повторная попытка запуска**

**После исправления пробую запусктить *terraform apply* снова.**

**Создается уже 2 минуты...**

![изображение](https://github.com/user-attachments/assets/68822f72-623a-4ddc-a5a6-4f1385ee5ec0)


**3 с половиной минуты... начинаю волноваться, что соединение отвалится по таймауту...**

![изображение](https://github.com/user-attachments/assets/bcdac6de-4daa-4d09-aa0f-bd692a20e268)


**Но нет, все круто!**

![изображение](https://github.com/user-attachments/assets/690444b4-9c22-4b70-99dc-ae205ff8d6af)


**Даже в GUI есть:**

![изображение](https://github.com/user-attachments/assets/700ca35d-e1bd-4d99-9cec-564d344b65be)


**Но теперь новая проблема, нет сетевого доступа:**

![изображение](https://github.com/user-attachments/assets/ab0b8bd0-3ece-4212-addc-e9279aee745c)


**По настройкам будто бы так и должно быть...**

![изображение](https://github.com/user-attachments/assets/df67d34b-0410-48b9-9798-6aae8b1903e8)

**После изучения задачи, понимаю, что моя ошибка была на шаге 7.2.3. Иду исправлять**

**7.4.1. Меняю имя группы безопасности в *secgroup.tf***

**7.4.2. Прописываю его в список групп безопасности *main.tf***

**7.4.3. Получаю внешний IP еще раз и пробую зайти**

![изображение](https://github.com/user-attachments/assets/02194cc0-1903-4117-b7c0-2aab1c97a22c)


**Каеф!**
* * *
## Выполняю деплой ВМ с помощью GUI в Sber и Yandex Cloud
* * *
## Sber Cloud

### 8. Создаю ВМ

**8.1. Иду в консоль и нажимаю *Создать ресурс***

**8.2. *Виртуальная машина***

![изображение](https://github.com/user-attachments/assets/03a38590-79b9-48c8-a938-9a8cbf36e97b)


**8.3. Задаю в полях аналогичные VK Cloud настройки и жму *Продолжить***

**8.4. В процессе понимаю, что необходимо создать объект *Публичный ключ***

![изображение](https://github.com/user-attachments/assets/1b9a9eb5-8a2b-46c5-8651-a412a90a6362)


**8.5. После указания нужных мне, например как *Публичный IP* полей жму *Создать***

**8.6. Наблюдаю, что ВМ создается**

![изображение](https://github.com/user-attachments/assets/0d75dfce-82c9-4c98-bf2d-d557f1883a8e)


### 9. Пробую подключиться

**9.1. Снова сетевая недоступность** 

![изображение](https://github.com/user-attachments/assets/e8287619-6595-4e6e-9380-68b8536b7856)


Но на этот раз есть некая группа безопасности по умолчанию, разрешающая SSH. Выглядит еще интереснее чем с VK Cloud...

![изображение](https://github.com/user-attachments/assets/b94f476c-4842-4e0d-a479-783443175fc3)

**Итог:** после обращения в поддержку и перезапуска ВМ, проблема решилась

**9.2. Дополнительно создал группу для доступа к PG извне**

**9.2.1 Иду в *Виртуальные машины* -> *otus-test-vm* -> листаю в самый низ -> в разделе *Интерфейсы* кликаю на "*...*" -> *Изменить группы безопасности* -> *Создать группу***

**9.2.2. Задаю правила:**

![изображение](https://github.com/user-attachments/assets/6ed752a3-2d98-4bf4-8fab-c5ffd26fa070)


**9.2.3. Выбираю новое правило в *Редактирование групп безопасности* и жму *Сохранить***

![изображение](https://github.com/user-attachments/assets/8b34b113-5112-46b0-b90e-ac627953fe00)

* * *
## Yandex Cloud

### 10. Создаю ВМ

**10.1. Иду в консоль и нажимаю *Создать ресурс***

**10.2. *Виртуальная машина***

![изображение](https://github.com/user-attachments/assets/361eb845-7c31-4bbc-9035-8d6349de56c6)


**10.3. Задаю в полях аналогичные VK и Sber Cloud настройки

**10.4. Создаю сеть**

![изображение](https://github.com/user-attachments/assets/d8537fb0-ad23-400a-9c06-1281abbce40f)


**10.5. Передаю SSH-ключ**

![изображение](https://github.com/user-attachments/assets/62d4aec3-d730-4be2-be55-67f97b70f654)


**10.6. И наконец, жму *Создать ВМ***

### 11. Пробую подключиться

![изображение](https://github.com/user-attachments/assets/a418f09f-21a6-42a6-a19f-a74e48cbdca1)

* * *
## Деплой PG на ВМ с помощью Ansible

### 12. Создаю каталог с Ansible-проектом и перехожу в него

![изображение](https://github.com/user-attachments/assets/f3e05002-7144-42b3-9c52-e422ec657060)


### 13. Устанавливаю Ansible

![изображение](https://github.com/user-attachments/assets/7cf66a1b-4931-42f2-926a-ba8db7f50357)


### 14. Создаю конфигурацию Ansible

**Из важного:**

**14.1. Расположение inventory и remote_tmp**

**14.2. Alias'ы хостов и данные для SSH-подключения**

**14.3. Используемые хосты и роли**

**14.4. Роль locale. Устанавливает RU-локаль по умолчанию**

**14.5. Роль postgres. Устанавливает Postgres, задает параметры в postgresql.conf, устанваливает расширение pg_stat_statements и в случае изменения параметров перезапускает/речитывает конфиг Postgres**

![изображение](https://github.com/user-attachments/assets/aa8b4dd1-7e76-461d-80db-375680fe62da)


### 15. Собираю хосты ВМ

**15.1. VK Cloud**

![изображение](https://github.com/user-attachments/assets/05602d8f-712a-4310-9fed-21cec3191ef7)


**15.2. Sber Cloud**

![изображение](https://github.com/user-attachments/assets/60c414b6-c7f5-4afb-b5c8-ba425b4c7cfc)


**15.3. Yandex Cloud**

![изображение](https://github.com/user-attachments/assets/2bea045d-9023-41e9-8c2c-7d4f1a8946a6)


**Итог:**

![изображение](https://github.com/user-attachments/assets/d04bf710-511a-4534-a4ca-32bdab7a780a)


### 16. Пробую выполнить Ansible Playbook

**16.1. И сразу же получаю исключение:**

![изображение](https://github.com/user-attachments/assets/9d6a2945-e409-4746-aa46-3a4d8fbfba9d)


**Нашел скрипт на GitHub, который должен был помочь, но тщетно:**

![9869c31fbe4f1df2598fe505fae57117.png](:/2c58178105b34b288d02c9b047f6b276)

**Решение:** Открываю соседнюю вкладку в Терминале, после этого playbook запускается (магия, не иначе)

![изображение](https://github.com/user-attachments/assets/81859fe8-4214-4cb4-8947-f5928fea38d0)


**\*Далее идет большой вывод\***

**16.2. Все отработало успешно, кроме Yandex Cloud**

![изображение](https://github.com/user-attachments/assets/1866c42f-ec49-431d-acb0-d68fb5693a73)

**Исключение:** ругается на отсутствие файла */etc/postgresql/15/main/postgresql.conf*

![изображение](https://github.com/user-attachments/assets/8eed1264-4118-4340-a053-abee4025d0ad)

Вижу, что кластер не запущен, и каталога */etc/postgresql/15* нет, а при попытке запустить его руками выдается ошибка локали:

![изображение](https://github.com/user-attachments/assets/23036e3f-7384-4532-bd11-257b501b7c3d)


**Решение, к сожалению, найти не удалось, вероятно стоит еще покрутить команды установки локали**

### 17. Выполняю попытки подключиться

Т.к. я ничего не задавал в *pg_hba.conf*, Postgres выдает мне соответствующие ошибки

![изображение](https://github.com/user-attachments/assets/c1e7c55c-d19b-40d7-b78c-66412d892dbf)

Но если зайти на серверы и попробовать подключиться:

**17.1. Sber Cloud**

![изображение](https://github.com/user-attachments/assets/4fc372f4-6c2a-493f-8eab-3b8d23397fdc)

**17.2. VK Cloud**

![изображение](https://github.com/user-attachments/assets/65ab392d-e016-4c48-a5f8-10ac94f22383)


***

**Спасибо за внимание, на сегодня**

![изображение](https://github.com/rus-99-pk/otus_edu/assets/93255418/a78e5138-f364-4321-96bf-0ba2d27e3279)
