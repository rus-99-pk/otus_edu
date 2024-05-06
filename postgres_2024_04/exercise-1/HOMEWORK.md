# SQL и реляционные СУБД. PostgreSQL в облаках 
### **1. Создал проект и виртуальную машину в платформе Яндекс.Облако**
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/a426c6fc-6019-4426-bbc3-930378687c7b)
### **2. В процессе создания ВМ дал имя начальному пользователю - otus и добавил публичный SSH-ключ, т.к. счел данный вариант более простым и быстрым (SSH-ключ ранее уже был сформирован)**
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/6e7ed285-f063-462d-b516-fcbae5f2f37c)
### **3. Вошел под описанными данными по SSH**
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/0aa666ba-585f-48e3-afad-d3edca5b0265)
### **4. Установил Postgres с помощью скрипта из [документации](https://www.postgresql.org/download/linux/ubuntu/)**
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/70d4f378-1b6f-4ddd-a44e-8c65734cdd43)
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/6ae30751-e5c9-42fa-9f97-4fec884e98ba)
###  5. Подключился через консоль psql и изменил параметр *listen_addresses* командой *ALTER SYSTEM SET*
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/331a0417-fefa-4be4-9f38-1c83d056a460)
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/6a8d5e14-e3ac-4cc5-825d-b4223505fc3c)
Выбрал такой вариант, т.к. в видеоуроке объяснили, что лучше не менять параметр в конфиге, а писать внизу, но внизу написано, что нужно указывать параметры для расширений:
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/fe273036-958a-417d-bbc5-57cb66b9297b)
***Прошу дать комментарий, насколько правильно так делать.***
###  6. Добавил в */etc/postgresql/16/main/pg_hba.conf* необходимое значение и перезапустил кластер Postgres
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/76fdabcd-b7dc-4cc4-b22f-eac9163e2119)
###  7. Открыл две сессии *psql* и выключил в них *autocommit*
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/f807f4c6-b22a-4cab-988b-c2573c568966)
###  8. Создал таблицу *persons* и заполнил ее данными в первой сессии
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/b79a80d2-ddce-4e92-806e-87915f69c36e)
###  9. Посмотрел текущий уровень изоляции
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/ae69e10a-915e-4bb4-b889-cdac3c71b65e)
###  10. Добавил в первой сессии новую запись в таблицу, во второй выполил *SELECT*
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/9ea46d1e-ee1b-4273-87f0-b5c43caa2f4e)
Во второй не появилось записи, потому что для применения изменения необходимо выполнить COMMIT в первой сессии, чтобы зафиксировать изменения, либо пока мы ее либо не отменим командой ROLLBACK. В ином случае транзакция будет "висеть".
### 11. Выполнил команду *COMMIT* чтобы зафиксировать изменения
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/c36b949c-34a5-4aa8-8c98-61c1e5cc98b7)
Теперь во второй сессии есть изменения, магия :)
### 12. Завершил транзакцию во второй сессии командой *COMMIT*
### 13. Изменил уровень изоляции обеих сессий
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/1eadf3f9-f017-4dc9-9b24-7868756e049e)
### 14. Добавил в первой сессии новую запись и выполнил *SELECT* во второй
Изменений не вижу, т.к. по описанным ранее причинам не выполнен COMMIT в первой сессии
### 15. Выполнил *COMMIT* в первой сессии и выполнил еще раз *SELECT* во второй
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/9cdc56ab-b631-43e5-bd26-9dccaf58530d)
Новой записи нет... Сначала не понял...
### 16. Выполнил *COMMIT* во второй сессии и выполнил еще раз *SELECT* в ней же
![image](https://github.com/rus-99-pk/otus_edu/assets/93255418/cfe0aa00-1786-4090-b7a3-830ffed81e8a)
Увидел изменения, а потом как понял :D

В уровне изоляции **repeatable read** необходимо завершить обе транзакции, чтобы увидеть обновленные данные во второй сессии.
