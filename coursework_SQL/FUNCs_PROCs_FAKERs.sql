
SELECT rand_nums(1, 1000000);
SELECT rand_name_func(3, 10, 65); -- Ivan
SELECT rand_name_func(3, 10, 97); -- ivan
SELECT rand_content_date();
SELECT rand_birthday_date();
SELECT rand_phone();
SELECT rand_email();
SELECT rand_text(3, 10, 3, 10);
SELECT rand_media_type_id();

CALL users_faker(1000); -- !!! done
CALL profiles_faker(1000); -- !!! done
CALL childs_faker(200, 1, 1000); -- !!! done
CALL media_faker(20000); -- !!! done
CALL likes_faker(100000); -- !!! done
CALL downloads_faker(20000); -- !!! done
CALL browses_faker(20000); -- !!! done

SELECT * FROM users;
SELECT COUNT(*) FROM users;
SELECT * FROM profiles;
SELECT COUNT(*) FROM profiles;
SELECT * FROM childs ORDER BY user_id;
SELECT COUNT(*) FROM childs;
SELECT * FROM media;
SELECT COUNT(*) FROM media;
SELECT * FROM likes;
SELECT COUNT(*) FROM likes;
SELECT * FROM downloads;
SELECT COUNT(*) FROM downloads;
SELECT * FROM browses;
SELECT COUNT(*) FROM browses;



-- -------------------------------------------------------------------------
-- F U N C T I O N S -------------------------------------------------------
-- -------------------------------------------------------------------------

DROP FUNCTION IF EXISTS rand_nums;
DELIMITER //
CREATE FUNCTION rand_nums(low_num int, high_num int)
	RETURNS int 
	DETERMINISTIC
	BEGIN
		RETURN low_num + floor(rand() * (high_num - low_num + 1));
	END//


DROP FUNCTION IF EXISTS rand_name_func;
DELIMITER //
CREATE FUNCTION rand_name_func(min_num TINYINT, max_num TINYINT, ascii_A_or_a TINYINT) -- ascii_A_or_a = 65 or 97
    RETURNS VARCHAR(10)
	DETERMINISTIC
BEGIN 
    DECLARE num TINYINT;
	DECLARE name VARCHAR(10);
	
	SET num = floor(min_num + rand() * (max_num - min_num + 1));
	SET name = CASE num
    	WHEN '1'
        	THEN char(ascii_A_or_a + rand()*25 USING utf8)
    	WHEN '2' 
        	THEN char(ascii_A_or_a + rand()*25, 97+rand()*25 USING utf8)	   
    	WHEN '3' 
        	THEN char(ascii_A_or_a + rand()*25, 97+rand()*25, 97+rand()*25 USING utf8)
    	WHEN '4'
        	THEN char(ascii_A_or_a + rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25 USING utf8)
		WHEN '5'
	    	THEN char(ascii_A_or_a + rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25 USING utf8)
		WHEN '6'
	    	THEN char(ascii_A_or_a + rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25 USING utf8)
		WHEN '7'
	    	THEN char(ascii_A_or_a + rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25 USING utf8)
		WHEN '8'
	    	THEN char(ascii_A_or_a + rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25 USING utf8)
		WHEN '9'
	    	THEN char(ascii_A_or_a + rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25 USING utf8)	    	
		ELSE     
		         char(ascii_A_or_a + rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25, 97+rand()*25 USING utf8)
		END;
	
	RETURN name;
END//


DROP FUNCTION IF EXISTS rand_content_date;
DELIMITER //
CREATE FUNCTION rand_content_date()
	RETURNS datetime
	DETERMINISTIC
BEGIN 
	RETURN '2005-08-08 00:00:00' + interval round(rand()*60*60*24*365*15) second;
END//


DROP FUNCTION IF EXISTS rand_birthday_date;
DELIMITER //
CREATE FUNCTION rand_birthday_date()
	RETURNS datetime
	DETERMINISTIC
BEGIN 
	RETURN '1970-08-08 00:00:00' + interval round(rand()*60*60*24*365*35) second;
END//


DROP FUNCTION IF EXISTS rand_phone;
DELIMITER //
CREATE FUNCTION rand_phone()
	RETURNS char(14)
	DETERMINISTIC
BEGIN 
	RETURN concat('+', 7, '(', 9, floor(rand()*10), floor(rand()*10), ')', floor(rand()*10), floor(rand()*10), floor(rand()*10), floor(rand()*10), floor(rand()*10), floor(rand()*10), floor(rand()*10)); 
END//


DROP FUNCTION IF EXISTS rand_email;
DELIMITER //
CREATE FUNCTION rand_email()
	RETURNS varchar(50)
	DETERMINISTIC
