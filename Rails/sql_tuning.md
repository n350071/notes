# performance tuning

## Bad, Anti pattern
No index, Full scan. This cause slow process, and high cpu usage of MySQL.
**1382.4ms** is needed for a query result.

```
> Model.where(attibute: 'hoge').explain
 Model Load (1364.2ms)  SELECT `models`.* FROM `models` WHERE `models`.`attibute` = 'hoge'
=> EXPLAIN for: SELECT `models`.* FROM `models` WHERE `models`.`attibute` = 'hoge'
+----+-------------+--------+------+---------------+------+---------+------+---------+-------------+
| id | select_type | table  | type | possible_keys | key  | key_len | ref  | rows    | Extra       |
+----+-------------+--------+------+---------------+------+---------+------+---------+-------------+
|  1 | SIMPLE      | models | ALL  | NULL          | NULL | NULL    | NULL | 1739502 | Using where |
+----+-------------+--------+------+---------------+------+---------+------+---------+-------------+

> Model.where(attribue: 'hoge').first
  Model Load (1382.4ms)  SELECT  `models`.* FROM `models` WHERE `models`.`attribue` = 'hoge' ORDER BY `models`.`id` ASC LIMIT 1
```

## Treatment
```
class AddIndexToModel < ActiveRecord::Migration[5.0]
  def change
    add_index :models, :attibute, name: :attibute_index_on_models
  end
end
```

```
== 20180913000000 AddIndexToModel: migrating ==================================
-- add_index(:models, :attibute, {:name=>:attibute_index_on_models})
   -> 6.1234s
== 20180913000000 AddIndexToModel: migrated (6.3081s) =========================
```

## Result

2.6ms is needed for a query result.
**531.7 times faster** than the past one.

```
> Model.where(attibute: 'hoge').explain
  Model Load (0.4ms)  SELECT `models`.* FROM `models` WHERE `models`.`attibute` = 'hoge'
=> "EXPLAIN for: SELECT `models`.* FROM `models` WHERE `models`.`attibute` = 'hoge'\n" +
"+----+-------------+--------+------------+------+--------------------------+-------------------------+---------+-------+------+----------+-------+\n" +
"| id | select_type | table  | partitions | type | possible_keys            | key                     | key_len | ref   | rows | filtered | Extra |\n" +
"+----+-------------+--------+------------+------+--------------------------+-------------------------+---------+-------+------+----------+-------+\n" +
"|  1 | SIMPLE      | models | NULL       | ref  | attibute_index_on_models | attibute_index_on_models| 768     | const |    1 |    100.0 | NULL  |\n" +
"+----+-------------+--------+------------+------+--------------------------+-------------------------+---------+-------+------+----------+-------+\n" +
"1 row in set (0.00 sec)\n"

> Model.where(attribue: 'hoge')
  Model Load (2.6ms)  SELECT  `models`.* FROM `models` WHERE `models`.`attribue` = 'hoge' ORDER BY `models`.`id` ASC LIMIT 1
```
