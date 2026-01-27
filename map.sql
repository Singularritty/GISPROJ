-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.4.3 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for gisproj
CREATE DATABASE IF NOT EXISTS `gisproj` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gisproj`;

-- Dumping structure for table gisproj.cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table gisproj.cache: ~0 rows (approximately)

-- Dumping structure for table gisproj.cache_locks
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table gisproj.cache_locks: ~0 rows (approximately)

-- Dumping structure for table gisproj.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table gisproj.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table gisproj.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table gisproj.jobs: ~0 rows (approximately)

-- Dumping structure for table gisproj.job_batches
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table gisproj.job_batches: ~0 rows (approximately)

-- Dumping structure for table gisproj.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table gisproj.migrations: ~1 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '0001_01_01_000000_create_users_table', 1),
	(2, '0001_01_01_000001_create_cache_table', 1),
	(3, '0001_01_01_000002_create_jobs_table', 1);

-- Dumping structure for table gisproj.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table gisproj.password_reset_tokens: ~0 rows (approximately)

-- Dumping structure for table gisproj.rainfall_levels
CREATE TABLE IF NOT EXISTS `rainfall_levels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `min_mm` int NOT NULL,
  `max_mm` int NOT NULL,
  `score` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table gisproj.rainfall_levels: ~4 rows (approximately)
INSERT INTO `rainfall_levels` (`id`, `description`, `min_mm`, `max_mm`, `score`, `created_at`, `updated_at`) VALUES
	(1, 'kering', 0, 1500, 2, NULL, NULL),
	(2, 'optimal', 1501, 2500, 4, NULL, NULL),
	(3, 'sangat ideal', 2501, 3500, 5, NULL, NULL),
	(4, 'basah', 3501, 5000, 3, NULL, NULL);

-- Dumping structure for table gisproj.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table gisproj.sessions: ~0 rows (approximately)
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
	('afeMEnk5hKJ3IA1C5VIYVCISCZIF6WhLDarT62g9', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQnVXMzRUd3JjQlFkQkpsbEtnYmJTTzFQaWlBR0hnRlVGV0VtT0k5VCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1769485249);

-- Dumping structure for table gisproj.soil_types
CREATE TABLE IF NOT EXISTS `soil_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `recommended_crops` json DEFAULT NULL,
  `score` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table gisproj.soil_types: ~4 rows (approximately)
INSERT INTO `soil_types` (`id`, `name`, `description`, `recommended_crops`, `score`, `created_at`, `updated_at`) VALUES
	(1, 'Eutropepts', 'Tanah subur, cocok untuk pertanian umum.', '["padi", "sayuran daun", "jagung", "umbi-umbian"]', 4, NULL, NULL),
	(2, 'Tropudults', 'Tanah ultisol tropis yang memerlukan pemupukan.', '["kelapa sawit", "karet", "pisang", "singkong"]', 3, NULL, NULL),
	(3, 'Humitropepts', 'Tanah lembab, cocok hortikultura.', '["stroberi", "kol", "wortel", "kentang"]', 4, NULL, NULL),
	(4, 'Tropohumults', 'Tanah agak masam, cocok tanaman keras.', '["kopi", "teh", "cengkeh"]', 3, NULL, NULL);

-- Dumping structure for table gisproj.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table gisproj.users: ~0 rows (approximately)

-- Dumping structure for table gisproj.zones
CREATE TABLE IF NOT EXISTS `zones` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `polygon` longtext NOT NULL,
  `color` varchar(7) DEFAULT NULL,
  `rainfall_avg` int DEFAULT NULL,
  `soil_type` varchar(100) DEFAULT NULL,
  `recommended_crops` text,
  `final_score` decimal(8,2) DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table gisproj.zones: ~0 rows (approximately)
INSERT INTO `zones` (`id`, `name`, `description`, `polygon`, `color`, `rainfall_avg`, `soil_type`, `recommended_crops`, `final_score`, `weight`, `created_at`, `updated_at`) VALUES
	(1, 'Ciwidey - Pangalengan - Rancabali', 'Wilayah selatan Kabupaten Bandung.', '{"type":"Polygon","coordinates":[[[107.33,-7.16],[107.26,-7.26],[107.45,-7.3],[107.52,-7.18],[107.33,-7.16]]]}', '#2ecc71', 1800, 'Andosol', 'Teh, Kentang, Stroberi, Sayuran Dataran Tinggi', 86.50, 5, NULL, NULL),
	(2, 'Baleendah - Soreang - Katapang', 'Wilayah dataran rendah Kabupaten Bandung.', '{"type":"Polygon","coordinates":[[[107.58,-6.98],[107.52,-7.03],[107.63,-7.05],[107.67,-6.95],[107.58,-6.98]]]}', '#f1c40f', 1400, 'Latosol', 'Padi, Jagung, Kacang Tanah', 72.00, 3, NULL, NULL),
	(3, 'Dataran basah / Kaki Bukit', 'Wilayah dengan kelembaban tinggi.', '{"type":"Polygon","coordinates":[[[107.6,-7],[107.55,-7.08],[107.7,-7.1],[107.72,-7.02],[107.6,-7]]]}', '#27ae60', 1600, 'Aluvial', 'Padi, Sayuran, Pepaya', 78.30, 4, NULL, NULL),
	(4, 'Cimenyan - Cilengkrang', 'Wilayah perbukitan Bandung Utara.', '{"type":"Polygon","coordinates":[[[107.67,-6.86],[107.62,-6.95],[107.76,-6.98],[107.8,-6.88],[107.67,-6.86]]]}', '#1abc9c', 1700, 'Andosol', 'Kopi, Sayuran, Teh', 81.20, 4, NULL, NULL),
	(5, 'Cicalengka - Nagreg', 'Wilayah timur dengan kemiringan sedang.', '{"type":"Polygon","coordinates":[[[107.85,-7.02],[107.78,-7.1],[107.92,-7.12],[107.98,-7.05],[107.85,-7.02]]]}', '#e67e22', 1300, 'Latosol', 'Jagung, Singkong, Pisang', 68.50, 3, NULL, NULL),
	(6, 'Bojongsoang - Rancaekek', 'Wilayah dataran rendah tengah kabupaten.', '{"type":"Polygon","coordinates":[[[107.68,-7.01],[107.63,-7.07],[107.75,-7.09],[107.78,-7.02],[107.68,-7.01]]]}', '#f39c12', 1200, 'Aluvial', 'Padi, Tebu', 62.40, 2, NULL, NULL),
	(7, 'Zona Erosi / Lereng Curam', 'Wilayah rawan longsor.', '{"type":"Polygon","coordinates":[[[107.49,-7.12],[107.45,-7.2],[107.55,-7.23],[107.6,-7.14],[107.49,-7.12]]]}', '#c0392b', 1500, 'Regosol', 'Hutan Lindung, Reboisasi', 48.10, 1, NULL, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
