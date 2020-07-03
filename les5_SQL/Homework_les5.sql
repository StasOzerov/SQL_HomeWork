
---------------------------------------------------------------------------------------------------------
-- Операторы, фильтрация, сортировка и ограничение
---------------------------------------------------------------------------------------------------------

-- task 1
/* Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
   Заполните их текущими датой и временем. */

update users set created_at = now(), updated_at = now();
select * from users;


-- task2
/* Таблица users была неудачно спроектирована. 
   Записи created_at и updated_at были заданы типом VARCHAR 
   и в них долгое время помещались значения в формате 20.10.2017 8:10. 
   Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения. */

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
  ) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', DATE_FORMAT(NOW(), '%d.%m.%Y %h:%m'), DATE_FORMAT(NOW(), '%d.%m.%Y %h:%m')),
  ('Наталья', '1984-11-12',  DATE_FORMAT(NOW(), '%d.%m.%Y %h:%m'), DATE_FORMAT(NOW(), '%d.%m.%Y %h:%m')),
  ('Александр', '1985-05-20', DATE_FORMAT(NOW(), '%d.%m.%Y %h:%m'), DATE_FORMAT(NOW(), '%d.%m.%Y %h:%m')),
  ('Сергей', '1988-02-14', DATE_FORMAT(NOW(), '%d.%m.%Y %h:%m'), DATE_FORMAT(NOW(), '%d.%m.%Y %h:%m')),
  ('Иван', '1998-01-12', DATE_FORMAT(NOW(), '%d.%m.%Y %h:%m'), DATE_FORMAT(NOW(), '%d.%m.%Y %h:%m')),
  ('Мария', '1992-08-29', DATE_FORMAT(NOW(), '%d.%m.%Y %h:%m'), DATE_FORMAT(NOW(), '%d.%m.%Y %h:%m'));

CREATE TEMPORARY TABLE created_updated(
   created_at VARCHAR(255),
   updated_at VARCHAR(255)
);
INSERT INTO created_updated(created_at, updated_at) SELECT created_at, updated_at FROM users;
UPDATE users SET created_at = NULL, updated_at = NULL;
ALTER TABLE users MODIFY created_at DATETIME;
ALTER TABLE users MODIFY updated_at DATETIME;
-- дальше запутался. Наверное вообще не туда забрёл. 


-- task3
/* В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, 
   если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
   чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, 
   после всех записей. */

SELECT * FROM storehouses_products WHERE value > 0 ORDER BY value;
SELECT * FROM storehouses_products ORDER BY value DESC;
-- сделал не до конца, но думал до последнего


-- task4
/* Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
   Месяцы заданы в виде списка английских названий (may, august). */

create temporary table users (
name varchar(250),
birthday_month varchar(250)
);
insert into users values
('Вася', 'august'),
('Лена', 'july'),
('Катя', 'august'),
('Стас', 'may'),
('Олег', 'april'),
('Павел', 'may'),
('Игорь', 'august'),
('Семён', 'may');

select group_concat(name), birthday_month
    from users 
	where birthday_month in ('may', 'august') 
	group by birthday_month; 

	
-- task5
/* Из таблицы catalogs извлекаются записи при помощи запроса 
   SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
   Отсортируйте записи в порядке, заданном в списке IN. */

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);



---------------------------------------------------------------------------------------------------------
-- Агрегация данных
---------------------------------------------------------------------------------------------------------

-- task1
/* Подсчитайте средний возраст пользователей в таблице users. */

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS avg_age FROM users;


-- task2
/* Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
   Следует учесть, что необходимы дни недели  текущего года, а не года рождения. */

-- к сожалению, не успеваю (   
  
  
-- task3   
/* Подсчитайте произведение чисел в столбце таблицы. */

CREATE TEMPORARY TABLE tab_values (value INT);
insert into tab_values values (1), (2), (3), (4), (5) ;
SELECT EXP(SUM(LOG(value))) FROM tab_values;






