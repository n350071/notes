# migrationがおかしい件

```rb
class RemoveReferencesFromManageProgramDirectCosts < ActiveRecord::Migration[7.0]
  def change
    # ProgramDirectCostから、Manage::Employee への参照を削除する
    # remove_reference :manage_program_direct_costs,          :employee, null: false, foreign_key: { to_table: :manage_employees }, index: { name: "index_manage_program_direct_costs_on_employee_id" }
    # remove_reference :manage_snapshot_program_direct_costs, :employee, null: false, foreign_key: { to_table: :manage_employees }, index: { name: "index_manage_snapshot_program_direct_costs_on_employee_id" }
  end
end
```

## エラー
```sh
Caused by:
Mysql2::Error: Cannot add or update a child row:
a foreign key constraint fails (`
    lbe_development`.`#sql-1_231`,
    CONSTRAINT `fk_rails_c9f666cc21` FOREIGN KEY (`employee_id`) REFERENCES `manage_employees` (`id`)
)
```

## migrate時
```sql
ALTER TABLE `manage_program_direct_costs`
DROP FOREIGN KEY `fk_rails_<自動生成されたキーの識別子>`;

ALTER TABLE `manage_program_direct_costs`
DROP INDEX `index_manage_program_direct_costs_on_employee_id`;

ALTER TABLE `manage_program_direct_costs`
DROP COLUMN `employee_id`;
```


## db:rollback;
```sql
ALTER TABLE `manage_program_direct_costs`
ADD COLUMN `employee_id` bigint;

ALTER TABLE `manage_program_direct_costs`
ADD INDEX `index_manage_program_direct_costs_on_employee_id` (`employee_id`);

ALTER TABLE `manage_program_direct_costs`
ADD CONSTRAINT `fk_rails_<自動生成されたキーの識別子>`
FOREIGN KEY (`employee_id`)
REFERENCES `manage_employees` (`id`);
```



--------

## 仕切り直し
エラー内容
Mysql2::Error: Cannot add or update a child row: a foreign key constraint fails (↓)
```
(
  `lbe_development`.`#sql-1_268`,
  CONSTRAINT `fk_rails_ffd7eceb7d`
  FOREIGN KEY (`employee_id`)
  REFERENCES `manage_employees` (`id`)
)
(
  `lbe_development`.`#sql-1_25f`,
  CONSTRAINT `fk_rails_c9f666cc21`
  FOREIGN KEY (`employee_id`)
  REFERENCES `manage_snapshot_employees` (`id`)
)
```

```sql
select * from schema_migrations order by version desc limit 1;

desc manage_program_direct_costs;
desc manage_snapshot_program_direct_costs;

alter table manage_program_direct_costs          drop column employee_id;
alter table manage_snapshot_program_direct_costs drop column employee_id;

show index from manage_program_direct_costs;
show index from manage_snapshot_program_direct_costs;

-- index削除
-- alter table manage_program_direct_costs          drop index index_manage_program_direct_costs_on_employee_id;
-- alter table manage_snapshot_program_direct_costs drop index index_manage_snapshot_program_direct_costs_on_employee_id;
```

## FKを確認する
```sql
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME,
    CONSTRAINT_SCHEMA
FROM
    information_schema.KEY_COLUMN_USAGE
WHERE
    CONSTRAINT_NAME LIKE 'fk_rails_%' AND
    REFERENCED_TABLE_NAME IS NOT NULL AND
    (TABLE_NAME  LIKE '%program_employees%' OR TABLE_NAME  LIKE '%program_direct_costs%' ) AND
    COLUMN_NAME LIKE '%employee%';
ORDER BY
    CONSTRAINT_SCHEMA, TABLE_NAME, COLUMN_NAME;
```
+-----------------------------------+-------------+---------------------+---------------------------+------------------------+-------------------+
| TABLE_NAME                        | COLUMN_NAME | CONSTRAINT_NAME     | REFERENCED_TABLE_NAME     | REFERENCED_COLUMN_NAME | CONSTRAINT_SCHEMA |
+-----------------------------------+-------------+---------------------+---------------------------+------------------------+-------------------+
| manage_program_employees          | employee_id | fk_rails_213bf79e46 | manage_employees          | id                     | lbe_development   |
| manage_snapshot_program_employees | employee_id | fk_rails_227c3fb505 | manage_snapshot_employees | id                     | lbe_development   |
| manage_program_employees          | employee_id | fk_rails_008c888bf5 | manage_employees          | id                     | lbe_test          |
| manage_snapshot_program_employees | employee_id | fk_rails_77f26c7e7a | manage_snapshot_employees | id                     | lbe_test          |
+-----------------------------------+-------------+---------------------+---------------------------+------------------------+-------------------+
| RAILS_ENV=test bin/rollback;
+--------------------------------------+-------------+---------------------+---------------------------+------------------------+-------------------+
| manage_snapshot_program_direct_costs | employee_id | fk_rails_c9f666cc21 | manage_snapshot_employees | id                     | lbe_test          |
| manage_program_direct_costs          | employee_id | fk_rails_ffd7eceb7d | manage_employees          | id                     | lbe_test          |
+--------------------------------------+-------------+---------------------+---------------------------+------------------------+-------------------+
| bin/rollback;

(
  `lbe_development`.`#sql-1_268`,
  CONSTRAINT `fk_rails_ffd7eceb7d`
  FOREIGN KEY (`employee_id`)
  REFERENCES `manage_employees` (`id`)
)
(
  `lbe_development`.`#sql-1_25f`,
  CONSTRAINT `fk_rails_c9f666cc21`
  FOREIGN KEY (`employee_id`)
  REFERENCES `manage_snapshot_employees` (`id`)
)



```sh
mysqldump -h localhost -u root -proot development --no-create-info --ignore-table=development.ar_internal_metadata --ignore-table=development.schema_migrations > tmp/development_20231117.dump.sql
```


---
title: 🐳 Login to MySQL on Docker and run a SQL file
tags: docker
published: true
---

## 🤔Situation
You maintain an app with MySQL and develop it on Docker. You have a dump file as .sql. Then, you want to run it.

## 👌Procedure
### 1. copy the SQL file into the Docker container
```sh
$ docker cp hoge.sql [cotaier-id]:/hoge.sql
```

### 2. Login to Docker
```shell
$ docker ps
$ docker exec -it [container-id] /bin/bash
```

### 3. Login to MySQL
```shell
$ mysql -u root -p
$ show databases;
$ use [your_database_name];
$ show tables;
```

💡hint: if you use a rails app, the password and connection informations should be defined at `config/database.yml`. Perhaps, it is actually written in `.env` file.


### 4. Run the SQL file
```shell
$ source hoge.sql
```
---

## Parent Note
{% link n350071/my-docker-note-3d0m %}
