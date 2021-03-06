## Модуль 2

:arrow_left: [К модулям](https://github.com/RaM0x1010/DE-101)

  ## 2.3 Подключение к Базам Данных и SQL
  ### Краткое описание задачи:
  *Создать таблицу базы данных в PostgreSQL на основе структуры файла Sample.xls. Загрузить данные из файла Sample.xls и выполнить запросы из "Модуль 1"*.
  - [Creating_tables_for_Superstore.sql](https://github.com/RaM0x1010/DE-101/blob/master/Module2/2.3/Creating_tables_for_Superstore.sql) - создаем таблицы в соответвествии со структурой файла Sample.xls;
  - [Questions_from_module_1.sql](https://github.com/RaM0x1010/DE-101/blob/master/Module2/2.3/Questions_from_module_1.sql) - шаблоны метрик из "Модуль 1";
  - [Extract_and_upload_Superstore_xls_data.py](https://github.com/RaM0x1010/DE-101/blob/master/Module2/2.3/Extract_and_upload_Superstore_xls_data.py) - скрипт для обработки данных из Sample.xls и загрузки их в таблицы базы данных.

  ## 2.4 Модели Данных
  ### Краткое описание задачи:
  *Создать концептуальную, логическую и физическую модель данных проекта. С помощью редактора sqlDBM сгенерировать шаблон и выполнить в PostgreSQL, чтобы создать БД на оснвое Dimensional Model. После создания БД, загрузить данные посредством*</br> <code>INSERT INTO SELECT</code> *запроса*.
  - [Conceptual_model.jpg](https://github.com/RaM0x1010/DE-101/blob/master/Module2/2.4/Conceptual_model.jpg) - концептуальная модель;
  - [Logical_model.jpg](https://github.com/RaM0x1010/DE-101/blob/master/Module2/2.4/Logical_model.jpg) - логическая модель;
  - [Physics_model.jpg](https://github.com/RaM0x1010/DE-101/blob/master/Module2/2.4/Physics_model.jpg) - физическая модель;
  - [Create_Supersotre_DM_sqlDBM.sql](https://github.com/RaM0x1010/DE-101/blob/master/Module2/2.4/Create_Supersotre_DM_sqlDBM.sql) - шаблон создания базы и таблиц из редактора sqlDBM.com;
  - [Upload_data_to_DM_tables_by_select.sql](https://github.com/RaM0x1010/DE-101/blob/master/Module2/2.4/Upload_data_to_DM_tables_by_select.sql) - заполнение данных через SELECT в таблицы измерений базы данных.

  ## 2.5 База данных в облаке
  ### Краткое описание задачи:
  *Загрузить данные из задания 2.3 в Staging(схема stg) и загрузка Dimensional Model из stg с помощью SELECT(схема dwh)*.
  - [Create_tables_Superstore_aws.sql](https://github.com/RaM0x1010/DE-101/blob/master/Module2/2.5/Create_tables_Superstore_aws.sql) - создание таблицы фактов и таблицы измерений со схемами stg(Staging) и dwh(DataWarehouse) в Amazon RDS;
  - [Upload_data_to_dwh_by_select_aws.sql](https://github.com/RaM0x1010/DE-101/blob/master/Module2/2.5/Upload_data_to_dwh_by_select_aws.sql) - загрузка данных через SELECT в таблицы измерений(схема dwh).
	
  ## 2.6 Как донести данные до бизнес-пользователя
  ### Краткое описание задачи:
  Создать дашборд одним из рассмотренных способов "Google Data Studio", "AWS QuickSight", "Klipfolio". В данном случае "Google Data Studio".
  - [SuperStore Dashboard](https://datastudio.google.com/s/gXbOBxlK4DQ) - дашборд с данными из Amazon RDS.
	
	
## Концептуальная модель
![Conceptual model](https://github.com/RaM0x1010/DE-101/blob/master/Module2/2.4/Conceptual_model.jpg)
## Логическая модель
![Logical model](https://github.com/RaM0x1010/DE-101/blob/master/Module2/2.4/Logical_model.jpg)
## Физическая модель
![Physics model](https://github.com/RaM0x1010/DE-101/blob/master/Module2/2.4/Physics_model.jpg)
## Дашборд
![Dashboard](https://github.com/RaM0x1010/DE-101/blob/master/Module2/2.6/SuperStore_Dashboard.jpg)