
USE vk;

-- 1. Проанализировать какие запросы могут выполняться наиболее
--    часто в процессе работы приложения и добавить необходимые индексы.

SELECT * FROM communities;
SELECT * FROM communities_users;
SELECT * FROM friendship;
SELECT * FROM friendship_statuses;
SELECT * FROM likes;
SELECT * FROM media; -- idx <filename>
SELECT * FROM media_types;
SELECT * FROM messages;
SELECT * FROM posts; -- idx <head>
SELECT * FROM profiles;
SELECT * FROM target_types;
SELECT * FROM users; -- idx <email>, <email, phone>

DROP INDEX media_filename_idx ON media;
CREATE INDEX media_filename_idx ON media(filename);

DROP INDEX posts_head_idx ON posts;
CREATE INDEX posts_head_idx ON posts(head);

DROP INDEX users_email_uq ON users;
CREATE UNIQUE INDEX users_email_uq ON users(email);

DROP INDEX users_email_phone_uq ON users;
CREATE UNIQUE INDEX users_email_phone_uq ON users(email, phone);


-- 2. Задание на оконные функции
--    Построить запрос, который будет выводить следующие столбцы:
--    имя группы  +
--    среднее количество пользователей в группах  -
--    самый молодой пользователь в группе  -
--    самый старший пользователь в группе  -
--    общее количество пользователей в группе  +
--    всего пользователей в системе  +
--    отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100  +

SELECT * FROM communities;
SELECT * FROM communities_users;
SELECT * FROM profiles;

 SELECT DISTINCT 
	communities.name,
	SUM(1) OVER (PARTITION BY communities_users.community_id) AS users_sum,
	AVG(1) OVER (PARTITION BY communities_users.community_id) AS users_avg,
	SUM(1) OVER () AS all_users,
	SUM(1) OVER (PARTITION BY communities_users.community_id) / SUM(1) OVER () * 100 AS '%%' 
FROM communities_users
JOIN communities
  ON communities_users.community_id = communities.id;

 


 





