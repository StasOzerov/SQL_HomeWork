
-- ДЗ к 9-му уроку по SQL


-- Тема: ---------------------------------------------------------------
-- Транзакции, переменные, представления

-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
--    Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

SELECT * FROM shop.users;
SELECT * FROM sample.users;

START TRANSACTION;
	INSERT INTO sample.users 
	SELECT * 
	  FROM shop.users 
	 WHERE id = 1;
	
	DELETE FROM shop.users
	 WHERE id = 1;
COMMIT;


-- 2. Создайте представление, которое выводит название name товарной позиции 
--    из таблицы products и соответствующее название каталога name из таблицы catalogs.

CREATE OR REPLACE VIEW product_catalogs AS
SELECT p.name AS product, c.name AS catalog
  FROM products AS p, 
  JOIN catalogs AS c
    ON p.catalog_id = c.id;
	
	
-- 3. Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные
--    записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
--    Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле 
--    значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.

DELETE posts
  FROM posts
  JOIN (SELECT created_at 
          FROM posts 
		 ORDER BY created_at DESC LIMIT 5, 1) AS del
		    ON posts.created_at = del.created_at;

			
-- Тема: ---------------------------------------------------------------			
-- Хранимые процедуры, функции, триггеры

-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от
--    текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
--    с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — 
--    "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DELIMITER //
CREATE FUNCTION hello()
RETURNS TINYTEXT NO SQL
BEGIN
	DECLARE hour INT;
	SET hour = HOUR(NOW());
	CASE
		WHEN hour BETWEEN 0  AND 5  THEN RETURN 'Доброй ночи';
		WHEN hour BETWEEN 6  AND 11 THEN RETURN 'Доброе утро';
		WHEN hour BETWEEN 12 AND 17 THEN RETURN 'Добрый день';
		WHEN hour BETWEEN 18 AND 23 THEN RETURN 'Добрый вечер';
	END CASE;
END//


-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его
--    описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля 
--    принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, 
--    чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям 
--    NULL-значение необходимо отменить операцию.

DELIMITER //
CREATE TRIGGER valid BEFORE INSERT ON products
FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'name and description are NULL';
	END IF;
END//

DELIMITER //
CREATE TRIGGER valid BEFORE UPDATE ON products
FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'name and description are NULL';
	END IF;
END//


