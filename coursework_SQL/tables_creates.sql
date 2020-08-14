
DROP DATABASE IF EXISTS youtube;
CREATE DATABASE youtube;
USE youtube;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100),
  `last_name` varchar(100),
  `email` varchar(100),
  `phone` varchar(100),
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB;


DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
  `user_id` int(10) unsigned NOT NULL,
  `is_male` bool DEFAULT 1,
  `birthday` date DEFAULT NULL,
  `country_id` int(10) NOT NULL REFERENCES `country` (`id`),
  `region_id` int(10) NOT NULL REFERENCES `region` (`id`),
  `city_id` int(10) NOT NULL REFERENCES `city` (`id`),
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `profiles_user_id_uq` UNIQUE (`user_id`),  
  KEY `profiles_user_id_fk` (`user_id`),
  KEY `profiles_country_id_fk` (`country_id`), 
  KEY `profiles_region_id_fk` (`region_id`),
  KEY `profiles_city_id_fk` (`city_id`),
  CONSTRAINT `profiles_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `profiles_country_id_fk` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE RESTRICT, 
  CONSTRAINT `profiles_region_id_fk` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `profiles_city_id_fk` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB;


DROP TABLE IF EXISTS country;
create table country(
	id			int(10) not null primary key,
	name		varchar(128) NOT NULL UNIQUE,
	crt_date	datetime NOT NULL DEFAULT NOW());


DROP TABLE IF EXISTS region;
create table region(
	id			int(10) not null primary key,
	country_id	int(10) not null REFERENCES country (id),
	name		varchar(128) not null,
	crt_date	datetime NOT NULL DEFAULT NOW(),
	CONSTRAINT `region_country_id_fk` FOREIGN KEY (`country_id`) REFERENCES country (id) ON DELETE CASCADE
	);


DROP TABLE IF EXISTS city;
create table city(
	id			int(10) not null primary KEY AUTO_INCREMENT,
	region_id	int(10) not null REFERENCES region (id),
	name		varchar(128) not null,
	crt_date	datetime NOT NULL DEFAULT NOW(),
	CONSTRAINT `city_region_id_fk` FOREIGN KEY (`region_id`) REFERENCES region (id) ON DELETE CASCADE
	);


DROP TABLE IF EXISTS `childs`;
CREATE TABLE `childs` (
  `user_id` int(10) unsigned NOT NULL,
  `child_name` varchar(255),
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `childs_user_id_fk` (`user_id`),
  CONSTRAINT `childs_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;


DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes` (
  `user_id` int(10) unsigned NOT NULL,
  `media_id` int(10) unsigned NOT NULL,
  `dislike` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  KEY `likes_user_id_fk` (`user_id`),
  KEY `likes_media_id_fk` (`media_id`),
  CONSTRAINT `likes_media_id_fk` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`),
  CONSTRAINT `likes_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB;


DROP TABLE IF EXISTS `apps`;
CREATE TABLE `apps` (
  `id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) COMMENT 'y_tv, y_music, y_for_children, y_creators, y_for_artists',
  UNIQUE KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB COMMENT='youtube applications';


DROP TABLE IF EXISTS `media_types`;
CREATE TABLE `media_types` (
  `id` int(10) unsigned DEFAULT NULL COMMENT '1-100 if apps_id = 1, 101-200 if apps_id =2, 201-300 if apps_id = 3, e.t.c.',
  `app_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL COMMENT 'TV-channel if apps_id = 1, genre if apps_id = 2, e.t.c.',
  UNIQUE KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `media_types_app_id_fk` (app_id),
  CONSTRAINT `media_types_apps_id_fk` FOREIGN KEY (`app_id`) REFERENCES `apps` (`id`) ON DELETE SET NULL 
) ENGINE=InnoDB;


DROP TABLE IF EXISTS `media`;
CREATE TABLE `media` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `media_type_id` int(10) unsigned DEFAULT NULL,
  `filename` varchar(255) NOT NULL COMMENT 'file name with reference and extension',
  `size` int(11) NOT NULL COMMENT 'file size',
  `metadata` longtext COMMENT 'whose author',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `media_media_type_id_fk` (`media_type_id`),
  CONSTRAINT `media_media_type_id_fk` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB;


DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE `subscriptions` (
  `user_id` int(10) unsigned NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  KEY `subscriptions_user_id_fk` (`user_id`),
  KEY `subscriptions_channel_id_fk` (`channel_id`),
  CONSTRAINT `subscriptions_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subscriptions_channel_id_fk` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;


DROP TABLE IF EXISTS `channels`;
CREATE TABLE `channels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT 'channel owner',
  `name` varchar(255),
  `description` text DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `country_id` int(10) NOT NULL REFERENCES `country` (`id`),
  `reference` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `channels_user_id_fk` (`user_id`),
  KEY `channels_country_id_fk` (`country_id`),
  CONSTRAINT `channels_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `channels_country_id_fk` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE RESTRICT  
) ENGINE=InnoDB;


DROP TABLE IF EXISTS `channels_content`;
CREATE TABLE `channels_content` (
  `channel_id` int(10) unsigned NOT NULL,
  `media_id` int(10) unsigned NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `channels_content_channel_id_fk` (`channel_id`),
  KEY `channels_content_media_id_fk` (`media_id`),
  CONSTRAINT `channels_content_channel_id_fk` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `channels_content_media_id_fk` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;


DROP TABLE IF EXISTS `playlists`;
CREATE TABLE `playlists` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `media_id` int(10) unsigned NOT NULL,
  `name` varchar(255),
  `created_at` datetime DEFAULT current_timestamp,
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp,
  KEY `playlists_user_id_fk` (`user_id`),
  KEY `playlists_media_id_fk` (`media_id`),
  CONSTRAINT `playlists_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `playlists_media_id_fk` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;


DROP TABLE IF EXISTS `downloads`;
CREATE TABLE `downloads` (
  `media_id` int(10) unsigned NOT NULL,
  `download_count` int(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp,
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp,
  KEY `downloads_media_id_fk` (`media_id`),
  CONSTRAINT `downloads_media_id_fk` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;  


DROP TABLE IF EXISTS `browses`;
CREATE TABLE `browses` (
  `media_id` int(10) unsigned NOT NULL,
  `browse_count` int(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp,
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp,
  KEY `browses_media_id_fk` (`media_id`),
  CONSTRAINT `browses_media_id_fk` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;  


