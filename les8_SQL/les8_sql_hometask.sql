
-- hometask 8 ---------------------------------

-- общие выборки для каждой таблицы базы vk

SELECT * FROM users;             
SELECT * FROM profiles;
SELECT * FROM likes;             
SELECT * FROM communities_users; 
SELECT * FROM posts;             
SELECT * FROM friendship;        
SELECT * FROM messages;          
SELECT * FROM target_types;
SELECT * FROM communities;
SELECT * FROM friendship_statuses;
SELECT * FROM media;
SELECT * FROM media_types;


-- ---------------------------------------------------------------------------------
-- определить кто больше поставил лайков (всего) - мужчины или женщины.

-- Примечание: столбец likes.dislikes отвечает за наличие лайка или дизлайка
-- если likes.dislikes = 0, значит это лайк
-- если likes.dislikes = 1, значит это дизлайк

-- кол-во мужчин, поставивших лайки
SELECT COUNT(*) 
  FROM profiles 
  JOIN likes
    ON profiles.user_id = likes.user_id
   AND profiles.gender = 'm'
   AND likes.dislikes = 0;

-- кол-во мужчин, поставивших дизлайки
SELECT COUNT(*) 
  FROM profiles 
  JOIN likes
    ON profiles.user_id = likes.user_id
   AND profiles.gender = 'm'
   AND likes.dislikes = 1;  

-- кол-во женщин, поставивших лайки  
SELECT COUNT(*) 
  FROM profiles 
  JOIN likes
    ON profiles.user_id = likes.user_id
   AND profiles.gender = 'w'
   AND likes.dislikes = 0;  

-- кол-во женщин, поставивших дизлайки 
SELECT COUNT(*) 
  FROM profiles 
  JOIN likes
    ON profiles.user_id = likes.user_id
   AND profiles.gender = 'w'
   AND likes.dislikes = 1;  
 

-- ---------------------------------------------------------------------------------
-- Подсчитать общее количество лайков десяти самым молодым пользователям 
-- (сколько лайков получили 10 самых молодых пользователей).

SELECT count(*), GROUP_CONCAT(likes.dislikes) AS like0_dislike1, profiles.user_id, profiles.birthday
     FROM profiles
LEFT JOIN likes
       ON likes.target_id = profiles.user_id
      AND likes.target_type_id = 2 -- при данном типе лайки ставятся непосредственно пользователям 
    WHERE likes.dislikes IS NOT NULL
    GROUP BY profiles.user_id 
    ORDER BY profiles.birthday DESC LIMIT 10;
 

-- -------------------------------------------------------------------------------------------------------
-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- Критерием активности считать создание постов, участие в сообществах, проставление лайков

SELECT posts.id AS made_post, communities_users.community_id AS has_community, likes.dislikes AS made_like, 
       concat(users.first_name, '  ', users.last_name) AS full_name, users.id
  FROM posts
 RIGHT JOIN communities_users
    ON posts.user_id = communities_users.user_id 
 RIGHT JOIN likes
    ON communities_users.user_id = likes.user_id
 RIGHT JOIN users
    ON likes.user_id = users.id
 ORDER BY made_post, has_community, made_like LIMIT 10;
 
 
 
 
 
 
 
 
 
 
 