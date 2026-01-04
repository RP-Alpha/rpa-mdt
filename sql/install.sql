-- RP-Alpha MDT Database Schema
-- Run this SQL before using the MDT resource

-- Reports table for incident reports
CREATE TABLE IF NOT EXISTS `rpa_mdt_reports` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    `author_id` VARCHAR(50) NOT NULL COMMENT 'CitizenID of the officer',
    `author_name` VARCHAR(100) NOT NULL,
    `category` ENUM('incident', 'arrest', 'citation', 'other') DEFAULT 'incident',
    `involved_citizens` JSON DEFAULT NULL COMMENT 'Array of CitizenIDs involved',
    `evidence` JSON DEFAULT NULL COMMENT 'Array of evidence items/images',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_author` (`author_id`),
    INDEX `idx_category` (`category`),
    INDEX `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Warrants table for active warrants
CREATE TABLE IF NOT EXISTS `rpa_mdt_warrants` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `citizen_id` VARCHAR(50) NOT NULL COMMENT 'CitizenID of wanted person',
    `citizen_name` VARCHAR(100) NOT NULL,
    `reason` TEXT NOT NULL,
    `issuing_officer_id` VARCHAR(50) NOT NULL,
    `issuing_officer_name` VARCHAR(100) NOT NULL,
    `status` ENUM('active', 'served', 'expired', 'cancelled') DEFAULT 'active',
    `expires_at` TIMESTAMP NULL DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `served_at` TIMESTAMP NULL DEFAULT NULL,
    `served_by` VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX `idx_citizen` (`citizen_id`),
    INDEX `idx_status` (`status`),
    INDEX `idx_expires` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- BOLO (Be On Lookout) table
CREATE TABLE IF NOT EXISTS `rpa_mdt_bolos` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `type` ENUM('person', 'vehicle') NOT NULL DEFAULT 'person',
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    `plate` VARCHAR(10) DEFAULT NULL COMMENT 'For vehicle BOLOs',
    `vehicle_model` VARCHAR(100) DEFAULT NULL,
    `vehicle_color` VARCHAR(50) DEFAULT NULL,
    `citizen_id` VARCHAR(50) DEFAULT NULL COMMENT 'For person BOLOs',
    `citizen_name` VARCHAR(100) DEFAULT NULL,
    `last_seen_location` VARCHAR(255) DEFAULT NULL,
    `author_id` VARCHAR(50) NOT NULL,
    `author_name` VARCHAR(100) NOT NULL,
    `status` ENUM('active', 'resolved', 'expired') DEFAULT 'active',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `resolved_at` TIMESTAMP NULL DEFAULT NULL,
    `resolved_by` VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX `idx_type` (`type`),
    INDEX `idx_plate` (`plate`),
    INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Criminal records / charges history
CREATE TABLE IF NOT EXISTS `rpa_mdt_criminal_records` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `citizen_id` VARCHAR(50) NOT NULL,
    `citizen_name` VARCHAR(100) NOT NULL,
    `charge` VARCHAR(255) NOT NULL,
    `fine_amount` INT DEFAULT 0,
    `jail_time` INT DEFAULT 0 COMMENT 'In months',
    `arresting_officer_id` VARCHAR(50) NOT NULL,
    `arresting_officer_name` VARCHAR(100) NOT NULL,
    `notes` TEXT DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_citizen` (`citizen_id`),
    INDEX `idx_charge` (`charge`),
    INDEX `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Officer notes on citizens (for profiles)
CREATE TABLE IF NOT EXISTS `rpa_mdt_citizen_notes` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `citizen_id` VARCHAR(50) NOT NULL COMMENT 'CitizenID being noted',
    `note` TEXT NOT NULL,
    `author_id` VARCHAR(50) NOT NULL,
    `author_name` VARCHAR(100) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_citizen` (`citizen_id`),
    INDEX `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dispatch call log history
CREATE TABLE IF NOT EXISTS `rpa_mdt_dispatch_log` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `call_type` VARCHAR(100) NOT NULL,
    `location` VARCHAR(255) NOT NULL,
    `coordinates` VARCHAR(100) DEFAULT NULL,
    `description` TEXT DEFAULT NULL,
    `caller_info` VARCHAR(255) DEFAULT NULL COMMENT 'Anonymous or citizen info',
    `responding_units` JSON DEFAULT NULL,
    `status` ENUM('pending', 'dispatched', 'enroute', 'onscene', 'cleared') DEFAULT 'pending',
    `priority` TINYINT DEFAULT 3 COMMENT '1=Critical, 2=High, 3=Normal, 4=Low',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `cleared_at` TIMESTAMP NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX `idx_status` (`status`),
    INDEX `idx_priority` (`priority`),
    INDEX `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
