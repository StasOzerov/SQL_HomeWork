
-- ------------------------------------------------------------------------------------------------  
-- HOMEWORK
-- ------------------------------------------------------------------------------------------------

/*
Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

Выведите список товаров products и разделов catalogs, который соответствует товару.

Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
Поля from, to и label содержат английские названия городов, поле name — русское. 
Выведите список рейсов flights с русскими названиями городов.
*/


-- предварительно были созданы и наполнены следующие таблицы из прилагаемого файла shop.sql:
-- catalogs, products, users.
-- также были созданы таблицы orders, orders_products из прилагаемого файла shop.sql
 
 
-- далее заполняем таблицы orders, orders_products
INSERT INTO orders(user_id) 
VALUES            (1), (5), (4), (1);
SELECT * FROM orders;

INSERT INTO orders_products
            (order_id, product_id, total)
VALUES      (       1,          7,     1),
            (       5,          2,     3),
            (       4,          3,     2),
            (       1,          1,     2);
SELECT * FROM orders_products;


-- ------------------------------------------------------------------------ 
-- запрос для первого задания
SELECT        * 
FROM          users
WHERE EXISTS (SELECT * 
              FROM orders 
              WHERE user_id = users.id);


-- ------------------------------------------------------------------------             
-- запрос для второго задания
SELECT p.name       , c.name       , op.order_id, op.total
FROM   products AS p, catalogs AS c, orders_products AS op
WHERE  op.product_id = p.id 
  AND  p.catalog_id  = c.id;


-- ------------------------------------------------------------------------  
-- подготовка к третьему заданию 
-- создаем и заполняем таблицы flights, cities
CREATE TABLE flights(
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(100),
  `to` VARCHAR(100));

INSERT INTO flights
            (`from`    , `to`     )
VALUES      ('moscow'  , 'omsk'   ),
            ('novgorod', 'kazan'  ),
            ('irkutsk' , 'moscow' ),
            ('omsk'    , 'irkutsk'),
            ('moscow'  , 'kazan'  );
SELECT * FROM flights;


CREATE TABLE cities(
  label VARCHAR(100),
  name VARCHAR(100));

INSERT INTO cities 
            (label     , name      )
VALUES      ('moscow'  , 'Москва'  ),
            ('irkutsk' , 'Иркутск' ),
            ('novgorod', 'Новгород'),
            ('kazan'   , 'Казань'  ),
            ('omsk'    , 'Омск'    );
SELECT * FROM cities;

-- запрос с выводом рейсов на английском и русском
SELECT f.id, f.`from`, f.`to`, c_from.name, c_to.name
FROM flights AS f, cities AS c_from, cities AS c_to
WHERE f.`from` = c_from.label AND f.`to` = c_to.label
ORDER BY f.id;
 
-- запрос с выводом рейсов только на русском
SELECT f.id, c_from.name, c_to.name
FROM flights AS f, cities AS c_from, cities AS c_to
WHERE f.`from` = c_from.label AND f.`to` = c_to.label
ORDER BY f.id;
 
 
 