BEGIN
	RETURN concat(rand_name_func(3, 10, 97), '@', rand_name_func(3, 10, 97), '.com');
END//


DROP FUNCTION IF EXISTS rand_text;
DELIMITER //
CREATE FUNCTION rand_text(min_words TINYINT, max_words TINYINT, min_num TINYINT, max_num TINYINT) -- ascii_A_or_a = 65 or 97
	RETURNS TINYTEXT
	DETERMINISTIC
BEGIN
    DECLARE words_num TINYINT;
	DECLARE words TINYTEXT;	
	
	SET words_num = floor(min_words + rand() * (max_words - min_words + 1));
	SET words = CASE words_num
    	WHEN '1'
        	THEN rand_name_func(min_num, max_num, 65)
    	WHEN '2' 
        	THEN concat(rand_name_func(min_num, max_num, 65), ' ',
        	            rand_name_func(min_num, max_num, 97)) 	   
    	WHEN '3' 
        	THEN concat(rand_name_func(min_num, max_num, 65), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97)) 
    	WHEN '4' 
        	THEN concat(rand_name_func(min_num, max_num, 65), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',        	            
        	            rand_name_func(min_num, max_num, 97)) 
    	WHEN '5' 
        	THEN concat(rand_name_func(min_num, max_num, 65), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',        	            
        	            rand_name_func(min_num, max_num, 97))
    	WHEN '6' 
        	THEN concat(rand_name_func(min_num, max_num, 65), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97))        	            
    	WHEN '7' 
        	THEN concat(rand_name_func(min_num, max_num, 65), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97))         	            
    	WHEN '8' 
        	THEN concat(rand_name_func(min_num, max_num, 65), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97))         	            
    	WHEN '9' 
        	THEN concat(rand_name_func(min_num, max_num, 65), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97), ' ',
        	            rand_name_func(min_num, max_num, 97))    
    	WHEN '10' 
        	THEN concat(rand_name_func(min_num, max_num, 65), ' ', -- 1
        	            rand_name_func(min_num, max_num, 97), ' ', -- 2
        	            rand_name_func(min_num, max_num, 97), ' ', -- 3
        	            rand_name_func(min_num, max_num, 97), ' ', -- 4
        	            rand_name_func(min_num, max_num, 97), ' ', -- 5
        	            rand_name_func(min_num, max_num, 97), ' ', -- 6
        	            rand_name_func(min_num, max_num, 97), ' ', -- 7
        	            rand_name_func(min_num, max_num, 97), ' ', -- 8
        	            rand_name_func(min_num, max_num, 97), ' ', -- 9
        	            rand_name_func(min_num, max_num, 97))      -- 10
    	WHEN '11' 
        	THEN concat(rand_name_func(min_num, max_num, 65), ' ', -- 1
        	            rand_name_func(min_num, max_num, 97), ' ', -- 2
        	            rand_name_func(min_num, max_num, 97), ' ', -- 3
        	            rand_name_func(min_num, max_num, 97), ' ', -- 4
        	            rand_name_func(min_num, max_num, 97), ' ', -- 5
        	            rand_name_func(min_num, max_num, 97), ' ', -- 6
        	            rand_name_func(min_num, max_num, 97), ' ', -- 7
        	            rand_name_func(min_num, max_num, 97), ' ', -- 8
        	            rand_name_func(min_num, max_num, 97), ' ', -- 9
        	            rand_name_func(min_num, max_num, 97), ' ', -- 10
        	            rand_name_func(min_num, max_num, 97))      -- 11       	            
    	WHEN '12' 
        	THEN concat(rand_name_func(min_num, max_num, 65), ' ', -- 1
        	            rand_name_func(min_num, max_num, 97), ' ', -- 2
        	            rand_name_func(min_num, max_num, 97), ' ', -- 3
        	            rand_name_func(min_num, max_num, 97), ' ', -- 4
        	            rand_name_func(min_num, max_num, 97), ' ', -- 5
        	            rand_name_func(min_num, max_num, 97), ' ', -- 6
        	            rand_name_func(min_num, max_num, 97), ' ', -- 7
        	            rand_name_func(min_num, max_num, 97), ' ', -- 8
        	            rand_name_func(min_num, max_num, 97), ' ', -- 9
        	            rand_name_func(min_num, max_num, 97), ' ', -- 10
        	            rand_name_func(min_num, max_num, 97), ' ', -- 11
        	            rand_name_func(min_num, max_num, 97))      -- 12         	  
     	WHEN '13' 
        	THEN concat(rand_name_func(min_num, max_num, 65), ' ', -- 1
        	            rand_name_func(min_num, max_num, 97), ' ', -- 2
        	            rand_name_func(min_num, max_num, 97), ' ', -- 3
        	            rand_name_func(min_num, max_num, 97), ' ', -- 4
        	            rand_name_func(min_num, max_num, 97), ' ', -- 5
        	            rand_name_func(min_num, max_num, 97), ' ', -- 6
        	            rand_name_func(min_num, max_num, 97), ' ', -- 7
        	            rand_name_func(min_num, max_num, 97), ' ', -- 8
        	            rand_name_func(min_num, max_num, 97), ' ', -- 9
        	            rand_name_func(min_num, max_num, 97), ' ', -- 10
        	            rand_name_func(min_num, max_num, 97), ' ', -- 11
        	            rand_name_func(min_num, max_num, 97), ' ', -- 12
        	            rand_name_func(min_num, max_num, 97))      -- 13       	            
     	WHEN '14' 
        	THEN concat(rand_name_func(min_num, max_num, 65), ' ', -- 1
        	            rand_name_func(min_num, max_num, 97), ' ', -- 2
        	            rand_name_func(min_num, max_num, 97), ' ', -- 3
        	            rand_name_func(min_num, max_num, 97), ' ', -- 4
        	            rand_name_func(min_num, max_num, 97), ' ', -- 5
        	            rand_name_func(min_num, max_num, 97), ' ', -- 6
        	            rand_name_func(min_num, max_num, 97), ' ', -- 7
        	            rand_name_func(min_num, max_num, 97), ' ', -- 8
        	            rand_name_func(min_num, max_num, 97), ' ', -- 9
        	            rand_name_func(min_num, max_num, 97), ' ', -- 10
        	            rand_name_func(min_num, max_num, 97), ' ', -- 11
        	            rand_name_func(min_num, max_num, 97), ' ', -- 12
        	            rand_name_func(min_num, max_num, 97), ' ', -- 13
        	            rand_name_func(min_num, max_num, 97))      -- 14         	            
      	ELSE 
        	     concat(rand_name_func(min_num, max_num, 65), ' ', -- 1
        	            rand_name_func(min_num, max_num, 97), ' ', -- 2
        	            rand_name_func(min_num, max_num, 97), ' ', -- 3
        	            rand_name_func(min_num, max_num, 97), ' ', -- 4
        	            rand_name_func(min_num, max_num, 97), ' ', -- 5
        	            rand_name_func(min_num, max_num, 97), ' ', -- 6
        	            rand_name_func(min_num, max_num, 97), ' ', -- 7
        	            rand_name_func(min_num, max_num, 97), ' ', -- 8
        	            rand_name_func(min_num, max_num, 97), ' ', -- 9
        	            rand_name_func(min_num, max_num, 97), ' ', -- 10
        	            rand_name_func(min_num, max_num, 97), ' ', -- 11
        	            rand_name_func(min_num, max_num, 97), ' ', -- 12
        	            rand_name_func(min_num, max_num, 97), ' ', -- 13
        	            rand_name_func(min_num, max_num, 97), ' ', -- 14
        	            rand_name_func(min_num, max_num, 97))      -- 15
        END;
	RETURN words;
END//


DROP FUNCTION IF EXISTS rand_media_type_id;
DELIMITER //
CREATE FUNCTION rand_media_type_id()
	RETURNS int(10)
	DETERMINISTIC
BEGIN
	DECLARE num TINYINT;
	DECLARE media_type_id int(10);

	SET num = CEILING(rand() * 4);
	SET media_type_id = CASE num
		WHEN '1' 
			THEN CEILING(rand() * 14)
		WHEN '2' 
			THEN CEILING(rand() * 34) + 100
		WHEN '3' 
			THEN CEILING(rand() * 4) + 200
		WHEN '4' 
			THEN CEILING(rand() * 9) + 300
		END;
	RETURN media_type_id;
END//


-- -------------------------------------------------------------------------
-- P R O C E D U R E S -----------------------------------------------------
-- -------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS users_faker;
DELIMITER //
CREATE PROCEDURE users_faker(n int)
BEGIN
	DECLARE i INT DEFAULT 1;
	
	WHILE i <= n DO
		INSERT INTO `users`
	   		       (`first_name`             , `last_name`              , `email`     , `phone`     , `created_at`       , `updated_at`       )
	        VALUES (rand_name_func(3, 10, 65), rand_name_func(3, 10, 65), rand_email(), rand_phone(), rand_content_date(), rand_content_date());
		SET i = i + 1;
	END WHILE;
	
	UPDATE `users`
	SET `updated_at` = timestampadd(SECOND, floor(rand() * timestampdiff(SECOND, created_at, now())), created_at) WHERE `updated_at` < `created_at`;
END//


DROP PROCEDURE IF EXISTS profiles_faker;
DELIMITER //
CREATE PROCEDURE profiles_faker(n int)
BEGIN
	DECLARE i INT DEFAULT 1;
	
	WHILE i <= n DO
		INSERT INTO `profiles`
	   		       (`user_id`, `is_male`    , `birthday`          , `country_id`, `region_id`, `city_id`            , `created_at`       , `updated_at`       )
	        VALUES ( i       , round(rand()), rand_birthday_date(),  0          ,  0         , CEILING(rand() * 172), rand_content_date(), rand_content_date());
		SET i = i + 1;
	END WHILE;
	
	UPDATE `profiles`
	SET `updated_at` = timestampadd(SECOND, floor(rand() * timestampdiff(SECOND, created_at, now())), created_at) WHERE `updated_at` < `created_at`;
END//


DROP PROCEDURE IF EXISTS childs_faker;
DELIMITER //
CREATE PROCEDURE childs_faker(n int, user_id_lowest int, user_id_highest int) -- user_id_lowest = 1, user_id_highest = 1000
BEGIN
	DECLARE i INT DEFAULT 1;
	
	WHILE i <= n DO
		INSERT INTO `childs`
	   		       (`user_id`                                  , `child_name`             , `created_at`       , `updated_at`       )
	        VALUES ( rand_nums(user_id_lowest, user_id_highest), rand_name_func(3, 10, 65), rand_content_date(), rand_content_date());
		SET i = i + 1;
	END WHILE;
	
	UPDATE `childs`
	SET `updated_at` = timestampadd(SECOND, floor(rand() * timestampdiff(SECOND, created_at, now())), created_at) WHERE `updated_at` < `created_at`;
END//


DROP PROCEDURE IF EXISTS media_faker;
DELIMITER //
CREATE PROCEDURE media_faker(n int)
BEGIN
	DECLARE i INT DEFAULT 1;

	WHILE i <= n DO
		INSERT INTO `media`
					(media_type_id       , filename                              , `size`                   , metadata                                         , created_at         )
			 VALUES (rand_media_type_id(), concat(rand_text(1, 3, 3, 10), '.avi'), round(rand() * 300 + 300), concat('{channel: ', rand_text(1, 3, 3, 10), '}'), rand_content_date());
		SET i = i + 1;
	END WHILE;
END//


DROP PROCEDURE IF EXISTS likes_faker;
DELIMITER //
CREATE PROCEDURE likes_faker(n int)
BEGIN
	DECLARE i int DEFAULT 1;
	
	WHILE i <= n DO
		INSERT INTO likes
					(user_id           , media_id           , dislike        , created_at         )
			 VALUES (rand_nums(1, 1000), rand_nums(1, 20000), rand_nums(0, 1), rand_content_date());
		SET i = i + 1;
	END WHILE;
END//


DROP PROCEDURE IF EXISTS downloads_faker;
DELIMITER //
CREATE PROCEDURE downloads_faker(n int)
BEGIN
	DECLARE i int DEFAULT 1;
	
	WHILE i <= n DO
		INSERT INTO downloads
					(media_id, download_count       , created_at         , updated_at         )
			 VALUES ( i      , rand_nums(1, 1000000), rand_content_date(), rand_content_date());
		SET i = i + 1;
	END WHILE;

	UPDATE downloads
	SET `updated_at` = timestampadd(SECOND, floor(rand() * timestampdiff(SECOND, created_at, now())), created_at) WHERE `updated_at` < `created_at`;
END//


DROP PROCEDURE IF EXISTS browses_faker;
DELIMITER //
CREATE PROCEDURE browses_faker(n int)
BEGIN
	DECLARE i int DEFAULT 1;
	
	WHILE i <= n DO
		INSERT INTO browses
					(media_id, browse_count         , created_at         , updated_at         )
			 VALUES ( i      , rand_nums(1, 1000000), rand_content_date(), rand_content_date());
		SET i = i + 1;
	END WHILE;

	UPDATE browses
	SET `updated_at` = timestampadd(SECOND, floor(rand() * timestampdiff(SECOND, created_at, now())), created_at) WHERE `updated_at` < `created_at`;
END//


DROP PROCEDURE IF EXISTS subscriptions_faker;
DELIMITER //
CREATE PROCEDURE subscriptions_faker(n int)
BEGIN
	DECLARE i int DEFAULT 1;
	
	WHILE i <= n DO
		INSERT INTO subscriptions
					(user_id           , channel_id       , created_at         )
			 VALUES (rand_nums(1, 1000), rand_nums(1, 100), rand_content_date());
		SET i = i + 1;
	END WHILE;
END//

